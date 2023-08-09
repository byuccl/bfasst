"""This module provides a class that uses rapidwright to create a 
vivado netlist that has only physical primitives."""
from argparse import ArgumentParser
import jpype
import jpype.imports
from jpype.types import JInt
from java.lang import System
from java.io import PrintStream, File
from bfasst.paths import DESIGNS_PATH, ROOT_PATH
import bfasst.rw_helpers as rw


class RwPhysNetlist:
    """Use rapidwright to create a vivado netlist that has only physical primitives."""

    def __init__(self, design):
        self.build = ROOT_PATH / "build" / design / "vivado_phys_netlist"

        self.rw_design = None
        self.rw_netlist = None

        # constant nets
        self.vcc = None
        self.gnd = None

        # cells to use for new primitives
        self.lut6_2_edif_cell = None
        self.ram32x1s_edif_cell = None
        self.ram32x1s1_edif_cell = None
        self.ram32x1d_edif_cell = None
        self.ram32m_edif_cell = None
        self.bufgctrl_edif_cell = None

        # Keep a list of old rep.laced cells to remove after processing
        self.cells_to_remove = []

        self.lut_pair_bel_names = [
            ("A6LUT", "A6LUT_O6", "A5LUT", "A5LUT_O5"),
            ("B6LUT", "B6LUT_O6", "B5LUT", "B5LUT_O5"),
            ("C6LUT", "C6LUT_O6", "C5LUT", "C5LUT_O5"),
            ("D6LUT", "D6LUT_O6", "D5LUT", "D5LUT_O5"),
        ]

    def run(self):
        """Run the netlist generator to create a vivado netlist
        that has only physical primitives."""
        phys_netlist_verilog_path = self.build / "viv_impl_physical.v"
        phys_netlist_edif_path = self.build / "viv_impl_physical.edf"

        # Redirect rapidwright output to a log file
        rapdiwright_log_path = self.build / "rapidwright.log"
        System.setOut(PrintStream(File(rapdiwright_log_path)))

        phys_netlist_checkpoint = self.build / "phys_netlist.dcp"

        try:
            self.run_rapidwright(phys_netlist_checkpoint, phys_netlist_edif_path)
        except jpype.JException as ex:
            raise rw.RapidwrightException from ex

        vivado_log_path = self.build / "vivado_edf_to_v.log"


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--design", type=str, required=True, help="The design to create a vivado netlist for."
    )
    args = parser.parse_args()
    netlist_generator = RwPhysNetlist(args.design)
    netlist_generator.run()
