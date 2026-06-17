"""Flow to create random soc block designs in Vivado"""

import pathlib

from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.paths import RAND_SOC_PATH, ROOT_PATH


class RandSoc(FlowNoDesign):
    """Flow to create random soc block designs in Vivado"""

    def __init__(
        self, num_designs=1, part=None, randsoc_config_path=None, start_seed=0, clock_period=None
    ):
        # pylint: disable=duplicate-code
        super().__init__()

        # Override default part
        if part is not None:
            self.part = part

        self.clock_period = clock_period

        # Get configuration of random SoC creator
        if randsoc_config_path is None:
            randsoc_config_path = RAND_SOC_PATH / "default_config.yaml"
        else:
            randsoc_config_path = ROOT_PATH / randsoc_config_path
        assert randsoc_config_path.exists(), f"Config file {randsoc_config_path} does not exist"

        # Create all random designs
        self.rand_soc_tool = RandSoC(
            self, num_designs=num_designs, config_path=randsoc_config_path, start_idx=start_seed
        )

        # Collect per-design clock XDC paths so create_build_snippets can write them
        self._clock_xdc_paths = []

        # Build each random design
        for design_tcl, contraints_tcl in zip(
            self.rand_soc_tool.outputs["design_tcl"],
            self.rand_soc_tool.outputs["impl_constraints_tcl"],
        ):
            synth_tool = VivadoSynth(self, design_tcl.parent)
            synth_tool.synth_build["tcl_sources"] = [str(design_tcl)]

            constraints = [synth_tool.outputs["synth_constraints"], contraints_tcl]
            if clock_period is not None:
                clock_xdc = design_tcl.parent / "clock_constraint.xdc"
                self._clock_xdc_paths.append(clock_xdc)
                constraints.append(clock_xdc)

            VivadoImpl(
                self,
                design_tcl.parent,
                synth_edf=synth_tool.outputs["synth_edf"],
                constraints_files=tuple(constraints),
            )

    def create_build_snippets(self):
        for xdc_path in self._clock_xdc_paths:
            xdc_path.parent.mkdir(parents=True, exist_ok=True)
            content = (
                f"create_clock -period {self.clock_period} "
                f"-name clk_wiz_in [get_ports {{clk[0]}}]\n"
            )
            if not xdc_path.exists() or xdc_path.read_text() != content:
                xdc_path.write_text(content)
        super().create_build_snippets()

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "rand_soc"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
