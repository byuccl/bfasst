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
        # pylint: disable=duplicate-code
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
        self.yosys_tool = Yosys(
            self,
            design,
            golden_netlist=self.vivado_impl_tool.outputs["golden_netlist"],
            rev_netlist=self.xrev_tool.outputs["rev_netlist"],
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
