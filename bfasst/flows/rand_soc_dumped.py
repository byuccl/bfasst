"""Flow to dump bels from random soc block designs with Isoblaze"""

import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth_tcl import VivadoSynthFromTcl
from bfasst.tools.transform.randsoc_dump import RandsocDump


class RandSocDumped(FlowNoDesign):
    """Flow to dump bels from random soc block designs with Isoblaze"""

    def __init__(self, num_designs=1):
        super().__init__()

        self.rand_soc_tool = RandSoC(self, num_designs=num_designs)

        for i, design in enumerate(self.rand_soc_tool.outputs["design_tcl"]):
            synth_tool = VivadoSynthFromTcl(self, design)
            VivadoImpl(self, design.parent, prev_tool_outputs=synth_tool.outputs)
            RandsocDump(
                self,
                checkpoint=design.parent / "impl" / "impl.dcp",
                dumpfile=f"design_{i}.dump",
            )

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "randsoc_dumped"

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
