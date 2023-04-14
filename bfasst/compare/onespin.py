import yaml
import shutil
import pathlib
import re

import bfasst
from bfasst import paths
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus

ONESPIN_TCL_TEMPLATE = "run_onespin.tcl"
ONESPIN_PY_TEMPLATE = "run_onespin.py"


class OneSpin_CompareTool(CompareTool):
    TOOL_WORK_DIR = "onespin"

    def compare_netlists(self, design):
        yaml_data = {}

        # TODO: I DON'T THINK THIS IS COPYING ALL OF GOLDEN? OR MAYBE I'VE CHANGED WHAT GOLDEN IS? I THINK THIS CAN BE WRONG!!!!!
        for f in design.compare_golden_files_paths:
            shutil.copyfile(f, self.work_dir / f.name)
        print("copying reversed netlist", design.reversed_netlist_path)
        shutil.copyfile(
            design.reversed_netlist_path, self.work_dir / design.reversed_netlist_filename()
        )

        if design.corrupt_netlist_paths is not None:
            for netlist in design.corrupt_netlist_paths:
                shutil.copyfile(netlist, self.work_dir / netlist.name)

        pathlib.Path(self.work_dir / "rtl").mkdir(exist_ok=True)
        rtl_paths = [design.full_path / f for f in design.get_support_files()]
        rtl_paths.append(pathlib.Path(design.top_path()))
        for f in rtl_paths:
            shutil.copyfile(f, self.work_dir / "rtl" / f.name)

        yaml_data["golden_files"] = design.compare_golden_files
        yaml_data["revised_file"] = design.reversed_netlist_filename()
        # yaml_data["revised_file"] = design.compare_revised_file
        yaml_data["rtl_files"] = ["rtl/" + f.name for f in rtl_paths]

        if design.golden_is_verilog:
            yaml_data["golden_top"] = design.top
        elif design.top_architecture is not None:
            yaml_data["golden_top"] = design.top + "(" + design.top_architecture + ")"

        if design.top_is_verilog:
            yaml_data["rtl_top"] = design.top
        elif design.top_architecture is not None:
            yaml_data["rtl_top"] = design.top + "(" + design.top_architecture + ")"

        compare_yaml = self.work_dir / "design.yaml"
        with open(compare_yaml, "w") as fp:
            yaml.dump(yaml_data, fp)

        self.write_compare_tcl(design)

        return Status(CompareStatus.NEED_TO_RUN_ONESPIN)

    def write_compare_tcl(self, design):
        # Read the sample onespin tcl script from resources
        sample_onespin_path = paths.ONESPIN_RESOURCES / ONESPIN_TCL_TEMPLATE
        tcl_template_lines = []
        with open(sample_onespin_path) as fp:
            for line in fp:
                tcl_template_lines.append(line)

        gold_is_rtl = False
        gold_is_yosys = False
        if design.compare_golden_files[0] == design.yosys_netlist_path.name:
            gold_is_yosys = True
        else:
            gold_is_rtl = True
        if not gold_is_rtl and not gold_is_yosys:
            print(
                "gold is not rtl or yosys!",
                design.compare_golden_files[0],
                design.yosys_netlist_path.name,
            )
        revised_is_reversed = False
        if design.compare_revised_file == design.reversed_netlist_filename():
            revised_is_reversed = True

        # Go through the file and write it to an output. Where needed fill in
        #   file names, etc
        if gold_is_rtl:
            tcl_name = "run_onespin_rtl_to_yosys.tcl"
        elif gold_is_yosys:
            if revised_is_reversed:
                if design.cur_error_flow_name is None:
                    tcl_name = "run_onespin_yosys_to_reversed.tcl"
                else:
                    tcl_name = "run_onespin_yosys_to_" + design.cur_error_flow_name + ".tcl"
            else:
                tcl_name = "run_onespin_yosys_to_yosys_" + design.cur_error_flow_name + ".tcl"
        else:
            print("Unhandled compare configuration")
        print("Writing tcl file", tcl_name)
        tcl_path = self.work_dir / tcl_name
        with open(tcl_path, "w") as fp:
            for line in tcl_template_lines:
                fp.write(line)

                if line.strip() == "# Read golden here":
                    for f in design.compare_golden_files:
                        print("golden file: ", f)
                        if gold_is_rtl:
                            f = "rtl/" + str(f)
                        # TODO: I'm not sure that design.top will point to the
                        #   right directory all the time... Maybe get the design
                        #   name somewhere else?
                        # TODO: I don't want to use golden_is_verilog, because
                        #   some designs can have goldens that have both vlog and
                        #   vhdl
                        if design.golden_is_verilog:
                            fp.write(
                                "read_verilog -golden -pragma_ignore {} -version 2001 {/home/jgoeders/temp/"
                                + design.top
                                + "/"
                                + str(f)
                                + "}\n"
                            )
                        else:
                            fp.write(
                                "read_vhdl -golden -pragma_ignore {} -version 93 {/home/jgoeders/temp/"
                                + design.top
                                + "/"
                                + str(f)
                                + "}\n"
                            )

                if line.strip() == "# Read revised here":
                    print("revised:", design.compare_revised_file)
                    # The revised design *should* always be a verilog netlist
                    # (we aren't really doing any comparison with edif)
                    fp.write(
                        "read_verilog -revised -pragma_ignore {} -version 2001 {/home/jgoeders/temp/"
                        + design.top
                        + "/"
                        + design.compare_revised_file
                        + "}\n"
                    )
                if line.strip() == "# Set top module in elaborate options":
                    # using golden_is_verilog should work here since we only
                    #   are looking at the top module
                    if design.golden_is_verilog:
                        fp.write(
                            "set_elaborate_option -golden -top {Verilog!work." + design.top + "}\n"
                        )
                if line.strip() == "# Save results":
                    # what output file names should be used?
                    # What about the RTL check?
                    out_name = "results_" + tcl_name[12:-4] + ".log"
                    fp.write(
                        "save_result_file /home/jgoeders/temp/" + design.top + "/" + out_name + "\n"
                    )
                if line.strip() == "map":
                    # Add extra commands to map internal net names to try to
                    #   help comparison
                    # This works with verilog for now
                    # TODO: Handle VHDL
                    f1 = design.compare_golden_files_paths[0]
                    if gold_is_rtl:
                        f1 = self.work_dir / "rtl" / design.top_file
                    f2 = self.work_dir / design.compare_revised_file
                    if not design.golden_is_verilog:
                        continue
                    mappings = self.find_mappings_vlog(f1, f2)
                    map_commands = self.get_tcl_map_commands(mappings)
                    for cmd in map_commands:
                        fp.write(cmd)

    # write_compare_script creates the python script used to run the compare
    #   tcl scripts
    def write_compare_script(self, design):
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
                    flow_list = design.error_flow_names.copy()
                    print(flow_list)
                    flow_list.append("yosys")  # this assumes a yosys flow
                    flow_list.append("rtl")
                    flow_list_str = "  flow_names = " + str(flow_list) + "\n"
                    fp.write(flow_list_str)

    # find_mappings_vlog
    # checks the two files f1 and f2 and finds a list of matching net names
    #   between the two. Only handles verilog files.
    def find_mappings_vlog(self, f1, f2):
        print("f1:", f1)
        print("f2:", f2)
        f1_nets = set()
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
        with open(f1) as f:
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
                        f1_nets.add(net)
                        if bus_match:
                            bus_list.append(net)
                            bus_decl_map[net] = bus_match.group(0)
        print("Found f1 nets", f1_nets)
        with open(f2) as f:
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
                            #   one in f1. If it doesn't, we could be using
                            #   a different encoding for the signal, which can
                            #   cause problems
                            if net not in bus_list:
                                # This isn't a bus in the f1. There's no way
                                #   it can match, so don't consider it
                                f2_nets.remove(net)
                                continue
                            if bus_match.group(0) != bus_decl_map[net]:
                                # Bus declarations are different; remove this
                                #   from f2 list so it won't be returned from
                                #   the function
                                f2_nets.remove(net)
        print("Found f2 nets", f2_nets)
        print("Intersection:", f1_nets & f2_nets)
        print("busses:", bus_list)
        return (f1_nets & f2_nets, bus_list)

    # get_tcl_map_commands
    # Takes a list of nets to map (see find_mappings_vlog) and returns a list
    #   of lines for a tcl script to create the mappings in onespin
    def get_tcl_map_commands(self, mappings_tuple):
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
                    "for {set i 0} {$i < [llength $bits]} {incr i} {add_mapping -internal [lindex $bits $i] [lindex $bits_revised $i]}\n"
                )
            else:
                # This net is not a bus, so we can just map it directly
                lines.append("add_mapping -internal {" + net + "} {" + net + "}\n")
        return lines
