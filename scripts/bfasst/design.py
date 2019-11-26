import os, yaml

import bfasst

DESIGN_YAML_NAME = "design.yaml"

class Design():
    def __init__(self, design_dir):
        self.design_dir = design_dir
        self.full_dir = os.path.join(bfasst.EXAMPLES_PATH, self.design_dir)
        self.yaml_path = os.path.join(self.full_dir, DESIGN_YAML_NAME)

        self.top = None
        self.top_file = None
        self.verilog_files = []
        self.vhdl_files = []

        # Flow paths
        self.netlist_path = None
        self.bitstream_path = None
        self.constraints_path = None
        self.reversed_netlist_path = None

        if not os.path.isdir(self.full_dir):
            bfasst.utils.error("Design folder", self.full_dir, " does not exist.")
        if not os.path.isfile(self.yaml_path):
            bfasst.utils.error("Design YAML file", self.yaml_path, "does not exist")
        
        with open(self.yaml_path) as fp:
            design_props = yaml.safe_load(fp)

        if "top" not in design_props:
            bfasst.utils.error(self.yaml_path, "missing <top> property.")
        self.top = design_props["top"]

        if "top_file" in design_props:
            self.top_file = design_props["top_file"]

        # Verify top file
        if self.top_file is None:
            verilogTop = self.top + ".v"
            vhdlTop = self.top + ".vhd"
            if os.path.isfile(os.path.join(self.full_dir, verilogTop)):
                self.top_file = verilogTop
            elif os.path.isfile(os.path.join(self.full_dir, vhdlTop)):
                self.top_file = vhdlTop
        
        if self.top_file is None:
            bfasst.utils.error("Cannot find a top file", verilogTop, "or", vhdlTop)
        if not os.path.isfile(self.top_path()):
            bfasst.utils.error("Top file", self.top_file, "does not exist.")
    
        # Find other source files
        if "include_all_verilog_files" in design_props and design_props["include_all_verilog_files"]:
            for dir_item in os.listdir(self.full_dir):
                if os.path.isfile(os.path.join(self.full_dir, dir_item)) and os.path.splitext(dir_item)[1] == ".v" and dir_item != self.top_file:
                    self.verilog_files.append(dir_item)

    def top_is_verilog(self):
        return (os.path.splitext(self.top_file)[1]).lower() == ".v"

    def top_is_vhdl(self):
        return (os.path.splitext(self.top_file)[1]).lower() == ".vhd"

    def top_path(self):
        return os.path.join(self.full_dir, self.top_file)

    def get_support_files(self):
        return []

    def reversed_netlist_filename(self):
        return os.path.basename(self.reversed_netlist_path)

    def last_modified_time(self):
        return max([os.path.getmtime(f) for f in (self.yaml_path, self.top_path())])