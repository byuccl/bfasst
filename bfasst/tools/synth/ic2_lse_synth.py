"""Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

import pathlib
import shutil
from bfasst.config import IC2_FOUNDRY, IC2_LD_LIBRARY_PATH, IC2_SBT_DIR, IC2_SYNTH_BIN
from bfasst.paths import BFASST_UTILS_PATH, LSE_PRJ_TEMPLATE
from bfasst.tools.synth.synth_tool import SynthTool


class Ic2LseSynth(SynthTool):
    """Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        # first, the prj file must be created
        self._create_prj_file()

        # then the build snippet can be created as normal
        self._append_build_snippets_default(
            __file__,
            # NOTE: prj_path, edif_file must be .name because LSE must run from the build_path
            # because it templates its report files using the top module name and drops
            # them in the current working directory
            {
                "ld_library_path": IC2_LD_LIBRARY_PATH,
                "foundry": IC2_FOUNDRY,
                "sbt_dir": IC2_SBT_DIR,
                "synth_bin_path": IC2_SYNTH_BIN,
                "prj_path": self.outputs["prj_file"].name,
                "design": self.design_path,
                "lse_post_synth_util": BFASST_UTILS_PATH / "lse_post_synth.py",
                "build_path": self.build_path,
                "edf_output": self.outputs["edif_file"].name,
            },
        )

    def _create_prj_file(self):
        # copy the template file over to the build_path
        shutil.copyfile(LSE_PRJ_TEMPLATE, self.outputs["prj_file"])

        # append the design sources to the prj file, specify top and output name
        with open(self.outputs["prj_file"], "a") as fp:
            fp.write("-p " + str(self.design_path) + "\n")
            for design_file in self.verilog:
                fp.write("-lib work -ver " + design_file + "\n")
            for design_file in self.vhdl:
                fp.write("-lib work -vhd " + design_file + "\n")
            fp.write("-top " + self.design_props.top + "\n")
            # NOTE: output_edif must be .name because LSE must run from the build_path
            # because it templates its report files using the top module name and drops
            # them in the current working directory
            fp.write("-output_edif " + str(self.outputs["edif_file"].name) + "\n")

    def _init_outputs(self):
        self.outputs["prj_file"] = self.build_path / "lse_project.prj"
        self.outputs["edif_file"] = self.build_path / "synth.edf"
        self.outputs["lsedata_file"] = self.build_path / "synth.lsedata"
        self.outputs["scf_file"] = self.build_path / "synth.scf"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
