"""The main comparison tool for comparing two netlists."""
from bfasst.compare_waveforms.file_parsing import file_rewriter, parse_files, parse_diff
from bfasst.compare_waveforms.file_generation import (testbench_generator,
tcl_generator, waveform_generator)

def generate_files(multiple_files, paths, test_num):
    """The main function that generates testbenches and TCL files. It begins by calling the
    parsers for the input & output names, then
    it calls the testbench generators, finally it calls the TCL generators. It then increments
    to the next file and clears the data structure."""
    # testbench.
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
                    # The logic for how to parse the file depends on whether or not there are
                    # multiple verilog files involved in a design
                    data = parse_files.parse_reversed(paths, i)
                    # Finds the IO names and bit sizes
                else:
                    data = parse_files.parse(file.name)

            if i == 0:
                # Create the initial testbench with randomized inputs for all input ports
                # (based upon bit-size)
                testbench_generator.generate_first_testbench(
                    paths, test_num, data, i
                )
            else:  # Build off of the old testbench to keep the same randomized values
                testbench_generator.generate_testbench(paths, data, i)

            if i == 0:
                tcl_generator.generate_first_tcl(paths, data, i)
                # The first TCL will be generated based upon the IO port names
            else:
                tcl_generator.generate_tcl(paths, i)
                # The second TCL just needs to change module names from the first one

            waveform_generator.generate_vcd(paths, i)
            # All previously generated files are ran through Icarus and then GTKwave, creating
            # the files we need.

def run_test(paths):
    """A function that generates the wavefiles from the testbenches, runs gtkwave w/ the TCLs
    generated earlier on the wavefiles
    that have just been generated, then checks the difference between gtkwave's two outputs. If
    there are more than 32 lines that
    are different, the designs must be unequivalent."""
    return parse_diff.check_diff(paths)
    # Checks the two VCD files against each other. Returns either equivalent or not depending
    # on how many lines are different.
