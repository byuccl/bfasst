"""Create rule and build snippets for wafove comparison."""

from bfasst.tools.tool import Tool


class Wafove(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, flow, design):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "wafove"

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_a, netlist_b, log_name, std_err_log):
        self._init_outputs(log_name, std_err_log)
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "top": self.design_props.top,
                "base_path": str(self.build_path),
                "netlist_a": str(netlist_a),
                "netlist_b": str(netlist_b),
                "log_path": str(self.outputs["wafove_log"]),
                "std_err_log": str(self.outputs["std_err_log"]),
                "reversed_tb": str(self.outputs["reversed_tb"]),
                "reversed_vcd": str(self.outputs["reversed_vcd"]),
                "impl_tb": str(self.outputs["impl_tb"]),
                "impl_vcd": str(self.outputs["impl_vcd"]),
            },
        )

    def _init_outputs(self, log_name, std_err_log):
        self.outputs["wafove_log"] = self.build_path / log_name
        self.outputs["std_err_log"] = self.build_path / std_err_log
        self.outputs["reversed_tb"] = self.build_path / f"{self.design_props.top}_reversed_tb.v"
        self.outputs["reversed_vcd"] = self.build_path / f"{self.design_props.top}_reversed.vcd"
        self.outputs["impl_tb"] = self.build_path / "viv_impl_tb.v"
        self.outputs["impl_vcd"] = self.build_path / "viv_impl.vcd"

    def add_ninja_deps(self, deps):
        super()._add_ninja_deps_default(deps, __file__)
