"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.structural.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoPhysNetlistCmp(Flow):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
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
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_tool.outputs["impl_edf"],
        )
        self.xray_tool.create_build_snippets(str(self.vivado_tool.outputs["bitstream"]))
        self.compare_tool.create_build_snippets(
            netlist_a=self.xray_tool.outputs["xray_netlist"],
            netlist_b=self.phys_netlist_tool.outputs["viv_impl_physical_v"],
            log_name="struct_cmp.log",
        )

    def add_ninja_deps(self, deps):
        self.vivado_tool.add_ninja_deps(deps)
        self.phys_netlist_tool.add_ninja_deps(deps)
        self.xray_tool.add_ninja_deps(deps)
        self.compare_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_phys_netlist_cmp.py")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_cmp.py"
