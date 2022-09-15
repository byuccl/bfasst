# Waveform equivalence checker. Designed by Jake Edvenson.
# Relies on gtkwave, icarus-verilog, spydrnet, and numpy.
# To use this script, use ./scripts/run_design.py (DESIGN_PATH) xilinx_yosys_waveform
# The rest of the script should be self-explanitory. I've included a lot of user-prompts to make it very user-friendly.
# If vivado or F4PGA ever change there netlist-generating style, this file may need to be edited.
# I would check the fix_file function because this file currently alters the netlists so that spydrnet can parse them.

import bfasst
import pathlib
from bfasst.compare_waveforms.Tools import analyze_graph
from bfasst.compare_waveforms.File_Parsing import parse_diff
from bfasst.compare_waveforms.File_Parsing import parse_files
from bfasst.compare_waveforms.File_Generation import testbench_generator
from bfasst.compare_waveforms.File_Generation import tcl_generator
from bfasst.compare_waveforms.File_Generation import waveform_generator
from bfasst.compare_waveforms.File_Generation import file_rewriter 
import bfasst.paths
import re
import pathlib
import yaml
import shutil
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct

data = parse_files.data

"""A data structure used to store all of the paths so they aren't redefined in multiple functions."""
paths = {
    "modules": [],  # The list of module names (Ex: add4, add4_impl, add4_reversed)
    "build_dir": "",  # The base directory that files are stored in
    "path": [],  # Paths to the implicit and reversed netlists
    "file": [],  # Paths to the output files for the implicit and reversed netlists
    "diff": "",  # Path to the diff txt file
    "parsed_diff": "",  # Path to the parsed_diff txt file
    "vcd": [],  # Paths to the VCD files
    "tcl": [],  # Paths to the TCL files
    "tb": [],  # Paths to the testbench files
    "sample_tb": "",  # Path to the sample testbench used for creating the automatic testbench
}

"""The main class for comparing the waveforms."""


