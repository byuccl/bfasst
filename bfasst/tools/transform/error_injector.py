"""Create the rule and build snippets for error injection into an xray netlist."""

import chevron

from bfasst.paths import BFASST_UTILS_PATH, NINJA_BUILD_PATH, NINJA_TRANSFORM_TOOLS_PATH
from bfasst.tools.tool import Tool


class ErrorInjector(Tool):
    """Create the rule and build snippets for error injection into an xray netlist."""

    def __init__(
        self,
        flow,
        design,
        *,
        logging_level="INFO",
        error_type=None,
        num=None,
        multiplier=None,
        reversed_netlist=None,
    ):
        super().__init__(flow, design)
        self.error_type = error_type
        self.num = num
        self.multiplier = multiplier
        self.reversed_netlist = reversed_netlist
        self.logging_level = logging_level
        self.build_path = self.design_build_path / "error_injection"
        if error_type is not None and num is not None:
            self.injection_log = self.build_path / f"{self.error_type.name.lower()}_{self.num}.log"
            self.corrupt_netlist = self.build_path / f"{self.error_type.name.lower()}_{self.num}.v"
        else:
            self.injection_log = None
            self.corrupt_netlist = None
        self._init_outputs(self.injection_log, self.corrupt_netlist)
        self.rule_snippet_path = NINJA_TRANSFORM_TOOLS_PATH / "error_injector_rules.ninja.mustache"

    def create_build_snippets(self):
        with open(NINJA_TRANSFORM_TOOLS_PATH / "error_injector_build.ninja.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "build_dir": str(self.build_path.parent),
                    "error_type": self.error_type.name,
                    "log_path": str(self.injection_log),
                    "corrupt_netlist_path": str(self.corrupt_netlist),
                    "top": self.design_props.top,
                    "seed": self.num * self.multiplier,
                    "error_injector_script_path": str(
                        BFASST_UTILS_PATH / "transform" / "error_injector.py"
                    ),
                    "reversed_netlist": self.reversed_netlist,
                    "logging_level": f"--logging_level {self.logging_level}",
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self, injection_log, corrupt_netlist):
        self.outputs["injection_log"] = injection_log
        self.outputs["corrupt_netlist"] = corrupt_netlist

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "transform" / "error_injector.py")
