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
        super().__init__(design)
        self.ic2_lse_synth_tool = Ic2LseSynth(self, design)
        self.ic2_impl_tool = Ic2Impl(self, design, self.ic2_lse_synth_tool.outputs)
        self.icestorm_reverse_bit_tool = IcestormRevBit(self, design, self.ic2_impl_tool.outputs)
        self.conformal_tool = Conformal(self, design, self.__create_conformal_inputs_dict())

        self.tools = [
            self.ic2_lse_synth_tool,
            self.ic2_impl_tool,
            self.icestorm_reverse_bit_tool,
            self.conformal_tool,
        ]

    def __create_conformal_inputs_dict(self):
        """Create the dictionary of inputs for the conformal tool."""
        return {
            "golden_netlist_gen": self.ic2_lse_synth_tool.outputs,
            "rev_netlist_gen": self.icestorm_reverse_bit_tool.outputs,
            "vendor": Vendor.LATTICE.name,
        }

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "ic2_lse_conformal.py"
