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
        self.build_path = self.design_build_path / "vivado_synth"
        self._init_outputs()
        self.rule_snippet_path = COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache"
        self.render_dict = {
            "vivado_path": config.VIVADO_BIN_PATH,
            "utils_path": BFASST_UTILS_PATH,
            "in_context": True,
        }

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        self._append_build_snippets_default(
            __file__,
            {
                "synth_constraints": self.outputs["synth_constraints"],
                "synth_edf": self.outputs["synth_edf"],
                "synth_dcp": self.outputs["synth_dcp"],
                "io_report": self.outputs["io_report"],
                "synth_log": self.outputs["synth_log"],
                "synth_journal": self.outputs["synth_journal"],
                "design_tcl": self.design_tcl_path,
                "cwd": self.build_path,
            },
        )

    def _init_outputs(self):
        self.outputs["synth_constraints"] = self.build_path / "design.xdc"
        self.outputs["synth_edf"] = self.build_path / "viv_synth.edf"
        self.outputs["synth_dcp"] = self.build_path / "synth.dcp"
        self.outputs["io_report"] = self.build_path / "report_io.txt"
        self.outputs["synth_journal"] = self.build_path / "vivado.jou"
        self.outputs["synth_log"] = self.build_path / "vivado.log"

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self._my_dir_path / "vivado_synth.tcl.mustache")
