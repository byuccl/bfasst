""" Base class for synthesis tools """

import pathlib

from bfasst.tools.tool import Tool


class SynthTool(Tool):
    """Base class for synthesis tools"""

    def __init__(self, flow, design_path, ooc=False) -> None:
        super().__init__(flow, design_path)

        self.verilog = []
        self.system_verilog = []
        self.vhdl = []
        self.vhdl_file_lib_map = {}
        self.other_sources = []

        if ooc:
            self.build_path = self.design_build_path / "synth_ooc"
        else:
            self.build_path = self.design_build_path / "synth"
        self.ooc = ooc

        if self.design_props is None:
            return

        self._read_hdl_files()
        self._read_vhdl_libs()

    def _read_hdl_files(self):
        """Read the hdl files in the design directory"""

        if self.flow.__class__.__name__ in {"RandSocDumped", "RandSoc"}:
            self.verilog = []
            self.system_verilog = []
            self.vhdl = []
            self.vhdl_libs = {}
            self.other_sources = []

        else:
            self.vhdl_libs = self.design_props.vhdl_libs

            if self.design_props.verilog_files is not None:
                self.verilog = [
                    str(self.design_path / file) for file in self.design_props.verilog_files
                ]

            if self.design_props.system_verilog_files is not None:
                self.system_verilog = [
                    str(self.design_path / file) for file in self.design_props.system_verilog_files
                ]

            if self.design_props.other_sources is not None:
                self.other_sources = [
                    str(self.design_path / file) for file in self.design_props.other_sources
                ]

            if self.verilog or self.system_verilog:
                return

            for child in self.design_path.rglob("*"):
                if child.is_dir():
                    continue

                # don't add vhdl libraries as src files
                is_lib = self.__check_is_lib(child)
                if is_lib:
                    continue

                if child.suffix == ".v":
                    self.verilog.append(str(child))
                elif child.suffix == ".sv":
                    self.system_verilog.append(str(child))
                elif child.suffix == ".vhd":
                    self.vhdl.append(str(child))

    def __check_is_lib(self, vhdl_file):
        """Check if a vhdl file is a library"""
        if not self.vhdl_libs:
            return False

        for lib in self.vhdl_libs:
            if lib in str(vhdl_file):
                return True
        return False

    def _read_vhdl_libs(self):
        if not self.vhdl_libs:
            return

        for lib in self.vhdl_libs:
            path = self.design_path / lib
            for file in path.rglob("*"):
                if file.is_dir():
                    continue
                if file.suffix == ".vhd":
                    key = str(file)
                    self.vhdl_file_lib_map[key] = pathlib.Path(lib).name
