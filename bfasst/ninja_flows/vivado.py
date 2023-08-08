"""Flow to create Vivado synthesis and implementation ninja snippets."""
from argparse import ArgumentParser
import code
import json
import chevron
from bfasst import config
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.paths import (
    NINJA_IMPL_TOOLS_PATH,
    NINJA_BUILD_PATH,
    ROOT_PATH,
    NINJA_SYNTH_TOOLS_PATH,
    NINJA_UTILS_PATH,
    NINJA_FLOWS_PATH,
    VIVADO_RULES_PATH,
)
from bfasst.utils import compare_json
from bfasst.yaml_parser import YamlParser


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, ooc=False):
        super().__init__(design)

        self.ooc = ooc
        if ooc:
            self.build = ROOT_PATH / "build" / design / "ooc"
        else:
            self.build = ROOT_PATH / "build" / design / "in_context"
        self.synth_output = self.build / "synth"
        self.impl_output = self.build / "impl"
        self.__create_build_dirs()

        self.top = YamlParser(self.design / "design.yaml").parse_top_module()
        self.__read_hdl_files()

        self.part = config.PART

    def __create_build_dirs(self):
        self.build.mkdir(parents=True, exist_ok=True)
        self.synth_output.mkdir(exist_ok=True)
        self.impl_output.mkdir(exist_ok=True)

    def __read_hdl_files(self):
        """Read the hdl files in the design directory"""
        self.verilog = []
        self.system_verilog = []
        for child in self.design.rglob("*"):
            if child.is_dir():
                continue

            if child.suffix == ".v":
                self.verilog.append(str(child))
            elif child.suffix == ".sv":
                self.system_verilog.append(str(child))

    def create_rule_snippets(self):
        with open(VIVADO_RULES_PATH, "r") as f:
            vivado_ninja = chevron.render(
                f,
                {
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
            "top": self.top,
            "io": str(self.synth_output / "report_io.txt") if not self.ooc else False,
            "synth_output": str(self.synth_output),
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
        deps.append(f"{NINJA_FLOWS_PATH}/vivado.py ")
        deps.append(f"{VIVADO_RULES_PATH} ")

        return deps

    def get_top_level_flow_path(self):
        path = (
            str(NINJA_FLOWS_PATH / "vivado.py")
            if not self.ooc
            else str(NINJA_FLOWS_PATH / "vivado_ooc.py")
        )
        return path


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--design", type=str, required=True, help="Design to run")
    args = parser.parse_args()
    flow = Vivado(args.design)
    create_build_file()
    flow.create_rule_snippets()
    flow.create_build_snippets()
