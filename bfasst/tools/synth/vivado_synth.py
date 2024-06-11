"""Tool to create Vivado synthesis ninja snippets."""

import json
import pathlib
from bfasst import config
from bfasst.tools.synth.synth_tool import SynthTool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH
from bfasst.utils.general import json_write_if_changed


class VivadoSynth(SynthTool):
    """Tool to create vivado synthesis ninja snippets."""

    def __init__(self, flow, design_path, synth_options="", ooc=False):
        super().__init__(flow, design_path, ooc=ooc)
        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = (
            self.build_path.with_name("vivado_ooc_synth")
            if ooc
            else self.build_path.with_name("vivado_synth")
        )

        self.deps = []  # add member for flows to add their own deps to (see opentitan)

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()
        self.outputs_str = {k: str(v) for k, v in self.outputs.items()}
        self.top = self.design_props.top if self.design_props is not None else None
        self.synth_build = {
            "part": self.flow.part,
            "top": self.top,
            "vhdl": self.vhdl,
            "vhdl_libs": list(self.vhdl_file_lib_map.items()),
            "verilog": self.verilog,
            "system_verilog": self.system_verilog,
            "io": str(self.build_path / "report_io.txt") if not self.ooc else False,
            "synth_output": str(self.build_path),
            "synth_design": "",
            "common_tools_path": str(COMMON_TOOLS_PATH),
            "outputs": self.outputs_str,
            "tcl_sources": [
                self.outputs_str["setup_tcl"],
                self.outputs_str["synth_tcl"],
                self.outputs_str["reports_tcl"],
            ],
        }
        if synth_options:
            self.synth_build.update(synth_options)
        if ooc:
            synth_opts = self.synth_build.get("synth_design", "") + " -mode out_of_context"
            self.synth_build["synth_design"] = synth_opts

        self.rule_snippet_path = COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache"
        self.rules_render_dict = {
            "vivado_path": config.VIVADO_BIN_PATH,
            "in_context": not self.ooc,
            "utils_path": BFASST_UTILS_PATH,
        }

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        # Specify synthesis arguments in a json file.
        # Chevron will use this file to fill in the tcl template.

        synth_json = json.dumps(self.synth_build, indent=4)

        json_write_if_changed(self.outputs["synth_json"], synth_json)

        self._append_build_snippets_default(
            __file__,
            {
                "in_context": not self.ooc,
                "synth_output": str(self.build_path),
                "synth_library": self._my_dir_path,
                "top": self.top,
                "verilog": self.verilog,
                "system_verilog": self.system_verilog,
                "cwd": self.build_path,
                "outputs": self.outputs_str,
                "common_tools_path": str(COMMON_TOOLS_PATH),
                "tcl_sources": [str(i) for i in self.synth_build["tcl_sources"]],
            },
        )

    def _init_outputs(self):
        self.outputs["run_tcl"] = self.build_path / "run.tcl"
        self.outputs["setup_tcl"] = self.build_path / "setup.tcl"
        self.outputs["synth_tcl"] = self.build_path / "synth.tcl"
        self.outputs["reports_tcl"] = self.build_path / "reports.tcl"
        self.outputs["synth_json"] = self.build_path / "synth.json"
        self.outputs["synth_edf"] = self.build_path / "viv_synth.edf"
        self.outputs["synth_dcp"] = self.build_path / "synth.dcp"
        self.outputs["journal"] = self.build_path / "vivado.jou"
        self.outputs["log"] = self.build_path / "vivado.log"

        if not self.ooc:
            self.outputs["io_report"] = self.build_path / "report_io.txt"
            self.outputs["synth_constraints"] = self.build_path / "design.xdc"
        else:
            self.outputs["io_report"] = None
            self.outputs["synth_constraints"] = None

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        self._add_ninja_deps_default(deps, __file__)
        for dep in self._my_dir_path.glob("*.mustache"):
            if "vivado" in dep.name:
                deps.append(dep)

        for dep in self.deps:
            deps.append(dep)
