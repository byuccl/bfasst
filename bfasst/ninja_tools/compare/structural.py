"""Create the rule and build snippets for structural comparison."""

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_BUILD_PATH, NINJA_COMPARE_TOOLS_PATH, NINJA_UTILS_PATH, ROOT_PATH
from bfasst.yaml_parser import YamlParser


class Structural(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, design, invert=False):
        super().__init__(design)
        self.build = ROOT_PATH / "build" / design / "struct_cmp"
        self.__create_build_dir()
        self.invert = invert
        self.top = YamlParser(self.design / "design.yaml").parse_top_module()

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": str(NINJA_UTILS_PATH), "invert": self.invert})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self, netlist_a, netlist_b, log_name):
        with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_build.mustache", "r") as f:
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

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.py ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_rules.mustache ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_build.mustache ")
        deps.append(f"{NINJA_UTILS_PATH}/structural.py ")
        return deps
