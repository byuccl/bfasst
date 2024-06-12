"""Run the OpenTitan flow with the Vivado toolchain."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import FLOWS_PATH, BUILD_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class OpenTitan(Flow):
    """Run the OpenTitan flow with the Vivado toolchain."""

    def __init__(self, design, synth_options=""):
        super().__init__(design)

        if not synth_options:
            synth_options = {}
        if "top" not in synth_options:
            synth_options["top"] = "chip_earlgrey_cw310"
        if "part" not in synth_options:
            synth_options["part"] = "xc7k410tfbg676-1"

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options, ooc=True)
        self.vivado_synth_tool.update_tcl_srcs(
            [
                BUILD_PATH
                / "opentitan/vivado_ooc_synth/lowrisc_systems_chip_earlgrey_cw310_0.1.tcl",
                self.vivado_synth_tool.outputs_str["reports_tcl"],
            ]
        )

        # TODO: Add code to copy reports to expected locations for further analysis steps

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "opentitan.py"
