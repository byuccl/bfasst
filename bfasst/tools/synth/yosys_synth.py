"""Tool to create Yosys synthesis ninja snippets."""

import json
import pathlib

from bfasst.paths import YOSYS_EXE_PATH, YOSYS_SYNTH_SCRIPT_TEMPLATE, TOOLS_PATH
from bfasst.tools.synth.synth_tool import SynthTool
from bfasst.utils.general import json_write_if_changed


class YosysSynth(SynthTool):
    """Tool to create Yosys synthesis ninja snippets."""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = self.build_path.with_name("yosys_synth")

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()
        self.rule_snippet_path = TOOLS_PATH / "synth" / "yosys_synth_rules.ninja"

    def create_build_snippets(self):
        # first, the yosys script must be created with ninja and chevron.
        # Arguments are passed to the template in a json file
        synth = {
            "verilog": self.verilog,
            "vhdl": self.vhdl,
            "netlist": str(self.outputs["netlist"]),
        }
        synth_json = json.dumps(synth, indent=4)
        json_write_if_changed(self.outputs["synth_json"], synth_json)

        # then the build snippet can be created as normal
        self._append_build_snippets_default(
            __file__,
            {
                "yosys_script_file": self.outputs["yosys_script"],
                "json_render_dict": self.outputs["synth_json"],
                "script_template": YOSYS_SYNTH_SCRIPT_TEMPLATE,
                "yosys_synth_outputs": [self.outputs["netlist"], self.outputs["log"]],
                "yosys_exe_path": YOSYS_EXE_PATH,
                "log": self.outputs["log"],
                "design": self.design_path,
            },
        )

    def _init_outputs(self):
        self.outputs["netlist"] = self.build_path / "yosys_netlist.v"
        self.outputs["yosys_script"] = self.build_path / "synth.yos"
        self.outputs["synth_json"] = self.build_path / "yosys_synth.json"
        self.outputs["log"] = self.build_path / "yosys_synth.log"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(YOSYS_SYNTH_SCRIPT_TEMPLATE)
