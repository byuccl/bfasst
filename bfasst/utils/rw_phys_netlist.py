"""Creates a xilinx netlist that has only physical primitives"""

from argparse import ArgumentParser
import logging
from pathlib import Path
import time
from typing import Optional

from jpype.types import JInt
from bfasst import jpype_jvm
from bfasst import utils
from bfasst.utils.phys_netlist import PhysNetlist
import bfasst.utils.rw_helpers as rw


# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import BELPin
from com.xilinx.rapidwright.device.SiteTypeEnum import SLICEL, SLICEM
from com.xilinx.rapidwright.design import Cell, SiteInst, SitePinInst
from com.xilinx.rapidwright.edif import (
    EDIFNet,
    EDIFCell,
    EDIFCellInst,
    EDIFHierCellInst,
    EDIFPropertyValue,
    EDIFValueType,
)
from com.xilinx.rapidwright.interchange import (
    LogNetlistWriter,
    PhysNetlistWriter,
)

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class PhysNetlistTransformError(Exception):
    """Exception for errors in phys netlist transformation"""


class RwPhysNetlist(PhysNetlist):
    """Creates a xilinx netlist that has only physical primitives"""

    def __init__(
        self, build_dir: str, impl_checkpoint: tuple[Path, Path], logging_level: str, log_name: str
    ) -> None:
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / "vivado_phys_netlist"
        self.logging_level = logging_level
        log_path = self.stage_dir / log_name if "/" not in log_name else Path(log_name)
        log_path.unlink(missing_ok=True)
        if not log_path.parent.exists():
            log_path.parent.mkdir(parents=True)
        logging.basicConfig(
            filename=log_path,
            format="%(asctime)s %(message)s",
            level=self.logging_level,
            datefmt="%Y%m%d%H%M%S",
        )
        rapidwright_log_path = str(self.stage_dir / "rapidwright_stdout.log")
        super().__init__(rapidwright_log_path, impl_checkpoint)
        # Redirect rapidwright output to file

    def run(self) -> None:
        """Transform the logical netlist into a netlist with only physical primitives"""
        self.run_rapidwright()
        self.export_transformation()

    def export_transformation(self):
        """Export checkpoint, then run vivado to generate a new netlist"""
        phys_netlist_checkpoint = self.stage_dir / "phys_netlist.dcp"
        self.vivado_design.unplaceDesign()
        self.vivado_design.writeCheckpoint(phys_netlist_checkpoint)

        phys_netlist_edif_path = self.stage_dir / "viv_impl_physical.edf"
        logging.info("Writing EDIF phsyical netlist: %s", phys_netlist_edif_path)
        self.vivado_netlist.exportEDIF(phys_netlist_edif_path)
        logging.info(
            "Writing capnp interchange netlist: %s",
            str(self.stage_dir / "phys_logical_netlist.capnp"),
        )
        LogNetlistWriter.writeLogNetlist(
            self.vivado_netlist, str(self.stage_dir / "phys_logical_netlist.capnp")
        )
        logging.info(
            "Writing capnp interchange physical netlist: %s",
            str(self.stage_dir / "phys_physical_netlist.capnp"),
        )
        PhysNetlistWriter.writePhysNetlist(
            self.vivado_design, str(self.stage_dir / "phys_physical_netlist.capnp")
        )

    def run_rapidwright(self) -> None:
        """Do all rapidwright related processing on the netlist"""
        logging.info("Starting logical to physical netlist conversion for %s", self.build_dir.name)

        # First loop through all sites and deal with LUTs.  We can't the later loop that iterates
        # over Design.getCells() as it does not return LUT routethru objects.
        fun_start_time = time.time()
        self.__process_all_clbs()
        logging.info("Finished processing CLBs in %s seconds", time.time() - fun_start_time)

        start_time = time.time()
        cells_gen = (
            c
            for c in self.vivado_design.getCells()
            if c.getEDIFCellInst() is not None and c not in self.visited_cells
        )
        for c in cells_gen:
            ctype = c.getType()
            logging.info("Examining %s (%s)", c.getName(), f"{ctype}")
            match ctype:
                case "MUXF7" | "MUXF8" | "CARRY4":
                    self.cells_to_remove.extend(self.__process_generic_primitive(c))
                    self.phys_ecells.append((c.getEDIFCellInst(), c.getSiteInst(), c.getBELName()))
                case "BUFG":
                    self.cells_to_remove.extend(self.__process_bufg(c))
                case (
                    "IBUF"
                    | "OBUF"
                    | "OBUFT"
                    | "FDSE"
                    | "FDRE"
                    | "FDCE"
                    | "FDPE"
                    | "RAMB36E1"
                    | "RAMB18E1"
                    | "LDCE"
                    | "DSP48E1"
                ):
                    self.phys_ecells.append((c.getEDIFCellInst(), c.getSiteInst(), c.getBELName()))
                case _:
                    logging.error("Unsupported cell type %s. Exiting...", ctype)
                    raise PhysNetlistTransformError(f"Unsupported cell type {ctype}")
        assert not self.hanging_pins
        logging.info("Processed other cells in %s seconds", time.time() - start_time)
        logging.info("Removing old cells...")
        _ = [rw.remove_and_disconnect_cell(cell) for cell in self.cells_to_remove]

        # Attempt to uniquify all nets, this breaks Net.getLogicalNet() -> EDIFNet
        hedif_cells = (
            (c.getEDIFHierCellInst(), c)
            for c in self.vivado_design.getCells()
            if c.getEDIFHierCellInst() is not None
        )
        output_ports = (
            (c[1], p.getPortInst(), p.getNet())
            for c in hedif_cells
            for p in c[0].getHierPortInsts()
            if p.isOutput() and p.getNet() is not None and not rw.is_static_net(p.getNet())
        )
        nets_processed = set()
        for cell, port, net in output_ports:
            if net.getName() in nets_processed:
                continue
            drv_str = f"{cell.getSiteName()}/{cell.getBELName()}/{port.getName()}"
            logging.info("Adding driver location %s to net name %s", drv_str, net.getName())
            net.rename(f"{drv_str}_{net.getName()}")
            nets_processed.add(net.getName())

        ttime = time.time() - fun_start_time
        logging.info("Transformation time %s seconds", f"{ttime:0.2f}")
        with open(self.stage_dir / "transformation_time.txt", "w") as fp:
            fp.write(f"{ttime:.2f}\n")

    def __process_all_clbs(self) -> None:
        """
        Visit all LUTs and replace them with LUT6_2 instances.
        Check FF for latch routethrus
        """
        # Design.getSiteInsts() won't return some sites w/only constant generators. RW Issue #1228
        site_insts = {self.vivado_design.getSiteInstFromSite(s) for s in self.device.getAllSites()}
        site_insts.remove(None)
        for site_inst in (s for s in site_insts if s.getSiteTypeEnum() in (SLICEL, SLICEM)):
            self.__process_luts(site_inst)

        # Now that all LUT Generators are instanced, process FFs
        for site_inst in (s for s in site_insts if s.getSiteTypeEnum() in (SLICEL, SLICEM)):
            self.__process_ffs(site_inst)

        self.visited_cells.discard(None)
        self.visited_cells.discard(self.empty_cell)

    def __process_luts(self, site_inst: SiteInst):
        """
        Replace all logical luts with appropriate LUT6_2 instances.
        Look for LUT routethrus and constant generators.
        Combine LUTRAMs into a single RAM cell if possible.
        """
        self._handle_ghost_luts(site_inst)
        lut_rams = []
        lrams_post = []
        for lut6_bel, lut6_pin_out, lut5_bel, lut5_pin_out in self.lut_pair_bel_names:
            lut6_cell = site_inst.getCell(lut6_bel)
            lut5_cell = site_inst.getCell(lut5_bel)

            gnd_luts = self.__check_lut_const_nets(
                (lut6_cell, lut6_pin_out),
                (lut5_cell, lut5_pin_out),
                site_inst,
            )
            if gnd_luts:
                self.visited_cells.update(gnd_luts)
                continue

            if self.__check_lutram_srl(lut6_cell, lut5_cell, lut_rams):
                continue

            if len(lut_rams) > 1:
                lrams_post.append(self.__process_lutrams(lut_rams))
                lut_rams = []

            if lut6_cell or lut5_cell:
                if lut6_cell is not None:
                    self.__process_lut(lut6_cell, lut5_cell)
                else:
                    if not lut5_cell.isRoutethru() and "LUT" not in lut5_cell.getType():
                        raise PhysNetlistTransformError("No LUT6 cell, LUT5 is not rt or LUT")
                    self.__process_lut(lut5_cell, None, True)

            self.visited_cells.add(lut6_cell)
            self.visited_cells.add(lut5_cell)

        if len(lut_rams) > 1:
            lrams_post.append(self.__process_lutrams(lut_rams))
        if lrams_post:
            parents = {j for i in lrams_post for j in i[0]}
            _ = [
                self.visited_cells.add(c)
                for c in site_inst.getCells()
                if c.getEDIFHierCellInst().getParent() in parents
            ]
            _ = [
                self.phys_ecells.append((c, site_inst, bel)) for i in lrams_post for c, bel in i[1]
            ]

    def _handle_ghost_luts(self, site_inst: SiteInst) -> None:
        """Some LUT generators are only detectable by the fact that the site output pin is used."""
        site_pins = (
            (site_inst.getSitePinInst(p), p)
            for p in ("A", "B", "C", "D")
            if site_inst.getSitePinInst(p) is not None  # Site pin is used
            and site_inst.getNetFromSiteWire(f"{p}6LUT_O6") is None  # Site wire appears unused
            and site_inst.getSitePinInst(p).getNet().isStaticNet()  # Static net = const generator
        )
        for src_pin, p in site_pins:
            old_net = src_pin.getNet()
            logging.info("Inferring constant generator on LUT based on site pin %s", src_pin)
            new_net = self.__process_lut_const(site_inst, [(f"{p}6LUT_O6", old_net.isGNDNet())])[0]
            self.site_pin_to_net[src_pin] = new_net

    def __process_ffs(self, site_inst: SiteInst):
        """Process FF routethru cell and add it to the design."""
        cell_gen = (site_inst.getCell(ff_name) for ff_name in ("AFF", "BFF", "CFF", "DFF"))
        for ff in (ff for ff in cell_gen if ff is not None and ff.getEDIFCellInst() is None):
            assert ff.isRoutethru()
            self.visited_cells.add(ff)
            logging.info("Processing FF routethru %s", str(ff))
            new_cell_inst = self.vivado_design.getTopEDIFCell().createChildCellInst(
                f"{ff.getName()}_phys_rt", self.ldce_edif_cell
            )
            logging.info("  Setting INIT to 0")
            new_cell_inst.addProperty("INIT", JInt(0))

            input_pins = {
                "CK": ("G", self.vcc),
                "CE": ("GE", self.vcc),
                "SR": ("CLR", self.gnd),
                "D": ("D", None),
            }
            if ff.getName() in self.hanging_pins:
                for drv, _, bp in self.hanging_pins.pop(ff.getName()):
                    logp = input_pins[bp.getName()][0]
                    input_pins[bp.getName()] = (logp, self.site_pin_to_net[drv])
            for physp, (logp, net) in list(input_pins.items())[:-1]:
                port = new_cell_inst.getOrCreatePortInst(logp)
                assert port
                logging.info("  Connecting %s to %s (%s)", net, logp, physp)
                net.addPortInst(port)

            physp = "D"
            logp, net = input_pins[physp]
            if net is None:
                # Make the rt ff drive the logical net
                edif_net = site_inst.getNetFromSiteWire(ff.getName()[-2:]).getLogicalNet()
                src = edif_net.getSourcePortInsts(True)
                assert len(src) == 1
                src = src[0]
                logging.info("  Switch driver on net %s from %s to routethru ff Q", edif_net, src)
                edif_net.createPortInst(new_cell_inst.getPort("Q"), new_cell_inst)
                edif_net.removePortInst(src)

                # Make a new net to connect the old driver to the ff input
                net = EDIFNet(f"{ff.getName()}_rt_net", self.vivado_design.getTopEDIFCell())
                logging.info("  Creating new net %s for %s driving ff D input", net, src)
                net.addPortInst(src)
            net.createPortInst(new_cell_inst.getPort("D"), new_cell_inst)
            self.phys_ecells.append((new_cell_inst, site_inst, ff.getBELName()))

    def __check_lutram_srl(self, lut6_cell: Cell, lut5_cell: Cell, lut_rams: list) -> bool:
        """Check for lutrams or srl luts"""
        if lut6_cell:
            cell_type = str(lut6_cell.getType())
            if cell_type.startswith("RAM"):
                lut_rams.append(lut6_cell)
                self.visited_cells.add(lut6_cell)
                # Currently do not support designs with inverted LUTRAM clk
                if lut6_cell.getEDIFCellInst().getProperty("IS_CLK_INVERTED").getValue() != "1'b0":
                    raise PhysNetlistTransformError("LUTRAM with inverted clock not supported")
                if not lut5_cell:
                    return True
            elif cell_type.startswith("SRL"):
                self.phys_ecells.append(
                    (lut6_cell.getEDIFCellInst(), lut6_cell.getSiteInst(), lut6_cell.getBELName())
                )
                if lut5_cell is not None:
                    assert lut5_cell.getType() == lut6_cell.getType()
                    self.visited_cells.add(lut5_cell)
                self.visited_cells.add(lut6_cell)
                return True
        if lut5_cell:
            cell_type = str(lut5_cell.getType())
            if cell_type.startswith("RAM"):
                self.visited_cells.add(lut5_cell)
                # Pretty sure this only happens when the LUT6 is a RAM
                assert lut6_cell.getType() == lut5_cell.getType()
                # Also pretty sure LUTRAM-O5 cells are never combined? TBD if comparison fails
                return True
            if cell_type.startswith("SRL"):
                assert lut6_cell is None
                self.phys_ecells.append(
                    (lut5_cell.getEDIFCellInst(), lut5_cell.getSiteInst(), lut5_cell.getBELName())
                )
                self.visited_cells.add(lut5_cell)
                return True
        return False

    def __check_lut_const_nets(
        self, lut6: tuple[Cell, str], lut5: tuple[Cell, str], site_inst: SiteInst
    ) -> set[Cell]:
        """
        Covers any combination of LUT outputs connected to const nets.
        Covers a combo const generator and a routethru.

        lut6: Tuple (lut6_cell, lut6_pin_out)
        lut5: Tuple (lut5_cell, lut5_pin_out)
        """
        output_nets = {
            lut6[1]: site_inst.getNetFromSiteWire(lut6[1]),
            lut5[1]: site_inst.getNetFromSiteWire(lut5[1]),
        }
        output_nets = [(k, v) for k, v in output_nets.items() if v is not None]
        const_nets = [(k, v.isGNDNet()) for k, v in output_nets if v.isStaticNet()]

        if not const_nets:
            return set()

        if len(output_nets) == len(const_nets):  # Check if all outputs are const nets
            self.__process_lut_const(site_inst, const_nets)
            return {self.empty_cell}

        lut, const_pin, is_gnd = None, None, None
        for pin, net in output_nets:
            if net.isStaticNet():
                const_pin = pin
                is_gnd = net.isGNDNet()
            elif pin[-1] == "5":
                lut = lut5[0]
            elif pin[-1] == "6":
                lut = lut6[0]
        assert lut is not None, "Expected a routethru on the site, but none found"
        assert const_pin is not None, "Expected a const pin, but none found"
        self.__process_lut5_and_const_lut(lut, const_pin, site_inst, is_gnd)
        return {lut} if lut.getType().startsWith("LUT") else {self.empty_cell}

    def __check_ram32x1d(
        self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]
    ) -> Optional[EDIFCellInst]:
        """Check if RAM32X1S/RAMS32 cells can be combined to RAM32X1D"""
        same_nets = ["WE", "WCLK", "D"]
        # check for ram32x1d (2 luts)
        lut6_cell = lut_rams[0]
        ram32x1s_cell = parents[0].getInst()
        nets_lh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x1s_cell)
        init = lut6_cell.getProperty("INIT")
        for lut6_cell_rh, hier_cell in zip(lut_rams[1:], parents[1:]):
            ram32x1s_cell = hier_cell.getInst()
            nets_rh = rw.get_net_names_from_edif_ports(lut6_cell_rh, same_nets, ram32x1s_cell)
            init2 = lut6_cell_rh.getProperty("INIT")
            if init != init2:
                nets_lh = nets_rh
                init = init2
                lut6_cell = lut6_cell_rh
                continue

            for lh, rh in zip(nets_lh, nets_rh):
                if lh != rh:
                    nets_lh = nets_rh
                    init = init2
                    lut6_cell = lut6_cell_rh
                    break
            else:
                return self.__process_ram32x1d((lut6_cell, lut6_cell_rh))

    def __check_ram32m(
        self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]
    ) -> Optional[EDIFCellInst]:
        """
        Check if RAM32X1S/RAMS32 or RAM32X1D/RAMD32 cells can be
        combined to RAM32M.
        """
        same_nets = ["WE", "WCLK"]
        lut6_cell = lut_rams[0]
        ram32x_cell = parents[0].getInst()
        nets_lh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x_cell)
        for lut6_cell, hier_cell in zip(lut_rams[1:], parents[1:]):
            ram32x_cell = hier_cell.getInst()
            nets_rh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x_cell)
            for lh, rh in zip(nets_lh, nets_rh):
                if lh != rh:
                    if lut6_cell.getType() == "RAMS32":
                        return self.__check_ram32x1d(lut_rams, parents)
                    return None
        return self.__process_ram32m(lut_rams)

    def __process_ram32x1d(self, cells: list[Cell]) -> list[EDIFCellInst, str]:
        """
        Replace two RAM32X1S cells with a single RAM32X1D cell.
        """
        parent, edif_cells = self.__lutram_assertions(cells)
        new_cell_name = f"{rw.generate_combinded_cell_name(edif_cells)}_ram32x1d_phys"
        cell_str = f"2 LUT_RAMS ({' '.join([str(n.getName()) for n in cells])})"
        logging.info("Converting %s to RAM32X1D %s", cell_str, new_cell_name)

        ram32x1d = parent.createChildCellInst(new_cell_name, self.ram32x1d_edif_cell)

        ram32x1d.addProperty("INIT", edif_cells[0].getProperty("INIT"))

        global_pins = {"WE": ["WE"], "WCLK": ["WCLK"], "D": ["D"]}
        rw.transfer_global_pins(edif_cells, ram32x1d, global_pins)

        addrs = ["A0", "A1", "A2", "A3", "A4"]
        for addr in addrs:
            rw.valid_net_transfer(addr, [addr], edif_cells[0], ram32x1d)
        rw.valid_net_transfer("O", ["DPO"], edif_cells[0], ram32x1d)

        rd_addrs = ["DPRA0", "DPRA1", "DPRA2", "DPRA3", "DPRA4"]
        for addr, rd_addr in zip(addrs, rd_addrs):
            rw.valid_net_transfer(addr, [rd_addr], edif_cells[1], ram32x1d)
        rw.valid_net_transfer("O", ["SPO"], edif_cells[1], ram32x1d)
        self.cells_to_remove.extend(cells)
        for cell in cells:
            parent = cell.getEDIFHierCellInst().getParent()
            self.cells_to_remove.append(parent)
        self.phys_ecells.append((ram32x1d, parent.getSiteInst(), ram32x1d.getBELName()))
        return [(ram32x1d, cells[0].getBELName())]

    def __process_ram32m(self, cells: list[Cell]) -> EDIFCellInst:
        """
        Replace four RAM32X1S or two RAM32X1D cells with a single RAM32M
        cell.
        """
        if len(cells) == 2:
            raise PhysNetlistTransformError("RAM32D not handled yet")

        parent, edif_cells = self.__lutram_assertions(cells)
        new_cell_name = f"{rw.generate_combinded_cell_name(edif_cells)}_ram32m_phys"
        cell_str = f"4 LUT_RAMS ({' '.join([str(n.getName()) for n in cells])})"
        logging.info("Converting %s to RAM32M %s", cell_str, new_cell_name)

        ram32m = parent.createChildCellInst(new_cell_name, self.ram32m_edif_cell)

        prefix = ["A", "B", "C", "D"]
        for i, cell in zip(prefix, edif_cells):
            val = str(cell.getProperty("INIT").getValue())[4:]
            ram32m.addProperty(f"INIT_{i}", f"64'h{int(val, base=16):0{16}X}")

        global_pins = {"WE": ["WE"], "WCLK": ["WCLK"]}
        rw.transfer_global_pins(edif_cells, ram32m, global_pins)

        addrs = ["A0", "A1", "A2", "A3", "A4"]
        for i, cell in zip(prefix, edif_cells):
            rw.valid_bus_transfer(addrs, f"ADDR{i}", cell, ram32m)
            rw.valid_bus_transfer(["D"], f"DI{i}", cell, ram32m)
            rw.valid_bus_transfer(["O"], f"DO{i}", cell, ram32m)

        self.cells_to_remove.extend(cells)
        for parent in (cell.getEDIFHierCellInst().getParent() for cell in cells):
            self.cells_to_remove.append(parent)
        return [(ram32m, cells[0].getBELName())]

    def __lutram_assertions(self, lut_rams: list[Cell]) -> tuple[EDIFCell, list[EDIFCellInst]]:
        """
        Run sanity assertions on LUTRAMs.
        Returns -> (parent cell, [child insts])
        """
        hedif_cells = [c.getEDIFHierCellInst() for c in lut_rams]
        parents1 = [c.getParent() for c in hedif_cells]
        test_type = {t.getCellType().getName() for t in parents1}
        assert len(test_type) == 1
        if not test_type < {"RAM32X1S", "RAM32X1D"}:
            raise PhysNetlistTransformError(f"Unexpected parent cell type {test_type}")

        # Need to go up 2 levels: True parent -> RAM32X1S -> RAMS32 (current cell)
        parent = {c.getParent().getParent() for c in hedif_cells}
        assert len(parent) == 1

        return (parent.pop().getCellType(), [c.getParent().getInst() for c in hedif_cells])

    def __process_lutrams(
        self, lut_rams: list[Cell]
    ) -> tuple[set[EDIFHierCellInst], list[tuple[EDIFCellInst, str]]]:
        """
        Look at LUTRAMs in a site and see if they should be combined into a
        single RAM primitive.  RAMS32 is wrapped in RAM32X1S (parent cell), so
        LUTRAMs only need processed if they can be combined.
        """
        parents = [c.getEDIFHierCellInst().getParent() for c in lut_rams]
        parents_insts = [(p.getInst(), c.getBELName()) for p, c in zip(parents, lut_rams)]
        if len(set(parents)) == 1:  # Sometimes LUTRAMs are already combined into bigger primitive
            return (set(parents), parents_insts)

        cell_type = {c.getType() for c in lut_rams}
        if not cell_type <= {"RAMS32", "RAMD32"}:
            raise PhysNetlistTransformError(f"Unexpected child cell type {cell_type}")

        if len(cell_type) > 1:
            if len(lut_rams) == 2:
                return (set(parents), parents_insts)
            assert len(lut_rams) != 4
            if lut_rams[0].getType() == lut_rams[1].getType():
                lut_rams = lut_rams[0:2]
            elif lut_rams[1].getType() == lut_rams[2].getType():
                lut_rams = lut_rams[1:]
                parents = parents[1:]
            else:  # Should not reach here
                type_str = ", ".join([c.getType() for c in lut_rams])
                raise PhysNetlistTransformError(
                    f"Unexpected lutram configuration in slice: {type_str}"
                )
            ret = self.__check_ram32x1d(lut_rams, parents) or parents_insts
            return set(parents), ret

        if cell_type.pop() == "RAMS32":
            if len(lut_rams) == 4:
                ret = self.__check_ram32m(lut_rams, parents) or parents_insts
                return set(parents), ret
            ret = self.__check_ram32x1d(lut_rams, parents) or parents_insts
            return set(parents), ret

        if len(lut_rams) == 2:
            parents_insts = self.__check_ram32m(lut_rams, parents) or parents_insts
        return set(parents), parents_insts

    def __process_generic_primitive(self, cell: Cell) -> list:
        """Process CARRY4/MUXF7/MUXF8 primitive"""
        if rw.PinMap.cell_is_default_mapping(cell):
            return []
        logging.error("\tInputs are unexpectedly permuted... Exiting")
        raise NotImplementedError

    def __process_bufg(self, bufg_cell: Cell) -> list[Cell]:
        """Convert BUFG to BUFGCTRL"""
        bufg_edif_inst = bufg_cell.getEDIFCellInst()
        assert bufg_edif_inst

        type_name = bufg_edif_inst.getCellType().getName()
        logging.info("")
        logging.info("Processing %s %s", type_name, bufg_cell)

        assert rw.PinMap.cell_is_default_mapping(bufg_cell)

        new_cell_name = bufg_edif_inst.getName() + "_phys"
        bufgctrl = bufg_edif_inst.getParentCell().createChildCellInst(
            new_cell_name, self.bufgctrl_edif_cell
        )

        logging.info("Created new cell %s", new_cell_name)

        bufgctrl.setPropertiesMap(bufg_edif_inst.createDuplicatePropertiesMap())

        # set default properties
        for prop_name in ("INIT_OUT", "IS_CE0_INVERTED", "IS_IGNORE1_INVERTED", "IS_S0_INVERTED"):
            bufgctrl.addProperty(prop_name, JInt(0))

        for prop_name in ("IS_CE1_INVERTED", "IS_IGNORE0_INVERTED", "IS_S1_INVERTED"):
            bufgctrl.addProperty(prop_name, JInt(1))

        bufgctrl.addProperty("PRESELECT_I0", "TRUE")
        bufgctrl.addProperty("PRESELECT_I1", "FALSE")

        # Copy pins
        logging.info("  Copying pins from %s", bufg_cell.getName())

        for pins in bufg_cell.getPinMappingsL2P().items():
            rw.valid_net_transfer(*pins, bufg_edif_inst, bufgctrl)

        ports = set(("CE0", "CE1", "I1", "IGNORE0", "IGNORE1", "S0", "S1"))
        if bufg_cell.getName() in self.hanging_pins:
            # If the bufg has hanging pins, then connect them to the site pin nets
            for src_pin, cell, pin in self.hanging_pins.pop(bufg_cell.getName()):
                assert pin.getName() in ports
                logging.info("  Connecting %s to %s", src_pin, pin)
                logical_pin = cell.getLogicalPinMapping(pin.getName())
                port = bufgctrl.getOrCreatePortInst(logical_pin)
                assert port
                self.site_pin_to_net[src_pin].addPortInst(port)
                ports.remove(pin.getName())
        for port_name in ports:  # Set default connections
            logging.info("  Setting %s to VCC", port_name)
            port = bufgctrl.getPort(port_name)
            assert port
            self.vcc.createPortInst(port, bufgctrl)
        self.phys_ecells.append((bufgctrl, bufg_cell.getSiteInst(), "BUFGCTRL"))
        return [bufg_cell]

    def __check_carry4_ff_const_net(
        self, site_inst: SiteInst, pin_out: str, new_net: EDIFNet, is_gnd: bool
    ) -> None:
        """
        It seems that if the const lut output is routed to a carry4 or site ff,
        the mux it routes through also doesn't have a cell, so you have to check
        the primitive input pins.
        """
        dest_ports = []
        cell = site_inst.getCell("CARRY4")
        if cell:
            pin_in = "DI" if pin_out.endswith("O5") else "S"
            idx = {"A": 0, "B": 1, "C": 2, "D": 3}[pin_out[0]]
            routed_to_cell_inst = cell.getEDIFCellInst()
            bus = routed_to_cell_inst.getPort(pin_in)
            log_port_name = bus.getPortInstNameFromPort(bus.getPortIndexFromNameIndex(idx))
            dest_port = routed_to_cell_inst.getPortInst(log_port_name)
            assert dest_port
            dest_ports.append((routed_to_cell_inst, log_port_name, dest_port))
        cell = site_inst.getCell(f"{pin_out[0]}FF")
        if cell:
            routed_to_cell_inst = cell.getEDIFCellInst()
            if routed_to_cell_inst is not None:
                dest_port = routed_to_cell_inst.getPortInst("D")
                assert dest_port
                dest_ports.append((routed_to_cell_inst, "D", dest_port))
        if not dest_ports:
            return
        for routed_to_cell_inst, log_port_name, dest_port in dest_ports:
            log_net = dest_port.getNet()
            if (is_gnd and log_net.isGND()) or (not is_gnd and log_net.isVCC()):
                log_net.removePortInst(dest_port)
                new_net.createPortInst(log_port_name, routed_to_cell_inst)

    def __find_site_pin_sinks(self, src_pin: SitePinInst) -> list[tuple[Cell, BELPin]]:
        """Find the sinks of a site pin by its Net"""
        old_net = src_pin.getNet()
        if old_net.getName() not in self.const_net_nd_to_pip:
            # Not every design needs this initialized, so wait to until needed
            ntp = {}  # See DesignTools.getConnectionPIPs()
            for pip in old_net.getPIPs():
                src = pip.getStartNode()
                if src not in ntp or not pip.isBidirectional():
                    ntp[src] = pip
                if pip.isBidirectional():
                    assert False  # Currently Unexpected
            self.const_net_nd_to_pip[old_net.getName()] = ntp
        ntp = self.const_net_nd_to_pip[old_net.getName()]
        pip = ntp[src_pin.getConnectedNode()]
        while pip.getEndNode() in ntp:
            pip = ntp[pip.getEndNode()]
        sink_site_pin = pip.getEndNode().getSitePin()
        sink_site = self.vivado_design.getSiteInstFromSite(sink_site_pin.getSite())
        sink_pin = sink_site.getSitePinInst(sink_site_pin.getPinName())
        cells = rw.get_cells_from_site_pin(sink_pin, sink_site)
        valid_cells = []  # Some cells still need to be transformed
        for cell, pin in cells:
            if cell.getEDIFCellInst() is not None:
                if cell.getLogicalPinMapping(pin.getName()) is not None:
                    valid_cells.append((cell, pin))
                else:  # If the edif cell exists, with no pin mapping, then the port is not used
                    assert old_net.isGNDNet()
            else:
                if cell.getName() in self.hanging_pins:
                    self.hanging_pins[cell.getName()].append((src_pin, cell, pin))
                else:
                    self.hanging_pins[cell.getName()] = [(src_pin, cell, pin)]
        return valid_cells

    def __process_lut_const_net(
        self, site_inst: SiteInst, new_cell_inst: EDIFCellInst, pin_out: str, is_gnd: bool
    ) -> EDIFNet:
        """
        Replace the global const net on an input with the const routethru LUT output.
        """
        const_type = "GND" if is_gnd else "VCC"
        logging.info("Processing %s output pin %s", const_type, pin_out)

        # Create a new net to replace the global ground
        new_net_name = f"{site_inst.getName()}.{pin_out}.{const_type}"
        logging.info("  Creating new %s net %s", const_type, new_net_name)
        new_net = EDIFNet(new_net_name, self.vivado_design.getTopEDIFCell())

        # Drive net using LUT output port
        logging.info("  Connecting new net to LUT output port %s", pin_out[6:])
        new_net.addPortInst(new_cell_inst.getOrCreatePortInst(pin_out[6:]))

        # Loop through ports this const net needs to drive and connect them up
        cells = [(site_inst.getCell(p.getBEL()), p) for p in site_inst.getSiteWirePins(pin_out)]
        if pin_out.endswith("O6") and site_inst.getSitePinInst(pin_out[0]) is not None:
            # Check if this LUT drives anything off-site
            cells += self.__find_site_pin_sinks(site_inst.getSitePinInst(pin_out[0]))
        cells_gen = (
            (c, c[0].getEDIFCellInst())
            for c in cells
            if c[0] is not None and c[0].getEDIFCellInst() is not None
        )
        for (cell, pin_in), routed_to_cell_inst in cells_gen:
            logging.info(" %s %s %s", pin_in, pin_in.getBEL(), cell)
            # Map physical pin back to logical netlist port name
            logical_port_name = cell.getLogicalPinMapping(pin_in.getName())
            routed_to_port_inst = routed_to_cell_inst.getPortInst(logical_port_name)
            assert routed_to_port_inst
            # Disconnect const net from pin
            routed_to_port_inst.getNet().removePortInst(routed_to_port_inst)
            new_net.addPortInst(routed_to_port_inst)

        self.__check_carry4_ff_const_net(site_inst, pin_out, new_net, is_gnd)
        return new_net

    def __process_lut_const(
        self, site_inst: SiteInst, pins: list[tuple[str, bool]]
    ) -> list[EDIFNet]:
        """
        Process a LUT that isn't part of the design (ie no cell), but
        is configured to generate a GND signal.

        pins: list of tuples (pin_name, is_gnd)
        """
        logging.info(
            "Processing const LUT at site %s, pin(s): %s",
            site_inst.getName(),
            ",".join(str(p[0]) for p in pins),
        )

        new_cell_inst = self.vivado_design.getTopEDIFCell().createChildCellInst(
            rw.generate_const_lut_name(site_inst, pins), self.lut6_2_edif_cell
        )
        pin1_gnd, pin2_gnd = None, None
        if len(pins) == 1:
            if pins[0][0][-1] == "6":
                pin1_gnd = pins[0][1]
            else:
                pin2_gnd = pins[0][1]
        else:
            pin1_gnd, pin2_gnd = pins[0][1], pins[1][1]

        init6 = "00000000" if pin1_gnd else "FFFFFFFF"
        init5 = "00000000" if pin2_gnd else "FFFFFFFF"
        prop_str = (
            f"64'h{init6 if pin1_gnd is not None else init5}"
            + f"{init5 if pin2_gnd is not None else init6}"
        )
        new_cell_inst.setPropertiesMap({"INIT": EDIFPropertyValue(prop_str, EDIFValueType.STRING)})
        logging.info("Created new cell %s", new_cell_inst.getName())
        new_nets = [
            self.__process_lut_const_net(site_inst, new_cell_inst, pin, is_gnd)
            for pin, is_gnd in pins
        ]

        # Connect inputs to VCC to relect f2b
        for logical_port in rw.PinMap["LUT6_2"]:
            if logical_port.startswith("I"):
                self.vcc.createPortInst(new_cell_inst.getPort(logical_port), new_cell_inst)
        self.phys_ecells.append((new_cell_inst, site_inst, f"{pins[0][0][0]}6LUT"))
        return new_nets

    def __process_lut(
        self, lut6_cell: Cell, lut5_cell: Cell, lut5_only: bool = False
    ) -> EDIFCellInst:
        """
        This function takes a LUT* from the netlist and replaces with with a LUT6_2
        with logical mapping equal to the physical mapping.

        lut5_only: The lut6_cell was none and is replaced with the lut5_cell.
            If True, lut5_cell is None. Sometimes the lut5 is a lone lut or a rt.
        """
        logging.info(
            "Processing and replacing LUT(s): %s",
            ",".join(
                str(lut_cell) + ("(routethru)" if lut_cell.isRoutethru() else "")
                for lut_cell in (lut6_cell, lut5_cell)
                if lut_cell is not None
            ),
        )

        lut6_edif_cell_inst = lut6_cell.getEDIFCellInst()
        assert lut6_edif_cell_inst

        #### Create the new LUT6_2 instance
        new_cell_name = rw.generate_lut62_name(lut6_edif_cell_inst, lut6_cell, lut5_cell)
        new_cell_inst = lut6_edif_cell_inst.getParentCell().createChildCellInst(
            new_cell_name, self.lut6_2_edif_cell
        )
        logging.info("Created new cell %s", new_cell_name)

        ##### Copy all properties from existing LUT to new LUT (INIT will be fixed later)
        new_cell_inst.setPropertiesMap(lut6_edif_cell_inst.createDuplicatePropertiesMap())

        #### Wire up inputs/outputs
        physical_pins_to_nets = {}

        logging.info("Processing LUT %s", lut6_cell.getName())
        for logical_pin, physical_pin in lut6_cell.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut6_edif_cell_inst.getPortInst(logical_pin)
            assert port_inst
            physical_pins_to_nets[physical_pin] = port_inst.getNet()

            rw.lut_move_net_to_new_cell(
                (lut6_edif_cell_inst, new_cell_inst), logical_pin, physical_pin
            )

        # Now do the same for the other LUT
        if lut5_cell:
            logging.info("Processing LUT %s", lut5_cell.getName())
            lut5_edif_cell_inst = lut5_cell.getEDIFCellInst()
            for logical_pin, physical_pin in lut5_cell.getPinMappingsL2P().items():
                assert len(physical_pin) == 1
                physical_pin = list(physical_pin)[0]

                # Disconnect net from logical pin on old cell,
                # and connect to new logical pin (based on physical pin) of new cell
                rw.lut_move_net_to_new_cell(
                    (lut5_edif_cell_inst, new_cell_inst),
                    logical_pin,
                    physical_pin,
                    logging.info,
                    already_connected_net=physical_pins_to_nets.get(physical_pin),
                )

        # Connect up remaining inputs to VCC
        for logical_port in rw.PinMap["LUT6_2"]:
            if logical_port.startswith("I") and not new_cell_inst.getPortInst(logical_port):
                self.vcc.createPortInst(new_cell_inst.getPort(logical_port), new_cell_inst)

        # If old cell is a LUT route through some extra processing is required.
        # LUT route through cells don't exist in the original netlist (the original net
        # goes straight to the FF), so now that the net is going to stop at the LUT input,
        # a new net is needed to connect LUT output to FF

        if lut6_cell.isRoutethru():
            rw.create_lut_routethru_net(lut6_cell, lut5_only, new_cell_inst)
        if lut5_cell and lut5_cell.isRoutethru():
            rw.create_lut_routethru_net(lut5_cell, True, new_cell_inst)

        # Fix the new LUT INIT property based on the new pin mappings
        if not lut5_only:
            new_init = rw.process_lut_init(lut6_cell, lut5_cell)
        else:
            new_init = rw.process_lut_init(None, lut6_cell)
        logging.info("  New LUT INIT: %s", new_init)
        new_cell_inst.addProperty("INIT", new_init)

        self.phys_ecells.append((new_cell_inst, lut6_cell.getSiteInst(), lut6_cell.getBELName()))

        return new_cell_inst

    def __process_lut5_and_const_lut(
        self, lut5: Cell, const_pin: str, site_inst: SiteInst, is_gnd: bool
    ) -> Cell:
        """Process a LUT5 and GND LUT pair."""
        assert lut5 is not None
        if str(lut5.getType()).startswith("RAM"):
            raise PhysNetlistTransformError("LUTRAM paired with gnd LUT not supported")

        const_type = "GND" if is_gnd else "VCC"
        logging.info(
            "Processing and replacing LUT5 %s paired with %s LUT %s on site %s",
            lut5.getName(),
            const_type,
            const_pin,
            site_inst.getName(),
        )

        lut5_edif_cell_inst = lut5.getEDIFCellInst()
        assert lut5_edif_cell_inst

        new_cell_inst = lut5_edif_cell_inst.getParentCell().createChildCellInst(
            rw.generate_const_rt_lut_name(lut5_edif_cell_inst, lut5, const_type, const_pin),
            self.lut6_2_edif_cell,
        )

        #### Copy all properties from existing LUT to new LUT (INIT will be fixed later)
        if lut5.getType().startsWith("LUT"):
            new_cell_inst.setPropertiesMap(lut5_edif_cell_inst.createDuplicatePropertiesMap())
            logging.info("Processing LUT %s", lut5_edif_cell_inst.getName())
        else:
            logging.info("Processing routethru/const ghost LUT connected to %s", lut5.getName())
            assert lut5.isRoutethru(), "Expected a routethru LUT5 cell"

        for logical_pin, physical_pin in lut5.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut5_edif_cell_inst.getPortInst(logical_pin)
            assert port_inst

            rw.lut_move_net_to_new_cell(
                (lut5_edif_cell_inst, new_cell_inst), logical_pin, physical_pin
            )

        if lut5.isRoutethru():
            assert len(lut5.getPinMappingsL2P()) == 1
            in_pins = {"I0", "I1", "I2", "I3", "I4"}
            rt_pin = (
                f"I{int(physical_pin[1], base=10) - 1}"  # pylint: disable=undefined-loop-variable
            )
            in_pins.remove(rt_pin)
            for pin in in_pins:
                self.vcc.createPortInst(new_cell_inst.getPort(pin), new_cell_inst)
            rw.create_lut_routethru_net(lut5, const_pin[-1] == "6", new_cell_inst)

        for logical_port in rw.PinMap["LUT6_2"]:
            if logical_port.startswith("I") and not new_cell_inst.getPortInst(logical_port):
                self.vcc.createPortInst(new_cell_inst.getPort(logical_port), new_cell_inst)

        # hook up A6 to VCC
        self.vcc.createPortInst(new_cell_inst.getPort("I5"), new_cell_inst)

        # Connect other output pin to VCC or GND
        self.__process_lut_const_net(site_inst, new_cell_inst, const_pin, is_gnd)

        # Fix the new LUT INIT property based on the new pin mappings
        rw.process_shared_gnd_lut_eqn(lut5, const_pin, new_cell_inst, is_gnd)
        self.phys_ecells.append((new_cell_inst, site_inst, lut5.getBELName()))
        return lut5


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--build_dir",
        type=str,
        required=True,
        help="The build_directory to create a vivado netlist for.",
    )
    utils.add_path_arg(parser, "--impl_dcp", "The implementation dcp file to use for the netlist.")
    utils.add_path_arg(parser, "--impl_edf", "The implementation edf file to use for the netlist.")
    parser.add_argument(
        "--logging_level", default="INFO", help="Decides what levels of logs to display"
    )
    parser.add_argument(
        "--log_name", type=str, default="log.txt", help="The log file path to use as output"
    )
    args = parser.parse_args()
    impl_files = (args.impl_dcp, args.impl_edf)
    RwPhysNetlist(args.build_dir, impl_files, args.logging_level, args.log_name).run()
