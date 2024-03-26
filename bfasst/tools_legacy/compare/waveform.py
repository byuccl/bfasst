"""Waveform equivalence checker. Uses WaFoVe for verification."""

# pylint: skip-file

import re

from wafove import compare_waveforms
from wafove.templates import get_paths
from wafove.tools import analyze_graph

import bfasst
from bfasst.tools_legacy.compare.base import CompareTool, CompareException
from bfasst.config import VIVADO_BIN_PATH


class WaveformCompareTool(CompareTool):
    """The main class for comparing the waveforms.
    Note: 2 functions are not included yet in this tool: Seed specification & testbench analysis.
    To include these functions, seed needs to be specified and the boolean value for all_signals
    needs to be specified. Seperate functions could be created for bfasst to do this, but for now
    they are hard-coded for the seed to be 0 & for all_signals to be set to false."""

    TOOL_WORK_DIR = "waveform"

    def add_args(self):
        """Parses all input arguments for WaFoVe's bfasst implementation."""
        super().add_args()

        self.arg_parser.add_argument(
            "-a",
            "--allSignals",
            action="store_true",
            help="Compares all signals rather than IOs (Typically returns false).",
            default=False,
        )

        self.arg_parser.add_argument(
            "-f",
            "--fullScreen",
            action="store_true",
            help="Specifies if graphs should be viewed in fullscreen.",
            default=False,
        )

        self.arg_parser.add_argument(
            "-s",
            "--seed",
            action="store",
            help="The seed random will use to generate the specific testbench. Defaults to 0.",
            default=0,
        )

        self.arg_parser.add_argument(
            "-t",
            "--tests",
            action="store",
            help="The number of tests to run. If not set, defaults to 100.",
            default=100,
        )

        self.arg_parser.add_argument(
            "-v",
            "--verbose",
            action="store_true",
            help="Allows for printing of debugging info & tracing the tool's flow.",
            default=False,
        )

        self.arg_parser.add_argument(
            "--vivado",
            action="store_true",
            help="Additional argument for waveform, specifies the Vivado Bin Path to launch Vivado",
            default=False,
        )

        self.arg_parser.add_argument(
            "--waveform",
            action="store_true",
            help="Run gtkwave at the end of the verification process or on a previously ran test.",
            default=False,
        )

    def compare_netlists(self):
        """The function that compares the netlists."""
        self.launch()
        self.log("\nRunning WaFoVe to compare netlists...")
        self.log(f"Number of tests being run: {self.args.tests}")
        self.log(f"Seed: {self.args.seed}")
        self.log(f"Testing against all internal signals: {self.args.allSignals}")
        self.log(f"Displaying waveforms via Gtkwave: {self.args.waveform}")
        self.log(f"Displaying waveforms via Vivado: {self.args.vivado}\n")

        if self.up_to_date(self.check_compare_status):
            return

        self.print_running_compare()

        # Gets all paths used for file-generation
        paths = get_paths.get_paths(
            self.work_dir,
            bfasst.paths.ROOT_PATH / ("third_party/yosys/techlibs/xilinx/cells_sim.v"),
            bfasst.paths.ROOT_PATH / ("third_party/WaFoVe/wafove/templates/sample_tb.v"),
            bfasst.paths.ROOT_PATH / ("third_party/WaFoVe/wafove/tools/"),
            self.gold_netlist,
            self.rev_netlist,
        )

        # self.design.impl_netlist_path,
        # self.design.reversed_netlist_path,

        if self.args.waveform & (paths["vcd"][0].exists() & paths["vcd"][1].exists()):
            if self.args.vivado:
                analyze_graph.analyze_graphs(
                    paths["build_dir"],
                    paths["modules"][1],
                    paths["modules"][2],
                    paths["vivado"],
                    VIVADO_BIN_PATH,
                    self.args.fullScreen,
                )
            else:
                analyze_graph.analyze_graphs(
                    paths["build_dir"],
                    paths["modules"][1],
                    paths["modules"][2],
                    paths["vivado"],
                    "none",
                    self.args.fullScreen,
                )
            if paths["diff"].exists():
                raise CompareException("The netlists are not equivalent.")

        for i in range(2):
            if paths["tb"][i].exists():
                paths["tb"][i].unlink()

        compare_waveforms.generate_files(
            paths, self.args.tests, self.args.seed, self.args.allSignals
        )

        if not compare_waveforms.run_test(paths):
            raise CompareException("The netlists are not equivalent.")

        self.log("Equivalent")
        self.cleanup()

    def check_compare_status(self, log_path):
        """Used to confirm whether a design is equivalent or not."""
        with open(log_path, "r") as log:
            log_text = log.read()

        # Check for timeout
        if re.search("^Timeout$", log_text, re.M):
            raise CompareException("The waveform tool timed out.")

        # Regex search for result
        if re.search("^Not equivalent$", log_text, re.M):
            raise CompareException("Not equivalent")
