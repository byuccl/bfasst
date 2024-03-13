"""Flow to compare reversed netlist to original using yosys."""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.yosys.yosys import Yosys
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoYosysCmp(Flow):
    """Flow to compare reversed netlist to original using yosys."""

    def __init__(self, design):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs
        )
        self.xrev_tool = Xray(self, design, prev_tool_outputs=self.vivado_impl_tool.outputs)
        self.yosys_tool = Yosys(self, design, self.__create_yosys_inputs_dict())

        self.tools = [
            self.vivado_synth_tool,
            self.vivado_impl_tool,
            self.xrev_tool,
            self.yosys_tool,
        ]

    def __create_yosys_inputs_dict(self):
        return {
            "impl_tool": self.vivado_impl_tool.outputs,
            "rev_bit_tool": self.xrev_tool.outputs,
        }

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
