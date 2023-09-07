"""Tool to create Vivado synthesis and implementation ninja snippets."""
import json
import chevron
from bfasst import config
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import (
    BUILD_DIR,
    NINJA_IMPL_TOOLS_PATH,
    NINJA_BUILD_PATH,
    NINJA_VIVADO_TOOLS_PATH,
    NINJA_SYNTH_TOOLS_PATH,
    NINJA_UTILS_PATH,
    VIVADO_RULES_PATH,
)
from bfasst.utils import compare_json
from bfasst.yaml_parser import YamlParser


class Vivado(Tool):
    """Tool to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, flow_args=None, ooc=False):
        super().__init__(design)

        self.flow_args = flow_args

        self.ooc = ooc
        if ooc:
            self.build = BUILD_DIR / design / "ooc"
        else:
            self.build = BUILD_DIR / design / "in_context"
        self.synth_output = self.build / "synth"
        self.impl_output = self.build / "impl"
        self.__create_build_dirs()

        self.top = YamlParser(self.design / "design.yaml").parse_top_module()
        self._read_hdl_files()

        self.vhdl_libs = {}
        self.__read_vhdl_libs()

        self.part = config.PART

    def __create_build_dirs(self):
        self.build.mkdir(parents=True, exist_ok=True)
        self.synth_output.mkdir(exist_ok=True)
        self.impl_output.mkdir(exist_ok=True)

    def __read_vhdl_libs(self):
        for child in self.design.glob("*"):
            if child.is_dir() and child.name == "lib":
                for lib in child.glob("*"):
                    for file in lib.rglob("*"):
                        if file.is_dir():
                            continue
                        if file.suffix == ".vhd":
                            key = str(file)
                            self.vhdl_libs[key] = lib.name

    def create_rule_snippets(self):
        with open(VIVADO_RULES_PATH, "r") as f:
            vivado_ninja = chevron.render(
                f,
                {
                    "vivado_path": config.VIVADO_BIN_PATH,
                    "utils": str(NINJA_UTILS_PATH),
                    "in_context": not self.ooc,
                },
            )
        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(vivado_ninja)

    def create_build_snippets(self):
        self.__write_json_files()
        self.__append_build_snippets()

    def __write_json_files(self):
        self.__write_synth_json()
        self.__write_impl_json()

    def __write_synth_json(self):
        """Specify synthesis arguments in a json file.
        Chevron will use to fill in the tcl template"""
        synth = {
            "part": self.part,
            "verilog": self.verilog,
            "system_verilog": self.system_verilog,
            "vhdl": self.vhdl,
            "vhdl_libs": list(self.vhdl_libs.items()),
            "top": self.top,
            "io": str(self.synth_output / "report_io.txt") if not self.ooc else False,
            "synth_output": str(self.synth_output),
            "flow_args": self.flow_args if self.flow_args else "",
        }
        synth_json = json.dumps(synth, indent=4)

        # check if the synth json file already exists and compare it to what we're about to write
        json_equivalent = compare_json(self.synth_output / "synth.json", synth_json)

        if not json_equivalent:
            with open(self.synth_output / "synth.json", "w") as f:
                f.write(synth_json)

    def __write_impl_json(self):
        """Specify implementation arguments in json file.
        Chevron will use json file to fill in the tcl template"""
        impl = {
            "part": self.part,
            "xdc": str(self.synth_output / (self.top + ".xdc")) if not self.ooc else False,
            "bit": str(self.impl_output / (self.top + ".bit")) if not self.ooc else False,
            "impl_output": str(self.impl_output),
            "synth_output": str(self.synth_output),
        }
        impl_json = json.dumps(impl, indent=4)

        # check if the impl json file already exists and compare it to what we're about to write
        json_equivalent = compare_json(self.impl_output / "impl.json", impl_json)

        if not json_equivalent:
            with open(self.impl_output / "impl.json", "w") as f:
                f.write(impl_json)

    def __append_build_snippets(self):
        self.__append_synth_snippets()
        self.__append_impl_snippets()

    def __append_synth_snippets(self):
        """Create ninja snippets for vivado synthesis in build.ninja"""
        with open(NINJA_SYNTH_TOOLS_PATH / "viv_synth.ninja.mustache") as f:
            synth_ninja = chevron.render(
                f,
                {
                    "in_context": not self.ooc,
                    "synth_output": str(self.synth_output),
                    "synth_library": NINJA_SYNTH_TOOLS_PATH,
                    "top": self.top,
                    "verilog": self.verilog,
                    "system_verilog": self.system_verilog,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(synth_ninja)

    def __append_impl_snippets(self):
        """Create ninja snippets for vivado implementation in build.ninja"""
        with open(NINJA_IMPL_TOOLS_PATH / "viv_impl.ninja.mustache") as f:
            impl_ninja = chevron.render(
                f,
                {
                    "in_context": not self.ooc,
                    "impl_output": str(self.impl_output),
                    "synth_output": str(self.synth_output),
                    "impl_library": NINJA_IMPL_TOOLS_PATH,
                    "top": self.top,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(impl_ninja)

    def add_ninja_deps(self, deps=None):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        if not deps:
            deps = []
        deps.append(f"{NINJA_SYNTH_TOOLS_PATH}/viv_synth.ninja.mustache ")
        deps.append(f"{NINJA_IMPL_TOOLS_PATH}/viv_impl.ninja.mustache ")
        deps.append(f"{NINJA_VIVADO_TOOLS_PATH}/vivado.py ")
        deps.append(f"{VIVADO_RULES_PATH} ")

        return deps
