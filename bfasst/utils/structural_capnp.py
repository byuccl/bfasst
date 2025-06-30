"""
Check two netlists for structural equivalence using location data.
"""

from argparse import ArgumentParser
import logging
from pathlib import Path
import time

# pylint: disable=no-name-in-module
from jpype import JException

# pylint: enable=no-name-in-module
from bfasst import jpype_jvm
from bfasst import utils
from bfasst.utils.f2b_design import F2BDesign
import bfasst.utils.rw_helpers as rw
from bfasst.utils.rw_phys_netlist import RwPhysNetlist
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

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class StructuralCapnp(RwPhysNetlist, F2BDesign):
    """
    Compare a vivado dcp with a capnp netlist for structural equivalence.

    Runs RWPhysNetlist to adjust for transformations that occur during implementation.
    """

    def __init__(
        self,
        build_dir: str,
        impl_checkpoint: tuple[Path, Path],
        phys_capnp: Path,
        edf_capnp: Path,
        logging_level: str,
        log_name: str,
    ) -> None:
        self.cmp_stage_dir = Path(build_dir) / "capnp_cmp"
        self.cmp_stage_dir.mkdir(parents=True, exist_ok=True)
        rw_log = str(self.cmp_stage_dir / "rapidwright_stdout.log")
        super().__init__(  # Python analyzes named args to pass to the appropriate parent constructor
            build_dir=build_dir,
            impl_checkpoint=impl_checkpoint,
            logging_level=logging_level,
            log_name=log_name,
            impl_capnp=phys_capnp,
            edf_capnp=edf_capnp,
            f2b_rw_log=rw_log,
        )
        self.cmp_log_path = self.cmp_stage_dir / log_name.split("/")[-1]
        self.logging_level = logging_level

        self._cell_props = create_cell_props()

        self.matches = {}  # VivadoEDIFName: (vivado_edif_cell, SiteInst, rev_cell)
        # nets are named based on the net driver.
        self.net_map = {}  # net names: [net names and alias nets] (vivado: rev)
        self.driver_cache = {}  # EDIFNet: driver_full_name_str
        self.rev_net_cache = set()  # Set to avoid reprocessing nets
        self.rev_driver_cache = {}  # EDIFHierPortInst: driver_full_name_str
        self.lut_gnd_net = set()

    def run(self):
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

        comp_start_time = time.time()
        for ecell, site_inst, bel_name in self.phys_ecells:
            self._compare_cell(ecell, site_inst, bel_name)
        self._check_nets()
        end_time = time.time()
        logging.info("Total Comparison Time: %s seconds", end_time - comp_start_time)
        logging.info("Total Transformation and Comparison Time: %s seconds", end_time - start_time)
        with open(self.cmp_stage_dir / "cmp_time.txt", "w") as f:
            f.write(f"{end_time - start_time:2f}\n")
        self.export_transformation()

    def get_properties_for_type(self, cell_type: str) -> tuple[str]:
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as err:
            raise StructuralCompareError(f"Unhandled properties for type {cell_type}") from err

    def _compare_cell(self, ecell: EDIFCellInst, site: SiteInst, bel_name: str) -> None:
        """
        Compare the post-implementation cell to the reversed cell.

        ecell: The transformed edif cell (used for properties and connections)
        log_name: Logical name of the cell
        cell: The original post-implementation cell (used for location data)
        """
        try:
            rev_cell = self.rev_design.getSiteInst(site.getSiteName()).getCell(bel_name)
        except AttributeError:
            # Sometimes F2B misses a LUT GND generator directly driving the O6 site pin output.
            assert bel_name.startswith("LUT")
            init = ecell.getProperty("INIT").getValue()
            assert utils.convert_verilog_literal_to_int(init) == 0
            logging.warning("F2B missed lut gnd gen at %s:%s", site.getSiteName(), bel_name)
            utils.interpreter(locals())
            self.lut_gnd_net.add(ecell.getPortInst("O"))

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
        elif cell_type == "BUFGCTRL":
            self.fix_rev_bufg(rev_cell)

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
        args.build_dir,
        (args.impl_dcp, args.impl_edf),
        args.phys_capnp,
        args.edf_capnp,
        args.logging_level,
        args.log_name,
    )
    copmarator.run()
    # except StructuralCompareError as err:
    #     logging.error("Structural comparison failed: %s", err)
    #     exit(0)
