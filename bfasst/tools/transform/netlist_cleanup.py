""" Tool to clean up a netlist 
(tested primarily on post-fasm2bels netlists)
"""

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH


class NetlistCleanup(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design, prev_tool_outputs):
        super().__init__(flow, design)

        # A dictionary of the previous tool outputs
        # In this case, the dictionary will contain a rev_netlist key
        self.prev_tool_outputs = prev_tool_outputs

        self.build_path = self.design_build_path / "netlist_cleanup"
        self._init_outputs()

    def _init_outputs(self):
        self.outputs["netlist_cleaned_path"] = self.build_path / (
            self.design_props.top + "_clean.v"
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "netlist_cleanup.py")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_cleanup_output": self.build_path,
                "netlist_in": self.prev_tool_outputs["rev_netlist"],
                "netlist_out": self.outputs["netlist_cleaned_path"],
            },
        )
