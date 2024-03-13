"""Create rule and build snippets for wafove comparison."""

from bfasst.tools.tool import Tool


class Wafove(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(self, flow, design, prev_tool_outputs):
        super().__init__(flow, design)

        # A dictionary of the previous tool outputs
        # In this case, the dictionary will contain keys for
        # 1. An implementation_tool golden_netlist
        # 2. A reverse_bit_tool rev_netlist
        # 3. A log_name
        # 4. A std_err_log
        self.prev_tool_outputs = prev_tool_outputs

        self.build_path = self.design_build_path / "wafove"
        self._init_outputs(
            self.prev_tool_outputs["log_name"], self.prev_tool_outputs["std_err_log"]
        )

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "top": self.design_props.top,
                "base_path": str(self.build_path),
                "netlist_a": str(self.prev_tool_outputs["impl_tool"]["golden_netlist"]),
                "netlist_b": str(self.prev_tool_outputs["rev_bit_tool"]["rev_netlist"]),
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
