"""Narrows down fastest clock rate for a design"""

from bfasst.flows.flow import Flow
from bfasst.paths import FLOWS_PATH
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth


class ClockCrank(Flow):
    """Narrows down fastest clock rate for a design"""

    def __init__(self, design, synth_options=""):
        super().__init__(design)

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.clock_defined = True
        if not self.vivado_impl_tool.impl_build["clocks"]:
            print(f"No clocks defined for {design}. Skipping.")
            self.__delattr__("vivado_impl_tool")
            self.__delattr__("vivado_synth_tool")
            self.clock_defined = False
            return

        self.vivado_impl_tool.outputs["clock_crank_tcl"] = (
            self.vivado_impl_tool.build_path / "clock_crank.tcl"
        )
        self.vivado_impl_tool.outputs_str["clock_crank_tcl"] = str(
            self.vivado_impl_tool.outputs["clock_crank_tcl"]
        )
        self.vivado_impl_tool.impl_build["tcl_sources"] = [
            self.vivado_impl_tool.outputs_str["setup_tcl"],
            self.vivado_impl_tool.outputs_str["impl_tcl"],
            self.vivado_impl_tool.outputs_str["clock_crank_tcl"],
            self.vivado_impl_tool.outputs_str["reports_tcl"],
        ]

    def create_build_snippets(self):
        if self.clock_defined:
            self.vivado_synth_tool.create_build_snippets()
            self.vivado_impl_tool.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "clock_crank.py"
