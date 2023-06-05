"""Run OneSpin to compare netlists."""
import shutil
import pathlib
import re
import yaml

from bfasst import paths
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus

ONESPIN_TCL_TEMPLATE = "run_onespin.tcl"
ONESPIN_PY_TEMPLATE = "run_onespin.py"


class OneSpinCompareTool(CompareTool):
    """OneSpin compare tool."""
    TOOL_WORK_DIR = "onespin"

    def compare_netlists(self):
        yaml_data = {}

        # TODO: I DON'T THINK THIS IS COPYING ALL OF GOLDEN?
        # OR MAYBE I'VE CHANGED WHAT GOLDEN IS? I THINK THIS CAN BE WRONG!!!!!
        for f in self.design.compare_golden_files_paths:
            shutil.copyfile(f, self.work_dir / f.name)
        print("copying reversed netlist", self.design.reversed_netlist_path)
        shutil.copyfile(
            self.design.reversed_netlist_path,
            self.work_dir / self.design.reversed_netlist_filename()
        )

        if self.design.corrupt_netlist_paths is not None:
            for netlist in self.design.corrupt_netlist_paths:
                shutil.copyfile(netlist, self.work_dir / netlist.name)

        pathlib.Path(self.work_dir / "rtl").mkdir(exist_ok=True)
        rtl_paths = [self.design.full_path / f for f in self.design.get_support_files()]
        rtl_paths.append(pathlib.Path(self.design.top_path()))
        for f in rtl_paths:
            shutil.copyfile(f, self.work_dir / "rtl" / f.name)

        yaml_data["golden_files"] = self.design.compare_golden_files
        yaml_data["revised_file"] = self.design.reversed_netlist_filename()
        # yaml_data["revised_file"] = design.compare_revised_file
        yaml_data["rtl_files"] = ["rtl/" + f.name for f in rtl_paths]

        if self.design.golden_is_verilog:
            yaml_data["golden_top"] = self.design.top
        elif self.design.top_architecture is not None:
            yaml_data["golden_top"] = self.design.top + "(" + self.design.top_architecture + ")"

        if self.design.top_is_verilog:
            yaml_data["rtl_top"] = self.design.top
        elif self.design.top_architecture is not None:
            yaml_data["rtl_top"] = self.design.top + "(" + self.design.top_architecture + ")"

        compare_yaml = self.work_dir / "design.yaml"
        with open(compare_yaml, "w") as fp:
            yaml.dump(yaml_data, fp)

        self.write_compare_tcl()

        return Status(CompareStatus.NEED_TO_RUN_ONESPIN)

    def read_golden(self, fp, gold_is_rtl):
        """Read the golden file."""
        for f in self.design.compare_golden_files:
            print("golden file: ", f)
            if gold_is_rtl:
                f = "rtl/" + str(f)
            # TODO: I'm not sure that design.top will point to the
            #   right directory all the time... Maybe get the design
            #   name somewhere else?
            # TODO: I don't want to use golden_is_verilog, because
            #   some designs can have goldens that have both vlog and
            #   vhdl
            if self.design.golden_is_verilog:
                fp.write(
                    "read_verilog -golden -pragma_ignore {} -version 2001 "
                    + "{/home/jgoeders/temp/"
                    + self.design.top
                    + "/"
                    + str(f)
                    + "}\n"
                )
            else:
                fp.write(
                    "read_vhdl -golden -pragma_ignore {} -version 93 "
                    + "{/home/jgoeders/temp/"
                    + self.design.top
                    + "/"
                    + str(f)
                    + "}\n"
                )

    def read_revised(self, fp):
        print("revised:", self.design.compare_revised_file)
        # The revised design *should* always be a verilog netlist
        # (we aren't really doing any comparison with edif)
        fp.write(
            "read_verilog -revised -pragma_ignore {} -version 2001 "
            + "{/home/jgoeders/temp/"
            + self.design.top
            + "/"
            + self.design.compare_revised_file
            + "}\n"
        )

    def set_top_in_elaborate(self, fp):
        # using golden_is_verilog should work here since we only
        #   are looking at the top module
        if self.design.golden_is_verilog:
            fp.write(
                "set_elaborate_option -golden -top {Verilog!work." 
                + self.design.top
                + "}\n"
            )

    def save_results(self, fp, tcl_name):
        # what output file names should be used?
        # What about the RTL check?
        out_name = "results_" + tcl_name[12:-4] + ".log"
        fp.write(
            "save_result_file /home/jgoeders/temp/"
            + self.design.top
            + "/"
            + out_name
            + "\n"
        )

    def map_internal_net_names(self, fp, gold_is_rtl):
        """Add extra commands to map internal net names to try to help comparison."""
        # This works with verilog for now
        # TODO: Handle VHDL
        f_1 = self.design.compare_golden_files_paths[0]
        if gold_is_rtl:
            f_1 = self.work_dir / "rtl" / self.design.top_file
        f_2 = self.work_dir / self.design.compare_revised_file
        if not self.design.golden_is_verilog:
            return
        mappings = self.find_mappings_vlog(f_1, f_2)
        map_commands = self.get_tcl_map_commands(mappings)
        for cmd in map_commands:
            fp.write(cmd)

    def commit_compare_tcl(self, tcl_name, tcl_template_lines, gold_is_rtl):
        """Write the tcl file for running the comparison."""
        print("Writing tcl file", tcl_name)
        tcl_path = self.work_dir / tcl_name
        with open(tcl_path, "w") as fp:
            for line in tcl_template_lines:
                fp.write(line)
                if line.strip() == "# Read golden here":
                    self.read_golden(fp, gold_is_rtl)
                if line.strip() == "# Read revised here":
                    self.read_revised(fp)
                if line.strip() == "# Set top module in elaborate options":
                    self.set_top_in_elaborate(fp)
                if line.strip() == "# Save results":
                    self.save_results(fp, tcl_name)
                if line.strip() == "map":
                    self.map_internal_net_names(fp, gold_is_rtl)

    def write_compare_tcl(self):
        """set conditions to create the tcl file for running the comparison."""
        # Read the sample onespin tcl script from resources
        sample_onespin_path = paths.ONESPIN_RESOURCES / ONESPIN_TCL_TEMPLATE
        tcl_template_lines = []
        with open(sample_onespin_path) as fp:
            for line in fp:
                tcl_template_lines.append(line)

        gold_is_rtl = False
        gold_is_yosys = False
        if self.design.compare_golden_files[0] == self.design.yosys_netlist_path.name:
            gold_is_yosys = True
        else:
            gold_is_rtl = True
        if not gold_is_rtl and not gold_is_yosys:
            print(
                "gold is not rtl or yosys!",
                self.design.compare_golden_files[0],
                self.design.yosys_netlist_path.name,
            )
        revised_is_reversed = False
        if self.design.compare_revised_file == self.design.reversed_netlist_filename():
            revised_is_reversed = True

        # Go through the file and write it to an output. Where needed fill in
        #   file names, etc
        if gold_is_rtl:
            tcl_name = "run_onespin_rtl_to_yosys.tcl"
        elif gold_is_yosys:
            if revised_is_reversed:
                if self.design.cur_error_flow_name is None:
                    tcl_name = "run_onespin_yosys_to_reversed.tcl"
                else:
                    tcl_name = "run_onespin_yosys_to_" + self.design.cur_error_flow_name + ".tcl"
            else:
                tcl_name = "run_onespin_yosys_to_yosys_" + self.design.cur_error_flow_name + ".tcl"
        else:
            print("Unhandled compare configuration")
        self.commit_compare_tcl(tcl_name, tcl_template_lines, gold_is_rtl)

    def write_compare_script(self):
        """Creates the python script used to run the compare tcl scripts"""
        # Read the template script from the resources directory
        template_lines = []
        with open(paths.ONESPIN_RESOURCES / ONESPIN_PY_TEMPLATE) as fp:
            for line in fp:
                template_lines.append(line)

        py_name = self.work_dir / "run_onespin.py"
        with open(py_name, "w") as fp:
            for line in template_lines:
                fp.write(line)
                if line.strip() == "# Create list of flow names here":
                    flow_list = self.design.error_flow_names.copy()
                    print(flow_list)
                    flow_list.append("yosys")  # this assumes a yosys flow
                    flow_list.append("rtl")
                    flow_list_str = "  flow_names = " + str(flow_list) + "\n"
                    fp.write(flow_list_str)

    def find_mappings_vlog(self, f_1, f_2):
        """
        Checks the two files f_1 and f_2 and finds a list of matching net names
        between the two. Only handles verilog files.
        """
        print("f_1:", f_1)
        print("f_2:", f_2)
        f_1_nets = set()
        f2_nets = set()
        # This regex should match a letter, _, or \, then 0 or more letters,
        #   numbers, _s, or .s
        regex = r"[a-zA-Z_\\\\][a-zA-Z0-9_\.]*"
        # This regex should match [, then a string of any characters, then a ]
        # regex_bus = r'\[[0-9]+:?[0-9]*\]'
        regex_bus = r"\[.*\]"
        # List of which nets are busses
        bus_list = []
        bus_decl_map = {}
        with open(f_1) as f:
            for line in f:
                if line.split() and line.split()[0] in {"wire", "reg", "logic"}:
                    # We need to find all net names in the declaration
                    # We can do this with a regex that matches valid net names
                    #   and skipping the first one since it will match the
                    #   wire (etc) keyword
                    match_list = re.findall(regex, line)
                    bus_match = re.search(regex_bus, line)
                    for net in match_list:
                        if net in {"wire", "reg", "logic"}:
                            continue
                        f_1_nets.add(net)
                        if bus_match:
                            bus_list.append(net)
                            bus_decl_map[net] = bus_match.group(0)
        print("Found f_1 nets", f_1_nets)
        with open(f_2) as f:
            for line in f:
                if line.split() and line.split()[0] in {"wire", "reg", "logic"}:
                    # We need to find all net names in the declaration
                    # We can do this with a regex that matches valid net names
                    #   and skipping the first one since it will match the
                    #   wire (etc) keyword
                    match_list = re.findall(regex, line)
                    bus_match = re.search(regex_bus, line)
                    for net in match_list:
                        if net in {"wire", "reg", "logic"}:
                            continue
                        f2_nets.add(net)
                        if bus_match:
                            # Check that the bus declaration here matches the
                            #   one in f_1. If it doesn't, we could be using
                            #   a different encoding for the signal, which can
                            #   cause problems
                            if net not in bus_list:
                                # This isn't a bus in the f_1. There's no way
                                #   it can match, so don't consider it
                                f2_nets.remove(net)
                                continue
                            if bus_match.group(0) != bus_decl_map[net]:
                                # Bus declarations are different; remove this
                                #   from f_2 list so it won't be returned from
                                #   the function
                                f2_nets.remove(net)
        print("Found f_2 nets", f2_nets)
        print("Intersection:", f_1_nets & f2_nets)
        print("busses:", bus_list)
        return (f_1_nets & f2_nets, bus_list)

    def get_tcl_map_commands(self, mappings_tuple):
        """
        Takes a list of nets to map (see find_mappings_vlog) and returns a list
        of lines for a tcl script to create the mappings in onespin
        """
        mappings, bus_list = mappings_tuple
        lines = []
        for net in mappings:
            # nets that start with a \ have to end with a space
            net_key = net
            if net[0] == "\\":
                net = net + " "
            if net_key in bus_list:
                # This net is a bus, so get all of its bits for the mapping
                lines.append("set bits [get_bits {" + net + "[*}]\n")
                lines.append("set bits_revised [get_bits -revised {" + net + "[*}]\n")
                lines.append(
                    "for {set i 0} {$i < [llength $bits]} {incr i} "
                    + "{add_mapping -internal [lindex $bits $i] [lindex $bits_revised $i]}\n"
                )
            else:
                # This net is not a bus, so we can just map it directly
                lines.append("add_mapping -internal {" + net + "} {" + net + "}\n")
        return lines
