"""
Check two netlists for structural equivalence using location data.
"""

from argparse import ArgumentParser
import logging
from pathlib import Path
import time

# pylint: disable=no-name-in-module
from jpype import JException
from jpype.types import JString

# pylint: enable=no-name-in-module

from bfasst import jpype_jvm
from bfasst import utils
from bfasst.utils.capnp_cells import CapnpCells
from bfasst.utils.rw_phys_netlist import RwPhysNetlist
import bfasst.utils.rw_helpers as rw
from bfasst.utils.structural_helpers import create_cell_props


# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.design import SiteInst, Cell
from com.xilinx.rapidwright.edif import (
    EDIFCellInst,
    EDIFHierPortInst,
    EDIFHierNet,
    EDIFHierCellInst,
    EDIFPortInst,
)
from com.xilinx.rapidwright.interchange import LogNetlistReader, PhysNetlistReader

from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class StructuralCapnp(RwPhysNetlist):
    """
    Compare a vivado dcp with a capnp netlist for structural equivalence.

    Runs RWPhysNetlist to adjust for transformations that occur during implementation.
    """

    def __init__(
        self, build_dir: str, impl_checkpoint: tuple[Path, Path], logging_level: str, log_name: str
    ) -> None:
        super().__init__(build_dir, impl_checkpoint, logging_level, log_name)
        self.cmp_stage_dir = Path(self.build_dir) / "capnp_cmp"
        self.cmp_stage_dir.mkdir(parents=True, exist_ok=True)
        self.cmp_log_path = self.cmp_stage_dir / log_name.split("/")[-1]
        self.logging_level = logging_level
        self.rev_design = None
        self.rev_netlist = None
        self.capnp_cells = None

        self._cell_props = create_cell_props()

        self.rw_value_mismatch = 0
        self.rw_value_mismatches = []
        self.rw_problem_cells = set()
        self.rw_port_mismatch = 0
        self.rw_port_mismatch_cells = set()

        self.matches = {}  # VivadoEDIFName: (vivado_edif_cell, SiteInst, rev_cell)
        # nets are named based on the net driver.
        self.net_map = {}  # net names: [net names and alias nets] (vivado: rev)
        self.driver_cache = {}  # EDIFNet: driver_full_name_str
        self.rev_net_cache = set()  # Set to avoid reprocessing nets
        self.rev_driver_cache = {}  # EDIFHierPortInst: driver_full_name_str

        # Static variables for fixing rev DSPs and BRAMS
        self.dsp_inv_props = (
            ("IS_INMODE_INVERTED", "INMODE"),
            ("IS_ALUMODE_INVERTED", "ALUMODE"),
            ("IS_OPMODE_INVERTED", "OPMODE"),
        )

        # These signals are fixed routing paths in the FPGA (nonprogrammable). They are always
        # connected to the cooresponding neighbor DSP site in the tile. Internal to the site,
        # there is a mux that selects them. Dispite this, when they are unused, Vivado shows
        # them as connected to GND or simply disconnected. F2B shows the persistant connection
        # to the neighboring DSP site.
        # Other inputs control the mux, so as long as this matches, the cascade values
        # are irrelevant. See Xilinx UG479 Figure 2-1 for more information.
        self.dsp_constant_ports = ["CARRYCASCIN", "CARRYCASCOUT"] + [
            f"{port_name}[{idx}]"
            for port_name, bus_size in (("PCIN", 48), ("PCOUT", 48))
            for idx in range(bus_size)
        ]

        self.bram_inv_props = (
            ("IS_CLKARDCLK_INVERTED", "CLKARDCLK"),
            ("IS_CLKBWRCLK_INVERTED", "CLKBWRCLK"),
            ("IS_ENARDEN_INVERTED", "ENARDEN"),
            ("IS_ENBWREN_INVERTED", "ENBWREN"),
            ("IS_RSTRAMARSTRAM_INVERTED", "RSTRAMARSTRAM"),
            ("IS_RSTRAMB_INVERTED", "RSTRAMB"),
            ("IS_RSTREGARSTREG_INVERTED", "RSTREGARSTREG"),
            ("IS_RSTREGB_INVERTED", "RSTREGB"),
        )

    def run(self, phys_capnp: Path, edf_capnp: Path):
        """Adjust for implementation transformations and then compare design with capnp netlist."""
        start_time = time.time()
        self.run_rapidwright()

        # Switch logging to cmp directory
        logging.basicConfig(
            filename=self.cmp_log_path,
            filemode="w",
            format="%(asctime)s %(message)s",
            level=self.logging_level,
            datefmt="%Y%m%d%H%M%S",
            force=True,
        )
        # Redirect rapidwright output to file
        rapidwright_log_path = str(self.cmp_stage_dir / "rapidwright_stdout.log")
        System.setOut(PrintStream(File(rapidwright_log_path)))
        System.setErr(PrintStream(File(rapidwright_log_path)))

        self.load_capnp_design(phys_capnp, edf_capnp)
        comp_start_time = time.time()
        for ecell, site_inst, bel_name in self.phys_cells:
            self._compare_cell(ecell, site_inst, bel_name)
        self._check_nets()
        end_time = time.time()
        logging.info("Total Comparison Time: %s seconds", end_time - comp_start_time)
        logging.info("Total Transformation and Comparison Time: %s seconds", end_time - start_time)
        with open(self.cmp_stage_dir / "cmp_time.txt", "w") as f:
            f.write(f"{end_time - start_time:2f}\n")
        self.export_transformation()

    def load_capnp_design(self, phys_capnp: Path, edf_capnp: Path) -> None:
        """Load the capnp design and netlist."""
        logging.info("Loading reversed capnp objects: %s, %s", str(phys_capnp), str(edf_capnp))
        start_time = time.time()
        self.rev_netlist = LogNetlistReader.readLogNetlist(str(edf_capnp))
        self.rev_design = PhysNetlistReader.readPhysNetlist(str(phys_capnp), self.rev_netlist)
        self.rev_design.flattenDesign()
        self.rev_netlist.expandMacroUnisims(self.device.getSeries())
        logging.info("Loading reversed capnp objects took %s seconds.", time.time() - start_time)

        self.capnp_cells = CapnpCells(phys_capnp, edf_capnp)

    def get_properties_for_type(self, cell_type: str) -> tuple[str]:
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as err:
            raise StructuralCompareError(f"Unhandled properties for type {cell_type}") from err

    def handle_missing_prop(self, rev_cell: Cell, prop_name: str) -> int:
        """
        Sometimes properties from capnp are missing in the RapidWright data structure.
        So far this has only been LUT Init strings.
        """
        _, lcapnp_cell = self.capnp_cells.get_capnp_cell(rev_cell.getName())
        assert lcapnp_cell is not None
        rev_value = None

        for props in lcapnp_cell.propMap.entries:
            if self.capnp_cells.log_capnp.strList[props.key] == prop_name:
                rev_value = self.capnp_cells.log_capnp.strList[props.textValue]
                break
        assert rev_value is not None
        rev_value = utils.convert_verilog_literal_to_int(rev_value)
        self.rw_value_mismatch += 1
        self.rw_problem_cells.add(rev_cell.getName())
        logging.warning("Adding cell %s to rw problem cells", rev_cell.getName())
        return rev_value

    def _compare_cell(self, ecell: EDIFCellInst, site: SiteInst, bel_name: str) -> None:
        """
        Compare the post-implementation cell to the reversed cell.

        ecell: The transformed edif cell (used for properties and connections)
        log_name: Logical name of the cell
        cell: The original post-implementation cell (used for location data)
        """
        rev_cell = self.rev_design.getSiteInst(site.getSiteName()).getCell(bel_name)
        rev_hcell = rev_cell.getEDIFHierCellInst()
        cell_type = rev_hcell.getCellType().getName()
        if cell_type.startsWith("RAM") and cell_type[3] != "B":
            rev_hcell = rev_hcell.getParent()
            cell_type = rev_hcell.getCellType().getName()
        elif cell_type in ("IBUF", "OBUF") and rev_hcell.getParent().getParent() is not None:
            rev_hcell = rev_hcell.getParent()
            ecell = site.getCell(rev_cell.getBELName()).getEDIFHierCellInst().getParent().getInst()
            cell_type = rev_hcell.getCellType().getName()
        elif cell_type == "DSP48E1":
            self.fix_rev_dsp(rev_cell)
            
        logging.info(
            "Comparing cell %s on BEL %s to reversed cell %s",
            str(ecell),
            bel_name,
            rev_cell.getName(),
        )
        viv_type = ecell.getCellType().getName()
        if (
            viv_type != cell_type
            and "LUT" not in viv_type
            and (viv_type, cell_type) != ("SRL16E", "SRLC16E")
        ):
            raise StructuralCompareError(
                f"Cell type {viv_type} does not match reversed cell " + f"{cell_type}."
            )

        # Check properties
        cell_props = ecell.getPropertiesMap()  # The regular cell may have out of date properties
        rev_props = rev_hcell.getInst().getPropertiesMap()
        keys = set(self.get_properties_for_type(viv_type))

        if keys > set(rev_props.keys()):
            raise StructuralCompareError(
                f"{keys - set(rev_props.keys())} not in rev cell {rev_cell} properties."
            )

        for name in keys:
            value = utils.convert_verilog_literal_to_int(cell_props[name].getValue())
            rev_value = utils.convert_verilog_literal_to_int(rev_props[name].getValue())

            if rev_value != value:
                capnp_rev_value = self.handle_missing_prop(rev_cell, name)
                if capnp_rev_value != value:
                    if name == "INIT":
                        raise StructuralCompareError(
                            f"Property {name} in rev cell {rev_cell.getName()} does not match. "
                            + f"({hex(value)} != {hex(capnp_rev_value)} != {hex(rev_value)})"
                        )
                    raise StructuralCompareError(
                        f"Property {name} in rev cell {rev_cell.getName()} does not match. "
                        + f"({value} != {capnp_rev_value} != {rev_value}"
                    )

        self.matches[ecell.getName()] = (ecell, site, rev_cell, rev_hcell)

    def _compare_shared_lut_pins(
        self, rev_port_insts: dict[str, EDIFHierPortInst], other_lut: EDIFHierCellInst
    ) -> None:
        """
        Compare the shared pins of LUT6 and LUT5 cells to ensure they match.
        This is used when a LUT6_2 cell is split into a LUT6 and LUT5.
        """
        for port_name in ("I0", "I1", "I2", "I3", "I4"):
            if port_name not in rev_port_insts:
                assert other_lut.getPortInst(port_name) is None
                continue
            l6_net = rev_port_insts[port_name].getHierarchicalNet()
            l5_net = other_lut.getPortInst(port_name).getHierarchicalNet()
            assert l6_net == l5_net

    def update_lut_ports(self, rev_cell: Cell, rev_port_insts: dict[str, EDIFHierPortInst]) -> None:
        """Update port_insts on the reversed LUT to reflect the combined LUT6_2 cell."""
        assert "O6" not in rev_port_insts
        assert "O5" not in rev_port_insts

        if rev_cell.getType() == "LUT6":
            rev_port_insts["O6"] = rev_port_insts.pop("O")
            rev_lut5 = rev_cell.getSiteInst().getCell(f"{rev_cell.getBELName()[0]}5LUT")
            if rev_lut5 is not None:
                rev_hecell_lut5 = rev_lut5.getEDIFHierCellInst()
                o5 = rev_hecell_lut5.getPortInst("O")
                if o5 is not None:
                    rev_port_insts["O5"] = o5
                if __debug__:  # Sanity check input nets are the same on shared pins
                    self._compare_shared_lut_pins(rev_port_insts, rev_hecell_lut5)

        elif rev_cell.getType() == "LUT5":
            rev_port_insts["O5"] = rev_port_insts.pop("O")
            rev_lut6 = rev_cell.getSiteInst().getCell(f"{rev_cell.getBELName()[0]}6LUT")
            if rev_lut6 is not None:
                rev_hecell_lut6 = rev_lut6.getEDIFHierCellInst()
                rev_port_insts["O6"] = rev_hecell_lut6.getPortInst("O")
                rev_port_insts["I5"] = rev_hecell_lut6.getPortInst("I5")
                if __debug__:  # Sanity check input nets are the same on shared pins
                    self._compare_shared_lut_pins(rev_port_insts, rev_hecell_lut6)

    def _check_bram(self, name: str, ecell: EDIFCellInst, rev_cell: Cell) -> set[str]:
        """Special checks for BRAM"""
        ignore_pins = {"RSTRAMARSTRAM", "RSTRAMB"}
        mode = ecell.getProperty("RAM_MODE").getValue()
        if ecell.getProperty("DOA_REG").getValue() == "0":
            if ecell.getProperty("DOB_REG").getValue() == "0":
                ignore_pins.update(("RSTREGARSTREG", "RSTREGB", "REGCEAREGCE", "REGCEB"))
            elif mode == "TDP":
                ignore_pins.update(("RSTREGARSTREG",))
        bram_a_only = False
        if mode == "TDP":
            ignore_pins.update(("SBITERR", "ECCPARITY", "RDADDRECC"))
            # Continue check for bram_a_only
            port_gen = (ecell.getPortInst(f"DOBDO[{i}]") for i in range(32))
            ports = [p for p in port_gen if p is not None and not p.getNet().isGND()]
            bram_a_only = not ports
        if bram_a_only:
            ignore_pins.update(
                ("CASCADEINA", "CASCADEINB", "CASCADEOUTA", "CASCADEOUTB", "CLKBWRCLK", "ENBWREN")
            )

        # According to the BRAM docs, if SDP, then these ports are not used.
        if mode == "SDP":
            ignore_pins.update(
                (
                    "CASCADEINA",
                    "CASCADEINB",
                    "CASCADEOUTA",
                    "CASCADEOUTB",
                    "REGCEB",
                    "RSTREGB",
                    "WEA",
                )
            )

        if rev_cell.getType() == "RAMB36E1":
            # A15 is only connected to a non-const net when cascade is enabled
            # Right now, it seems vivado will connect to vcc, although unconnected is valid
            expected_props = (
                ecell.getProperty("RAM_EXTENSION_A").getValue() == '"NONE"'
                and ecell.getProperty("RAM_EXTENSION_B").getValue() == '"NONE"'
                and rw.is_static_net(ecell.getPortInst("ADDRARDADDR[15]").getNet())
                and rw.is_static_net(ecell.getPortInst("ADDRBWRADDR[15]").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEINA").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEINB").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEOUTA").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEOUTB").getNet())
            )
            if not expected_props:
                logging.warning("Unexpected BRAM properties for %s", name)

        self.fix_rev_bram(rev_cell, ignore_pins)

        return ignore_pins

    def _adjust_ports(
        self, rev_cell: Cell, rev_hecell: EDIFHierCellInst, name: str, ecell: EDIFCellInst
    ) -> tuple[list[EDIFPortInst], dict[str, EDIFHierPortInst]]:
        """Create port inst iterables based on cell type."""
        ecell_port_insts = list(ecell.getPortInsts())
        rev_port_insts = {p.getPortInst().getName(): p for p in rev_hecell.getHierPortInsts()}
        rev_type = rev_cell.getType()
        if rev_type.startsWith("LUT"):
            self.update_lut_ports(rev_cell, rev_port_insts)
        elif rev_type.startsWith("RAMB"):
            ignore_pins = self._check_bram(name, ecell, rev_cell)
            ecell_port_insts = [p for p in ecell_port_insts if p.getName() not in ignore_pins]
            rev_port_insts = {k: v for k, v in rev_port_insts.items() if k not in ignore_pins}
        elif (ecell.getCellType().getName(), rev_type) == ("SRL16E", "SRLC16E"):
            rev_port_insts.pop("Q15")  # Connects to F2B cell that doesn't drive anything
        return ecell_port_insts, rev_port_insts

    def _check_nets(self) -> None:
        """
        Check nets at the end once all transformations are done.
        Assume nets match -> throw an error if an already matched net is contradicted
        """
        for name, (ecell, _, rev_cell, rev_hecell) in self.matches.items():
            ecell_ports, rev_ports = self._adjust_ports(rev_cell, rev_hecell, name, ecell)
            for port in ecell_ports:
                net = port.getNet()
                if str(net) not in self.driver_cache:  # Get the driver for the net
                    try:
                        drv = f"{net.getName()}/{net.getSourcePortInsts(True)[0].getFullName()}"
                    except JException:  # Top I/O causes java excpetion in net.getSourcePortInsts
                        drv = str(net)
                    self.driver_cache[str(net)] = drv
                net_driver = self.driver_cache[str(net)]

                # Get the driver for the reversed net
                rev_port = rev_ports.pop(port.getName(), None)
                rev_net = rev_port.getHierarchicalNet() if rev_port is not None else None
                if rev_net is None:  # Assume ground connection
                    rev_net = self.rev_design.getGndNet()
                    rev_net = self.rev_netlist.getHierNetFromName(rev_net.getName())
                rev_net_driver = self._get_single_rev_driver(rev_port, rev_net, net_driver)

                # If the net is not in the mapping, add it
                if net_driver not in self.net_map:
                    logging.info(
                        "Mapping net %s drv port %s to drv %s based on cell/port %s mapped to %s",
                        net,
                        net_driver,
                        rev_net_driver,
                        str(port),
                        str(rev_port),
                    )
                    self.net_map[net_driver] = rev_net_driver

                # If the net is already mapped to a different rev net, raise an error
                elif self.net_map[net_driver] != rev_net_driver:
                    if net.isGND() and (
                        rev_port is None
                        or not rw.is_connected(rev_port)
                        or rev_port.getNet().isGND()
                    ):
                        # F2B port is connected to a net that does not have a real driver (GND).
                        continue

                    if rev_port is None:
                        rev_port = (
                            f"{rev_hecell.getFullHierarchicalInstName()} "
                            + "with Disconnected port... Assuming ground connection"
                        )

                    # p = self.capnp_cells.phys_capnp
                    # n = self.capnp_cells.log_capnp
                    # capnp_cell, lcapnp_cell = self.capnp_cells.get_capnp_cell(rev_cell.getName())
                    # logging.info(
                    #     f"Net {net_driver} on port {port.getName()} in cell {ecell.getName()}"
                    #     + f" already mapped. ({self.net_map[net_driver]} != {rev_net_driver})\n\t"
                    #     + f"Edif Cell/port: {port}  \n\t"
                    #     + f"Rev Edif Cell/port: {rev_port}"
                    # )
                    # logging.shutdown()
                    # utils.interpreter(locals())
                    raise StructuralCompareError(
                        f"Net {net_driver} on port {port.getName()} in cell {ecell.getName()}"
                        + f" already mapped. ({self.net_map[net_driver]} != {rev_net_driver})\n\t"
                        + f"Edif Cell/port: {name}/{port.getName()}  \n\t"
                        + f"Rev Edif Cell/port: {str(rev_port)}"
                    )

            for port in rev_ports.values():
                # These ports are disconnected in the Vivado design
                if rw.is_connected(port):
                    raise StructuralCompareError(
                        f"Reverse Port {port} in cell {name} is "
                        + "connected, but disconnected in Vivado"
                    )

    def _get_single_rev_driver(
        self, rev_port: EDIFHierPortInst, rev_net: EDIFHierNet, driver: str
    ) -> str:
        """
        Helper to return exactly one driver-string for rev_net,
        caching results and handling the 2-driver IBUF case.
        """
        if rev_port in self.rev_driver_cache:
            return self.rev_driver_cache[rev_port]
        drv = rev_net.getLeafHierPortInsts(True, False)
        if not drv:  # fallback for top-level I/Os
            drv = [p for p in rev_net.getPortInsts() if p.isInput()]
            if len(drv) == 2:  # IBUF nets: pick the one that matches driver
                top_io = driver.split("/")[-1]
                drv = [l for l in drv if str(l) == top_io]
        assert len(drv) == 1, f"Expected 1 driver on {rev_net}, found {drv}"
        drv = str(drv[0])
        if rev_net not in self.rev_net_cache:  # Often only one port is missing.
            self.rev_net_cache.add(rev_net)
            sinks = rev_net.getLeafHierPortInsts(False, True)
            for s in sinks:  # This is way faster than dict.update(dict.from_keys(sinks,drv))
                self.rev_driver_cache[s] = drv
            self.rev_driver_cache[drv] = drv
        self.rev_driver_cache[rev_port] = drv
        return drv

    def fix_rev_dsp(self, cell: Cell) -> None:
        """
        Fasm2bels does not accurately set the OPMODE, ALUMODE, INMODE pins.
        The fasm file specifies some incoming nets to these ports should be
        inverted, but the f2b code does not do anything with this information.
        I have added some code to add a custom property to the DSP48E2 for these
        values. Check the dsp properties and adjust the input signals accordingly.
        """
        logging.info("Processing reversed DSP %s for inverted signals", cell.getName())
        ecell = cell.getEDIFCellInst()
        assert ecell

        # XRAY erroneously does not output feature to invert carryin signal.
        rw.flip_const_port_signal(self.rev_design, ecell, "CARRYIN")

        name = cell.getSite().getName()
        viv_cell = self.vivado_design.getSiteInstFromSiteName(name).getCell(cell.getBELName())
        viv_cell = viv_cell.getEDIFCellInst()
        for port_name in self.dsp_constant_ports:
            viv_port_inst = viv_cell.getPortInst(port_name)
            if viv_port_inst is None or viv_port_inst.getNet().isGND():
                logging.info("Disconnecting %s port", port_name)
                port_inst = ecell.getPortInst(port_name)
                assert port_inst
                port_inst.getNet().removePortInst(port_inst)

        # Flip dsp signals according to f2b properties
        for prop, port_name in self.dsp_inv_props:
            val = ecell.getProperty(prop).getValue()
            for idx, inv in enumerate(reversed(val[3:])):
                if not int(inv):
                    continue
                rw.flip_const_port_signal(self.rev_design, ecell, f"{port_name}[{idx}]", idx)
        if ecell.getProperty("IS_CLK_INVERTED").getValue() == "1'b1":
            rw.flip_const_port_signal(self.rev_design, ecell, "CLK")

        # FASM2BELS just sets USE_MULT to "MULTIPLY" -> infer new value based on OPMODE
        # If opmode is not constant, then the value is DYNAMIC
        # The multiply unit (output) is only used if opmode[3:0] = 4'b0101
        opmode = [
            ecell.getPortInst(port_name).getNet()
            for port_name in ("OPMODE[3]", "OPMODE[2]", "OPMODE[1]", "OPMODE[0]")
        ]
        if [net for net in opmode if not rw.is_static_net(net)]:
            logging.info("Nonconstant OPMODE: Setting USE_MULT to DYNAMIC for %s", cell.getName())
            ecell.addProperty("USE_MULT", JString("DYNAMIC"))
        elif [net.isVCC() for net in opmode] != [False, True, False, True]:
            logging.info(
                "Constant OPMODE bypasses mult output. Setting USE_MULT to NONE for %s",
                cell.getName(),
            )
            ecell.addProperty("USE_MULT", JString("NONE"))

    def fix_rev_bram(self, cell: Cell, ignore_pins: set[str]) -> None:
        """
        Invert BRAM ports based on f2b properties.
        Ignore pins takes non zero timme, so skip if possible.
        """
        logging.info("Processing reversed BRAM %s for inverted signals", cell.getName())
        ecell = cell.getEDIFCellInst()
        assert ecell

        # Flip bram signals according to f2b properties
        for prop, port_name in (p for p in self.bram_inv_props if p[1] not in ignore_pins):
            val = int(str(ecell.getProperty(prop).getValue()))
            if val:
                rw.flip_const_port_signal(self.rev_design, ecell, port_name)


if __name__ == "__main__":
    parser = ArgumentParser()
    utils.add_path_arg(parser, "--impl_edf", "The implementation edf file to use for the netlist.")
    utils.add_path_arg(parser, "--impl_dcp", "The implementation dcp file to use for the netlist.")
    utils.add_path_arg(
        parser, "--phys_capnp", "The capnp file containing the reversed physical netlist."
    )
    utils.add_path_arg(
        parser, "--edf_capnp", "The capnp file containing the reversed logical netlist."
    )
    parser.add_argument(
        "--build_dir",
        type=str,
        required=True,
        help="The build_directory for transformation and comparison.",
    )
    parser.add_argument(
        "--logging_level", default="INFO", help="Decides what levels of logs to display"
    )
    parser.add_argument(
        "--log_name", type=str, default="log.txt", help="The log file path to use as output"
    )

    args = parser.parse_args()
    copmarator = StructuralCapnp(
        args.build_dir, (args.impl_dcp, args.impl_edf), args.logging_level, args.log_name
    )
    copmarator.run(phys_capnp=args.phys_capnp, edf_capnp=args.edf_capnp)
    # except StructuralCompareError as err:
    #     logging.error("Structural comparison failed: %s", err)
    #     exit(0)
