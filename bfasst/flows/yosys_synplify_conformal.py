"""Yosys -> Synplify -> Ic2Impl -> Icestorm -> Conformal"""

from bfasst.flows.flow import Flow
from bfasst.paths import FLOWS_PATH
from bfasst.tools.compare.conformal.conformal import Conformal
from bfasst.tools.impl.ic2_impl import Ic2Impl
from bfasst.tools.rev_bit.icestorm import IcestormRevBit
from bfasst.tools.synth.ic2_synplify_synth import Ic2SynplifySynth
from bfasst.tools.synth.yosys_synth import YosysSynth
from bfasst.types import Vendor


class YosysSynplifyConformal(Flow):
    """Yosys -> Synplify -> Ic2Impl -> Icestorm -> Conformal"""

    def __init__(self, design):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.yosys_synth_tool = YosysSynth(self, design)
        self.ic2_synplify_tool = Ic2SynplifySynth(
            self, design, input_verilog_file=self.yosys_synth_tool.outputs["netlist"]
        )
        self.ic2_impl_tool = Ic2Impl(
            self, design, synth_edf_file=self.ic2_synplify_tool.outputs["edf_output"]
        )
        self.icestorm_reverse_bit_tool = IcestormRevBit(
            self,
            design,
            constraints_file=self.ic2_impl_tool.outputs["constraints"],
            bitstream=self.ic2_impl_tool.outputs["bitstream"],
        )
        self.conformal_tool = Conformal(
            self,
            design,
            golden_netlist=self.ic2_synplify_tool.outputs["golden_netlist"],
            rev_netlist=self.icestorm_reverse_bit_tool.outputs["rev_netlist"],
            vendor=Vendor.LATTICE.name,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "yosys_lse_conformal.py"
