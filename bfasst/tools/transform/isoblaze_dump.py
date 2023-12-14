"""Tool for dumping the bels of a placed and routed design with Isoblaze"""
from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH


class IsoblazeDump(Tool):
    """Tool for dumping the bels of a placed and routed design with Isoblaze"""

    def __init__(self, flow):
        super().__init__(flow, None)

        self.build_path = self.flow.build_path / "isoblaze_dump"
        self._init_outputs()

    def _init_outputs(self):
        self.outputs["isoblaze_dump_output"] = self.build_path / "isoblaze_dump"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "isoblaze_dump.py")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_path):
        # for each design
