"""Create the rule and build snippets for conformal comparison."""

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import BUILD_DIR, NINJA_BUILD_PATH, NINJA_COMPARE_TOOLS_PATH, NINJA_UTILS_PATH


class Conformal(Tool):
    """Create the rule and build snippets for conformal comparison."""

    def __init__(self, design):
        super().__init__(design)
        self.build = BUILD_DIR / design / "conformal"
        self.__create_build_dir()
        self._init_outputs()
        self._read_hdl_files()

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        """Create the rule snippets for conformal comparison."""
        with open(NINJA_COMPARE_TOOLS_PATH / "conformal.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": str(NINJA_UTILS_PATH)})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self, impl_netlist, rev_netlist, vendor):
        """Create the build snippets for conformal comparison."""
        with open(NINJA_COMPARE_TOOLS_PATH / "conformal.ninja_build.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "log_path": str(self.build / "log.txt"),
                    "do_path": str(self.build / "compare.do"),
                    "gui_path": str(self.build / "run_conformal_gui.sh"),
                    "hdl_srcs": impl_netlist,
                    "rev_netlist": rev_netlist,
                    "conformal_script_path": str(NINJA_UTILS_PATH / "conformal.py"),
                    "build_dir": self.build.parent,
                    "vendor": vendor.name,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self):
        self.outputs["conformal_log"] = self.build / "log.txt"
        self.outputs["conformal_gui"] = self.build / "run_conformal_gui.sh"
        self.outputs["conformal_do"] = self.build / "compare.do"

    def add_ninja_deps(self, deps=None):
        """Add the conformal ninja deps."""
        if not deps:
            deps = []
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/conformal.py")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/conformal.ninja_rules.mustache")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/conformal.ninja_build.mustache")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/conformal.do.mustache")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/conformal.gui.mustache")
        deps.append(f"{NINJA_UTILS_PATH}/conformal.py ")

        return deps
