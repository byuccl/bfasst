"""Tool to create Vivado synthesis ninja snippets."""
import pathlib
from bfasst import config
from bfasst.tools.tool import Tool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH


class VivadoSynthFromTcl(Tool):
    """Tool to create vivado synthesis ninja snippets."""

    def __init__(self, flow, design_tcl_path):
        super().__init__(flow, design_tcl_path.parent)
        self.design_tcl_path = design_tcl_path
        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = self.design_build_path / "synth"

    def create_rule_snippets(self):
        self._append_rule_snippets_default(
            __file__,
            {
                "vivado_path": config.VIVADO_BIN_PATH,
                "utils_path": BFASST_UTILS_PATH,
                "in_context": True,
            },
            COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache",
        )

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        self._append_build_snippets_default(
            __file__,
            {
                "synth_output": self.build_path,
                "design_tcl": self.design_tcl_path,
                "cwd": self.build_path,
                "utils_path": BFASST_UTILS_PATH,
            },
        )

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self._my_dir_path / "vivado_synth.tcl.mustache")
