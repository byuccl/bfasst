"""Tool to create Vivado implementation ninja snippets."""

import json
import pathlib
from bfasst import config
from bfasst.tools.impl.impl_tool import ImplTool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH
from bfasst.utils.general import json_write_if_changed


class VivadoImpl(ImplTool):
    """Tool to create Vivado implementation ninja snippets."""

    def __init__(self, flow, design, prev_tool_outputs, ooc=False):
        super().__init__(flow, design)
        self.ooc = ooc

        # A dictionary with the outputs of previous tools in a flow.
        # For this implementation tool, it will be the outputs of the synthesis tool.
        self.prev_tool_outputs = prev_tool_outputs

        self.build_path = (
            self.build_path.with_name("vivado_ooc_impl")
            if ooc
            else self.build_path.with_name("vivado_impl")
        )
        self._my_dir_path = pathlib.Path(__file__).parent
        self._init_outputs()

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        impl = {
            "part": config.PART,
            "xdc": str(self.prev_tool_outputs["synth_constraints"]) if not self.ooc else False,
            "bit": str(self.outputs["bitstream"]) if not self.ooc else False,
            "impl_output": str(self.build_path),
            "synth_output": str(self.prev_tool_outputs["synth_constraints"].parent),
        }
        impl_json = json.dumps(impl, indent=4)
        json_write_if_changed(self.outputs["impl_json"], impl_json)

        self._append_build_snippets_default(
            __file__,
            {
                "in_context": not self.ooc,
                "impl_output": str(self.build_path),
                "synth_output": self.prev_tool_outputs["synth_constraints"].parent,
                "impl_library": self._my_dir_path,
                "cwd": self.build_path,
            },
        )

    def create_rule_snippets(self):
        self._append_rule_snippets_default(
            __file__,
            {
                "vivado_path": config.VIVADO_BIN_PATH,
                "utils_path": BFASST_UTILS_PATH,
            },
            COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache",
        )

    def _init_outputs(self):
        self.outputs["impl_tcl"] = self.build_path / "impl.tcl"
        self.outputs["impl_json"] = self.build_path / "impl.json"
        self.outputs["golden_netlist"] = self.build_path / "viv_impl.v"
        self.outputs["impl_edf"] = self.build_path / "viv_impl.edf"
        self.outputs["impl_checkpoint"] = self.build_path / "impl.dcp"
        self.outputs["utilization"] = self.build_path / "utiliztion.txt"
        self.outputs["impl_journal"] = self.build_path / "vivado.jou"
        self.outputs["impl_log"] = self.build_path / "vivado.log"
        self.outputs["bitstream"] = self.build_path / "design.bit"

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self._my_dir_path / "vivado_impl.tcl.mustache")
