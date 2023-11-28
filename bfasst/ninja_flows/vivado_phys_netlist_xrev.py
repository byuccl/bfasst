"""Flow that combines vivado phys netlist and xray/f2b reversal"""


from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth


class VivadoPhysNetlistXrev(Flow):
    """Flow that combines vivado phys netlist and xray/f2b reversal."""

    def __init__(self, design, synth_options=""):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.phys_netlist_tool = PhysNetlist(self, design)
        self.xrev_tool = Xray(self, design)

    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja."""
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        self.xrev_tool.create_build_snippets(self.vivado_impl_tool.outputs["bitstream"])

    def get_top_level_flow_path(self):
        return NINJA_FLOWS_PATH / "vivado_phys_netlist_xrev.py"
