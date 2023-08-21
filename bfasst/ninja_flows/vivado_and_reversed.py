"""Flow to reverse a netlist from a bitstream using xray."""
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.rev_bit.xray import Xray as XrevTool
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoAndReversed(Flow):
    """Flow to reverse a netlist from a bitstream using xray."""

    def __init__(self, design, flow_args=None):
        super().__init__()
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.xrev_tool = XrevTool(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets()

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.xrev_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_and_reversed.py ")
        return deps

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_and_reversed.py"
