"""Manage creating rule and build snippets for a given tool."""

import abc

from bfasst.paths import BUILD_DIR, DESIGNS_PATH
from bfasst.yaml_parser import YamlParser


class Tool(abc.ABC):
    """Manage creating rule and build snippets"""

    def __init__(self, design_path):
        self.design_path = design_path
        self.design_build_path = BUILD_DIR / design_path.relative_to(DESIGNS_PATH)
        self.verilog = None
        self.system_verilog = None
        self.vhdl = None
        self.vhdl_libs = None
        self.outputs = {}

    @abc.abstractmethod
    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja"""

    @abc.abstractmethod
    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja"""

    @abc.abstractmethod
    def add_ninja_deps(self):
        """Add the template and flow paths of this flow
        and its sub-flows as dependencies of the build.ninja file"""

    @abc.abstractmethod
    def _init_outputs(self):
        """Creates a dict of the tool's outputs where key is the output name
        and value is the output path"""

    def _read_hdl_files(self):
        """Read the hdl files in the design directory"""
        self.verilog = []
        self.system_verilog = []
        self.vhdl = []
        self.vhdl_libs = YamlParser(self.design_path / "design.yaml").parse_vhdl_libs()
        for child in self.design_path.rglob("*"):
            if child.is_dir():
                continue

            # don't add vhdl libraries as src files
            is_lib = self.__check_is_lib(child)
            if is_lib:
                continue

            if child.suffix == ".v":
                self.verilog.append(str(child))
            elif child.suffix == ".sv":
                self.system_verilog.append(str(child))
            elif child.suffix == ".vhd":
                self.vhdl.append(str(child))

    def __check_is_lib(self, vhdl_file):
        """Check if a vhdl file is a library"""
        if not self.vhdl_libs:
            return False

        for lib in self.vhdl_libs:
            if lib in str(vhdl_file):
                return True
        return False
