"""Create the rule and build snippets for error injection into an xray netlist."""

import pathlib
import chevron

from bfasst.ninja_tools.tool import ToolBase
from bfasst.paths import BUILD_PATH, NINJA_BUILD_PATH, NINJA_UTILS_PATH


class RandSoCTool(ToolBase):
    """Tool to create a random SoC"""

    def __init__(self, flow, num_designs):
        super().__init__(flow)
        self.build_path = BUILD_PATH / "rand_soc"
        self._my_dir_path = pathlib.Path(__file__).parent.resolve()
        self.num_designs = num_designs

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        for i in range(self.num_designs):
            design_dir_path = self.build_path / f"design_{i}"
            # design_dir_path.mkdir(parents=True, exist_ok=True)

            # TODO: Outputs
            # self._init_outputs(self.injection_log, self.corrupt_netlist)

            with open(self._my_dir_path / "rand_soc_build.ninja.mustache", "r") as f:
                build = chevron.render(
                    f,
                    {
                        "design_dir_path": design_dir_path,
                        "seed": i,
                    },
                )

            with open(NINJA_BUILD_PATH, "a") as f:
                f.write(build)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_UTILS_PATH / "error_injector.py")
