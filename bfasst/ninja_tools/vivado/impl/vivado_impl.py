"""Tool to create Vivado implementation ninja snippets."""
import json
import chevron
from bfasst.ninja_tools.vivado.vivado import Vivado
from bfasst.paths import (
    NINJA_VIVADO_IMPL_TOOL_PATH,
    NINJA_BUILD_PATH,
)


class VivadoImpl(Vivado):
    """Tool to create Vivado implementation ninja snippets."""

    def __init__(self, design, ooc=False):
        super().__init__(design, ooc)
        self.build_path = self.design_build_path / "impl"

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def _write_json_file(self):
        """Specify implementation arguments in a json file.
        Chevron will use the file to fill in the tcl template."""
        impl = {
            "part": self.part,
            "xdc": str(self.build_path.parent / "synth" / (self.top + ".xdc"))
            if not self.ooc
            else False,
            "bit": str(self.build_path / (self.top + ".bit")) if not self.ooc else False,
            "impl_output": str(self.build_path),
            "synth_output": str(self.build_path.parent / "synth"),
        }
        impl_json = json.dumps(impl, indent=4)

        self._json_write(self.build_path / "impl.json", impl_json)

    def _append_build_snippets(self):
        """Create ninja snippets for vivado implementation in build.ninja"""
        with open(NINJA_VIVADO_IMPL_TOOL_PATH / "viv_impl.ninja.mustache") as f:
            impl_ninja = chevron.render(
                f,
                {
                    "in_context": not self.ooc,
                    "impl_output": str(self.build_path),
                    "synth_output": str(self.build_path.parent / "synth"),
                    "impl_library": NINJA_VIVADO_IMPL_TOOL_PATH,
                    "top": self.top,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(impl_ninja)

    def _init_outputs(self):
        self.outputs["impl_tcl"] = self.build_path / "impl.tcl"
        self.outputs["impl_json"] = self.build_path / "impl.json"
        self.outputs["impl_verilog"] = self.build_path / "viv_impl.v"
        self.outputs["impl_edf"] = self.build_path / "viv_impl.edf"
        self.outputs["impl_checkpoint"] = self.build_path / "impl.dcp"
        self.outputs["utilization"] = self.build_path / "utiliztion.txt"
        self.outputs["impl_journal"] = self.build_path / "vivado.jou"
        self.outputs["impl_log"] = self.build_path / "vivado.log"

        if not self.ooc:
            self.outputs["bitstream"] = self.build_path / (self.top + ".bit")

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified."""
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_VIVADO_IMPL_TOOL_PATH / "viv_impl.ninja.mustache")
