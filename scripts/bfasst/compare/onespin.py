import yaml
import shutil
import pathlib

import bfasst
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
        shutil.copyfile(design.reversed_netlist_path, self.work_dir / design.reversed_netlist_filename())

        if design.corrupt_netlist_paths is not None:
            for netlist in design.corrupt_netlist_paths:
                shutil.copyfile(netlist, self.work_dir / netlist.name)

        pathlib.Path(self.work_dir / "rtl").mkdir(exist_ok=True);
        rtl_paths = [design.full_path / f for f in design.get_support_files()]
        rtl_paths.append(pathlib.Path(design.top_path()))
        for f in rtl_paths:
            shutil.copyfile(f, self.work_dir / "rtl" / f.name)

        yaml_data["golden_files"] = design.compare_golden_files
        yaml_data["revised_file"] = design.reversed_netlist_filename()
        #yaml_data["revised_file"] = design.compare_revised_file
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
        with open(compare_yaml, 'w') as fp:
            yaml.dump(yaml_data, fp)

        self.write_compare_tcl(design)
            
        return Status(CompareStatus.NEED_TO_RUN_ONESPIN)

    def write_compare_tcl(self, design):
        # Read the sample onespin tcl script from resources
        sample_onespin_path = bfasst.ONESPIN_RESOURCES / ONESPIN_TCL_TEMPLATE
        tcl_template_lines = []
        with open(sample_onespin_path) as fp:
            for line in fp:
                tcl_template_lines.append(line)

        gold_is_rtl = False
        gold_is_yosys = False
        if design.cur_error_flow_name is None:
            if design.compare_golden_files[0] == design.yosys_netlist_path.name:
                gold_is_yosys = True
            else:
                gold_is_rtl = True

        # Go through the file and write it to an output. Where needed fill in
        #   file names, etc
        if gold_is_rtl: tcl_name = "run_onespin_rtl.tcl"
        elif gold_is_yosys: tcl_name = "run_onespin_yosys.tcl"
        else: tcl_name = "run_onespin_" + design.cur_error_flow_name + ".tcl"
        tcl_path = self.work_dir / tcl_name
        with open(tcl_path, 'w') as fp:
            for line in tcl_template_lines:
                fp.write(line)
                
                if line.strip() == "# Read golden here":
                    for f in design.compare_golden_files:
                        print("golden file: ", f)
                        if gold_is_rtl: f = "rtl/" + str(f)
                        # TODO: I'm not sure that design.top will point to the
                        #   right directory all the time... Maybe get the design
                        #   name somewhere else?
                        # TODO: I don't want to use golden_is_verilog, because
                        #   some designs can have goldens that have both vlog and
                        #   vhdl
                        if design.golden_is_verilog:
                            fp.write("read_verilog -golden -pragma_ignore {} -version 2001 {/home/jgoeders/temp/" + design.top + "/" + str(f) + "}\n")
                        else:
                            fp.write("read_vhdl -golden -pragma_ignore {} -version 93 {/home/jgoeders/temp/" + design.top + "/" + str(f) + "}\n")
                            
                if line.strip() == "# Read revised here":
                    # The revised design *should* always be a verilog netlist
                    # (we aren't really doing any comparison with edif)
                    fp.write("read_verilog -revised -pragma_ignore {} -version 2001 {/home/jgoeders/temp/" + design.top + "/" + design.compare_revised_file + "}\n")
                if line.strip() == "# Set top module in elaborate options":
                    # using golden_is_verilog should work here since we only
                    #   are looking at the top module
                    if design.golden_is_verilog:
                        fp.write("set_elaborate_option -golden -top {Verilog!work." + design.top + "}\n")
                if line.strip() == "# Save results":
                    # what output file names should be used?
                    # What about the RTL check?
                    if design.cur_error_flow_name is None:
                        # this is hacky...
                        if design.compare_golden_files[0] == design.yosys_netlist_path.name:
                            out_name = "results_yosys.log"
                        else:
                            out_name = "results_rtl.log"
                    else:
                        out_name = "results_" + design.cur_error_flow_name + ".log"
                    fp.write("save_results_file /home/jgoeders/temp/" + design.top + "/" + out_name + "\n")

    # write_compare_script creates the python script used to run the compare
    #   tcl scripts
    def write_compare_script(self, design):
        # Read the template script from the resources directory
        template_lines = []
        with open(bfasst.ONESPIN_RESOURCES / ONESPIN_PY_TEMPLATE) as fp:
            for line in fp:
                template_lines.append(line)

        py_name = self.work_dir / "run_onespin.py"
        with open(py_name, 'w') as fp:
            for line in template_lines:
                fp.write(line)
                if line.strip() == "# Create list of flow names here":
                    flow_list = design.error_flow_names.copy()
                    print(flow_list)
                    flow_list.append("yosys") # this assumes a yosys flow
                    flow_list.append("rtl")
                    flow_list_str = "  flow_names = " + str(flow_list) + '\n'
                    fp.write(flow_list_str)
            
