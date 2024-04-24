"""Create the rule and build snippets for yosys comparison."""

import json
from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, YOSYS_TOOLS_PATH
from bfasst.utils.general import json_write_if_changed


class YosysCompare(Tool):
    """Create the rule and build snippets for yosys comparison."""

    def __init__(self, flow, design, golden_netlist, rev_netlist):
        super().__init__(flow, design)

        self.golden_netlist = golden_netlist
        self.rev_netlist = rev_netlist

        self.build_path = self.design_build_path / "yosys"
        self.tcl_template = YOSYS_TOOLS_PATH / "yosys.tcl.mustache"
        self._init_outputs()
        self.rule_snippet_path = YOSYS_TOOLS_PATH / "yosys_rules.ninja.mustache"
        self.rules_render_dict = {"utils": str(BFASST_UTILS_PATH)}

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def __write_json_file(self):
        """Specify netlists for tcl template in json file.
        Chevron will use the file to create a yosys tcl script."""
        yosys_tcl_args = {
            "gold_netlist": str(self.golden_netlist),
            "rev_netlist": str(self.rev_netlist),
        }
        yosys_json = json.dumps(yosys_tcl_args, indent=4)

        json_write_if_changed(self.outputs["yosys_json"], yosys_json)

    def __append_build_snippets(self):
        """Create ninja snippets for yosys comparison."""
        self._append_build_snippets_default(
            __file__,
            {
                "tcl_script": str(self.outputs["yosys_tcl"]),
                "json": str(self.outputs["yosys_json"]),
                "tcl_template": str(self.tcl_template),
                "log": str(self.outputs["yosys_log"]),
                "gold_netlist": str(self.golden_netlist),
                "rev_netlist": str(self.rev_netlist),
            },
        )

    def _init_outputs(self):
        self.outputs["yosys_log"] = self.build_path / "log.txt"
        self.outputs["yosys_json"] = self.build_path / "yosys.json"
        self.outputs["yosys_tcl"] = self.build_path / "compare.ys"

    def add_ninja_deps(self, deps):
        """Add the yosys ninja deps for the configure rule."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self.tcl_template)
