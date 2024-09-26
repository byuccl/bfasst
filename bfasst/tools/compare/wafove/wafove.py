"""Create rule and build snippets for wafove comparison."""

from bfasst.tools.tool import Tool
from bfasst.paths import COMPARE_TOOLS_PATH


class Wafove(Tool):
    """Create the rule and build snippets for structural comparison."""

    def __init__(
        self,
        flow,
        design,
        golden_netlist,
        rev_netlist,
        *,
        std_out_log_name="wafove.log",
        std_err_log_name="wafove_err.log",
    ):
        super().__init__(flow, design)

        self.std_out_log_name = std_out_log_name
        self.std_err_log_name = std_err_log_name
        self.golden_netlist = golden_netlist
        self.rev_netlist = rev_netlist

        self.build_path = self.design_build_path / "wafove"
        self._init_outputs(self.std_out_log_name, self.std_err_log_name)
        self.rule_snippet_path = COMPARE_TOOLS_PATH / "wafove" / "wafove_rules.ninja.mustache"

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "top": self.design_props.top,
                "base_path": str(self.build_path),
                "netlist_a": str(self.golden_netlist),
                "netlist_b": str(self.rev_netlist),
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
