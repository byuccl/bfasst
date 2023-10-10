"""Create the rule and build snippets for structural comparison."""

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_BUILD_PATH, NINJA_STRUCTURAL_TOOLS_PATH, NINJA_UTILS_PATH


class Structural(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, design):
        super().__init__(design)
        self.build = self.design_build_path / "struct_cmp"
        self.__create_build_dir()
        self.log_name = None

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        with open(NINJA_STRUCTURAL_TOOLS_PATH / "structural.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": str(NINJA_UTILS_PATH)})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self, netlist_a, netlist_b, log_name):
        self._init_outputs(log_name)
        with open(NINJA_STRUCTURAL_TOOLS_PATH / "structural.ninja_build.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "build": str(self.build.parent),
                    "netlist_a": str(netlist_a),
                    "netlist_b": str(netlist_b),
                    "log_path": str(self.build / log_name),
                    "compare_script_path": str(NINJA_UTILS_PATH / "structural.py"),
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self, log_name):
        if "structural_log" not in self.outputs:
            self.outputs["structural_log"] = []
        self.outputs["structural_log"].append(self.build / log_name)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.append(f"{NINJA_STRUCTURAL_TOOLS_PATH}/structural.py")
        deps.append(f"{NINJA_STRUCTURAL_TOOLS_PATH}/structural.ninja_rules.mustache")
        deps.append(f"{NINJA_STRUCTURAL_TOOLS_PATH}/structural.ninja_build.mustache")
        deps.append(f"{NINJA_UTILS_PATH}/structural.py")
        return deps
