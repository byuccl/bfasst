"""Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

import pathlib
from bfasst.tools.tool import Tool


class IcestormRevBit(Tool):
    """Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = self.design_build_path / "icestorm"

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, bitstream, constraints):
        self._append_build_snippets_default(
            __file__,
            {
                "bitstream": bitstream,
                "constraints": constraints,
                "asciifile": self.outputs["asciifile"],
                "netlist": self.outputs["netlist"],
                "report": self.outputs["report"],
            },
        )

    def _init_outputs(self):
        self.outputs["asciifile"] = self.build_path / (self.design_props.top + ".asc")
        self.outputs["netlist"] = self.build_path / (self.design_props.top + "_rev.v")
        self.outputs["report"] = self.build_path / (self.design_props.top + "_rev.rpt")

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
