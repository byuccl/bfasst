"""Tool to create Vivado implementation ninja snippets."""
import json
import pathlib
from bfasst import config
from bfasst.ninja_tools.impl.impl_tool import ImplTool
from bfasst.paths import (
    COMMON_TOOLS_PATH,
    NINJA_UTILS_PATH,
)
from bfasst.utils.general import json_write_if_changed


class VivadoImpl(ImplTool):
    """Tool to create Vivado implementation ninja snippets."""

    def __init__(self, flow, design, ooc=False):
        super().__init__(flow, design)
        self.ooc = ooc
        if self.ooc:
            self.build_path = self.build_path.parent / "impl_ooc"
        self._my_dir_path = pathlib.Path(__file__).parent
        self._init_outputs()

    def create_build_snippets(self):
        """Create build snippets in ninja file"""

        impl = {
            "part": config.PART,
            "xdc": str(self.build_path.parent / "synth" / (self.design_props.top + ".xdc"))
            if not self.ooc
            else False,
            "bit": str(self.build_path / (self.design_props.top + ".bit"))
            if not self.ooc
            else False,
            "impl_output": str(self.build_path),
            "synth_output": str(
                self.build_path.parent / ("synth" if not self.ooc else "synth_ooc")
            ),
        }
        impl_json = json.dumps(impl, indent=4)
        json_write_if_changed(self.build_path / "impl.json", impl_json)

        self._append_build_snippets_default(
            __file__,
            {
                "in_context": not self.ooc,
                "impl_output": str(self.build_path),
                "synth_output": self.build_path.parent / ("synth" if not self.ooc else "synth_ooc"),
                "impl_library": self._my_dir_path,
                "top": self.design_props.top,
            },
        )

    def create_rule_snippets(self):
        self._append_rule_snippets_default(
            __file__,
            {
                "vivado_path": config.VIVADO_BIN_PATH,
                "utils": str(NINJA_UTILS_PATH),
            },
            COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache",
        )

    def _init_outputs(self):
        self.outputs["impl_tcl"] = self.build_path / "impl.tcl"
        self.outputs["impl_json"] = self.build_path / "impl.json"
        self.outputs["impl_verilog"] = self.build_path / "viv_impl.v"
        self.outputs["impl_edf"] = self.build_path / "viv_impl.edf"
        self.outputs["impl_checkpoint"] = self.build_path / "impl.dcp"
        self.outputs["utilization"] = self.build_path / "utiliztion.txt"
        self.outputs["impl_journal"] = self.build_path / "vivado.jou"
        self.outputs["impl_log"] = self.build_path / "vivado.log"
        self.outputs["bitstream"] = self.build_path / (self.design_props.top + ".bit")

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(self._my_dir_path / "vivado_impl.tcl.mustache")
