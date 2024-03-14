"""Flow to create Vivado synthesis and implementation ninja snippets."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, ooc=False):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.ooc = ooc
        self.vivado_synth_tool = VivadoSynth(self, design, ooc)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_file=self.vivado_synth_tool.outputs["synth_constraints"],
            ooc=ooc,
        )
        self.tools = [self.vivado_synth_tool, self.vivado_impl_tool]
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado.py" if not self.ooc else FLOWS_PATH / "vivado_ooc.py"
