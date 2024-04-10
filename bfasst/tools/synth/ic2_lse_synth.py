"""Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

import json
import pathlib
from bfasst.config import (
    IC2_FOUNDRY,
    IC2_LSE_LD_LIBRARY_PATH,
    IC2_SBT_DIR,
    IC2_LSE_SYNTH_BIN,
)
from bfasst.paths import BFASST_UTILS_PATH, LSE_PRJ_TEMPLATE, TOOLS_PATH
from bfasst.tools.synth.synth_tool import SynthTool
from bfasst.utils.general import json_write_if_changed


class Ic2LseSynth(SynthTool):
    """Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent
        self.build_path = self.build_path.with_name("ic2_lse_synth")

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()
        self.rule_snippet_path = TOOLS_PATH / "synth" / "ic2_lse_synth_rules.ninja"

    def create_build_snippets(self):
        # first, the project file must be created with ninja and chevron.
        # Arguments are passed to the template in a json file
        synth = {
            "design_path": str(self.design_path),
            "verilog": self.verilog,
            "vhdl": self.vhdl,
            "top": self.design_props.top,
            "edf_output": str(self.outputs["edif_file"]),
        }
        synth_json = json.dumps(synth, indent=4)
        json_write_if_changed(self.outputs["synth_json"], synth_json)

        # then the build snippet can be created as normal
        self._append_build_snippets_default(
            __file__,
            {
                "ld_library_path": IC2_LSE_LD_LIBRARY_PATH,
                "foundry": IC2_FOUNDRY,
                "sbt_dir": IC2_SBT_DIR,
                "synth_bin_path": IC2_LSE_SYNTH_BIN,
                "prj_path": self.outputs["prj_file"],
                "json_render_dict": self.outputs["synth_json"],
                "prj_template": LSE_PRJ_TEMPLATE,
                "design": self.design_path,
                "lse_post_synth_util": BFASST_UTILS_PATH / "lse_post_synth.py",
                "build_path": self.build_path,
                "edf_output": self.outputs["edif_file"],
                "outputs": [
                    v
                    for _, v in self.outputs.items()
                    if (v not in [self.outputs["prj_file"], self.outputs["synth_json"]])
                ],  # all outputs not related to prj file are built by lse synth tool with ninja
            },
        )

    def _init_outputs(self):
        self.outputs["prj_file"] = self.build_path / "lse_project.prj"
        self.outputs["edif_file"] = self.build_path / "synth.edf"
        self.outputs["lsedata_file"] = self.build_path / "synth.lsedata"
        self.outputs["scf_file"] = self.build_path / "synth.scf"
        self.outputs["golden_netlist"] = self.build_path / (self.design_props.top + "_prim.v")
        self.outputs["synth_json"] = self.build_path / "synth.json"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(LSE_PRJ_TEMPLATE)
