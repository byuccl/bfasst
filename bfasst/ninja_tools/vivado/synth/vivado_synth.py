"""Tool to create Vivado synthesis ninja snippets."""
import json
import chevron
from bfasst.ninja_tools.vivado.vivado import Vivado
from bfasst.paths import NINJA_BUILD_PATH, NINJA_VIVADO_SYNTH_TOOL_PATH


class VivadoSynth(Vivado):
    """Tool to create vivado synthesis ninja snippets."""

    def __init__(self, design, flow_args=None, ooc=False):
        super().__init__(design, ooc)
        self.flow_args = flow_args

        self.build_path = self.build_path / "synth"

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def _write_json_file(self):
        """Specify synthesis arguments in a json file.
        Chevron will use this file to fill in the tcl template."""
        synth = {
            "part": self.part,
            "top": self.top,
            "vhdl": self.vhdl,
            "vhdl_libs": list(self.vhdl_file_lib_map.items()),
            "verilog": self.verilog,
            "system_verilog": self.system_verilog,
            "io": str(self.build_path / "report_io.txt") if not self.ooc else False,
            "synth_output": str(self.build_path),
            "flow_args": self.flow_args if self.flow_args else "",
        }
        synth_json = json.dumps(synth, indent=4)

        self._json_write(self.build_path / "synth.json", synth_json)

    def _append_build_snippets(self):
        """Create ninja snippets for vivado synthesis in build.ninja"""
        with open(NINJA_VIVADO_SYNTH_TOOL_PATH / "viv_synth.ninja.mustache") as f:
            synth_ninja = chevron.render(
                f,
                {
                    "in_context": not self.ooc,
                    "synth_output": str(self.build_path),
                    "synth_library": NINJA_VIVADO_SYNTH_TOOL_PATH,
                    "top": self.top,
                    "verilog": self.verilog,
                    "system_verilog": self.system_verilog,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(synth_ninja)

    def _init_outputs(self):
        self.outputs["synth_tcl"] = self.build_path / "synth.tcl"
        self.outputs["synth_json"] = self.build_path / "synth.json"
        self.outputs["synth_edf"] = self.build_path / "viv_synth.edf"
        self.outputs["synth_dcp"] = self.build_path / "synth.dcp"
        self.outputs["synth_journal"] = self.build_path / "vivado.jou"
        self.outputs["synth_log"] = self.build_path / "vivado.log"

        if not self.ooc:
            self.outputs["io_report"] = self.build_path / "report_io.txt"
            self.outputs["synth_constraints"] = self.build_path / (self.top + ".xdc")

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified"""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_VIVADO_SYNTH_TOOL_PATH / "viv_synth.ninja.mustache")
