"""Create the rule and build snippets for error injection into an xray netlist."""

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_BUILD_PATH, NINJA_TRANSFORM_TOOLS_PATH, NINJA_UTILS_PATH, ROOT_PATH
from bfasst.yaml_parser import YamlParser


class ErrorInjector(Tool):
    """Create the rule and build snippets for error injection into an xray netlist."""

    def __init__(self, design):
        super().__init__(design)
        self.build = ROOT_PATH / "build" / design / "error_injection"
        self.__create_build_dir()
        self.top = YamlParser(self.design / "design.yaml").parse_top_module()

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        with open(NINJA_TRANSFORM_TOOLS_PATH / "error_injector.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": NINJA_UTILS_PATH})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self, error_type, num, multiplier):
        injection_log_path = self.build / f"{error_type.name.lower()}_{num}.log"
        corrupt_netlist_path = self.build / f"{error_type.name.lower()}_{num}.v"

        with open(NINJA_TRANSFORM_TOOLS_PATH / "error_injector.ninja_build.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "build_dir": str(self.build.parent),
                    "error_type": error_type.name,
                    "log_path": str(injection_log_path),
                    "corrupt_netlist_path": str(corrupt_netlist_path),
                    "top": self.top,
                    "seed": num * multiplier,
                    "error_injector_script_path": str(NINJA_UTILS_PATH / "error_injector.py"),
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/error_injector.py ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/error_injector.ninja_rules.mustache ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/error_injector.ninja_build.mustache ")
        deps.append(f"{NINJA_UTILS_PATH}/error_injector.py ")
        return deps
