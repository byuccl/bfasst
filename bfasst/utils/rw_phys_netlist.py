"""Creates a xilinx netlist that has only physical primitives"""

# pylint: disable=too-many-lines
# pylint: disable=too-many-public-methods

from argparse import ArgumentParser
import logging
from pathlib import Path
import sys
import time

import jpype
from jpype.types import JInt

from bfasst import jpype_jvm
from bfasst.config import PART
import bfasst.utils.rw_helpers as rw


# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import Device, SiteTypeEnum
from com.xilinx.rapidwright.design import Design, Unisim, SiteInst, Cell
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
from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class PhysNetlistTransformError(Exception):
    """Exception for errors in phys netlist transformation"""


class RwPhysNetlist:
    """Creates a xilinx netlist that has only physical primitives"""

    def __init__(self, build_dir: str, logging_level: str, log_name: str) -> None:
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
        # Redirect rapidwright output to file
        rapidwright_log_path = str(self.stage_dir / "rapidwright_stdout.log")
        System.setOut(PrintStream(File(rapidwright_log_path)))
        System.setErr(PrintStream(File(rapidwright_log_path)))

        # Rapidwright design / netlist
        self.vivado_design = None
        self.vivado_netlist = None

        # Const nets
        self.vcc = None
        self.gnd = None

        # Cells to use for new Primitives
        self.lut6_2_edif_cell = None
        self.ram32x1s_edif_cell = None
        self.ram32x1s1_edif_cell = None
        self.ram32x1d_edif_cell = None
        self.ram32m_edif_cell = None
        self.bufgctrl_edif_cell = None

        # Keep a list of old replaced cells to remove after processing
        self.cells_to_remove = []
        self.phys_cells = []  # tuple(EDIFCellInst, SiteInst, str(bel_name))

        self.lut_pair_bel_names = [
            ("A6LUT", "A6LUT_O6", "A5LUT", "A5LUT_O5"),
            ("B6LUT", "B6LUT_O6", "B5LUT", "B5LUT_O5"),
            ("C6LUT", "C6LUT_O6", "C5LUT", "C5LUT_O5"),
            ("D6LUT", "D6LUT_O6", "D5LUT", "D5LUT_O5"),
        ]

    def run(self, impl_netlist_checkpoint: Path, impl_netlist_edif_path: Path) -> None:
        """Transform the logical netlist into a netlist with only physical primitives"""
        self.run_rapidwright(impl_netlist_checkpoint, impl_netlist_edif_path)
        self.export_transformation()

    def __init_const_nets(self) -> None:
        """Init VCC and GND nets"""
        net_tuples = ((Unisim.GND, "G", "gnd"), (Unisim.VCC, "P", "vcc"))
        for unisim_cell, port, name in net_tuples:
            edif_cell = self.vivado_netlist.getHDIPrimitive(unisim_cell)

            cell_insts = [
                inst
                for inst in self.vivado_netlist.getTopCell().getCellInsts()
                if inst.getCellType() == edif_cell
            ]
            if len(cell_insts) > 1:
                rw.combine_const_nets(
                    port, cell_insts[1:], cell_insts[0], unisim_cell, logging.warning
                )

            if cell_insts:
                const_net = cell_insts[0].getPortInst(port).getNet()
                setattr(self, name, const_net)
                continue

            # Create new const instance as part of top-level
            const_edif_inst = self.vivado_netlist.getTopCell().createChildCellInst(
                f"{name}_phys_netlist", edif_cell
            )

            # Create const net as part of top-level
            const_net = EDIFNet(name + "_net_phys_netlist", self.vivado_netlist.getTopCell())
            assert const_net
            setattr(self, name, const_net)

            const_port = const_edif_inst.getPort(port)
            assert const_port
            const_net.createPortInst(const_port, const_edif_inst)

    def load_designs(self, impl_dcp: Path, impl_edf: Path) -> None:
        """Load the designs from the given paths"""
        logging.info("Loading vivado dcp and edf files: %s, %s", str(impl_dcp), str(impl_edf))
        start_time = time.time()
        self.vivado_design = Design.readCheckpoint(impl_dcp, impl_edf)
        self.vivado_netlist = self.vivado_design.getNetlist()
        self.vivado_design.flattenDesign()
        self.vivado_netlist.expandMacroUnisims(Device.getDevice(PART).getSeries())
        logging.info("Loading vivado netlist took %s seconds.", time.time() - start_time)

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

    def run_rapidwright(self, impl_dcp: Path, impl_edf: Path) -> None:
        """Do all rapidwright related processing on the netlist"""
        logging.info(
            "Starting logical to physical netlist conversion for %s %s",
            str(impl_dcp),
            str(impl_edf),
        )
        start_time = time.time()
        self.load_designs(impl_dcp, impl_edf)

        self.__init_const_nets()

        # Init BUFGCTRL cell template
        self.bufgctrl_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.BUFGCTRL)

        # Init LUT cell templates
        self.lut6_2_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.LUT6_2)
        self.ram32x1s_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1S)
        self.ram32x1s1_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1S_1)
        self.ram32x1d_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1D)
        self.ram32m_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32M)

        # Keep a list of cells already visited and skip them
        # This happens when we process LUTS mapped to the same BEL
        cells_already_visited = set()

        # First loop through all sites and deal with LUTs.  We can't the later loop that iterates
        # over Design.getCells() as it does not return LUT routethru objects.
        start_time = time.time()
        self.__process_all_luts(cells_already_visited)
        logging.info("Finished processing LUTs in %s seconds", time.time() - start_time)
        # print("Finished processing LUTs in %s seconds", time.time() - start_time)
        start_time = time.time()

        # Loop through all cells in the design
        for cell in self.vivado_design.getCells():
            edif_cell_inst = cell.getEDIFCellInst()

            if edif_cell_inst is None:
                logging.info("Examining %s ... No EDIF Cell ... Skipping", cell.getName())
                continue

            if cell in cells_already_visited:
                continue

            logging.info("Examining %s (%s)", cell.getName(), f"{cell.getType()}")

            cell_type = cell.getType()
            if cell_type in ("MUXF7", "MUXF8"):
                self.cells_to_remove.extend(self.__process_muxf7_muxf8(cell))
                continue

            if cell_type in ("CARRY4",):
                self.cells_to_remove.extend(self.__process_carry4(cell))
                continue

            if cell_type in ("BUFG",):
                self.cells_to_remove.extend(self.__process_bufg(cell))
                continue

            # These primitives don't need to get transformed
            if cell_type in (
                "IBUF",
                "OBUF",
                "OBUFT",
                "FDSE",
                "FDRE",
                "FDCE",
                "FDPE",
                "RAMB36E1",
                "RAMB18E1",
                "LDCE",
                "DSP48E1",
            ):
                self.phys_cells.append((edif_cell_inst, cell.getSiteInst(), cell.getBELName()))
                continue

            logging.error("Unsupported cell type %s. Exiting...", cell_type)
            raise PhysNetlistTransformError(f"Unsupported cell type {cell_type}")

        logging.info("Rapidwright bug count %d", self.rw_value_mismatch)
        logging.info("Processed other cells in %s seconds", time.time() - start_time)

        # Remove old unusued cells
        logging.info("Removing old cells...")
        for cell in self.cells_to_remove:
            rw.remove_and_disconnect_cell(cell)

        ttime = time.time() - start_time
        logging.info("Transformation time %s seconds", f"{ttime:0.2f}")
        with open(self.stage_dir / "transformation_time.txt", "w") as fp:
            fp.write(f"{ttime:.2f}\n")

    def __process_all_luts(self, cells_already_visited: set[Cell]) -> None:
        """Visit all LUTs and replace them with LUT6_2 instances"""
        for site_inst in self.vivado_design.getSiteInsts():
            if site_inst.getSiteTypeEnum() not in (SiteTypeEnum.SLICEL, SiteTypeEnum.SLICEM):
                continue

            gnd_nets = site_inst.getSiteWiresFromNet(self.vivado_design.getGndNet())
            vcc_nets = site_inst.getSiteWiresFromNet(self.vivado_design.getVccNet())

            lut_rams = []
            for lut6_bel, lut6_pin_out, lut5_bel, lut5_pin_out in self.lut_pair_bel_names:
                lut6_cell = site_inst.getCell(lut6_bel)
                lut5_cell = site_inst.getCell(lut5_bel)

                # if lut6_cell is not None and lut6_cell.getType() in ("FDRE", "CARRY4"):
                #     lut6_cell = None
                # if lut5_cell is not None and lut5_cell.getType() in ("FDRE", "CARRY4"):
                #     lut5_cell = None

                gnd_luts = self.__check_lut_const_nets(
                    (lut6_cell, lut6_pin_out),
                    (lut5_cell, lut5_pin_out),
                    (gnd_nets, vcc_nets),
                    site_inst,
                )
                if gnd_luts:
                    cells_already_visited.update(gnd_luts)
                    continue

                if self.__check_lutram_srl(lut6_cell, lut5_cell, lut_rams, cells_already_visited):
                    continue

                if len(lut_rams) > 1:
                    self.__process_lutrams(lut_rams)
                    lut_rams = []

                if lut6_cell or lut5_cell:
                    if lut6_cell is not None:
                        self.__process_lut(lut6_cell, lut5_cell)
                    else:
                        if (
                            not lut5_cell.isRoutethru() and "LUT" not in lut5_cell.getType()
                        ):  # Possible RW bug -> sometimes lut6 cell is none and lut5 is FDRE
                            raise PhysNetlistTransformError(
                                "LUT6 cell is None and LUT5 is not routethru or LUT"
                            )
                        self.__process_lut(lut5_cell, None, True)

                cells_already_visited.add(lut6_cell)
                cells_already_visited.add(lut5_cell)

            if len(lut_rams) > 1:
                self.__process_lutrams(lut_rams)
        cells_already_visited.discard(None)

    def __check_lutram_srl(
        self, lut6_cell: Cell, lut5_cell: Cell, lut_rams: list, cells_already_visited: set[Cell]
    ) -> bool:
        """Check for lutrams or srl luts"""
        if lut6_cell:
            cell_type = str(lut6_cell.getType())
            if cell_type.startswith("RAM"):
                lut_rams.append(lut6_cell)
                cells_already_visited.add(lut6_cell)
                # Currently do not support designs with inverted LUTRAM clk
                if lut6_cell.getEDIFCellInst().getProperty("IS_CLK_INVERTED").getValue() != "1'b0":
                    raise PhysNetlistTransformError("LUTRAM with inverted clock not supported")
                if not lut5_cell:
                    return True
            elif cell_type.startswith("SRL"):
                # assert lut5_cell is None
                if lut5_cell is not None:
                    assert lut5_cell.getType() == lut6_cell.getType()
                    cells_already_visited.add(lut5_cell)
                cells_already_visited.add(lut6_cell)
                return True
        if lut5_cell:
            cell_type = str(lut5_cell.getType())
            if cell_type.startswith("RAM"):
                cells_already_visited.add(lut5_cell)
                # Pretty sure this only happens when the LUT6 is a RAM
                assert lut6_cell.getType() == lut5_cell.getType()
                # Also pretty sure LUTRAM-O5 cells are never combined? TBD if comparison fails
                return True
            if cell_type.startswith("SRL"):
                assert lut6_cell is None
                cells_already_visited.add(lut5_cell)
                return True
        return False

    def __check_lut_const_nets(
        self,
        lut6: tuple[Cell, str],
        lut5: tuple[Cell, str],
        const_nets: tuple[list[str], list[str]],
        site_inst,
    ) -> set[Cell]:
        """
        Check if the LUT6 or LUT5 are connected to a const net
        Covers O5/O6 being gnd
        Covers O5/O6 being vcc
        Covers one output being gnd and the other being vcc

        lut6: Tuple (lut6_cell, lut6_pin_out)
        lut5: Tuple (lut5_cell, lut5_pin_out)
        const_nets: Tuple (gnd_nets, vcc_nets)
        """

        gnd_nets, vcc_nets = const_nets

        const_generator_pins = [None, None]
        pin1_gnd = None
        pin2_gnd = None
        for is_gnd, const_net in ((True, gnd_nets), (False, vcc_nets)):
            if lut6[1] in const_net:
                # If a gnd net, then there can't be a cell there
                assert lut6[0] is None
                if lut5[0] is not None and "LUT" in lut5[0].getType():
                    self.__process_lut5_and_const_lut(lut5[0], lut6[1], site_inst, is_gnd)
                    return {
                        lut5[0],
                    }
                assert const_generator_pins[0] is None
                const_generator_pins[0] = lut6[1]
                pin1_gnd = is_gnd

            if lut5[1] in const_net:
                # If a gnd net, then there can't be a cell there
                # This assumption is not true for LUTRAMs
                assert lut5[0] is None
                if lut6[0] is not None and "LUT" in lut6[0].getType():
                    self.__process_lut5_and_const_lut(lut6[0], lut5[1], site_inst, is_gnd)
                    return {
                        lut6[0],
                    }
                assert const_generator_pins[1] is None
                const_generator_pins[1] = lut5[1]
                pin2_gnd = is_gnd

        if const_generator_pins[0] is not None or const_generator_pins[1] is not None:
            if None in const_generator_pins:
                const_generator_pins.remove(None)
            self.__process_lut_const(site_inst, const_generator_pins, pin1_gnd, pin2_gnd)
            return set()
        return set()

    def __check_ram32x1d(self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]) -> list[Cell]:
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
                self.__process_ram32x1d((lut6_cell, lut6_cell_rh))
                return lut_rams

    def __check_ram32m(self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]) -> list[Cell]:
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
                    return lut_rams
        self.__process_ram32m(lut_rams)
        return lut_rams

    def __process_ram32x1d(self, cells: list[Cell]) -> EDIFCellInst:
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
        return ram32x1d

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
        for cell in cells:
            parent = cell.getEDIFHierCellInst().getParent()
            self.cells_to_remove.append(parent)
        return ram32m

    def __lutram_assertions(self, lut_rams: list[Cell]) -> tuple[EDIFCell, list[EDIFCellInst]]:
        """
        Run sanity assertions on LUTRAMs.

        Returns:
        (EDIFCell, [EDIFCellInst]) -> (parent cell, [child insts])
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

    def __process_lutrams(self, lut_rams: list[Cell]) -> None:
        """
        Look at LUTRAMs in a site and see if they should be combined into a
        single RAM primitive.  RAMS32 is wrapped in RAM32X1S (parent cell), so
        LUTRAMs only need processed if they can be combined.
        """

        parents = [c.getEDIFHierCellInst().getParent() for c in lut_rams]
        if len(set(parents)) == 1:
            # Sometimes LUTRAM cells are already combined into bigger primitive
            return

        cell_type = {c.getType() for c in lut_rams}

        if not cell_type <= {"RAMS32", "RAMD32"}:
            raise PhysNetlistTransformError(f"Unexpected child cell type {cell_type}")

        if len(cell_type) > 1:
            if len(lut_rams) == 2:
                return
            assert len(lut_rams) != 4
            if lut_rams[0].getType() == lut_rams[1].getType():
                lut_rams = lut_rams[0:2]
            elif lut_rams[1].getType() == lut_rams[2].getType():
                lut_rams = lut_rams[1:]
                parents = parents[1:]
            else:
                # Should not reach here
                type_str = ", ".join([c.getType() for c in lut_rams])
                raise PhysNetlistTransformError(
                    f"Unexpected lutram configuration in slice: {type_str}"
                )
            self.__check_ram32x1d(lut_rams, parents)
            return

        if cell_type.pop() == "RAMS32":
            if len(lut_rams) == 4:
                self.__check_ram32m(lut_rams, parents)
                return
            self.__check_ram32x1d(lut_rams, parents)
            return

        if len(lut_rams) == 2:
            self.__check_ram32m(lut_rams, parents)

    def __process_muxf7_muxf8(self, cell: Cell) -> list:
        """
        Process MUXF7/MUXF8 primitive
        Not sure whether inputs can be permuted or not, but for now let's
        raise NotImplementedError if they are.
        """

        if rw.PinMap.cell_is_default_mapping(cell):
            self.phys_cells.append((cell.getEDIFCellInst(), cell.getSiteInst(), cell.getBELName()))
            return []

        logging.info("\tInputs are unexpectedly permuted... Exiting")
        raise NotImplementedError

    def __process_carry4(self, cell: Cell) -> list:
        """
        Process CARRY4 primitive
        Not sure whether inputs can be permuted or not, but for now let's
        raise NotImplementedError if they are.
        """
        if rw.PinMap.cell_is_default_mapping(cell):
            self.phys_cells.append((cell.getEDIFCellInst(), cell.getSiteInst(), cell.getBELName()))
            return []

        logging.info("\tInputs are permuted. Ensuring connections")

        rw.PinMap.ensure_connected(cell.getEDIFCellInst(), self.gnd)

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

        # Set default connections
        for port_name in ("CE0", "CE1", "I1", "IGNORE0", "IGNORE1", "S0", "S1"):
            port = bufgctrl.getPort(port_name)
            assert port
            self.vcc.createPortInst(port, bufgctrl)
        self.phys_cells.append((bufgctrl, bufg_cell.getSiteInst(), "BUFGCTRL"))

        return [bufg_cell]

    def __check_carry4_const_net(
        self, site_inst: SiteInst, const_info: tuple[str, bool], pin_out: str, new_net: EDIFNet
    ) -> None:
        """
        It seems that if the const lut output is routed to a carry4, the
        mux it routes through also doesn't have a cell, so you have to check
        the c4 input pins.
        """

        const_type, is_gnd = const_info
        cell = site_inst.getCell("CARRY4")
        assert cell, f"{const_type} LUT routed to no cells"
        pin_in = "DI" if pin_out.endswith("O5") else "S"
        idx = {"A": 0, "B": 1, "C": 2, "D": 3}[pin_out[0]]
        routed_to_cell_inst = cell.getEDIFCellInst()
        bus = routed_to_cell_inst.getPort(pin_in)
        new_port = bus.getPortInstNameFromPort(bus.getPortIndexFromNameIndex(idx))
        routed_to_port_inst = routed_to_cell_inst.getPortInst(new_port)
        assert routed_to_port_inst
        if (is_gnd and routed_to_port_inst.getNet().getName() == "<const0>") or (
            not is_gnd and routed_to_port_inst.getNet().getName() == "<const1>"
        ):
            routed_to_port_inst.getNet().removePortInst(routed_to_port_inst)
            new_net.createPortInst(new_port, routed_to_cell_inst)
            new_net.createPortInst(new_port, routed_to_cell_inst)

    def __process_lut_const_net(
        self, site_inst: SiteInst, new_cell_inst: EDIFCellInst, pin_out: str, is_gnd: bool
    ) -> None:
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
        lut_out_port = new_cell_inst.getPort("O6" if pin_out.endswith("O6") else "O5")
        logging.info("  Connecting new net to LUT output port %s", lut_out_port.getName())
        assert lut_out_port
        new_net.createPortInst(lut_out_port, new_cell_inst)

        # Loop through ports this const net needs to drive and connect them up
        cells = [site_inst.getCell(pin.getBEL()) for pin in site_inst.getSiteWirePins(pin_out)]
        for cell, pin_in in zip(cells, site_inst.getSiteWirePins(pin_out)):
            if not cell:
                continue

            logging.info(" %s %s %s", pin_in, pin_in.getBEL(), site_inst.getCell(pin_in.getBEL()))
            routed_to_cell_inst = cell.getEDIFCellInst()

            # Map physical pin back to logical netlist port name
            assert rw.PinMap.cell_is_default_mapping(cell)
            logical_port_name = rw.PinMap[routed_to_cell_inst.getCellType().getName()].inverse[
                pin_in.getName()
            ]

            routed_to_port_inst = routed_to_cell_inst.getPortInst(logical_port_name)
            assert routed_to_port_inst
            # Disconnect const net from pin
            routed_to_cell_inst.getPortInst(logical_port_name).getNet().removePortInst(
                routed_to_port_inst
            )

            # Connect up new LUT const net to pin
            if routed_to_port_inst.getPort().isBus():
                new_net.createPortInst(
                    routed_to_port_inst.getPort(),
                    routed_to_port_inst.getIndex(),
                    routed_to_cell_inst,
                )
            else:
                new_net.createPortInst(routed_to_port_inst.getPort(), routed_to_cell_inst)

        if site_inst.getCell("CARRY4") is not None:
            self.__check_carry4_const_net(site_inst, (const_type, is_gnd), pin_out, new_net)

    def __process_lut_const(
        self, site_inst: SiteInst, pins: list[str], pin1_gnd: bool, pin2_gnd: bool
    ) -> None:
        """
        Process a LUT that isn't part of the design (ie no cell), but
        is configured to generate a GND signal.

        len(pins) <= 2
        """
        logging.info(
            "Processing const LUT at site %s, pin(s): %s",
            site_inst.getName(),
            ",".join(str(p) for p in pins),
        )

        new_cell_inst = self.vivado_design.getTopEDIFCell().createChildCellInst(
            rw.generate_const_lut_name(site_inst, pins, pin1_gnd, pin2_gnd), self.lut6_2_edif_cell
        )
        init6 = "00000000" if pin1_gnd else "FFFFFFFF"
        init5 = "00000000" if pin2_gnd else "FFFFFFFF"
        prop_str = (
            f"64'h{init6 if pin1_gnd is not None else init5}"
            + f"{init5 if pin2_gnd is not None else init6}"
        )
        new_cell_inst.setPropertiesMap({"INIT": EDIFPropertyValue(prop_str, EDIFValueType.STRING)})
        logging.info("Created new cell %s", new_cell_inst.getName())
        if len(pins) == 2:
            self.__process_lut_const_net(site_inst, new_cell_inst, pins[0], pin1_gnd)
            self.__process_lut_const_net(site_inst, new_cell_inst, pins[1], pin2_gnd)
        else:
            self.__process_lut_const_net(
                site_inst, new_cell_inst, pins[0], pin1_gnd if pin1_gnd is not None else pin2_gnd
            )

        # Connect inputs to VCC
        for logical_port in rw.PinMap["LUT6_2"]:
            if logical_port.startswith("I"):
                self.vcc.createPortInst(new_cell_inst.getPort(logical_port), new_cell_inst)
        self.phys_cells.append((new_cell_inst, site_inst, f"{pins[0][0]}6LUT"))

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
        # TODO: If other_lut_cell is not None, then check that properties don't conflict?

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
            for logical_pin, physical_pin in lut5_cell.getPinMappingsL2P().items():
                assert len(physical_pin) == 1
                physical_pin = list(physical_pin)[0]

                lut5_edif_cell_inst = lut5_cell.getEDIFCellInst()
                port_inst = lut5_edif_cell_inst.getPortInst(logical_pin)
                assert port_inst

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
            self.__create_lut_routethru_net(lut6_cell, lut5_only, new_cell_inst)
        if lut5_cell and lut5_cell.isRoutethru():
            self.__create_lut_routethru_net(lut5_cell, True, new_cell_inst)

        # Fix the new LUT INIT property based on the new pin mappings
        if not lut5_only:
            new_init = rw.process_lut_init(lut6_cell, lut5_cell)
        else:
            new_init = rw.process_lut_init(None, lut6_cell)
        logging.info("  New LUT INIT: %s", new_init)
        new_cell_inst.addProperty("INIT", new_init)

        self.phys_cells.append((new_cell_inst, lut6_cell.getSiteInst(), lut6_cell.getBELName()))

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
        new_cell_inst.setPropertiesMap(lut5_edif_cell_inst.createDuplicatePropertiesMap())
        logging.info("Processing LUT %s", lut5_edif_cell_inst.getName())

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
            self.__create_lut_routethru_net(lut5, const_pin.endswith("O6"), new_cell_inst)

        for logical_port in rw.PinMap["LUT6_2"]:
            if logical_port.startswith("I") and not new_cell_inst.getPortInst(logical_port):
                self.vcc.createPortInst(new_cell_inst.getPort(logical_port), new_cell_inst)

        # hook up A6 to VCC
        self.vcc.createPortInst(new_cell_inst.getPort("I5"), new_cell_inst)

        # Connect other output pin to VCC or GND
        self.__process_lut_const_net(site_inst, new_cell_inst, const_pin, is_gnd)

        # Fix the new LUT INIT property based on the new pin mappings
        rw.process_shared_gnd_lut_eqn(lut5, const_pin, new_cell_inst, is_gnd)
        self.phys_cells.append((new_cell_inst, site_inst, lut5.getBELName()))
        return lut5

    def __create_lut_routethru_net(
        self, cell: Cell, is_lut5: bool, new_lut_cell: EDIFCellInst
    ) -> None:
        """Extra processing for LUT route through.  Need to create a new net
        connecting from the new LUT6_2 instance to the FF"""

        logging.info("Creating routethru for %s", cell.getName())

        site_str = f"X{cell.getSite().getInstanceX()}Y{cell.getSite().getInstanceY()}"
        # Create the new net
        new_net_name = (
            cell.getName()
            + f"_routethru_{site_str}:"
            + str(cell.getBEL().getName())[0]
            + ("6" if not is_lut5 else "5")
        )
        logging.info("  Creating new net %s", new_net_name)
        new_net = EDIFNet(new_net_name, cell.getEDIFCellInst().getParentCell())

        # Connect net to LUT output
        lut_out_port = new_lut_cell.getPort("O5" if is_lut5 else "O6")
        assert lut_out_port
        logging.info(
            "  Connecting new net to LUT %s port %s", new_lut_cell.getName(), lut_out_port.getName()
        )
        new_net.createPortInst(lut_out_port, new_lut_cell)

        # Connect net to the input of the other cell in this site (FF, CARRY4)
        matching_cells = [
            other_cell
            for other_cell in cell.getSiteInst().getCells()
            if other_cell.getName() == cell.getName() and not other_cell.isRoutethru()
        ]
        assert len(matching_cells) == 1
        routed_to_cell = matching_cells[0]
        routed_to_cell_inst = routed_to_cell.getEDIFCellInst()

        # First figure out which logical pin this routethru goes to.
        # Even though we are calling the gePinMappingsL2P on the LUT cell,
        # it doesn't actually return the logical pin on the LUT, but rather
        # the downstream cell (FF, CARRY4).
        logical_pins = list(cell.getPinMappingsL2P().keys())
        assert len(logical_pins) == 1
        routed_to_port_name = str(logical_pins[0])

        routed_to_port_inst = routed_to_cell_inst.getPortInst(routed_to_port_name)
        assert routed_to_port_inst

        logging.info(
            "  Connecting new net to BEL %s, port %s",
            routed_to_cell.getBEL().getName(),
            routed_to_port_name,
        )

        if routed_to_port_inst.getPort().isBus():
            new_net.createPortInst(
                routed_to_port_inst.getPort(), routed_to_port_inst.getIndex(), routed_to_cell_inst
            )
        else:
            new_net.createPortInst(routed_to_port_inst.getPort(), routed_to_cell_inst)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--build_dir",
        type=str,
        required=True,
        help="The build_directory to create a vivado netlist for.",
    )
    parser.add_argument(
        "--impl_dcp",
        type=Path,
        required=True,
        help="The implementation dcp file to use for the netlist.",
    )
    parser.add_argument(
        "--impl_edf",
        type=Path,
        required=True,
        help="The implementation edf file to use for the netlist.",
    )
    parser.add_argument(
        "--logging_level", default="INFO", help="Decides what levels of logs to display"
    )
    parser.add_argument(
        "--log_name", type=str, default="log.txt", help="The log file path to use as output"
    )
    args = parser.parse_args()
    netlist_generator = RwPhysNetlist(args.build_dir, args.logging_level, args.log_name)
    try:
        netlist_generator.run(args.impl_dcp, args.impl_edf, args.phys_capnp, args.edf_capnp)
    except (jpype.JException, rw.RapidwrightException) as e:  # pylint: disable=no-member
        logging.error("ERROR: %s", e)
        sys.exit(1)
