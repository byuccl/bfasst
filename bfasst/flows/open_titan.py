"""Run the OpenTitan flow with the Vivado toolchain."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import FLOWS_PATH, DESIGNS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class OpenTitan(Flow):
    """Run the OpenTitan flow with the Vivado toolchain."""

    def __init__(self, design, synth_options=""):
        super().__init__(design)

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options)
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.vivado_impl_tool.impl_build["tcl_sources"] = [
            self.vivado_impl_tool.outputs_str["impl_tcl"],
            DESIGNS_PATH / "opentitan",
            self.vivado_impl_tool.outputs_str["reports_tcl"],
        ]

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "clock_crank.py"
