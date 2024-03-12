"""Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.conformal.conformal import Conformal
from bfasst.tools.rev_bit.xray import Xray
from bfasst.paths import FLOWS_PATH
from bfasst.types import Vendor
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoConformal(Flow):
    """Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

    def __init__(self, design):
        super().__init__(design)
        self.vivado_synth_tool = VivadoSynth(self, design)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs
        )
        self.xrev_tool = Xray(self, design)
        self.conformal_tool = Conformal(self, design, self.__create_conformal_inputs_dict())

    def __create_conformal_inputs_dict(self):
        """Create the dictionary of inputs for the conformal tool."""
        return {
            "golden_netlist_gen": self.vivado_impl_tool.outputs,
            "rev_netlist_gen": self.xrev_tool.outputs,
            "vendor": Vendor.XILINX.name,
        }

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_impl_tool.outputs["bitstream"]))
        self.conformal_tool.create_build_snippets()

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "vivado_conformal.py"
