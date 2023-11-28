"""Creates a Vivado netlist that has only physical primitives."""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth


class VivadoPhysNetlist(Flow):
    """Creates a Vivado netlist that has only physical primitives."""

    def __init__(self, design, synth_options=""):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.phys_netlist_tool = PhysNetlist(self, design)

    def create_build_snippets(self):
        # pylint: disable=duplicate-code
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return NINJA_FLOWS_PATH / "vivado_phys_netlist.py"

    @staticmethod
    def add_required_synth_options(options):
        if "-flatten_hierarchy" not in options:
            options += " -flatten_hierarchy full"
        if "-max_dsp" not in options:
            options += " -max_dsp 0"
        return options
