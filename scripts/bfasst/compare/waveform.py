"""Waveform equivalence checker. Designed by Jake Edvenson.
    Relies on gtkwave, icarus-verilog, spydrnet, and numpy.
    To use this script, use ./scripts/run_design.py (DESIGN_PATH)
    xilinx_yosys_waveform
    The rest of the script should be self-explanitory. I've included a lot of
    user-prompts to make it very user-friendly.
    If vivado or F4PGA ever change there netlist-generating style, this file may need to be edited.
    I would check the fix_file function because this file currently alters the netlists so that
    spydrnet can parse them."""

import pathlib
import re
import bfasst
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct
from bfasst.compare_waveforms.tools import analyze_graph
from bfasst.compare_waveforms.interface import waveform_interface
from bfasst.compare_waveforms.templates import get_paths
from bfasst.compare_waveforms import compare_waveforms


class WaveformCompareTool(CompareTool):
    """The main class for comparing the waveforms."""

    TOOL_WORK_DIR = "waveform"
    LOG_FILE_NAME = "log.txt"

    def compare_netlists(self, design, runInterface):
        """The function that compares the netlists."""
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

        paths = get_paths.get_paths(self.work_dir, bfasst.paths.ROOT_PATH /
        ("third_party/yosys/techlibs/xilinx/cells_sim.v"),
        bfasst.paths.ROOT_PATH / ("scripts/bfasst/compare_waveforms/templates/sample_tb.v"),
        design.impl_netlist_path, design.reversed_netlist_path)
        # Gets all paths used for file-generation

        if runInterface:
            # If the quick flow is chosen, interface is skipped and so is viewing the actual
            # waveforms.
            choice = waveform_interface.user_interface(paths)
            # Runs through the User interface, finds what the user wants to do.
        else:
            choice = 1

        multiple_files = waveform_interface.check_multiple_files(design)
        # Checks if there are multiple verilog files in the design.

        if choice == 0:
            # Previous Status was unequivalent and User doesn't want to do any tests.
            return Status(CompareStatus.NOT_EQUIVALENT)
        if choice == 1:  # User wants to re-generate files.
            # Remove old testbenches and generate new ones
            for i in range(2):
                if paths["tb"][i].exists():
                    paths["tb"][i].unlink()
            test_num = input("Input the Number of tests to run.")
            compare_waveforms.generate_files(multiple_files, paths, test_num)
            if compare_waveforms.run_test(paths):
                return self.success_status
        if choice == 2:
            # User wants to analyze graphs, previous Status was unequivalent
            analyze_graph.analyze_graphs(paths["build_dir"], paths["modules"][0])
        if choice == 3:
            # Previous Status was equivalent and User doesn't want to do any tests.
            return Status(CompareStatus.SUCCESS)
        if choice == 4:  # User wants to analyze graphs, previous status was equivalent
            analyze_graph.analyze_graphs(paths["build_dir"], paths["modules"][0])
            return Status(CompareStatus.SUCCESS)
        return Status(CompareStatus.NOT_EQUIVALENT)

    def check_compare_status(self, log_path, default=CompareStatus.NOT_EQUIVALENT):
        """Used to confirm whether a design is equivalent or not."""
        with open(log_path, "r") as log:
            log_text = log.read()

        # Check for timeout
        if re.search("^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        i = re.search("Equivalence successfully proven!", log_text, re.M)
        if i:
            return Status(CompareStatus.SUCCESS)

        i = re.search("ERROR", log_text, re.M)
        if i:
            return Status(CompareStatus.NOT_EQUIVALENT)

        return default
