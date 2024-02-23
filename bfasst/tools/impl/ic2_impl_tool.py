"""Ic2 Implementation Tool (ninja snippet generation for ic2 implementation)"""

import pathlib
from bfasst.tools.impl.impl_tool import ImplTool


class Ic2Impl(ImplTool):
    """Ic2 Implementation Tool (ninja snippet generation for ic2 implementation)"""

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
