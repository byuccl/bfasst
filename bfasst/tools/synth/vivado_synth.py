"""Tool to create Vivado synthesis ninja snippets."""

import json
import pathlib
from bfasst import config
from bfasst.tools.synth.synth_tool import SynthTool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH
from bfasst.utils.general import json_write_if_changed


class VivadoSynth(SynthTool):
    """Tool to create vivado synthesis ninja snippets."""

    def __init__(self, flow, design_path, ooc=False, synth_options=""):
        super().__init__(flow, design_path, ooc=ooc)
        self.synth_options = synth_options
        if ooc:
            self.synth_options += " -mode out_of_context"
        self._my_dir_path = pathlib.Path(__file__).parent

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(
            __file__,
            {
                "vivado_path": config.VIVADO_BIN_PATH,
                "in_context": not self.ooc,
                "utils_path": BFASST_UTILS_PATH,
            },
            COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache",
        )

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        # Specify synthesis arguments in a json file.
        # Chevron will use this file to fill in the tcl template.
        synth = {
            "part": config.PART,
            "top": self.design_props.top,
            "vhdl": self.vhdl,
            "vhdl_libs": list(self.vhdl_file_lib_map.items()),
            "verilog": self.verilog,
            "system_verilog": self.system_verilog,
            "io": str(self.build_path / "report_io.txt") if not self.ooc else False,
            "synth_output": str(self.build_path),
            "synth_args": self.synth_options,
        }
        synth_json = json.dumps(synth, indent=4)

        json_write_if_changed(self.build_path / "synth.json", synth_json)

        self._append_build_snippets_default(
            __file__,
            {
                "in_context": not self.ooc,
                "synth_output": str(self.build_path),
                "synth_library": self._my_dir_path,
                "top": self.design_props.top,
                "verilog": self.verilog,
                "system_verilog": self.system_verilog,
                "cwd": self.build_path,
            },
        )

    def _init_outputs(self):
        self.outputs["synth_tcl"] = self.build_path / "synth.tcl"
        self.outputs["synth_json"] = self.build_path / "synth.json"
        self.outputs["synth_edf"] = self.build_path / "viv_synth.edf"
        self.outputs["synth_dcp"] = self.build_path / "synth.dcp"
        self.outputs["synth_journal"] = self.build_path / "vivado.jou"
        self.outputs["synth_log"] = self.build_path / "vivado.log"

        if not self.ooc:
            self.outputs["io_report"] = self.build_path / "report_io.txt"
            self.outputs["synth_constraints"] = self.build_path / "design.xdc"

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self._my_dir_path / "vivado_synth.tcl.mustache")
