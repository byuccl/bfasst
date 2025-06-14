"""
Check two netlists for structural equivalence using location data.
"""

from argparse import ArgumentParser
import logging
from itertools import groupby
from pathlib import Path
import sys
import time

import jpype

from bfasst import jpype_jvm
from bfasst.config import PART
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.capnp_cells import CapnpCells
from bfasst.utils.rw_phys_netlist import RwPhysNetlist
import bfasst.utils.rw_helpers as rw
from bfasst.utils.structural_helpers import create_cell_props


# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.design import SiteInst, Cell
from com.xilinx.rapidwright.edif import (
    EDIFCellInst,
    EDIFHierPortInst,
    EDIFHierNet,
    EDIFHierCellInst,
)
from com.xilinx.rapidwright.interchange import LogNetlistReader, PhysNetlistReader

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class StructuralCapnp(RwPhysNetlist):
    """
    Compare a vivado dcp with a capnp netlist for structural equivalence.

    Runs RWPhysNetlist to adjust for transformations that occur during implementation.
    """

    def __init__(self, build_dir: str, logging_level: str, log_name: str) -> None:
        super().__init__(build_dir, logging_level, log_name)
        self.rev_design = None
        self.rev_netlist = None
        self.capnp_cells = None

        self._cell_props = create_cell_props()

        self.rw_value_mismatch = 0
        self.rw_value_mismatches = []
        self.rw_problem_cells = set()
        self.rw_port_mismatch = 0
        self.rw_port_mismatch_cells = set()

        self.matches = {}  # vivado edif cell name: (vivado_edif_cell, rev_edif_cell)
        # nets are named based on the net driver.
        self.net_map = {}  # net names: [net names and alias nets] (vivado: rev)
        self.driver_cache = {}  # EDIFNet: driver_full_name_str
        self.rev_driver_cache = {}  # EDIFHierPortInst: driver_full_name_str

    def run(
        self, impl_dcp_path: Path, impl_netlist_edif_path: Path, phys_capnp: Path, edf_capnp: Path
    ):
        """Adjust for implementation transformations and then compare design with capnp netlist."""
        start_time = time.time()
        self.run_rapidwright(impl_dcp_path, impl_netlist_edif_path)
        self.load_capnp_design(phys_capnp, edf_capnp)
        comp_start_time = time.time()
        for ecell, site_inst, bel_name in self.phys_cells:
            self._compare_cell(ecell, site_inst, bel_name)
        self.fix_rev_dsps()
        self._check_nets()
        end_time = time.time()
        logging.info("Total Comparison Time: %s seconds", end_time - comp_start_time)
        logging.info("Total Transformation and Comparison Time: %s seconds", end_time - start_time)
        self.export_transformation()

    def load_capnp_design(self, phys_capnp: Path, edf_capnp: Path) -> None:
        """Load the capnp design and netlist."""
        logging.info("Loading reversed capnp objects: %s, %s", str(phys_capnp), str(edf_capnp))
        start_time = time.time()
        self.rev_netlist = LogNetlistReader.readLogNetlist(str(edf_capnp))
        self.rev_design = PhysNetlistReader.readPhysNetlist(str(phys_capnp), self.rev_netlist)
        self.rev_design.flattenDesign()
        self.rev_netlist.expandMacroUnisims(Device.getDevice(PART).getSeries())
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
        rev_value = convert_verilog_literal_to_int(rev_value)
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

        rev_cell = self.rev_design.getSiteInst(site.getName()).getCell(bel_name)

        logging.info(
            "Comparing cell %s on BEL %s to reversed cell %s",
            ecell.getName(),
            bel_name,
            rev_cell.getName(),
        )

        rev_ecell = rev_cell.getEDIFCellInst()

        if ecell.getCellType().getName() != rev_ecell.getCellType().getName():
            if "LUT" not in ecell.getCellType().getName():
                raise StructuralCompareError(
                    f"Cell type {ecell.getCellType().getName()} does not match reversed cell "
                    + f"{rev_ecell.getCellType().getName()}."
                )
            if __debug__:
                logging.warning(
                    "Warning: Comparing LUT cell %s to %s",
                    ecell.getCellType().getName(),
                    rev_ecell.getCellType().getName(),
                )

        # Check properties
        cell_props = ecell.getPropertiesMap()  # The regular cell may have out of date properties
        rev_props = rev_cell.getProperties()
        keys = self.get_properties_for_type(ecell.getCellType().getName())

        for name in keys:
            if name not in rev_props:
                raise StructuralCompareError(
                    f"Property {name} not in rev cell {rev_cell.getName()} properties."
                )
            value = convert_verilog_literal_to_int(cell_props[name].getValue())
            rev_value = convert_verilog_literal_to_int(rev_props[name].getValue())

            if rev_value != value:
                capnp_rev_value = self.handle_missing_prop(rev_cell, name)
                if capnp_rev_value != value:
                    raise StructuralCompareError(
                        f"Property {name} in rev cell {rev_cell.getName()} does not match. "
                        + f"({value} != {capnp_rev_value} != {rev_value}"
                    )

        self.matches[ecell.getName()] = (ecell, rev_cell, rev_ecell)

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

    def _check_nets(self) -> None:
        """
        Check nets at the end once all transformations are done.
        Assume nets match -> throw an error if an already matched net is contradicted
        """
        # Loop through each pair of matching cells
        for name, (ecell, rev_cell, _) in self.matches.items():
            ecell_port_insts = ecell.getPortInsts()
            rev_hecell = rev_cell.getEDIFHierCellInst()
            rev_port_insts = {p.getPortInst().getName(): p for p in rev_hecell.getHierPortInsts()}

            # Check each cell has the same number of connections
            if ecell.getCellType().getName() == "LUT6_2":
                self.update_lut_ports(rev_cell, rev_port_insts)

            # Get the corresponding ports
            for port in ecell_port_insts:
                # Get the driver for the net
                net = port.getNet()
                if net not in self.driver_cache:
                    drv = f"{net.getParentCell()}/{net.getSourcePortInsts(True)[0].getFullName()}"
                    self.driver_cache[net] = drv
                net_driver = self.driver_cache[net]

                # Get the driver for the reversed net
                rev_port = rev_port_insts.pop(port.getName(), None)
                rev_net = rev_port.getHierarchicalNet() if rev_port is not None else None
                if rev_net is None:
                    # Assume ground connection
                    rev_net = self.rev_design.getGndNet()
                    rev_net = self.rev_netlist.getHierNetFromName(rev_net.getName())
                rev_net_driver = self._get_single_rev_driver(rev_port, rev_net, net_driver)

                # If the net is not in the mapping, add it
                if net_driver not in self.net_map:
                    logging.info("Mapping net %s to %s", net_driver, rev_net_driver)
                    self.net_map[net_driver] = rev_net_driver

                # If the net is already mapped to a different rev net, raise an error
                elif self.net_map[net_driver] != rev_net_driver:
                    if net.isGND() and not rw.is_connected(rev_port):
                        # F2B port is connected to a net that does not have a real driver (GND).
                        continue

                    # check for routethru or const generator

                    if rev_port is None:
                        rev_port = (
                            f"{rev_hecell.getFullHierarchicalInstName()} "
                            + "with Disconnected port... Assuming ground connection"
                        )
                    self.rw_port_mismatch += 1
                    self.rw_port_mismatch_cells.add(rev_hecell.getFullHierarchicalInstName())
                    logging.shutdown()
                    # traceback.print_exc()
                    p = self.capnp_cells.phys_capnp
                    n = self.capnp_cells.log_capnp
                    capnp_cell, lcapnp_cell = self.capnp_cells.get_capnp_cell(rev_cell.getName())
                    import code

                    code.interact(local=dict(globals(), **locals()))
                    raise StructuralCompareError(
                        f"Net {net_driver} on port {port.getName()} in cell {ecell.getName()}"
                        + f" already mapped. ({self.net_map[net_driver]} != {rev_net_driver})\n\t"
                        + f"Edif Cell/port: {name}/{port.getName()}  \n\t"
                        + f"Rev Edif Cell/port: {str(rev_port)}"
                    )
            for port in rev_port_insts.values():
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
        if rev_port not in self.rev_driver_cache:
            leafs = rev_net.getLeafHierPortInsts(True, True)
            drivers = []
            sinks = []
            for k, g in groupby(leafs, key=lambda x: x.isOutput()):
                if k:
                    drivers.extend(g)
                else:
                    sinks.extend(g)
            if not drivers:
                # fallback for top-level I/Os
                drivers = [p for p in rev_net.getPortInsts() if p.isInput()]
                if len(drivers) == 2:
                    # IBUF nets: pick the one that matches driver
                    top_io = driver.split("/")[-1]
                    drivers = [l for l in drivers if str(l) == top_io]
            assert len(drivers) == 1, f"Expected 1 driver on {rev_net}, found {drivers}"

            tmp = dict.fromkeys(sinks, str(drivers[0]))
            self.rev_driver_cache.update(tmp)
            self.rev_driver_cache[drivers[0]] = str(drivers[0])
            self.rev_driver_cache[rev_port] = str(drivers[0])

        return self.rev_driver_cache[rev_port]

    def fix_rev_dsps(self) -> None:
        """
        Fasm2bels does not accurately set the OPMODE, ALUMODE, INMODE pins.
        The fasm file specifies some incoming nets to these ports should be
        inverted, but the f2b code does not do anything with this information.
        I have added some code to add a custom property to the DSP48E2 for these
        values. Check the dsp properties and adjust the input signals accordingly.
        """
        props = ("IS_INMODE_INVERTED", "IS_ALUMODE_INVERTED", "IS_OPMODE_INVERTED")
        constant_ports = ["CARRYCASCIN", "CARRYCASCOUT"] + [
            f"{port_name}[{idx}]"
            for port_name, bus_size in (("PCIN", 48), ("PCOUT", 48))
            for idx in range(bus_size)
        ]
        for cell in self.rev_design.getCells():
            if cell.getType() != "DSP48E1":
                continue
            logging.info("Processing reversed DSP %s for inverted signals", cell.getName())
            ecell = cell.getEDIFCellInst()
            assert ecell

            # XRAY erroneously does not output feature to invert carryin signal.
            rw.flip_const_port_signal(self.rev_design, ecell, "CARRYIN")

            # These signals are fixed routing paths in the FPGA (nonprogrammable). They are always
            # connected to the cooresponding neighbor DSP site in the tile. Internal to the site,
            # there is a mux that selects them. Dispite this, when they are unused, Vivado shows
            # them as connected to GND or simply disconnected. F2B shows the persistant connection
            # to the neighboring DSP site.
            # Other inputs control the mux, so as long as this matches, the cascade values
            # are irrelevant. See Xilinx UG479 Figure 2-1 for more information.
            site_name = cell.getSite().getName()
            viv_cell = self.vivado_design.getSiteInst(site_name).getCell(cell.getBELName())
            viv_ecell = viv_cell.getEDIFCellInst()
            for port_name in constant_ports:
                viv_port_inst = viv_ecell.getPortInst(port_name)
                if viv_port_inst is None or viv_port_inst.getNet().isGND():
                    logging.info("Disconnecting %s port", port_name)
                    port_inst = ecell.getPortInst(port_name)
                    assert port_inst
                    port_inst.getNet().removePortInst(port_inst)

            # Flip dsp signals according to f2b properties
            for prop in props:
                val = ecell.getProperty(prop).getValue()
                port_name = prop.split("_")[1]
                for idx, inv in enumerate(reversed(val[3:])):
                    if not int(inv):
                        continue
                    rw.flip_const_port_signal(self.rev_design, ecell, f"{port_name}[{idx}]", idx)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--build_dir",
        type=str,
        required=True,
        help="The build_directory for transformation and comparison.",
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
        "--phys_capnp",
        type=Path,
        required=True,
        help="The capnp file containing the reversed physical netlist.",
    )
    parser.add_argument(
        "--edf_capnp",
        type=Path,
        required=True,
        help="The capnp file containing the reversed logical netlist.",
    )
    parser.add_argument(
        "--logging_level", default="INFO", help="Decides what levels of logs to display"
    )
    parser.add_argument(
        "--log_name", type=str, default="log.txt", help="The log file path to use as output"
    )
    args = parser.parse_args()
    copmarator = StructuralCapnp(args.build_dir, args.logging_level, args.log_name)
    try:
        copmarator.run(
            impl_dcp_path=args.impl_dcp,
            impl_netlist_edif_path=args.impl_edf,
            phys_capnp=args.phys_capnp,
            edf_capnp=args.edf_capnp,
        )
    except (jpype.JException, rw.RapidwrightException) as e:  # pylint: disable=no-member
        logging.error("ERROR: %s", e)
        sys.exit(1)
