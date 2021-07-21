import os, yaml, pathlib, collections
import enum

import bfasst
from bfasst import paths
from bfasst.utils import error

DESIGN_YAML_NAME = "design.yaml"

class HdlType(enum.Enum):
    VERILOG = 1
    VHDL = 2
    MIXED = 3
    SYSTEM_VERILOG = 4

class Design:
    def __init__(self, dir_path):
        if not dir_path.is_dir():
            error("Design folder", dir_path, " does not exist.")

        self.path = dir_path
        self.rel_path = self.path.relative_to(paths.EXAMPLES_PATH)
        self.yaml_path = self.path / DESIGN_YAML_NAME

        self.top = None
        self.top_architecture = None
        self.top_file_path = None
        self.verilog_file_paths = []
        self.system_verilog_file_paths = []
        self.vhdl_file_paths = []
        self.vhdl_libs = collections.OrderedDict()

        # self.compare_golden_files = []        
        # self.golden_is_verilog = None
        # I don't like having two golden file lists...
        # self.compare_golden_files_paths = []
        # self.compare_revised_file = None

        # Golden
        self.golden_sources = None

        ############## Flow paths ###############
        self.netlist_path = None
        self.yosys_netlist_path = None
        self.impl_netlist_path = None
        self.bitstream_path = None
        self.constraints_path = None
        self.reversed_netlist_path = None
        self.results_summary_path = None

        # Error flow related stuff
        self.error_flow_yaml = None
        self.cur_error_flow_name = None
        self.corrupt_netlist_paths = None
        self.error_flow_names = []
        self.nets_to_remove_from_pcf = set()

        if not self.yaml_path.is_file():
            error("Design YAML file", self.yaml_path, "does not exist")

        with open(self.yaml_path) as fp:
            design_props = yaml.safe_load(fp)

        if design_props is None:
            error(self.yaml_path, "has no properties.  At minimum, design needs a 'top' property.")

        for k,v in design_props.items():
            # Get top module name
            if k == "top":
                self.top = v

            # Top file 
            elif k == "top_file":
                self.top_file_path = self.path / v
                if not self.top_file_path.is_file():
                    error("top_file", self.top_file_path, "does not exist.")

            # Top architecture
            elif k ==  "top_architecture":
                self.top_architecture = v

            # Synthesized netlist path
            elif k == "synthesized_netlist":
                self.netlist_path = self.path / v
                if not self.netlist_path.is_file():
                    error("synthesized_netlist file", self.netlist_path, "does not exist.")

            # Reversed netlist path
            elif k == "reversed_netlist":
                self.reversed_netlist_path = self.path / v
                if not self.reversed_netlist_path.is_file():
                    error("reversed_netlist file", self.reversed_netlist_path, "does not exist.")

            # Handle 'include_all_verilog_files' option
            elif k == "include_all_verilog_files":
                if v:
                    for dir_item in self.path.iterdir():
                        if (
                            dir_item.is_file()
                            and (dir_item.suffix == ".v"
                            or dir_item.suffix == ".vh")
                            and dir_item != self.top_file_path
                        ):
                            self.verilog_file_paths.append(dir_item)

            # Handle 'include_all_system_verilog_files' option
            elif k == "include_all_system_verilog_files":
                if v:
                    for dir_item in self.path.iterdir():
                        if (
                            dir_item.is_file()
                            and dir_item.suffix == ".sv"
                            and dir_item != self.top_file_path
                        ):
                            self.system_verilog_file_paths.append(dir_item)
            
            # Handle 'include_all_vhdl_files'
            elif k == "include_all_vhdl_files":
                if v:
                    for dir_item in self.path.iterdir():
                        if (
                            dir_item.is_file()
                            and dir_item.suffix == ".vhd"
                            and dir_item != self.top_file_path
                        ):
                            self.vhdl_file_paths.append(dir_item)

            # Add user-specified individual verilog files
            elif k == "verilog_files":
                for verilog_file in v:
                    verilog_file_path = self.path / verilog_file
                    if not verilog_file_path.is_file():
                        error("Invalid 'verilog_files' option. File not found:", verilog_file_path)
                    self.verilog_file_paths.append(verilog_file_path)

            # VHDL libraries
            elif k == "vhdl_libs":
                for vhdl_lib in v:
                    vhdl_lib_path = self.path / vhdl_lib
                    for vhdl_file_path in vhdl_lib_path.rglob("*.vhd"):
                        self.vhdl_libs[vhdl_file_path] = vhdl_lib_path.name

            else:
                error("Invalid option", k, "in", self.yaml_path)

        ########### Validation #############

        # Check for top
        if "top" not in design_props:
            bfasst.utils.error(self.yaml_path, "missing <top> property.")

        # If no top_file given, find one 
        if self.top_file_path is None and not self.netlist_path:
            verilog_top_path = self.path / (self.top + ".v")
            system_verilog_top_path = self.path / (self.top + ".sv")
            vhdl_top_path = self.path / (self.top + ".vhd")
            if verilog_top_path.is_file():
                self.top_file_path = self.path / (self.top + ".v")
            elif system_verilog_top_path.is_file():
                self.top_file_path = self.path / (self.top + ".sv")
            elif vhdl_top_path.is_file():
                self.top_file_path = self.path / (self.top + ".vhd")

            if self.top_file_path is None:
                error(
                    "Cannot find a top file",
                    verilog_top_path.name,
                    "or",
                    system_verilog_top_path.name,
                    "or",
                    vhdl_top_path.name,
                    "for design",
                    self.path,
                )

        # For VHDL designs, we need the name of the 'architecture' of the top-level entity
        if self.is_source_hdl() and self.get_top_hdl_type() == HdlType.VHDL and self.top_architecture is None:
            error(self.rel_path, "top_architecture not specified for VHDL design")
        
    def is_source_hdl(self):
        return self.top_file_path is not None

    def get_top_hdl_type(self):
        return get_hdl_type(self.top_file_path)

    def get_support_files(self):
        return self.verilog_file_paths + self.vhdl_file_paths + self.system_verilog_file_paths

    # def reversed_netlist_filename(self):
    #     return os.path.basename(self.reversed_netlist_path)

    def last_modified_time(self):
        return max([os.path.getmtime(f) for f in (self.yaml_path, self.top_file_path)])

    def get_golden_hdl_type(self):
        if self.golden_sources is None:
            return self.get_top_hdl_type()
        else:
            return get_hdl_type(self.get_golden_files())

    def get_golden_files(self):
        if self.golden_sources is None:
            return [
                self.top_file_path,
            ] + self.get_support_files()
        else:
            return self.golden_sources

def get_hdl_type(files):
    # Listify
    if type(files) not in [list, tuple]:
        files = (files,)

    hdl_type = None
    for f in files:
        if f.suffix == ".v":
            if hdl_type is None:
                hdl_type = HdlType.VERILOG
            elif hdl_type == HdlType.VHDL:
                hdl_type == HdlType.MIXED
        elif f.suffix == ".sv":
            if hdl_type is None:
                hdl_type = HdlType.SYSTEM_VERILOG
            elif hdl_type == HdlType.VHDL:
                hdl_type == HdlType.MIXED
        elif f.suffix == ".vhd":
            if hdl_type is None:
                hdl_type = HdlType.VHDL
            elif hdl_type == HdlType.VERILOG:
                hdl_type == HdlType.MIXED
    
    assert hdl_type is not None
    return hdl_type