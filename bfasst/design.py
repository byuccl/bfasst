"""A class holding a design object, coordinating different parts of the flow"""

import os
import yaml

import bfasst
from bfasst import paths
from bfasst.utils import error
from bfasst.utils.general import get_hdl_src_types, HdlType

DESIGN_YAML_NAME = "design.yaml"


class Design:
    "class holding paths and other metadata for a given design" ""

    def __init__(self, dir_path, experiment_dir):
        if not dir_path.is_dir() and (paths.DESIGNS_PATH / dir_path).is_dir():
            dir_path = paths.DESIGNS_PATH / dir_path
        dir_path = dir_path.absolute()

        if not dir_path.is_dir():
            error("Design folder", dir_path, " does not exist.")

        self.path = dir_path
        if self.path.relative_to(paths.DESIGNS_PATH) is not None:
            self.rel_path = self.path.relative_to(paths.DESIGNS_PATH)
        else:
            self.rel_path = self.path.resolve()

        self.build_dir = experiment_dir / self.rel_path
        self.yaml_path = self.path / DESIGN_YAML_NAME

        self.top = None
        self.top_architecture = None
        self.top_file_path = None
        self.verilog_file_paths = []
        self.system_verilog_file_paths = []
        self.vhdl_file_paths = []
        self.vhdl_libs = {}

        # self.compare_golden_files = []
        # self.golden_is_verilog = None
        # I don't like having two golden file lists...
        # self.compare_golden_files_paths = []
        # self.compare_revised_file = None

        self.mapped_io = None

        # Golden
        self.golden_sources = None

        ############## Flow paths ###############
        self.netlist_path = None
        self.reversed_netlist_path = None
        self.yosys_netlist_path = None
        self.impl_netlist_path = None
        self.impl_edif_path = None
        self.bitstream_path = None
        self.phys_netlist_path = None
        self.constraints_path = None
        self.results_summary_path = None

        # Toolchain-specific paths
        self.xilinx_impl_checkpoint_path = None

        # Error flow related stuff
        self.error_flow_yaml = None
        self.cur_error_flow_name = None
        self.corrupt_netlist_paths = None
        self.error_flow_names = []
        self.nets_to_remove_from_pcf = set()

        self.process_yaml()

    def process_yaml(self):
        """process the yaml file to set the paths for the design netlists, etc."""
        if not self.yaml_path.is_file():
            error("Design YAML file", self.yaml_path, "does not exist")

        with open(self.yaml_path, "r") as stream:
            design_props = yaml.safe_load(stream)

        if design_props is None:
            error(
                self.yaml_path,
                "has no properties.  At minimum, design needs a 'top' property.",
            )

        # Note that in python, lambdas are _expressions_, and
        # cannot contain assignment _statements_, or any other
        # type of statement.
        yaml_parse = {
            "top": lambda value: setattr(self, "top", value),
            "top_file": lambda value: setattr(self, "top_file_path", self.path / value),
            "top_architecture": lambda value: setattr(self, "top_architecture", value),
            "synthesized_netlist": lambda value: setattr(self, "netlist_path", self.path / value),
            "reversed_netlist": lambda value: setattr(
                self, "reversed_netlist_path", self.path / value
            ),
            "include_all_verilog_files": lambda value: self.verilog_file_paths.extend(
                self.hdl_by_suffix(".v", ".vh")
            ),
            "include_all_system_verilog_files": lambda value: self.system_verilog_file_paths.extend(
                self.hdl_by_suffix(".sv")
            ),
            "include_all_vhdl_files": lambda value: self.vhdl_file_paths.extend(
                self.hdl_by_suffix(".vhd")
            ),
            "verilog_files": lambda value: self.verilog_file_paths.extend(
                self.path / source for source in value
            ),
            "vhdl_libs": lambda value: setattr(self, "vhdl_libs", self.enum_vhdl_libs(value)),
        }

        for key, value in design_props.items():
            if key not in yaml_parse:
                error("Invalid option", key, "in", self.yaml_path)
            yaml_parse[key](value)

        ########### Validation #############

        self.check_paths()

        # Check for top
        if "top" not in design_props:
            bfasst.utils.error(self.yaml_path, "missing <top> property.")

        # If no top_file given, find one
        if self.top_file_path is None and not self.netlist_path:
            self.top_file_path = self.find_top_file()

        # For VHDL designs, we need the name of the 'architecture' of the top-level entity
        if (
            self.is_source_hdl()
            and self.get_top_hdl_type() == HdlType.VHDL
            and self.top_architecture is None
        ):
            error(self.rel_path, "top_architecture not specified for VHDL design")

    def check_paths(self):
        """for all the paths that are set, check to make sure they refer to valid files"""
        set_paths = filter(
            None,
            [
                self.top_file_path,
                self.netlist_path,
                self.reversed_netlist_path,
                *self.verilog_file_paths,
            ],
        )
        for path in set_paths:
            if not path.is_file():
                error("invalid path:", path)

    def find_top_file(self):
        """infer top file from top module, checking for errors"""
        top_paths = [self.path / (self.top + ext) for ext in [".v", ".sv", ".vhd"]]
        valid_paths = filter(lambda x: x.is_file(), top_paths)
        if not valid_paths:
            error(
                "Cannot find a top file",
                " or ".join([path.name for path in top_paths]),
                "for design",
                self.path,
            )

        return next(valid_paths)

    def hdl_by_suffix(self, *suffixes):
        return (
            source
            for source in self.path.iterdir()
            if (source.is_file() and source.suffix in suffixes and source != self.top_file_path)
        )

    def enum_vhdl_libs(self, vhdl_paths):
        result = {}
        libraries = (
            (library.split("/")[-1], (self.path / library).rglob("*.vhd")) for library in vhdl_paths
        )
        for library in libraries:
            for source in library[1]:
                result[source] = library[0]
        return result

    def is_source_hdl(self):
        return self.top_file_path is not None

    def get_top_hdl_type(self):
        return get_hdl_src_types(self.top_file_path)

    def get_support_files(self):
        return self.verilog_file_paths + self.vhdl_file_paths + self.system_verilog_file_paths

    # def reversed_netlist_filename(self):
    #     return os.path.basename(self.reversed_netlist_path)

    def last_modified_time(self):
        times = [os.path.getmtime(f) for f in (self.yaml_path, self.top_file_path)]
        times.extend(
            [
                os.path.getmtime(f)
                for f in self.verilog_file_paths
                + self.system_verilog_file_paths
                + self.vhdl_file_paths
            ]
        )
        return max(times)

    def get_golden_hdl_type(self):
        if self.golden_sources is None:
            return self.get_top_hdl_type()
        return get_hdl_src_types(self.get_golden_files())

    def get_golden_files(self):
        if self.golden_sources is None:
            return [
                self.top_file_path,
            ] + self.get_support_files()
        return self.golden_sources
