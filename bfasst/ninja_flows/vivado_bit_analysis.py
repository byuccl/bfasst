"""Flow to reverse a netlist from a bitstream using xray."""

import pathlib

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.rev_bit.xray import Xray as XrevTool
from bfasst.ninja_tools.transform.netlist_cleanup import NetlistCleanupTool


class XilinxBitAnalysis(Flow):
    """Flow to reverse a netlist from a bitstream using x-ray."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.xrev_tool = XrevTool(design)
        self.netlist_cleanup_tool = NetlistCleanupTool(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.netlist_cleanup_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_tool.outputs["bitstream"]))
        self.netlist_cleanup_tool.create_build_snippets(
            netlist_in_path=self.xrev_tool.outputs["xray_netlist"],
        )

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.xrev_tool.add_ninja_deps())
        deps.extend(self.netlist_cleanup_tool.add_ninja_deps())
        deps.append(str(self.get_top_level_flow_path()))
        return deps

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
