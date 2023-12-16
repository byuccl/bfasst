"""Flow to dump bels from random soc block designs with Isoblaze"""
import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.paths import DUMP_TOOL_BUILD_PATH
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth_tcl import VivadoSynthFromTcl
from bfasst.tools.transform.isoblaze_dump import IsoblazeDump


class RandSocDumped(FlowNoDesign):
    """Flow to dump bels from random soc block designs with Isoblaze"""

    def __init__(self, num_designs=1):
        super().__init__()

        self.rand_soc_tool = RandSoC(self, num_designs=num_designs)

        for design in self.rand_soc_tool.outputs["design_tcl"]:
            VivadoSynthFromTcl(self, design)
            VivadoImpl(self, design.parent)

        IsoblazeDump(self, num_designs=num_designs)

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return DUMP_TOOL_BUILD_PATH.name

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
