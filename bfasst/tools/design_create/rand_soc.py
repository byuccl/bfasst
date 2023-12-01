"""Create the rule and build snippets for error injection into an xray netlist."""

import pathlib
import chevron

from bfasst.tools.tool import ToolBase
from bfasst.paths import BUILD_PATH, GMT_TOOLS_PATH, NINJA_BUILD_PATH


class RandSoCTool(ToolBase):
    """Tool to create a random SoC"""

    def __init__(self, flow, num_designs):
        super().__init__(flow)
        self.build_path = BUILD_PATH / "rand_soc"
        self._my_dir_path = pathlib.Path(__file__).parent.resolve()
        self.num_designs = num_designs

        self.outputs["design_tcl"] = []
        for i in range(self.num_designs):
            design_dir_path = self.build_path / f"design_{i}"
            self.outputs["design_tcl"].append(design_dir_path / "design.tcl")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

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
                        "seed": i,
                        "rand_soc_source_files": " ".join((str(s) for s in rand_soc_pkg_files)),
                    },
                )

            with open(NINJA_BUILD_PATH, "a") as f:
                f.write(build)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
