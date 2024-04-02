"""Ic2LseConformal flow"""

from bfasst.flows.flow import Flow
from bfasst.paths import FLOWS_PATH

from bfasst.tools.compare.conformal.conformal import Conformal
from bfasst.tools.rev_bit.icestorm import IcestormRevBit
from bfasst.tools.synth.ic2_lse_synth import Ic2LseSynth
from bfasst.tools.impl.ic2_impl import Ic2Impl
from bfasst.types import Vendor


class Ic2LseConformal(Flow):
    """Ic2LseConformal flow"""

    def __init__(self, design):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.ic2_lse_synth_tool = Ic2LseSynth(self, design)
        self.ic2_impl_tool = Ic2Impl(
            self, design, synth_edf_file=self.ic2_lse_synth_tool.outputs["edif_file"]
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
            golden_netlist=self.ic2_lse_synth_tool.outputs["golden_netlist"],
            rev_netlist=self.icestorm_reverse_bit_tool.outputs["rev_netlist"],
            vendor=Vendor.LATTICE.name,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "ic2_lse_conformal.py"
