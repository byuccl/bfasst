"""Create the rule and build snippets for structural comparison."""

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH


class Structural(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(
        self,
        flow,
        design,
        log_name=None,
        golden_netlist=None,
        rev_netlist=None,
        expect_fail=False,
        debug=False,
        logging_level=None,
    ):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "struct_cmp"
        self.log_name = log_name
        self.golden_netlist = golden_netlist
        self.rev_netlist = rev_netlist
        self.expect_fail = expect_fail
        self.debug = debug
        self.logging_level = logging_level
        self._init_outputs()
        self.rule_snippet_path = COMPARE_TOOLS_PATH / "structural" / "structural_rules.ninja"

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_a": str(self.golden_netlist),
                "netlist_b": str(self.rev_netlist),
                "log_path": str(self.outputs["structural_log"]),
                "compare_script_path": str(BFASST_UTILS_PATH / "structural.py"),
                "expect_fail": "--expect_fail" if self.expect_fail else "",
                "debug": "--debug True" if self.debug else "",
                "logging_level": f"--logging_level {self.logging_level}",
            },
        )

    def _init_outputs(self):
        self.outputs["structural_log"] = self.build_path / self.log_name if self.log_name else None

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "structural.py")
