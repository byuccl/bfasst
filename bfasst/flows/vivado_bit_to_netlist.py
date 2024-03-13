"""Flow to reverse a netlist from a bitstream"""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoBitToNetlist(Flow):
    """Flow to reverse a netlist from a bitstream"""

    def __init__(self, design, synth_options=""):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs
        )
        self.xrev_tool = Xray(self, design, prev_tool_outputs=self.vivado_impl_tool.outputs)

        self.tools = [
            self.vivado_synth_tool,
            self.vivado_impl_tool,
            self.xrev_tool,
        ]

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
