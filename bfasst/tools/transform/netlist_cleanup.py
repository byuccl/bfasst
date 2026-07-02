"""Tool to clean up a netlist
(tested primarily on post-fasm2bels netlists)
"""

from bfasst.paths import BFASST_UTILS, NINJA_TRANSFORM_TOOLS
from bfasst.tools.tool import Tool


class NetlistCleanup(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design, rev_netlist, logging_level):
        super().__init__(flow, design)

        self.rev_netlist = rev_netlist
        self.logging_level = logging_level

        self.build_path = self.design_build_path / "netlist_cleanup"
        self._init_outputs()
        self.rule_snippet_path = NINJA_TRANSFORM_TOOLS / "netlist_cleanup_rules.ninja.mustache"

    def _init_outputs(self):
        self.outputs["netlist_cleaned_path"] = self.build_path / (
            self.design_props.top + "_clean.v"
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS / "netlist_cleanup.py")

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_cleanup_output": self.build_path,
                "netlist_in": self.rev_netlist,
                "netlist_out": self.outputs["netlist_cleaned_path"],
                "logging_level": f"--logging_level {self.logging_level}",
            },
        )
