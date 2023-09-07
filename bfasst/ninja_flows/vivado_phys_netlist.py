"""Creates a Vivado netlist that has only physical primitives."""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoPhysNetlist(Flow):
    """Creates a Vivado netlist that has only physical primitives."""

    def __init__(self, design, flow_args=None):
        super().__init__()
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.phys_netlist_tool = PhysNetlist(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets()

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.phys_netlist_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist.py")
        return deps

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist.py"
