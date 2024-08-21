"""Creates a Vivado netlist that has only physical primitives."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoPhysNetlist(Flow):
    """Creates a Vivado netlist that has only physical primitives."""

    def __init__(self, design, synth_options="", logging_level="INFO"):
        # pylint: disable=duplicate-code
        super().__init__(design)

        self.synth_options = VivadoPhysNetlist.add_required_synth_options(synth_options)
        self.logging_level = logging_level

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=self.synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_file=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.phys_netlist_tool = PhysNetlist(
            self,
            design,
            impl_checkpoint=self.vivado_impl_tool.outputs["impl_dcp"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
            logging_level=self.logging_level,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado_phys_netlist.py"

    @staticmethod
    def add_required_synth_options(options):
        if not options:
            options = {}
        synth_opts = options.get("synth_design", "")
        if "-flatten_hierarchy" not in synth_opts:
            synth_opts += " -flatten_hierarchy full"
        # if "-max_dsp" not in synth_opts:
        #     options += " -max_dsp 0"
        options["synth_design"] = synth_opts
        return options
