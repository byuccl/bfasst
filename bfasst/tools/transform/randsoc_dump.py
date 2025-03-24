"""Tool for dumping the bels of a placed and routed design with Isoblaze"""

from pathlib import Path
from bfasst.tools.tool import ToolBase
from bfasst.paths import BFASST_UTILS_PATH, NINJA_TRANSFORM_TOOLS_PATH


class RandsocDump(ToolBase):
    """Tool for dumping the bels of a placed and routed design with Isoblaze"""

    def __init__(self, flow, checkpoint, dumpfile):
        super().__init__(flow)

        self.build_path = self.flow.build_path / "randsoc_dump" / Path(dumpfile).stem
        self.checkpoint = checkpoint
        self.dumpfile = dumpfile
        self._init_outputs()
        self.rule_snippet_path = NINJA_TRANSFORM_TOOLS_PATH / "randsoc_dump_rules.ninja"

    def _init_outputs(self):
        self.outputs["dumpfile_output"] = self.build_path / self.dumpfile

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "randsoc_dump.py")
        deps.append(BFASST_UTILS_PATH / "collect_ip.tcl")

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            {
                "dumpfile": self.outputs["dumpfile_output"],
                "design_checkpoint": self.checkpoint,
                "randsoc_dump_util": BFASST_UTILS_PATH / "randsoc_dump.py",
                "dump_tcl": BFASST_UTILS_PATH / "dump.tcl",
                "dump_dcp_tcl": BFASST_UTILS_PATH / "dump-dcp.tcl",
            },
        )
