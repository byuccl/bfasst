"""Create the rule and build snippets for conformal comparison."""

import chevron
from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_BUILD_PATH, CONFORMAL_TOOLS_PATH, BFASST_UTILS_PATH


class Conformal(Tool):
    """Create the rule and build snippets for conformal comparison."""

    def __init__(self, flow, design, golden_netlist, rev_netlist, vendor):
        super().__init__(flow, design)

        self.golden_netlist = golden_netlist
        self.rev_netlist = rev_netlist
        self.vendor = vendor

        self.build_path = self.design_build_path / "conformal"
        self._init_outputs()
        # self._read_hdl_files()
        self.rule_snippet_path = CONFORMAL_TOOLS_PATH / "conformal_rules.ninja.mustache"
        self.rules_render_dict = {"utils": str(BFASST_UTILS_PATH)}

    def create_build_snippets(self):
        """Create the build snippets for conformal comparison."""
        with open(CONFORMAL_TOOLS_PATH / "conformal_build.ninja.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "log_path": str(self.outputs["conformal_log"]),
                    "do_path": str(self.outputs["conformal_do"]),
                    "gui_path": str(self.outputs["conformal_gui"]),
                    "hdl_srcs": self.golden_netlist,
                    "rev_netlist": self.rev_netlist,
                    "conformal_script_path": str(BFASST_UTILS_PATH / "conformal.py"),
                    "build_dir": self.build_path.parent,
                    "vendor": self.vendor,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self):
        self.outputs["conformal_log"] = self.build_path / "log.txt"
        self.outputs["conformal_gui"] = self.build_path / "run_conformal_gui.sh"
        self.outputs["conformal_do"] = self.build_path / "compare.do"

    def add_ninja_deps(self, deps):
        """Add the conformal ninja deps."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(CONFORMAL_TOOLS_PATH / "conformal.do.mustache")
        deps.append(CONFORMAL_TOOLS_PATH / "conformal.gui.mustache")
        deps.append(BFASST_UTILS_PATH / "conformal.py")
