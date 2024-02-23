"""Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

import pathlib
from bfasst.tools.synth.synth_tool import SynthTool


class Ic2LseSynth(SynthTool):
    """Ic2 LSE Synthesis Tool (ninja snippet generation for ic2 lse synthesis)"""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def create_rule_snippets(self):
        pass

    def create_build_snippets(self):
        pass

    def _init_outputs(self):
        pass

    def add_ninja_deps(self, deps):
        pass
