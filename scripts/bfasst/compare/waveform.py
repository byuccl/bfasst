#Waveform equivalence checker. Designed by Jake Edvenson.
#Relies on gtkwave, icarus-verilog, spydrnet, and numpy. 
#To use this script, use ./scripts/run_design.py (DESIGN_PATH) xilinx_yosys_waveform
#The rest of the script should be self-explanitory. I've included a lot of user-prompts to make it very user-friendly.
#If vivado or F4PGA ever change there netlist-generating style, this file may need to be edited.
#I would check the fix_file function because this file currently alters the netlists so that spydrnet can parse them. 

from pickle import FALSE
import bfasst
import pathlib
from bfasst.compare_waveforms import analyze_graph
from bfasst.compare_waveforms import parse_diff
import bfasst.paths
import re
import pathlib
import numpy as np
import spydrnet as sdn
import subprocess
import yaml
import shutil
from pathlib import Path
from random import randint
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct
from subprocess import Popen

# A data structure used to store the list of inputs, outputs, and their respective bits.
data = {
    "input_list": [],
    "input_bits_list": [],
    "output_list": [],
    "output_bits_list": [],
    "total_list": [],
    "random_list": [],
}

"""A function used to referesh all of the data in the data structure."""


def refresh(data):
    data["input_list"].clear()
    data["input_bits_list"].clear()
    data["output_list"].clear()
    data["output_bits_list"].clear()
    data["total_list"].clear()
    data["random_list"].clear()


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

        impl_path = design.impl_netlist_path
        module = impl_path.name[0 : len(impl_path.name) - 7]
        build_dir = self.work_dir
        diff = build_dir / "diff.txt"
        impl_vcd = build_dir / (module + "_impl.vcd")
        reversed_vcd = build_dir / (module + "_reversed.vcd")

        shutil.copyfile(impl_path, build_dir / design.impl_netlist_path.name)
        shutil.copyfile(design.reversed_netlist_path, build_dir / design.reversed_netlist_path.name)

        #print(self.work_dir)

        #Added this in to check if there are multiple verilog files or not. This will present the user with a warning because
        #currently these can cause strange errors with equivalence checking. 
        with open(design.yaml_path) as fp:
            design_props = yaml.safe_load(fp)
        
        giveWarning = False

        for k,v in design_props.items():
            # Handle 'include_all_verilog_files' option
            if k == "include_all_verilog_files":
                giveWarning = True
            # Handle 'include_all_system_verilog_files' option
            elif k == "include_all_system_verilog_files":
                giveWarning = True

        if giveWarning:
            cont = input("Warning: Detected multiple verilog files. Results may be inaccurate.\n Continue anyways? 1 for yes, 0 for no.")
            if(cont == "0"):
                print("Ok. Returning non-equivalent status.")
                return Status(CompareStatus.NOT_EQUIVALENT)

        #This series of if/else statements is used to check if the tests have already been performed. If they have, an option is presented
        # for the user to view the previously-generated waveforms. If the design was unequivalent previously, the diff output will be
        # pasted into the linux terminal so they can view specific times in the waveform.

        if(diff.exists()):
            cont = input("Design has already been tested and came back unequivalent. View Waveforms? Input 1 for yes, 0 for no.")
            if(cont == "0"):
                cont = input("Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no.")
                if(cont == "0"):
                    print("Ok. Ending Tests.")
                    return Status(CompareStatus.NOT_EQUIVALENT)
                else:
                    self.generate_files(design, giveWarning)
                    if self.run_test(design):
                        return self.success_status
                    else:
                        return Status(CompareStatus.NOT_EQUIVALENT)
            else:
                analyze_graph.analyze_graphs(build_dir, module)
                return Status(CompareStatus.NOT_EQUIVALENT)
        elif(impl_vcd.exists() & reversed_vcd.exists()):
            cont = input("Design has already been tested and was equivalent. View Waveforms? Input 1 for yes, 0 for no.")
            if(cont == "0"):
                cont = input("Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no.")
                if(cont == "0"):
                    print("Ok. Ending Tests.")
                    return self.success_status
                else:
                    self.generate_files(design, giveWarning)
                    if self.run_test(design):
                        return self.success_status
                    else:
                        return Status(CompareStatus.NOT_EQUIVALENT)
            else:
                analyze_graph.analyze_graphs(build_dir, module)
                return self.success_status
        else:
            # Calls the generate_files function to create the testbenches and TCLs necessary for gtkwave.
            self.generate_files(design, giveWarning)

            # Checks if the designs are equivalent. If they are, returns success. If not, asserts NOT_EQUIVALENT.
            if self.run_test(design):
                return self.success_status
            else:
                return Status(CompareStatus.NOT_EQUIVALENT)

    """A simple function to return the amount of data stored in the input list."""

    def input_num(self):
        return len(data["input_list"])

    """A simple function to return the total amount of data being stored as both inputs and outputs."""

    def total_num(self):
        return len(data["input_list"]) + len(data["output_list"])

    """A function to fix syntax issues that spydrnet commonly has with xilinx-generated or reverse-generated netlists."""

    def fix_file(self, path, file_name, is_reversed):
        with path.open("r") as fin:
            file_data = fin.read()
            if is_reversed:
                file_data = file_data.replace(
                    "module top(", "module " + file_name + "("
                )
            else:
                file_data = file_data.replace(
                    "module " + file_name[0 : len(file_name) - 5] + "\n",
                    "module " + file_name
                )
        with path.open("w") as fin:
            fin.write(file_data)

    """Uses spydrnet to analyze the netlist and add the names of all inputs, outputs, and their respective bit sizes to the data structure."""

    def parse(self, file):
        netlist = sdn.parse(file)
        library = netlist.libraries[0]
        definition = library.definitions[0]

        # Use design.yaml_path to find yaml file. Read to find if more modules exist.

        for port in definition.ports:
            if str(port.direction) == "Direction.OUT":
                data["output_list"].append(port.name)
                data["total_list"].append(port.name)
                data["output_bits_list"].append(len(port.pins) - 1)
            elif str(port.direction) == "Direction.IN":
                data["input_list"].append(port.name)
                data["total_list"].append(port.name)
                data["input_bits_list"].append(len(port.pins) - 1)
        if(data["input_list"].__contains__("clk")):
            if(data["input_list"].index("clk") == 0):
                data["input_list"].append(data["input_list"].pop(0))

    """A specific parse function in the situation where multiple verilog files exist. The design has multiple layers of ports, so finding the equivalent
    ports requires comparing the ports in each layer to the ports in the reversed_netlist. Once both have the same equivalence, they are stored."""

    def parse_multiple(self, file, reversed_file):
        total_reversed = []

        netlist = sdn.parse(reversed_file)
        library = netlist.libraries[0]
        definition = library.definitions[0]
        
        #Stores the reversed_netlist ports in one array.
        for port in definition.ports:
            total_reversed.append(port.name)

        netlist = sdn.parse(file)
        library = netlist.libraries[0]

        contains_item = False
        not_port  = False

        for i in library.definitions:
            for port in i.ports:
                for item in total_reversed:
                    if item == port.name:
                        contains_item = True
                if(contains_item == False):
                    not_port = True
                else:
                    contains_item = False
            if(not_port == False):
                for port in i.ports:
                    print(port.name)
                    if str(port.direction) == "Direction.OUT":
                        data["output_list"].append(port.name)
                        data["total_list"].append(port.name)
                        data["output_bits_list"].append(len(port.pins) - 1)
                    elif str(port.direction) == "Direction.IN":
                        data["input_list"].append(port.name)
                        data["total_list"].append(port.name)
                        data["input_bits_list"].append(len(port.pins) - 1)
                if(data["input_list"].__contains__("clk")):
                    if(data["input_list"].index("clk") == 0):
                        data["input_list"].append(data["input_list"].pop(0))
            else:
                not_port = False
        
    """Due to reversed netlists having incomplete ports that can cause issues with spydrnet, this function removes
    all of the excess data the spydrnet doesn't need so that the inputs and outputs can still be parsed."""

    def parse_reversed(self, path, build_dir, multiple_files, file_name, is_impl):
        test_file = build_dir / "test.v"
        with path.open() as file:
            if test_file.exists():
                test_file.unlink()
            with test_file.open("x") as newFile:
                i = 0
                # Only includes lines that declare the module, the inputs, or the outputs or the line directly after them.
                for line in file:
                    if "module" in line:
                        newFile.write(line)
                    elif "input" in line:
                        newFile.write(line)
                    elif "output" in line:
                        newFile.write(line)
                    else:
                        if i == 0:
                            i = 1
                            newFile.write(line)
        if(multiple_files & is_impl):
            self.parse_multiple(file_name, newFile.name)
        else:
            self.parse(newFile.name)  # Parses this newly-generated simplified netlist.
        test_file.unlink()

    """This function creates the initial testbench that will be modified by the reversed-netlist. It reads in a sample testbench
    and replaces certain variables with the corresponding information from the data structure. It also sets the variables equal
    to random numbers that are generated to be within the corresponding variable's bit range."""

    def generate_first_testbench(self, tb, line, file_name, test_num):
        if "TB_NAME;" in line:
            line = "module " + file_name[0] + "_tb;"
            tb.write(line)
            line = "\n"

        if "TB_NAME)" in line:
            line = "    $dumpvars(0," + file_name[0] + "_tb);\n"

        if "INPUTS" in line:
            for input, bits in zip(data["input_list"], data["input_bits_list"]):
                input = str(input)
                bits = str(bits)
                if input != "clk":
                    line = "reg [" + bits + ":0] " + input + " = 0;\n"
                    tb.write(line)
                else:
                    line = "reg clk = 0;\n"
                    tb.write(line)
                line = ""

        if "OUTPUTS" in line:
            for output, bits in zip(data["output_list"], data["output_bits_list"]):
                output = str(output)
                bits = str(bits)
                line = "wire [" + bits + ":0] " + output + ";\n"
                tb.write(line)
            line = ""

        if "MODULE_NAME" in line:
            line = file_name[0] + " instanceOf ("
            for total, i in zip(data["total_list"], range(self.total_num())):
                total = str(total)
                if i == self.total_num() - 1:
                    line = line + total + ");\n"
                else:
                    line = line + total + ", "

        if "reg clk = 0;" in line:
            for input in data["input_list"]:
                if (input == "clk"):
                    line = ""

        if "/*SIGNALS" in line:
            for bits in data["input_bits_list"]:
                if bits == 0:
                    data["random_list"].append(
                        np.random.randint(low=0, high=2, size=int(test_num))
                    )
                else:
                    data["random_list"].append(
                        np.random.randint(
                            low=0, high=(2 ** (int(bits) + 1) - 1), size=int(test_num)
                        )
                    )

            # The actual logic for adding random numbers to the testbench.
            for i in range(int(test_num)):
                for input, j in zip(data["input_list"], range(self.input_num())):
                    if(input != "clk"):
                        if j == 0:
                            line = (
                                "    # 5 "
                                + str(input)
                                + " = "
                                + str(data["random_list"][j][i])
                                + ";\n"
                            )
                        else:
                            line = (
                                "    "
                                + str(input)
                                + " = "
                                + str(data["random_list"][j][i])
                                + ";\n"
                            )
                    else:
                        if j == 0:
                            line = "    # 5 "
                    tb.write(line)
                    line = ""
                tb.write("\n")
            line = "    # 5 $finish;"

        tb.write(line)

    """Rather than generating a whole new testbench, this one takes the first generated testbench and replaces everything that
    is specific to that module with this module's information."""

    def generate_testbench(self, tb, line, file_name, file_num):
        if file_name[file_num - 1] + "_tb;" in line:
            line = line.replace(file_name[file_num - 1], file_name[file_num])

        if file_name[file_num - 1] + "_tb);" in line:
            line = "    $dumpvars(0," + file_name[file_num] + "_tb);\n"

        if file_name[file_num - 1] + " instanceOf (" in line:
            line = file_name[file_num] + " instanceOf ("

            for totalData, i in zip(data["total_list"], range(self.total_num())):
                if i == self.total_num() - 1:
                    line = line + totalData + ");\n"
                else:
                    line = line + totalData + ", "

        tb.write(line)

    """Generates the first TCL that will be used in gtkwave to create a VCD output."""

    def generate_first_TCL(self, build_dir, file_name, file_num):
        path = build_dir / (file_name[file_num] + ".tcl")
        if path.exists():
            path.unlink()
        with path.open("x") as TCL:
            line = "set filter [list "
            for totalData in data["total_list"]:
                line = line + file_name[file_num] + "_tb." + totalData.strip() + " "
            line = line + "]\n"
            TCL.write(line)
            TCL.write("gtkwave::addSignalsFromList $filter\n")
            TCL.write(
                'gtkwave::/File/Export/Write_VCD_File_As "'
                + str(build_dir)
                + "/"
                + file_name[file_num]
                + '.vcd"\n'
            )
            TCL.write("gtkwave::File/Quit")

    """Replaces information in the last TCL with information specific to this testbench."""

    def generate_TCL(self, build_dir, file_name, file_num):
        path = build_dir / (file_name[file_num] + ".tcl")
        sample_path = build_dir / (file_name[file_num - 1] + ".tcl")
        if path.exists():
            path.unlink()
        with path.open("x") as TCL:
            with sample_path.open() as sample:
                for line in sample:
                    if file_name[file_num - 1] in line:
                        line = line.replace(
                            file_name[file_num - 1], file_name[file_num]
                        )
                    TCL.write(line)

    """The main function that generates testbenches and TCL files. It begins by calling the parsers for the input & output names, then
    it calls the testbench generators, finally it calls the TCL generators. It then increments to the next file and clears the data structure."""

    def generate_files(self, design, multiple_files):
        test_num = 100
        sample_path = bfasst.paths.ROOT_PATH / (
            "scripts/bfasst/compare_waveforms/sample_tb.v"
        )
        impl_path = design.impl_netlist_path
        reversed_path = design.reversed_netlist_path
        impl_module = impl_path.name[0 : len(impl_path.name) - 2]
        reversed_module = reversed_path.name[0 : len(reversed_path.name) - 2]
        file_name = [impl_module, reversed_module]

        # opens both files to be used in generating respective testbenches and TCLs
        with open(impl_path) as impl_file:
            with open(reversed_path) as reversed_file:
                file = [impl_file, reversed_file]
                build_dir = self.work_dir
                for f, file_num in zip(file, range(len(file))):
                    file_path = build_dir / (file_name[file_num] + ".v")
                    tb_path = build_dir / (file_name[file_num] + "_tb.v")

                    # Checks if the design is a reversed_netlist or not.
                    if f.name.find("reversed") != -1:
                        self.fix_file(file_path, file_name[file_num], True)
                        self.parse_reversed(file_path, build_dir, multiple_files, f.name, False)
                    else:
                        self.fix_file(file_path, file_name[file_num], False)
                        if(multiple_files):
                            self.parse_reversed((build_dir / (reversed_module + ".v")), build_dir, multiple_files, f.name, True)
                        else:
                            self.parse(f.name)

                    if tb_path.exists():
                        tb_path.unlink()

                    if file_num == 0:
                        compare_path = sample_path
                    else:
                        compare_path = build_dir / (
                            file_name[file_num - 1] + "_tb.v"
                        )

                    # Calls both the testbench and the TCL generators.
                    with compare_path.open() as sample:
                        with tb_path.open("x") as tb:
                            for line in sample:
                                if file_num == 0:
                                    self.generate_first_testbench(
                                        tb, line, file_name, test_num
                                    )
                                else:
                                    self.generate_testbench(
                                        tb, line, file_name, file_num
                                    )

                    if file_num == 0:
                        self.generate_first_TCL(build_dir, file_name, file_num)
                    else:
                        self.generate_TCL(build_dir, file_name, file_num)

                    refresh(data)

    """A function that generates the wavefiles from the testbenches, runs gtkwave w/ the TCLs generated earlier on the wavefiles
    that have just been generated, then checks the difference between gtkwave's two outputs. If there are more than 32 lines that
    are different, the designs must be unequivalent. Removes all unnecessary files after testing."""

    def run_test(self, design):
        is_equivalent = False
        build_dir = self.work_dir
        impl_path = self.work_dir / design.impl_netlist_path.name
        reversed_path = self.work_dir / design.reversed_netlist_path.name
        impl_module = impl_path.name[0 : len(impl_path.name) - 2]
        reversed_module = reversed_path.name[0 : len(reversed_path.name) - 2]
        dsn = build_dir / ("dsn")
        impl_tb = build_dir / (impl_module + "_tb.v")
        reversed_tb = build_dir / (reversed_module + "_tb.v")
        impl_tcl = build_dir / (impl_module + ".tcl")
        reversed_tcl = build_dir / (reversed_module + ".tcl")
        impl_temp_vcd = build_dir / (impl_module + "_temp.vcd")
        reversed_temp_vcd = build_dir / (reversed_module + "_temp.vcd")
        impl_vcd = build_dir / (impl_module + ".vcd")
        reversed_vcd = build_dir / (reversed_module + ".vcd")
        impl_fst = build_dir / (impl_module + "_temp.vcd.fst")
        reversed_fst = build_dir / (reversed_module + "_temp.vcd.fst")
        cells_sim = bfasst.paths.ROOT_PATH / (
            "third_party/yosys/techlibs/xilinx/cells_sim.v"
        )
        diff_file = build_dir / ("diff.txt")
        parsed_diff_file = build_dir / ("parsed_diff.txt")

        # Generate wavefiles for the golden-file
        subprocess.run(
            ["iverilog", "-o", str(dsn), str(impl_tb), impl_path, str(cells_sim)]
        )
        subprocess.run(["vvp", str(dsn)])
        subprocess.run(["mv", "test.vcd", str(impl_temp_vcd)])

        # Generate wavefiles for the reversed-netlist
        subprocess.run(
            [
                "iverilog",
                "-o",
                str(dsn),
                str(reversed_tb),
                reversed_path,
                str(cells_sim),
            ]
        )
        subprocess.run(["vvp", str(dsn)])
        subprocess.run(["mv", "test.vcd", str(reversed_temp_vcd)])

        # Setup gtkwave for the two files (creates file .gtkwaverc to set the zoom on the graphs to fit the window.)
        gtkwave = Path(".gtkwaverc")
        if(gtkwave.exists()):
            gtkwave.unlink()
        with gtkwave.open("x") as wavefile:
            wavefile.write("do_initial_zoom_fit 1")
        
        commands = [
            ["gtkwave", "-T", str(impl_tcl), "-o", str(impl_temp_vcd)],
            ["gtkwave", "-T", str(reversed_tcl), "-o", str(reversed_temp_vcd)],
        ]

        # Procs is used to run these two wavefiles in parallel so both can be viewed against each other.
        procs = [Popen(i) for i in commands]
        for p in procs:
            p.wait()

        gtkwave.unlink()
        # Finds how many lines are different in the two files.
        dif = subprocess.getoutput(["diff -c " + str(impl_vcd) + " " + str(reversed_vcd)])
        if diff_file.exists():
            diff_file.unlink()
        with diff_file.open("x") as file:
            for line in dif:
                file.write(line)

        lines = 0
        with diff_file.open() as file:
            for line in file:
                if len(line) != 0:
                    lines = lines + 1

        # If there are more than 32 lines different, the two designs must be unequivalent.
        if lines > 32:
            print("NOT EQUIVALENT! SEE " + str(parsed_diff_file) + " for more info")
            parse_diff.parse_diff(impl_vcd, diff_file, parsed_diff_file)
            if(parsed_diff_file.exists()):
                with parsed_diff_file.open() as file:
                    for line in file:
                        print(line)
            else:
               subprocess.run(["diff", "-c", str(impl_vcd), str(reversed_vcd)]) 

        else:
            dsn.unlink()
            diff_file.unlink()
            is_equivalent = True
        # removes unnecessary files.
        impl_temp_vcd.unlink()
        reversed_temp_vcd.unlink()
        impl_fst.unlink()
        reversed_fst.unlink()
        lines = []
        with impl_tcl.open("r") as fp:
            lines = fp.readlines()
        with impl_tcl.open("w") as fp:
            for number, line in enumerate(lines):
                if number not in [2,3]:
                    fp.write(line)
        with reversed_tcl.open("r") as fp:
            lines = fp.readlines()
        with reversed_tcl.open("w") as fp:
            for number, line in enumerate(lines):
                if number not in [2,3]:
                    fp.write(line)
        return is_equivalent

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
