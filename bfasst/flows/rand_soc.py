"""Flow to create random soc block designs in Vivado"""

import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.paths import BFASST_ROOT, RAND_SOC_PATH
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth


class RandSoc(FlowNoDesign):
    """Flow to create random soc block designs in Vivado"""

    def __init__(self, num_designs=1, part=None, randsoc_config_path=None):
        # pylint: disable=duplicate-code
        super().__init__()

        # Override default part
        if part is not None:
            self.part = part

        # Get configuration of random SoC creator
        if randsoc_config_path is None:
            randsoc_config_path = RAND_SOC_PATH / "default_config.yaml"
        else:
            randsoc_config_path = BFASST_ROOT / randsoc_config_path
        assert randsoc_config_path.exists(), f"Config file {randsoc_config_path} does not exist"

        # Create all random designs
        self.rand_soc_tool = RandSoC(self, num_designs=num_designs, config_path=randsoc_config_path)

        # Build each random design
        for design_tcl, contraints_tcl in zip(
            self.rand_soc_tool.outputs["design_tcl"],
            self.rand_soc_tool.outputs["impl_constraints_tcl"],
        ):
            synth_tool = VivadoSynth(self, design_tcl.parent)
            synth_tool.synth_build["tcl_sources"] = [str(design_tcl)]
            VivadoImpl(
                self,
                design_tcl.parent,
                synth_edf=synth_tool.outputs["synth_edf"],
                constraints_files=(synth_tool.outputs["synth_constraints"], contraints_tcl),
            )

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "rand_soc"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
