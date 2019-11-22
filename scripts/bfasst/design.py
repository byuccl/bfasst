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
            verilogTop = os.path.join(self.full_dir, self.top + ".v")
            vhdlTop = os.path.join(self.full_dir, self.top + ".vhd")
            if os.path.isfile(verilogTop):
                self.top_file = verilogTop                
            elif os.path.isfile(vhdlTop):
                self.top_file = vhdlTop
        
        if self.top_file is None:
            bfasst.utils.error("Cannot find a top file", verilogTop, "or", vhdlTop)
        if not os.path.isfile(self.top_file):
            bfasst.utils.error("Top file", self.top_file, "does not exist.")
    
    def topIsVerilog(self):
        return (os.path.splitext(self.top_file)[1]).lower() == ".v"

    def topIsVHDL(self):
        return (os.path.splitext(self.top_file)[1]).lower() == ".vhd"