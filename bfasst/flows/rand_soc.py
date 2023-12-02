"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.synth.vivado_synth_tcl import VivadoSynthFromTcl


class RandSoc(FlowNoDesign):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, num_designs=1):
        super().__init__()

        self.rand_soc_tool = RandSoC(self, num_designs=num_designs)

        for design in self.rand_soc_tool.outputs["design_tcl"]:
            VivadoSynthFromTcl(self, design)

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "rand_soc"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
