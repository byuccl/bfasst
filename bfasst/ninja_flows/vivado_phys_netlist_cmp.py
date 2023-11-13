"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.compare.structural.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_flows.flow_utils import configure_vivado_synth_tool

class VivadoPhysNetlistCmp(Flow):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_synth_tool = configure_vivado_synth_tool(design, flow_args)
        self.vivado_impl_tool = VivadoImpl(design)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xray_tool = Xray(design)
        self.compare_tool = Structural(design)

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xray_tool.create_rule_snippets()
        self.compare_tool.create_rule_snippets()

    def create_build_snippets(self):
        # pylint: disable=duplicate-code
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        self.xray_tool.create_build_snippets(str(self.vivado_impl_tool.outputs["bitstream"]))
        self.compare_tool.create_build_snippets(
            netlist_a=self.xray_tool.outputs["xray_netlist"],
            netlist_b=self.phys_netlist_tool.outputs["viv_impl_physical_v"],
            log_name="struct_cmp.log",
        )
        # pylint: enable=duplicate-code

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        self.phys_netlist_tool.add_ninja_deps(deps)
        self.xray_tool.add_ninja_deps(deps)
        self.compare_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_phys_netlist_cmp.py")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_cmp.py"
