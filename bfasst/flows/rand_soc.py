"""Flow to create random soc block designs in Vivado"""

import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth_tcl import VivadoSynthFromTcl


class RandSoc(FlowNoDesign):
    """Flow to create random soc block designs in Vivado"""

    def __init__(self, num_designs=1, part=None):
        # pylint: disable=duplicate-code
        super().__init__()

        # Override default part
        if part is not None:
            self.part = part

        self.rand_soc_tool = RandSoC(self, num_designs=num_designs)

        for design in self.rand_soc_tool.outputs["design_tcl"]:
            synth_tool = VivadoSynthFromTcl(self, design)
            VivadoImpl(
                self,
                design.parent,
                synth_edf=synth_tool.outputs["synth_edf"],
                constraints_file=synth_tool.outputs["synth_constraints"],
            )
        # pylint: enable=duplicate-code

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "rand_soc"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
