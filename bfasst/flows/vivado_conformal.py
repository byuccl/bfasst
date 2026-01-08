"""Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

from bfasst.flows.flow import Flow
from bfasst.paths import BFASST_FLOWS
from bfasst.tools.compare.conformal.conformal import Conformal
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.types import Vendor


class VivadoConformal(Flow):
    """Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

    def __init__(self, design):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.xrev_tool = Xray(
            self,
            design,
            xdc_input=self.vivado_synth_tool.outputs["synth_constraints"],
            bitstream=self.vivado_impl_tool.outputs["bitstream"],
        )
        self.conformal_tool = Conformal(
            self,
            design,
            golden_netlist=self.vivado_impl_tool.outputs["impl_verilog"],
            rev_netlist=self.xrev_tool.outputs["rev_netlist"],
            vendor=Vendor.XILINX.name,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self) -> str:
        return BFASST_FLOWS / "vivado_conformal.py"
