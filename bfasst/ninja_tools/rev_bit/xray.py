"""Tool to create rule and build snippets that reverse a bitstream using xray."""

import chevron
from bfasst import config
from bfasst.paths import NINJA_BUILD_PATH, REV_BIT_TOOLS_PATH, XRAY_PATH, get_fasm2bels_path
from bfasst.ninja_tools.tool import Tool
from bfasst.yaml_parser import YamlParser


class Xray(Tool):
    """Tool to create rule and build snippets that reverse a bitstream using xray."""

    def __init__(self, design):
        super().__init__(design)

        self.build_path = self.design_build_path / "xray"
        self._create_build_dir()

        self.top = YamlParser(self.design_path / "design.yaml").parse_top_module()

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
        self.xray_db_path = self.fasm2bels_path / "third_party" / "prjxray-db"
        self.db_root = self.xray_db_path / config.PART_FAMILY
        self.to_netlist_log = self.build_path / "to_netlist.log"
        self.fasm_path = self.build_path / (self.top + ".fasm")
        self.reversed_netlist_path = self.build_path / (self.top + "_reversed.v")
        self.xdc_path = self.build_path / (self.top + "_reversed.xdc")
        self.constraints_path = (
            str(self.build_path.parent / "in_context" / "synth" / self.top) + ".xdc"
        )
        self._init_outputs()

    def create_rule_snippets(self):
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_rules", "r") as f:
            rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self, bitstream: str):
        """Populate xray build statements from template and copy them to build.ninja."""
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_build.mustache", "r") as f:
            build_rules = chevron.render(
                f,
                {
                    "xray_path": str(XRAY_PATH / "build" / "tools"),
                    "bitstream_path": bitstream,
                    "xray_output": self.build_path,
                    "fasm2bels_path": self.fasm2bels_path,
                    "fasm2bels_python_path": self.fasm2bels_python_path,
                    "bit_to_fasm_path": XRAY_PATH / "utils" / "bit2fasm.py",
                    "db_root": self.db_root,
                    "part": config.PART,
                    "top": self.top,
                    "verilog_file": self.reversed_netlist_path,
                    "xdc_file": self.xdc_path,
                    "input_xdc": self.constraints_path,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build_rules)

    def _init_outputs(self):
        self.outputs["xray_fasm"] = self.fasm_path
        self.outputs["xray_netlist"] = self.reversed_netlist_path
        self.outputs["xray_xdc"] = self.xdc_path

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
