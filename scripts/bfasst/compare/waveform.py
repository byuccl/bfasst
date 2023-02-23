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

    def compare_netlists(self, design, run_waveform, tests, vivado):
        """The function that compares the netlists."""
        seed = 0  # Change this w/ a new input at a later time
        all_signals = False  # Change this w/ a new input at a later time

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
            design.impl_netlist_path,
            design.reversed_netlist_path,
        )

        if run_waveform & (paths["vcd"][0].exists() & paths["vcd"][1].exists()):
            if vivado:
                analyze_graph.analyze_graphs(
                    paths["build_dir"],
                    paths["modules"][1],
                    paths["modules"][2],
                    (bfasst.paths.ROOT_PATH),
                    VIVADO_BIN_PATH,
                    False,
                )
            else:
                analyze_graph.analyze_graphs(
                    paths["build_dir"],
                    paths["modules"][1],
                    paths["modules"][2],
                    (bfasst.paths.ROOT_PATH),
                    "none",
                    False,
                )
            if paths["diff"].exists():
                return Status(CompareStatus.NOT_EQUIVALENT)
            return Status(CompareStatus.SUCCESS)

        multiple_files = self.check_multiple_files(design)
        # Checks if there are multiple verilog files in the design.

        for i in range(2):
            if paths["tb"][i].exists():
                paths["tb"][i].unlink()

        compare_waveforms.generate_files(multiple_files, paths, tests, seed, all_signals)

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
