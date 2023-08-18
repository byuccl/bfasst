"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoPhysNetlistCmp(Flow):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, flow_args=None):
        super().__init__()
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xray_tool = Xray(design)
        self.compare_tool = Structural(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xray_tool.create_rule_snippets()
        self.compare_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets()
        self.xray_tool.create_build_snippets()
        self.compare_tool.create_build_snippets(
            self.xray_tool.reversed_netlist_path,
            self.phys_netlist_tool.phys_netlist_path,
            "struct_cmp.log",
        )

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.phys_netlist_tool.add_ninja_deps())
        deps.extend(self.xray_tool.add_ninja_deps())
        deps.extend(self.compare_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_cmp.py ")

        return deps

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_cmp.py"
