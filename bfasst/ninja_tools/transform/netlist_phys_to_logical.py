""" Tool to convert a physical netlist to a logical netlist
"""

from bfasst.ninja_tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, GMT_TOOLS_PATH


class NetlistPhysToLogicalTool(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design):
        super().__init__(flow, design)

        self.build_path = self.design_build_path / "netlist_phys_to_logical"
        self.netlist_out_path = self.build_path / (self.design_props.top + "_logical.v")

    def _init_outputs(self):
        self.outputs["netlist_phys_to_logical_path"] = self.netlist_out_path

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(GMT_TOOLS_PATH / "netlist_phys_to_logical.py")
        deps.append(BFASST_UTILS_PATH / "sdn_helpers.py")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_in_path):
        self._append_build_snippets_default(
            __file__,
            render_dict={
                "netlist_phys_to_logical_output": self.build_path,
                "netlist_in": netlist_in_path,
                "netlist_out": self.netlist_out_path,
            },
        )
