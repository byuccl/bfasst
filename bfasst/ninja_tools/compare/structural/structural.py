"""Create the rule and build snippets for structural comparison."""

from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_UTILS_PATH


class Structural(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, flow, design, expect_fail=False):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "struct_cmp"
        self.expect_fail = expect_fail

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_a, netlist_b, log_name):
        self._init_outputs(log_name)
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "build": str(self.build_path.parent),
                "netlist_a": str(netlist_a),
                "netlist_b": str(netlist_b),
                "log_path": str(self.build_path / log_name),
                "compare_script_path": str(NINJA_UTILS_PATH / "structural.py"),
                "expect_fail": "--expect_fail" if self.expect_fail else "",
            },
        )

    def _init_outputs(self, log_name):
        if "structural_log" not in self.outputs:
            self.outputs["structural_log"] = []
        self.outputs["structural_log"].append(self.build_path / log_name)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_UTILS_PATH / "structural.py")
