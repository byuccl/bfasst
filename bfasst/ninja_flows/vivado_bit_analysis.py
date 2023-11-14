"""Flow to reverse a netlist from a bitstream using xray."""

import pathlib

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.rev_bit.xray import Xray as XrevTool
from bfasst.ninja_tools.transform.netlist_cleanup import NetlistCleanupTool
from bfasst.ninja_tools.transform.netlist_phys_to_logical import NetlistPhysToLogicalTool
from bfasst.ninja_flows.flow_utils import configure_vivado_synth_tool


class VivadoBitAnalysis(Flow):
    """Flow to reverse a netlist from a bitstream using x-ray."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_synth_tool = configure_vivado_synth_tool(design, flow_args)
        self.vivado_impl_tool = VivadoImpl(design)
        self.xrev_tool = XrevTool(design)
        self.netlist_cleanup_tool = NetlistCleanupTool(design)
        self.netlist_phys_to_logical = NetlistPhysToLogicalTool(design)

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.netlist_cleanup_tool.create_rule_snippets()
        self.netlist_phys_to_logical.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_impl_tool.outputs["bitstream"]))
        self.netlist_cleanup_tool.create_build_snippets(
            netlist_in_path=self.xrev_tool.outputs["xray_netlist"],
        )
        self.netlist_phys_to_logical.create_build_snippets(
            netlist_in_path=self.netlist_cleanup_tool.outputs["netlist_cleaned_path"],
        )

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        self.xrev_tool.add_ninja_deps(deps)
        self.netlist_cleanup_tool.add_ninja_deps(deps)
        self.netlist_phys_to_logical.add_ninja_deps(deps)
        deps.append(self.get_top_level_flow_path())

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
