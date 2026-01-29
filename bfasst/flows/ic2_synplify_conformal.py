"""Ic2LseConformal flow"""

from bfasst.design import Vendor
from bfasst.flows.flow import Flow
from bfasst.paths import BFASST_FLOWS
from bfasst.tools.compare.conformal.conformal import Conformal
from bfasst.tools.impl.ic2_impl import Ic2Impl
from bfasst.tools.rev_bit.icestorm import IcestormRevBit
from bfasst.tools.synth.ic2_synplify_synth import Ic2SynplifySynth


class Ic2SynplifyConformal(Flow):
    """Ic2LseConformal flow"""

    def __init__(self, design):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.ic2_synplify_synth_tool = Ic2SynplifySynth(self, design)
        self.ic2_impl_tool = Ic2Impl(
            self, design, synth_edf_file=self.ic2_synplify_synth_tool.outputs["edf_output"]
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
            golden_netlist=self.ic2_synplify_synth_tool.outputs["golden_netlist"],
            rev_netlist=self.icestorm_reverse_bit_tool.outputs["rev_netlist"],
            vendor=Vendor.LATTICE.name,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return BFASST_FLOWS / "ic2_synplify_conformal.py"
