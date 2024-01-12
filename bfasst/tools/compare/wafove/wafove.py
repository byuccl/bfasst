"""Create rule and build snippets for wafove comparison."""

from bfasst.tools.tool import Tool


class Wafove(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, flow, design):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "wafove"

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_a, netlist_b, log_name, warning_log_name):
        self._init_outputs(log_name, warning_log_name)
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "top": self.design_props.top,
                "base_path": str(self.build_path),
                "netlist_a": str(netlist_a),
                "netlist_b": str(netlist_b),
                "log_path": str(self.build_path / log_name),
                "warnings": str(self.build_path / warning_log_name),
            },
        )

    def _init_outputs(self, log_name, warning_log_name):
        if "wafove_log" not in self.outputs:
            self.outputs["wafove_log"] = []
        self.outputs["wafove_log"].append(self.build_path / log_name)

        if "wafove_warnings_log" not in self.outputs:
            self.outputs["wafove_warnings_log"] = []
        self.outputs["wafove_warnings_log"].append(self.build_path / warning_log_name)

    def add_ninja_deps(self, deps):
        super()._add_ninja_deps_default(deps, __file__)
