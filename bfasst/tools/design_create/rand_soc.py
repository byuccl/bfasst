"""Create the rule and build snippets for error injection into an xray netlist."""

import pathlib
import chevron

from bfasst.tools.tool import ToolBase
from bfasst.paths import BUILD_PATH, GMT_TOOLS_PATH, NINJA_BUILD_PATH, TOOLS_PATH


class RandSoC(ToolBase):
    """Tool to create a random SoC"""

    def __init__(self, flow, num_designs, config_path):
        super().__init__(flow)
        self.build_path = BUILD_PATH / "rand_soc"
        self._my_dir_path = pathlib.Path(__file__).parent.resolve()
        self.num_designs = num_designs
        self.config_path = config_path
        self._init_outputs()
        self.rule_snippet_path = TOOLS_PATH / "design_create" / "rand_soc_rules.ninja"

    def create_build_snippets(self):
        rand_soc_pkg_files = list((GMT_TOOLS_PATH / "rand_soc" / "rand_soc").glob("**/*.py"))
        rand_soc_pkg_files.append(GMT_TOOLS_PATH / "rand_soc" / "main.py")

        for i, design in enumerate(self.outputs["design_tcl"]):
            design_dir_path = design.parent
            with open(self._my_dir_path / "rand_soc_build.ninja.mustache", "r") as f:
                build = chevron.render(
                    f,
                    {
                        "design_dir_path": design_dir_path,
                        "config_path": self.config_path,
                        "seed": i,
                        "rand_soc_source_files": " ".join((str(s) for s in rand_soc_pkg_files)),
                        "part": self.flow.part,
                    },
                )

            with open(NINJA_BUILD_PATH, "a") as f:
                f.write(build)

    def _init_outputs(self):
        self.outputs["design_tcl"] = []
        self.outputs["impl_constraints_tcl"] = []
        for i in range(self.num_designs):
            design_dir_path = self.build_path / f"design_{i}"
            self.outputs["design_tcl"].append(design_dir_path / "design.tcl")
            self.outputs["impl_constraints_tcl"].append(design_dir_path / "impl_constraints.tcl")

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
