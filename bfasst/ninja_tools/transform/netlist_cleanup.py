""" Tool to clean up a netlist 
(tested primarily on post-fasm2bels netlists)
"""

from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_UTILS_PATH


class NetlistCleanupTool(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design):
        super().__init__(flow, design)

        self.build_path = self.design_build_path / "netlist_cleanup"
        self.netlist_out_path = self.build_path / (self.design_props.top + "_clean.v")
        self._init_outputs()

    def _init_outputs(self):
        self.outputs["netlist_cleaned_path"] = self.netlist_out_path

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_UTILS_PATH / "netlist_cleanup.py")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_in_path):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_cleanup_output": self.build_path,
                "netlist_in": netlist_in_path,
                "netlist_out": self.netlist_out_path,
            },
        )
