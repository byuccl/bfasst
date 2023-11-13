"""Flow that combines vivado phys netlist and xray/f2b reversal"""


from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_flows.flow_utils import configure_vivado_synth_tool


class VivadoPhysNetlistXrev(Flow):
    """Flow that combines vivado phys netlist and xray/f2b reversal."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_synth_tool = configure_vivado_synth_tool(design, flow_args)
        self.vivado_impl_tool = VivadoImpl(design)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xrev_tool = Xray(design)

    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja."""
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()

    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja."""
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        self.xrev_tool.create_build_snippets(self.vivado_impl_tool.outputs["bitstream"])

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        self.phys_netlist_tool.add_ninja_deps(deps)
        self.xrev_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_phys_netlist_xrev.py")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py"
