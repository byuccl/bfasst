"""Waveform equivalence checker. Uses WaFoVe for verification."""

import pathlib
import re
import yaml

from wafove import compare_waveforms
from wafove.templates import get_paths
from wafove.tools import analyze_graph

import bfasst
from bfasst.compare.base import CompareTool
from bfasst.config import VIVADO_BIN_PATH
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct


class WaveformCompareTool(CompareTool):
    """The main class for comparing the waveforms.
    Note: 2 functions are not included yet in this tool: Seed specification & testbench analysis.
    To include these functions, seed needs to be specified and the boolean value for all_signals
    needs to be specified. Seperate functions could be created for bfasst to do this, but for now
    they are hard-coded for the seed to be 0 & for all_signals to be set to false."""

    TOOL_WORK_DIR = "waveform"
    LOG_FILE_NAME = "log.txt"

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

    def compare_netlists(self, design):
        """The function that compares the netlists."""

        print("\nRunning WaFoVe to compare netlists...")
        print(f"Number of tests being run: {self.args.tests}")
        print(f"Seed: {self.args.seed}")
        print(f"Testing against all internal signals: {self.args.allSignals}")
        print(f"Displaying waveforms via Gtkwave: {self.args.waveform}")
        print(f"Displaying waveforms via Vivado: {self.args.vivado}\n")

        log_path = self.work_dir / self.LOG_FILE_NAME
        generate_comparison = ToolProduct(None, log_path, self.check_compare_status)
        status = self.get_prev_run_status(
            tool_products=(generate_comparison,),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime,
                design.reversed_netlist_path.stat().st_mtime,
            ),
        )

        if status is not None:
            self.print_skipping_compare()
            return status

        self.print_running_compare()

        # Gets all paths used for file-generation
        paths = get_paths.get_paths(
            self.work_dir,
            bfasst.paths.ROOT_PATH / ("third_party/yosys/techlibs/xilinx/cells_sim.v"),
            bfasst.paths.ROOT_PATH / ("third_party/WaFoVe/wafove/templates/sample_tb.v"),
            bfasst.paths.ROOT_PATH / ("third_party/WaFoVe/wafove/tools/"),
            design.impl_netlist_path,
            design.reversed_netlist_path,
        )

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
                return Status(CompareStatus.NOT_EQUIVALENT)
            return Status(CompareStatus.SUCCESS)

        multiple_files = self.check_multiple_files(design)
        # Checks if there are multiple verilog files in the design.

        for i in range(2):
            if paths["tb"][i].exists():
                paths["tb"][i].unlink()

        compare_waveforms.generate_files(
            multiple_files, paths, self.args.tests, self.args.seed, self.args.allSignals
        )

        if compare_waveforms.run_test(paths):
            return Status(CompareStatus.SUCCESS)

        return Status(CompareStatus.NOT_EQUIVALENT)

    def check_multiple_files(self, design):
        """A function to check if there are multiple verilog files in a design or not. Used later in
        parsing stages due to different logic being needed. Assumed true if no design exists."""

        if design is None:
            return True

        with open(design.yaml_path, "r") as fp:
            design_props = yaml.safe_load(fp)

        return ("included_all_verilog_files" in design_props) or (
            "include_all_system_verilog_files" in design_props
        )

    def check_compare_status(self, log_path):
        """Used to confirm whether a design is equivalent or not."""
        with open(log_path, "r") as log:
            log_text = log.read()

        # Check for timeout
        if re.search("^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        i = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
        if i.group(1) == "PASS":
            return Status(CompareStatus.SUCCESS)
        return Status(CompareStatus.NOT_EQUIVALENT, i.group(1))
