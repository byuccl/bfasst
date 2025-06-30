"""Tool to convert a physical netlist to a logical netlist"""

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, GMT_TOOLS_PATH, NINJA_TRANSFORM_TOOLS_PATH


class NetlistPhysToLogical(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design, cleaned_netlist):
        super().__init__(flow, design)

        self.cleaned_netlist = cleaned_netlist

        self.build_path = self.design_build_path / "netlist_phys_to_logical"
        self._init_outputs()
        self.rule_snippet_path = (
            NINJA_TRANSFORM_TOOLS_PATH / "netlist_phys_to_logical_rules.ninja.mustache"
        )

    def _init_outputs(self):
        self.outputs["netlist_phys_to_logical_path"] = self.build_path / (
            self.design_props.top + "_logical.v"
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "netlist_phys_to_logical.py")
        deps.append(BFASST_UTILS_PATH / "sdn_helpers.py")

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_phys_to_logical_output": self.build_path,
                "netlist_in": self.cleaned_netlist,
                "netlist_out": self.outputs["netlist_phys_to_logical_path"],
            },
        )