class Waveform_CompareTool(CompareTool):
    TOOL_WORK_DIR = "waveform"
    LOG_FILE_NAME = "log.txt"

    """The function that compares the netlists."""

    def compare_netlists(self, design, print_to_stdout=True):
        self.print_to_stdout = print_to_stdout
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
            if self.print_to_stdout:
                self.print_skipping_compare()
            return status

        if self.print_to_stdout:
            self.print_running_compare()

        paths["build_dir"] = self.work_dir
        paths["path"].append(design.impl_netlist_path)
        paths["path"].append(design.reversed_netlist_path)
        paths["file"].append(paths["build_dir"] / (paths["path"][0].name))
        paths["file"].append(paths["build_dir"] / (paths["path"][1].name))
        paths["modules"].append(
            paths["path"][0].name[0 : len(paths["path"][0].name) - 7]
        )
        paths["modules"].append(
            paths["path"][0].name[0 : len(paths["path"][0].name) - 2]
        )
        paths["modules"].append(
            paths["path"][1].name[0 : len(paths["path"][1].name) - 2]
        )
        paths["diff"] = paths["build_dir"] / "diff.txt"
        paths["vcd"].append(paths["build_dir"] / (paths["modules"][1] + ".vcd"))
        paths["vcd"].append(paths["build_dir"] / (paths["modules"][2] + ".vcd"))
        paths["dsn"] = paths["build_dir"] / ("dsn")
        paths["cells_sim"] = bfasst.paths.ROOT_PATH / (
            "third_party/yosys/techlibs/xilinx/cells_sim.v"
        )
        paths["sample_tb"] = bfasst.paths.ROOT_PATH / (
            "scripts/bfasst/compare_waveforms/Templates/sample_tb.v"
        )
        paths["tcl"].append(
            self.work_dir
            / (
                design.impl_netlist_path.name[
                    0 : len(design.impl_netlist_path.name) - 2
                ]
                + ".tcl"
            )
        )
        paths["tcl"].append(
            self.work_dir
            / (
                design.reversed_netlist_path.name[
                    0 : len(design.reversed_netlist_path.name) - 2
                ]
                + ".tcl"
            )
        )
        paths["parsed_diff"] = self.work_dir / ("parsed_diff.txt")

        shutil.copyfile(paths["path"][0], paths["build_dir"] / paths["path"][0].name)
        shutil.copyfile(paths["path"][1], paths["build_dir"] / paths["path"][1].name)

        # Added this in to check if there are multiple verilog files or not. This will present the user with a warning because
        # currently these can cause strange errors with equivalence checking.
        with open(design.yaml_path) as fp:
            design_props = yaml.safe_load(fp)

        multiple_files = False

        for k, v in design_props.items():
            # Handle 'include_all_verilog_files' option
            if k == "include_all_verilog_files":
                multiple_files = True
            # Handle 'include_all_system_verilog_files' option
            elif k == "include_all_system_verilog_files":
                multiple_files = True

        # This series of if/else statements is used to check if the tests have already been performed. If they have, an option is presented
        # for the user to view the previously-generated waveforms. If the design was unequivalent previously, the diff output will be
        # pasted into the linux terminal so they can view specific times in the waveform.

        if paths["diff"].exists():
            cont = input(
                "Design has already been tested and came back unequivalent. View Waveforms? Input 1 for yes, 0 for no."
            )
            if cont == "0":
                cont = input(
                    "Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no."
                )
                if cont == "0":
                    print("Ok. Ending Tests.")
                    return Status(CompareStatus.NOT_EQUIVALENT)
                else:
                    self.generate_files(multiple_files)
                    if self.run_test():
                        return self.success_status
                    else:
                        return Status(CompareStatus.NOT_EQUIVALENT)
            else:
                analyze_graph.analyze_graphs(paths["build_dir"], paths["modules"][0])
                return Status(CompareStatus.NOT_EQUIVALENT)
        elif paths["vcd"][0].exists() & paths["vcd"][1].exists():
            cont = input(
                "Design has already been tested and was equivalent. View Waveforms? Input 1 for yes, 0 for no."
            )
            if cont == "0":
                cont = input(
                    "Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no."
                )
                if cont == "0":
                    print("Ok. Ending Tests.")
                    return self.success_status
                else:
                    self.generate_files(multiple_files)
                    if self.run_test():
                        return self.success_status
                    else:
                        return Status(CompareStatus.NOT_EQUIVALENT)
            else:
                analyze_graph.analyze_graphs(paths["build_dir"], paths["modules"][0])
                return self.success_status
        else:
            # Calls the generate_files function to create the testbenches and TCLs necessary for gtkwave.
            self.generate_files(multiple_files)

            # Checks if the designs are equivalent. If they are, returns success. If not, asserts NOT_EQUIVALENT.
            if self.run_test():
                return self.success_status
            else:
                return Status(CompareStatus.NOT_EQUIVALENT)

    """The main function that generates testbenches and TCL files. It begins by calling the parsers for the input & output names, then
    it calls the testbench generators, finally it calls the TCL generators. It then increments to the next file and clears the data structure."""

    def generate_files(self, multiple_files):
        test_num = 100  # NOTE: Change this number if you want to run more than 100 tests in the testbench.
        file_name = [paths["modules"][1], paths["modules"][2]]
        for i in range(2):
            with open(paths["path"][i]) as file:

                if i==1:
                    file_rewriter.fix_file(paths, i)
                    data = parse_files.parse_reversed(paths["file"][i], False, file.name, i, paths)

                else:
                    file_rewriter.fix_file(paths, i)
                    if multiple_files:
                        data = parse_files.parse_reversed(paths["file"][1], multiple_files, file.name, i, paths)
                    else:
                        data = parse_files.parse(file.name)
                tb_path = (paths["build_dir"] / (file_name[i] + "_tb.v"))   
                if tb_path.exists():
                    tb_path.unlink()
                
                if i==0:
                    compare_path = paths["sample_tb"]

                else:
                    compare_path = paths["build_dir"] / (file_name[0] + "_tb.v")

                # Calls both the testbench and the TCL generators.
                with compare_path.open() as sample:
                    with tb_path.open("x") as tb:
                        for line in sample:
                            if i == 0:
                                testbench_generator.generate_first_testbench(
                                    tb, line, file_name, test_num, data
                                )
                            else:
                                testbench_generator.generate_testbench(
                                    tb, line, file_name, i, data
                                )

                if i == 0:
                    tcl_generator.generate_first_TCL(paths, file_name, i, data)
                else:
                    tcl_generator.generate_TCL(paths, file_name, i)

                waveform_generator.generate_VCD(
                    paths,
                    paths["file"][i],
                    tb_path,
                    paths["build_dir"] / (file_name[i] + ".tcl"),
                    paths["build_dir"] / (file_name[i] + "_temp.vcd"),
                    paths["build_dir"] / (file_name[i] + "_temp.vcd.fst"),
                )
                data = parse_files.clear_data(data)
        file_rewriter.rewrite_tcl(paths)

    """A function that generates the wavefiles from the testbenches, runs gtkwave w/ the TCLs generated earlier on the wavefiles
    that have just been generated, then checks the difference between gtkwave's two outputs. If there are more than 32 lines that
    are different, the designs must be unequivalent."""

    def run_test(self):
        return parse_diff.check_diff(paths)

    def check_compare_status(self, log_path):
        with open(log_path) as log:
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
