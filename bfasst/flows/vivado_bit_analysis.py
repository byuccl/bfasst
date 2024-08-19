"""Flow to reverse a netlist from a bitstream using xray."""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.transform.netlist_cleanup import NetlistCleanup
from bfasst.tools.transform.netlist_phys_to_logical import NetlistPhysToLogical
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoBitAnalysis(Flow):
    """Flow to reverse a netlist from a bitstream using x-ray."""

    def __init__(self, design, synth_options="", logging_level="DEBUG"):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.logging_level = logging_level
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_file=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.xrev_tool = Xray(
            self,
            design,
            xdc_input=self.vivado_synth_tool.outputs["synth_constraints"],
            bitstream=self.vivado_impl_tool.outputs["bitstream"],
        )
        self.netlist_cleanup_tool = NetlistCleanup(
            self,
            design,
            rev_netlist=self.xrev_tool.outputs["rev_netlist"],
            logging_level=self.logging_level,
        )
        self.netlist_phys_to_logical = NetlistPhysToLogical(
            self, design, cleaned_netlist=self.netlist_cleanup_tool.outputs["netlist_cleaned_path"]
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
