"""Flow to create Vivado synthesis and implementation ninja snippets."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, ooc=False):
        super().__init__(design)
        self.ooc = ooc
        self.vivado_synth_tool = VivadoSynth(self, design, ooc)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs, ooc=ooc
        )
        self.tools = [self.vivado_synth_tool, self.vivado_impl_tool]

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado.py" if not self.ooc else FLOWS_PATH / "vivado_ooc.py"
