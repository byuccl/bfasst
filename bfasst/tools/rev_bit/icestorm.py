"""Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

from bfasst.tools.tool import Tool


class IcestormRevBit(Tool):
    """Icestorm reverse bit tool (ninja snippet generation for icestorm reverse bitstream tool)"""

    def __init__(self, flow, design):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "icestorm"
        self._init_outputs()

    def create_rule_snippets(self):
        pass

    def create_build_snippets(self, bitstream_path):
        pass

    def _init_outputs(self):
        pass

    def add_ninja_deps(self, deps):
        pass
