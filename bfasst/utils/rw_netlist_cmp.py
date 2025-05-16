from argparse import ArgumentParser
import bidict
import logging
from pathlib import Path
import sys
import time

import jpype
import jpype.imports
from jpype.types import JInt

from bfasst import jpype_jvm
from bfasst.config import PART
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.structural_helpers import create_cell_props
import bfasst.utils.rw_helpers as rw

import code
import traceback

# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import SiteTypeEnum, Device
from com.xilinx.rapidwright.design import Design, Unisim
from com.xilinx.rapidwright.edif import EDIFNet, EDIFPropertyValue, EDIFValueType
from com.xilinx.rapidwright.interchange import LogNetlistReader, PhysNetlistReader
from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class RwNetlistCmp:
    """
    Compare two interchange netlists using Rapidwright.
    """

    def __init__(self, build_dir, logging_level):
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / "netlist_cmp"
        (self.stage_dir / "log.txt").unlink(missing_ok=True)
        self.logging_level = logging_level
        logging.basicConfig(
            filename=self.stage_dir / "log.txt",
            format="%(asctime)s %(message)s",
            level=self.logging_level,
            datefmt="%Y%m%d%H%M%S",
        )
        # Redirect rapidwright output to file
        rapidwright_log_path = str(self.stage_dir / "rapidwright_stdout.log")
        System.setOut(PrintStream(File(rapidwright_log_path)))
        System.setErr(PrintStream(File(rapidwright_log_path)))

        self.vivado_design = None
        self.vivado_netlist = None
        self.rev_design = None
        self.rev_netlist = None

        self.phys_capnp = None
        self.log_capnp = None
        self.rw_value_mismatch = 0
        self.rw_value_mismatches = []

        self._cell_props = create_cell_props()

        self.matches = {}  # physical cell names - vivado: rev

    def get_properties_for_type(self, cell_type) -> tuple[str]:
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as err:
            raise StructuralCompareError(f"Unhandled properties for type {cell_type}") from err

    def compare(self, impl_dcp, impl_edf, phys_capnp, edf_capnp):
        """
        Compare the netlists.

        Log physical transformations made to the post-synthesis netlist.
        """
        device = Device.getDevice(PART)
        logging.info("Loading vivado dcp and edf files: %s, %s", str(impl_dcp), str(impl_edf))
        start_time = time.time()
        self.vivado_design = Design.readCheckpoint(impl_dcp, impl_edf)
        self.vivado_netlist = self.vivado_design.getNetlist()
        self.vivado_design.flattenDesign()
        self.vivado_netlist.expandMacroUnisims(device.getSeries())
        logging.info("Loading vivado netlist took %s seconds.", time.time() - start_time)
        logging.info("Loading reversed capnp objects: %s, %s", str(phys_capnp), str(edf_capnp))
        start_time = time.time()
        self.rev_netlist = LogNetlistReader.readLogNetlist(str(edf_capnp))
        self.rev_design = PhysNetlistReader.readPhysNetlist(str(phys_capnp), self.rev_netlist)
        self.rev_netlist.expandMacroUnisims(device.getSeries())
        logging.info("Loading reversed capnp objects took %s seconds.", time.time() - start_time)

        self.phys_capnp = rw.read_phys_capnp(str(phys_capnp))
        self.log_capnp = rw.read_log_capnp(str(edf_capnp))

        logging.info("Starting netlist comparison and inspection.")
        start_time = time.time()
        self._check_sites()
        logging.info("Netlist comparison took %s seconds.", time.time() - start_time)

    def get_capnp_cell(self, cell_name):
        p = self.phys_capnp
        n = self.log_capnp
        for pidx, tmp in enumerate(p.strList):
            if tmp == cell_name:
                break
        else:
            pidx = None
        for capnp_cell in p.placements:
            if capnp_cell.cellName == pidx:
                break
        else:
            capnp_cell = None

        for lidx, tmp in enumerate(n.strList):
            if tmp == cell_name.split("/")[0]:
                break
        else:
            lidx = None

        for lcapnp_cell in n.instList:
            if lcapnp_cell.name == lidx:
                break
        else:
            lcapnp_cell = None

        return capnp_cell, lcapnp_cell

    def check_lut_transformation(self, site, ecell, cell, rev_cell):
        """Check for pin reordering and lut combinations"""
        # Check pin reordering

        code.interact(local=dict(globals(), **locals()))

    def _check_sites(self):
        """ "
        Check each site for implementation transformations and equality"
        """
        try:
            vivado_gnd = self.vivado_design.getGndNet()
            vivado_vcc = self.vivado_design.getVccNet()
            rev_gnd = self.rev_design.getGndNet()
            rev_vcc = self.rev_design.getVccNet()
            for site in self.vivado_design.getSiteInsts():
                site_name = site.getName()
                site_type = str(site.getSiteTypeEnum())
                rev_site = self.rev_design.getSiteInst(site_name)
                assert rev_site
                logging.info("Checking site %s of type %s", site_name, site_type)

                cells = list(site.getCells())
                site_matches = {}
                while cells:
                    cell = cells.pop()
                    if not cell.isPlaced():
                        logging.info("Cell %s is not placed, skipping", cell.getName())
                        continue
                    bel_name = cell.getBELName()
                    rev_cell = rev_site.getCell(bel_name)
                    if rev_cell is None:
                        logging.info("Cell %s not found in rev site %s", cell.getName(), site_name)
                    assert rev_cell.isPlaced()
                    logging.info(
                        "Comparing cell %s on BEL %s to reversed cell %s",
                        cell.getName(),
                        bel_name,
                        rev_cell.getName(),
                    )

                    ecell = cell.getEDIFCellInst()  # check for cell in logical netlist
                    if ecell is None:  # check for transformation
                        logging.info("Cell not in logical netlist, checking for transformation")
                        pass

                    # check properties
                    cell_props = cell.getProperties()
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
                            # INIT String is not as expected - check transformation/rw bug
                            if "LUT" in bel_name:
                                self.check_lut_transformation(ecell, cell, rev_cell)

                            capnp_cell, lcapnp_cell = self.get_capnp_cell(rev_cell.getName())
                            assert lcapnp_cell is not None
                            cvalue = None
                            for props in lcapnp_cell.propMap.entries:
                                if n.strList[props.key] == name:
                                    cvalue = n.strList[props.textValue]
                                    break
                            assert cvalue is not None
                            cvalue = convert_verilog_literal_to_int(cvalue)
                            self.rw_value_mismatch += 1
                            self.rw_value_mismatches.append(
                                f"Property {name} in rev cell {rev_cell.getName()} does not match. ({value} != {rev_value})"
                            )
                            if cvalue != value:
                                # check for transformation
                                logging.info(
                                    "Check for transformation. Property %s in rev cell %s does not match. (%s != %s != %s)\n",
                                    name,
                                    rev_cell.getName(),
                                    cvalue,
                                    value,
                                    rev_value,
                                )

                    # check nets

                    site_matches[cell.getName()] = rev_cell.getName()
                # update master list
                self.matches.update(site_matches)

        except Exception as e:
            logging.shutdown()
            traceback.print_exc()
            print(f"RW errors: {self.rw_value_mismatch}")
            p = self.phys_capnp
            n = self.log_capnp
            assert rev_cell is not None
            for pidx, tmp in enumerate(p.strList):
                if tmp == rev_cell.getName():
                    break
            else:
                pidx = None
            for capnp_cell in p.placements:
                if capnp_cell.cellName == pidx:
                    break
            else:
                capnp_cell = None

            for lidx, tmp in enumerate(n.strList):
                if tmp == rev_cell.getName().split("/")[0]:
                    break
            else:
                lidx = None

            for lcapnp_cell in n.instList:
                if lcapnp_cell.name == lidx:
                    break
            else:
                lcapnp_cell = None

            code.interact(local=dict(globals(), **locals()))


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
        "--phys_capnp",
        type=Path,
        required=True,
        help="The capnp physical netlist to compare against",
    )
    parser.add_argument(
        "--edf_capnp",
        type=Path,
        required=True,
        help="The capnp logical netlist to compare against",
    )
    parser.add_argument(
        "--logging_level", default="INFO", help="Decides what levels of logs to display"
    )
    args = parser.parse_args()
    netlist_comparator = RwNetlistCmp(args.build_dir, args.logging_level)
    try:
        netlist_comparator.compare(args.impl_dcp, args.impl_edf, args.phys_capnp, args.edf_capnp)
    except jpype.JException as e:
        logging.error("ERROR: %s", e)
        sys.exit(1)

"""
python bfasst/utils/rw_phys_netlist.py --build_dir build/byu/riscv_final/ --impl_dcp build/byu/riscv_final/vivado_impl/impl.dcp --impl_edf build/byu/riscv_final/vivado_impl/viv_impl.edf --phys_capnp build/byu/riscv_final/xray/riscv_final_reversed_phys.capnp --edf_capnp build/byu/riscv_final/xray/riscv_final_reversed_log.capnp
"""
