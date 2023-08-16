"""Flow that combines vivado phys netlist and xray/f2b reversal"""


from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado import Vivado
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoPhysNetlistXrev(Flow):
    """Flow that combines vivado phys netlist and xray/f2b reversal."""

    def __init__(self, design):
        super().__init__()
        self.vivado_tool = Vivado(design)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xrev_tool = Xray(design)

    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja."""
        self.vivado_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()

    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja."""
        self.vivado_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets()

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.phys_netlist_tool.add_ninja_deps())
        deps.extend(self.xrev_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py ")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py"
