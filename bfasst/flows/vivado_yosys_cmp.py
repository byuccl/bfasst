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
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.xrev_tool = Xray(self, design)
        self.yosys_tool = Yosys(self, design)

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_impl_tool.outputs["bitstream"]))
        self.yosys_tool.create_build_snippets(
            gold_netlist=self.vivado_impl_tool.outputs["impl_verilog"],
            rev_netlist=self.xrev_tool.outputs["xray_netlist"],
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
