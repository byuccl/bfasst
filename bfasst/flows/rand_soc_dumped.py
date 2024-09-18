"""Flow to dump bels from random soc block designs with Isoblaze"""

import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.transform.randsoc_dump import RandsocDump
from bfasst.paths import ROOT_PATH, GMT_TOOLS_PATH


class RandSocDumped(FlowNoDesign):
    """Flow to dump bels from random soc block designs with Isoblaze"""

    def __init__(self, num_designs=1, part=None, randsoc_config_path=None):
        # pylint: disable=duplicate-code
        super().__init__()

        # Override default part
        if part is not None:
            self.part = part

        # Get configuration of random SoC creator
        if randsoc_config_path is None:
            randsoc_config_path = GMT_TOOLS_PATH / "rand_soc" / "default_config.yaml"
        else:
            randsoc_config_path = ROOT_PATH / randsoc_config_path
        assert randsoc_config_path.exists(), f"Config file {randsoc_config_path} does not exist"

        # Create all random designs
        self.rand_soc_tool = RandSoC(self, num_designs=num_designs, config_path=randsoc_config_path)

        # Build each random design
        for i, design_tcl, contraints_tcl in enumerate(
            zip(
                self.rand_soc_tool.outputs["design_tcl"],
                self.rand_soc_tool.outputs["impl_constraints_tcl"],
            )
        ):
            synth_tool = VivadoSynth(self, design_tcl.parent)
            synth_tool.synth_build["tcl_sources"] = [str(design_tcl)]
            impl_tool = VivadoImpl(
                self,
                design_tcl.parent,
                synth_edf=synth_tool.outputs["synth_edf"],
                constraints_files=(synth_tool.outputs["synth_constraints"], contraints_tcl),
            )
            RandsocDump(
                self,
                checkpoint=impl_tool.outputs["impl_dcp"],
                dumpfile=f"design_{i}.dump",
            )
            # pylint: enable=duplicate-code

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "randsoc_dumped"

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
