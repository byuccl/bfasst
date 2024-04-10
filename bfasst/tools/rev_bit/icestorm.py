"""Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

import pathlib
from bfasst.paths import ICEBOX_VLOG_PATH, ICEUNPACK_PATH, REV_BIT_TOOLS_PATH
from bfasst.tools.tool import Tool


class IcestormRevBit(Tool):
    """Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

    def __init__(self, flow, design_path, constraints_file, bitstream):
        super().__init__(flow, design_path)

        self.constraints_file = constraints_file
        self.bitstream = bitstream

        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = self.design_build_path / "icestorm"

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()
        self.rule_snippet_path = REV_BIT_TOOLS_PATH / "icestorm_rules.ninja"

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            {
                "bitstream": self.bitstream,
                "constraints": self.constraints_file,
                "asciifile": self.outputs["asciifile"],
                "rev_netlist": self.outputs["rev_netlist"],
                "report": self.outputs["report"],
                "icebox_vlog_path": ICEBOX_VLOG_PATH,
                "iceunpack_path": ICEUNPACK_PATH,
            },
        )

    def _init_outputs(self):
        self.outputs["asciifile"] = self.build_path / (self.design_props.top + ".asc")
        self.outputs["rev_netlist"] = self.build_path / (self.design_props.top + "_rev.v")
        self.outputs["report"] = self.build_path / (self.design_props.top + "_rev.rpt")

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
