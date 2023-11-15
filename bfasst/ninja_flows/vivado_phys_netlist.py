"""Creates a Vivado netlist that has only physical primitives."""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_tools.vivado.synth.vivado_synth import VivadoSynth
from bfasst.utils.general import ensure


class VivadoPhysNetlist(Flow):
    """Creates a Vivado netlist that has only physical primitives."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(design, ensure(flow_args, {}).get("synth"))
        self.vivado_impl_tool = VivadoImpl(design)
        self.phys_netlist_tool = PhysNetlist(design)

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()

    def create_build_snippets(self):
        # pylint: disable=duplicate-code
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        # pylint: enable=duplicate-code

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        self.phys_netlist_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_phys_netlist.py")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_phys_netlist.py"
