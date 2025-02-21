"""Tool to create rule and build snippets that reverse a bitstream using xray."""

import chevron
from bfasst.utils.general import get_family_from_part
from bfasst.paths import (
    NINJA_BUILD_PATH,
    REV_BIT_TOOLS_PATH,
    XRAY_PATH,
    FASM2BELS_PATH,
    FASM2BELS_PYTHON_PATH,
    XRAY_DB_PATH,
)
from bfasst.tools.tool import Tool


class Xray(Tool):
    """Tool to create rule and build snippets that reverse a bitstream using xray."""

    def __init__(self, flow, design, xdc_input, bitstream):
        super().__init__(flow, design)

        self.xdc_input = xdc_input
        self.bitstream = bitstream
        self.build_path = self.design_build_path / "xray"
        self.to_netlist_log = self.build_path / "to_netlist.log"

        self.fasm_path = self.build_path / (self.design_props.top + ".fasm")
        self.reversed_netlist_path = self.build_path / (self.design_props.top + "_reversed.v")
        self.xdc_path = self.build_path / (self.design_props.top + "_reversed.xdc")

        self.rule_snippet_path = REV_BIT_TOOLS_PATH / "xray.ninja_rules"
        self._init_outputs()

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
                    "fasm2bels_path": FASM2BELS_PATH,
                    "fasm2bels_python_path": FASM2BELS_PYTHON_PATH,
                    "bit_to_fasm_path": XRAY_PATH / "utils" / "bit2fasm.py",
                    "db_root": XRAY_DB_PATH / get_family_from_part(self.flow.part),
                    "part": self.flow.part,
                    "input_xdc": self.xdc_input,
                    "output_capnp_log": self.build_path / (self.design_props.top + "_reversed_log.capnp"),
                    "output_capnp_phys": self.build_path / (self.design_props.top + "_reversed_phys.capnp"),
                    "output_capnp_xdc": self.build_path / (self.design_props.top + "_reversed_xdc.capnp"),
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
