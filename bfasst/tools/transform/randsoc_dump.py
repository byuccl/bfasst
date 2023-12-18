"""Tool for dumping the bels of a placed and routed design with Isoblaze"""
from bfasst.tools.tool import ToolBase
from bfasst.paths import BFASST_UTILS_PATH, BUILD_PATH


class RandsocDump(ToolBase):
    """Tool for dumping the bels of a placed and routed design with Isoblaze"""

    def __init__(self, flow, checkpoint, dumpfile, labelfile):
        super().__init__(flow)

        self.build_path = BUILD_PATH / "randsoc_dump"
        self.checkpoint = checkpoint
        self.dumpfile = dumpfile
        self.labelfile = labelfile
        self._init_outputs()

    def _init_outputs(self):
        self.outputs["dumpfile_output"] = self.build_path / self.dumpfile
        self.outputs["labelfile_output"] = self.build_path / self.labelfile

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "randsoc_dump.py")
        deps.append(BFASST_UTILS_PATH / "collect_ip.tcl")

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            {
                "dumpfile": self.outputs["dumpfile_output"],
                "labelfile": self.outputs["labelfile_output"],
                "design_checkpoint": self.checkpoint,
                "randsoc_dump_util": BFASST_UTILS_PATH / "randsoc_dump.py",
                "collect_ip_util": BFASST_UTILS_PATH / "collect_ip.tcl",
            },
        )
