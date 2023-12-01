"""Create the rule and build snippets for yosys comparison."""

import json
from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_UTILS_PATH, YOSYS_TOOLS_PATH
from bfasst.utils.general import json_write_if_changed


class Yosys(Tool):
    """Create the rule and build snippets for yosys comparison."""

    def __init__(self, flow, design):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "yosys"
        self.log = self.build_path / "log.txt"
        self.json = self.build_path / "yosys.json"
        self.tcl = self.build_path / "compare.ys"
        self.tcl_template = YOSYS_TOOLS_PATH / "yosys.tcl.mustache"
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__, {"utils": str(NINJA_UTILS_PATH)})

    def create_build_snippets(self, gold_netlist, rev_netlist):
        self.__write_json_file(gold_netlist, rev_netlist)
        self.__append_build_snippets(gold_netlist, rev_netlist)

    def __write_json_file(self, gold_netlist, rev_netlist):
        """Specify netlists for tcl template in json file.
        Chevron will use the file to create a yosys tcl script."""
        yosys_tcl_args = {
            "gold_netlist": str(gold_netlist),
            "rev_netlist": str(rev_netlist),
        }
        yosys_json = json.dumps(yosys_tcl_args, indent=4)

        json_write_if_changed(self.json, yosys_json)

    def __append_build_snippets(self, gold_netlist, rev_netlist):
        """Create ninja snippets for yosys comparison."""
        self._append_build_snippets_default(
            __file__,
            {
                "tcl_script": str(self.tcl),
                "json": str(self.json),
                "tcl_template": str(self.tcl_template),
                "log": str(self.log),
                "gold_netlist": str(gold_netlist),
                "rev_netlist": str(rev_netlist),
            },
        )

    def _init_outputs(self):
        self.outputs["yosys_log"] = self.log
        self.outputs["yosys_json"] = self.json
        self.outputs["yosys_tcl"] = self.tcl

    def add_ninja_deps(self, deps):
        """Add the yosys ninja deps for the configure rule."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self.tcl_template)
