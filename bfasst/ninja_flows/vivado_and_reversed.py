"""Flow to reverse a netlist from a bitstream using xray."""
from argparse import ArgumentParser
import chevron
from bfasst import config
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado import Vivado
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
    REV_BIT_TOOLS_PATH,
    ROOT_PATH,
    get_fasm2bels_path,
)
from bfasst.yaml_parser import YamlParser


class VivadoAndReversed(Flow):
    """Flow to reverse a netlist from a bitstream using xray."""

    def __init__(self, design):
        super().__init__(design)
        self.vivado_flow = Vivado(design)

        self.build = ROOT_PATH / "build" / design / "xray"
        self.__create_build_dirs()

        self.top = YamlParser(self.design / "design.yaml").parse_top_module()

        # get these moved to paths later
        self.fasm2bels_path = get_fasm2bels_path()
        self.fasm2bels_python_path = (
            self.fasm2bels_path
            / "env"
            / "conda"
            / "envs"
            / "f4pga_xc_fasm2bels"
            / "bin"
            / "python3"
        )
        self.xray_path = self.fasm2bels_path / "third_party" / "prjxray"
        self.xray_db_path = self.fasm2bels_path / "third_party" / "prjxray-db"
        self.db_root = self.xray_db_path / config.PART_FAMILY
        self.to_netlist_log = self.build / "to_netlist.log"
        self.to_fasm_log = self.build / "to_fasm.log"
        self.fasm_path = self.build / (self.top + ".fasm")
        self.reversed_netlist_path = self.build / (self.top + "_reversed.v")
        self.xdc_path = self.build / (self.top + "_reversed.xdc")
        self.constraints_path = self.build / "constraints.xdc"

    def __create_build_dirs(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        self.vivado_flow.create_rule_snippets()

        with open(REV_BIT_TOOLS_PATH / "xray.ninja_rules", "r") as f:
            rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self):
        """Populate xray build statements from template and copy them to build.ninja."""
        self.vivado_flow.create_build_snippets()
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_build.mustache", "r") as f:
            build_rules = chevron.render(
                f,
                {
                    "fasm2bels_python_path": self.fasm2bels_python_path,
                    "bit_to_fasm_path": self.xray_path / "utils" / "bit2fasm.py",
                    "db_root": self.db_root,
                    "part": config.PART,
                    "fasm_file": self.fasm_path,
                    "verilog_file": self.reversed_netlist_path,
                    "xdc_file": self.xdc_path,
                    "input_xdc": self.constraints_path,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build_rules)

    def add_ninja_deps(self, deps=None):
        """Add dependencies to build.ninja
        that would trigger a rebuild of that file if modified"""
        if not deps:
            deps = []
        deps.extend(self.vivado_flow.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_and_reversed.py ")
        deps.append(f"{REV_BIT_TOOLS_PATH}/xray.ninja_rules ")
        deps.append(f"{REV_BIT_TOOLS_PATH}/xray.ninja_build.mustache ")
        return deps

    def get_top_level_flow_path(self):
        path = str(NINJA_FLOWS_PATH / "vivado_and_reversed.py")
        return path


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--design", type=str, required=True, help="Design to run")
    args = parser.parse_args()
    flow = VivadoAndReversed(args.design)
    create_build_file()
    flow.create_rule_snippets()
    flow.create_build_snippets()
