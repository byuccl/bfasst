"""Flow to compare netlists using wafove."""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.compare.wafove.wafove import Wafove


class VivadoWafove(Flow):
    """Flow to compare netlists using wafove."""

    def __init__(self, design):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs
        )
        self.xrev_tool = Xray(self, design, prev_tool_outputs=self.vivado_impl_tool.outputs)
        self.wafove_tool = Wafove(self, design)

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets()
        self.wafove_tool.create_build_snippets(
            netlist_a=self.vivado_impl_tool.outputs["impl_verilog"],
            netlist_b=self.xrev_tool.outputs["xray_netlist"],
            log_name="wafove.log",
            std_err_log="wafove_error.log",
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
