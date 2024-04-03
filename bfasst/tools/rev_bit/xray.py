"""Tool to create rule and build snippets that reverse a bitstream using xray."""

import chevron
from bfasst import config
from bfasst.paths import NINJA_BUILD_PATH, REV_BIT_TOOLS_PATH, XRAY_PATH, get_fasm2bels_path
from bfasst.tools.tool import Tool


class Xray(Tool):
    """Tool to create rule and build snippets that reverse a bitstream using xray."""

    def __init__(self, flow, design, xdc_input, bitstream):
        super().__init__(flow, design)

        self.xdc_input = xdc_input
        self.bitstream = bitstream

        self.build_path = self.design_build_path / "xray"

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
        self.fasm_path = self.build_path / (self.design_props.top + ".fasm")
        self.reversed_netlist_path = self.build_path / (self.design_props.top + "_reversed.v")
        self.xdc_path = self.build_path / (self.design_props.top + "_reversed.xdc")

        self._init_outputs()

    def create_rule_snippets(self):
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_rules", "r") as f:
            rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self):
        """Populate xray build statements from template and copy them to build.ninja."""
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_build.mustache", "r") as f:
            build_rules = chevron.render(
                f,
                {
                    "xray_path": str(XRAY_PATH / "build" / "tools"),
                    "xray_fasm": str(self.outputs["xray_fasm"]),
                    "rev_netlist": str(self.outputs["rev_netlist"]),
                    "xray_xdc": str(self.outputs["xray_xdc"]),
                    "bitstream_path": self.bitstream,
                    "fasm2bels_path": self.fasm2bels_path,
                    "fasm2bels_python_path": self.fasm2bels_python_path,
                    "bit_to_fasm_path": XRAY_PATH / "utils" / "bit2fasm.py",
                    "db_root": self.db_root,
                    "part": config.PART,
                    "input_xdc": self.xdc_input,
                    "db_marker": self.fasm2bels_path / "db_marker",
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build_rules)

    def _init_outputs(self):
        self.outputs["xray_fasm"] = self.fasm_path
        self.outputs["rev_netlist"] = self.reversed_netlist_path
        self.outputs["xray_xdc"] = self.xdc_path

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
