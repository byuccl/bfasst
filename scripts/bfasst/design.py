import os, yaml, pathlib, collections

import bfasst
from bfasst import paths
from bfasst.utils import error

DESIGN_YAML_NAME = "design.yaml"


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
        self.vhdl_file_paths = []
        self.vhdl_libs = collections.OrderedDict()
        self.compare_golden_files = []
        self.golden_is_verilog = None
        # I don't like having two golden file lists...
        self.compare_golden_files_paths = []
        self.compare_revised_file = None

        # Flow paths
        self.netlist_path = None
        self.yosys_netlist_path = None
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

        if not os.path.isfile(self.yaml_path):
            bfasst.utils.error("Design YAML file", self.yaml_path, "does not exist")

        with open(self.yaml_path) as fp:
            design_props = yaml.safe_load(fp)

        if "top" not in design_props:
            bfasst.utils.error(self.yaml_path, "missing <top> property.")
        self.top = design_props["top"]

        # If top file is specified, make sure it can be found
        if "top_file" in design_props:
            top_file = design_props["top_file"]
            self.top_file_path = self.path / top_file

            if not self.top_file_path.is_file():
                error("Top file", self.top_file_path, "does not exist.")

        # Otherwise look for a file given the 'top' name
        else:
            verilog_top_path = self.path / (self.top + ".v")
            vhdl_top_path = self.path / (self.top + ".vhd")
            if verilog_top_path.is_file():
                self.top_file_path = self.path / (self.top + ".v")
            elif vhdl_top_path.is_file():
                self.top_file_path = self.path / (self.top + ".vhd")

            if self.top_file_path is None:
                error(
                    "Cannot find a top file",
                    verilog_top_path.name,
                    "or",
                    vhdl_top_path.name,
                    "for design",
                    self.path,
                )

        # For VHDL designs, we need the name of the 'architecture' of the top-level entity
        if "top_architecture" in design_props:
            self.top_architecture = design_props["top_architecture"]

        # Handle 'include_all_verilog_files' option
        if "include_all_verilog_files" in design_props and design_props["include_all_verilog_files"]:
            for dir_item in self.path.iterdir():
                if dir_item.is_file() and dir_item.suffix == ".v" and dir_item != self.top_file_path:
                    self.verilog_file_paths.append(dir_item)

        # Handle 'include_all_vhdl_files'
        if "include_all_vhdl_files" in design_props and design_props["include_all_vhdl_files"]:
            for dir_item in self.path.iterdir():
                if dir_item.is_file() and dir_item.suffix == ".vhd" and dir_item != self.top_file_path:
                    self.vhdl_file_paths.append(dir_item)

        # Add user-specified individual verilog files
        if "verilog_files" in design_props:
            for verilog_file in design_props["verilog_files"]:
                verilog_file_path = self.path / verilog_file
                if not verilog_file_path.is_file():
                    error("Invalid 'verilog_files' option. File not found:", verilog_file_path)
                self.verilog_file_paths.append(verilog_file_path)

        # VHDL libraries
        # if "vhdl_lib_files" in design_props:
        #     for vhdl_lib in design_props["vhdl_lib_files"]:
        #         for (lib, files) in vhdl_lib.items():
        #             for f in files:
        #                 self.vhdl_libs[self.full_path / f] = lib
        if "vhdl_libs" in design_props:
            for vhdl_lib in design_props["vhdl_libs"]:
                vhdl_lib_path = self.path / vhdl_lib
                for vhdl_file_path in vhdl_lib_path.rglob("*.vhd"):
                    self.vhdl_libs[vhdl_file_path] = vhdl_lib_path.name

    def top_is_verilog(self):
        return self.top_file_path.suffix == ".v"

    def top_is_vhdl(self):
        return self.top_file_path.suffix == ".vhd"

    # def top_path(self):
    #     return os.path.join(self.full_path, self.top_file)

    def get_support_files(self):
        return self.verilog_file_paths + self.vhdl_file_paths

    def reversed_netlist_filename(self):
        return os.path.basename(self.reversed_netlist_path)

    def last_modified_time(self):
        return max([os.path.getmtime(f) for f in (self.yaml_path, self.top_file_path)])

    def get_golden_files(self):
        return [self.top_file_path,] + self.get_support_files()