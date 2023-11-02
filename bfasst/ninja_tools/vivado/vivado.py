"""Parent tool for vivado synth and impl tools."""
from pathlib import Path
from abc import ABC
import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import NINJA_BUILD_PATH, NINJA_UTILS_PATH, VIVADO_RULES_PATH
from bfasst import config
from bfasst.utils.general import compare_json

from bfasst.yaml_parser import YamlParser


class Vivado(Tool, ABC):
    """Parent tool for vivado synth and impl tools."""

    # Static method to prevent rule duplication across all children tools
    rules_appended_to_build = False

    def __init__(self, design, ooc=False):
        super().__init__(design)
        self.ooc = ooc
        if ooc:
            self.build_path = self.design_build_path / "ooc"
        else:
            self.build_path = self.design_build_path / "in_context"

        self._create_build_dir()
        self.top = YamlParser(self.design_path / "design.yaml").parse_top_module()

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

    def _create_build_dir(self):
        super()._create_build_dir()

    def create_rule_snippets(self):
        if not Vivado.rules_appended_to_build:
            with open(VIVADO_RULES_PATH, "r") as f:
                vivado_ninja = chevron.render(
                    f,
                    {
                        "vivado_path": config.VIVADO_BIN_PATH,
                        "utils": str(NINJA_UTILS_PATH),
                        "in_context": not self.ooc,
                    },
                )
            with open(NINJA_BUILD_PATH, "a") as f:
                f.write(vivado_ninja)
            Vivado.rules_appended_to_build = True

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def _json_write(self, old_path, new_string):
        """Write the json file for the tool, if the new string
        does not match the json already in existence."""
        json_equivalent = compare_json(old_path, new_string)

        if not json_equivalent:
            with open(old_path, "w") as f:
                f.write(new_string)

    def __write_json_file(self):
        pass

    def __append_build_snippets(self):
        pass

    def add_ninja_deps(self):
        pass

    def _init_outputs(self):
        pass
