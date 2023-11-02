"""Tool to create Vivado synthesis ninja snippets."""
import json
from pathlib import Path
import chevron
from bfasst import config
from bfasst.ninja_tools.tool import Tool
from bfasst.utils import compare_json
from bfasst.yaml_parser import YamlParser


class VivadoSynth(Tool):
    """Tool to create vivado synthesis ninja snippets."""

    def __init__(self, design, flow_args=None, ooc=False):
        super().__init__(design)
        self.flow_args = flow_args

        self.ooc = ooc
        if ooc:
            self.build_path = self.design_build_path / "ooc" / "synth"
        else:
            self.build_path = self.design_build_path / "in_context" / "synth"

        self._create_build_dir()

        self.top = YamlParser(self.design_path / "design.yaml").parse_top_module()

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

        self._read_hdl_files()
        self.vhdl_file_lib_map = {}
        self.__read_vhdl_libs()

        self.part = config.PART

    def __read_vhdl_libs(self):
        if not self.vhdl_libs:
            return

        for lib in self.vhdl_libs:
            path = self.design_path / lib
            for file in path.rglob("*"):
                if file.is_dir():
                    continue
                if file.suffix == ".vhd":
                    key = str(file)
                    self.vhdl_file_lib_map[key] = Path(lib).name

    def create_rule_snippets(self):
        return super().create_rule_snippets()
