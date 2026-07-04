"""Flow to create Vivado synthesis and implementation ninja snippets."""

from bfasst.flows.flow import Flow
from bfasst.paths import BFASST_FLOWS
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, synth_options=None, ooc=False):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.ooc = ooc
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options, ooc=ooc)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
            ooc=ooc,
        )
        self.tools = [self.vivado_synth_tool, self.vivado_impl_tool]
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return BFASST_FLOWS / "vivado.py" if not self.ooc else BFASST_FLOWS / "vivado_ooc.py"
