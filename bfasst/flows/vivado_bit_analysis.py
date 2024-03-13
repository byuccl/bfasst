"""Flow to reverse a netlist from a bitstream using xray."""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.transform.netlist_cleanup import NetlistCleanup
from bfasst.tools.transform.netlist_phys_to_logical import NetlistPhysToLogical
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoBitAnalysis(Flow):
    """Flow to reverse a netlist from a bitstream using x-ray."""

    def __init__(self, design, synth_options=""):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs
        )
        self.xrev_tool = Xray(self, design, prev_tool_outputs=self.vivado_impl_tool.outputs)
        self.netlist_cleanup_tool = NetlistCleanup(
            self, design, prev_tool_outputs=self.xrev_tool.outputs
        )
        self.netlist_phys_to_logical = NetlistPhysToLogical(
            self, design, prev_tool_outputs=self.netlist_cleanup_tool.outputs
        )

        self.tools = [
            self.vivado_synth_tool,
            self.vivado_impl_tool,
            self.xrev_tool,
            self.netlist_cleanup_tool,
            self.netlist_phys_to_logical,
        ]

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
