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
        self.icestorm_reverse_bit_tool = IcestormRevBit(self, design)
        self.conformal_tool = Conformal(self, design)

    def create_rule_snippets(self):
        self.ic2_lse_synth_tool.create_rule_snippets()
        self.ic2_impl_tool.create_rule_snippets()
        self.icestorm_reverse_bit_tool.create_rule_snippets()
        self.conformal_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.ic2_lse_synth_tool.create_build_snippets()
        self.ic2_impl_tool.create_build_snippets()
        self.icestorm_reverse_bit_tool.create_build_snippets(
            bitstream=str(self.ic2_impl_tool.outputs["bitstream"]),
            constraints=str(self.ic2_impl_tool.outputs["constraints"]),
        )
        self.conformal_tool.create_build_snippets(
            impl_netlist=str(self.ic2_lse_synth_tool.outputs["prim_netlist"]),
            rev_netlist=str(self.icestorm_reverse_bit_tool.outputs["netlist"]),
            vendor=Vendor.LATTICE,
        )

    def add_ninja_deps(self, deps):
        self.ic2_lse_synth_tool.add_ninja_deps(deps)
        self.ic2_impl_tool.add_ninja_deps(deps)
        self.icestorm_reverse_bit_tool.add_ninja_deps(deps)
        self.conformal_tool.add_ninja_deps(deps)
        deps.append(FLOWS_PATH / "ic2_lse_conformal.py")

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "ic2_lse_conformal.py"
