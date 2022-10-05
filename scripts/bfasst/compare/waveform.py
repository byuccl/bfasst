# Waveform equivalence checker. Designed by Jake Edvenson.
# Relies on gtkwave, icarus-verilog, spydrnet, and numpy.
# To use this script, use ./scripts/run_design.py (DESIGN_PATH) xilinx_yosys_waveform
# The rest of the script should be self-explanitory. I've included a lot of user-prompts to make it very user-friendly.
# If vivado or F4PGA ever change there netlist-generating style, this file may need to be edited.
# I would check the fix_file function because this file currently alters the netlists so that spydrnet can parse them.

import pathlib
import re
import bfasst
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct

# Note: All of the tools below cna be found in the compare_waveforms directory. Each covers a part of the waveform toolchain
from bfasst.compare_waveforms.tools import analyze_graph
from bfasst.compare_waveforms.file_parsing import file_rewriter, parse_diff, parse_files
from bfasst.compare_waveforms.file_generation import (
    testbench_generator,
    tcl_generator,
    waveform_generator,
)
from bfasst.compare_waveforms.templates import get_paths
from bfasst.compare_waveforms.interface import waveform_interface


class Waveform_CompareTool(CompareTool):
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

        paths = get_paths.get_paths(self.work_dir, bfasst.paths.ROOT_PATH, design)
        # Gets all paths used for file-generation

        if runInterface:
            # If the quick flow is chosen, interface is skipped and so is viewing the actual waveforms.
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
            self.generate_files(multiple_files, paths)
            if self.run_test(paths):
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

    def generate_files(self, multiple_files, paths):
        """The main function that generates testbenches and TCL files. It begins by calling the parsers for the input & output names, then
        it calls the testbench generators, finally it calls the TCL generators. It then increments to the next file and clears the data structure."""
        test_num = 100  # Change this number if you want to run more or less than 100 tests in the testbench.
        data = {}  # Contains all of the IOs for the design.
        file_rewriter.copy_files(paths)
        # Creates copies of the netlists that will be modified by the file_rewriter
        for i in range(2):
            with open(paths["path"][i], "r") as file:

                if i == 1:
                    file_rewriter.fix_file(paths, i)
                    # Rewrites the files to have correct module names
                    data = parse_files.parse_reversed(paths, i)
                    # Finds the IO names and bit sizes
                    paths["test"].unlink()  # Gets rid of the test.v file

                else:
                    file_rewriter.fix_file(paths, i)
                    # Rewrites the files to have correct module names
                    if multiple_files:
                        # The logic for how to parse the file depends on whether or not there are multiple verilog files involved in a design
                        data = parse_files.parse_reversed(paths, i)
                        # Finds the IO names and bit sizes
                    else:
                        data = parse_files.parse(file.name)

                if i == 0:
                    # Create the initial testbench with randomized inputs for all input ports (based upon bit-size)
                    testbench_generator.generate_first_testbench(
                        paths, test_num, data, i
                    )
                else:  # Build off of the old testbench to keep the same randomized values
                    testbench_generator.generate_testbench(paths, data, i)

                if i == 0:
                    tcl_generator.generate_first_TCL(paths, data, i)
                    # The first TCL will be generated based upon the IO port names
                else:
                    tcl_generator.generate_TCL(paths, i)
                    # The second TCL just needs to change module names from the first one

                waveform_generator.generate_VCD(paths, i)
                # All previously generated files are ran through Icarus and then GTKwave, creating the files we need.

    def run_test(self, paths):
        """A function that generates the wavefiles from the testbenches, runs gtkwave w/ the TCLs generated earlier on the wavefiles
        that have just been generated, then checks the difference between gtkwave's two outputs. If there are more than 32 lines that
        are different, the designs must be unequivalent."""
        return parse_diff.check_diff(paths)
        # Checks the two VCD files against each other. Returns either equivalent or not depending on how many lines are different.

    def check_compare_status(self, log_path, default=CompareStatus.NOT_EQUIVALENT):
        with open(log_path, "r") as log:
            log_text = log.read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        m = re.search(r"Equivalence successfully proven!", log_text, re.M)
        if m:
            return Status(CompareStatus.SUCCESS)

        m = re.search(r"ERROR", log_text, re.M)
        if m:
            return Status(CompareStatus.NOT_EQUIVALENT)

        return default
