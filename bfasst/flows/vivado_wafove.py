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
            self,
            design,
            synth_output_dir=self.vivado_synth_tool.outputs["synth_dcp"].parent,
            constraints_file=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.xrev_tool = Xray(
            self,
            design,
            xdc_input=self.vivado_synth_tool.outputs["synth_constraints"],
            bitstream=self.vivado_impl_tool.outputs["bitstream"],
        )
        self.wafove_tool = Wafove(
            self,
            design,
            golden_netlist=self.vivado_impl_tool.outputs["golden_netlist"],
            rev_netlist=self.xrev_tool.outputs["rev_netlist"],
            std_out_log_name="wafove.log",
            std_err_log_name="wafove_err.log",
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
