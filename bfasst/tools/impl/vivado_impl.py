"""Tool to create Vivado implementation ninja snippets."""

import json
import pathlib
from bfasst import config
from bfasst.tools.impl.impl_tool import ImplTool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH
from bfasst.utils.general import ensure_tuple, json_write_if_changed


class VivadoImpl(ImplTool):
    """Tool to create Vivado implementation ninja snippets."""

    def __init__(
        self,
        flow,
        design,
        synth_edf,
        build_path=None,
        opt_design=True,
        phys_opt_design=False,
        read_iphys_opt_tcl_file=None,
        constraints_files="",
        ooc=False,
        impl_options="",
    ):  # pylint: disable=too-many-positional-arguments
        super().__init__(flow, design)
        self.ooc = ooc

        self.constraints_file = [
            str(f) for f in ensure_tuple(constraints_files if not self.ooc else "")
        ]
        self.synth_edf = synth_edf

        if build_path:
            self.build_path = self.build_path.with_name(build_path)
        elif ooc:
            self.build_path = self.build_path.with_name("vivado_ooc_impl")
        else:
            self.build_path = self.build_path.with_name("vivado_impl")

        self._my_dir_path = pathlib.Path(__file__).parent

        self.opt_design = opt_design
        self.phys_opt_design = phys_opt_design

        self.read_iphys_opt_tcl_file = str(read_iphys_opt_tcl_file)
        self.read_iphys_opt_tcl = True if read_iphys_opt_tcl_file is not None else False

        self._init_outputs()
        self.inputs_str = {"xdc": self.constraints_file, "synth_edf": str(self.synth_edf)}
        self.outputs_str = {k: str(v) for k, v in self.outputs.items()}
        self.impl_build = {
            "part": self.flow.part,
            "impl_output": str(self.build_path),
            "synth_output": str(
                self.build_path.parent / ("synth" if not self.ooc else "synth_ooc")
            ),
            "clocks": (
                self.design_props.clocks
                if self.design_props is not None
                and type(self.flow).__name__ in ("ClockCrank", "ImplObfuscate")
                else ""
            ),
            "outputs": self.outputs_str,
            "opt_design": self.opt_design,
            "phys_opt_design": self.phys_opt_design,
            "read_iphys_opt_tcl": self.read_iphys_opt_tcl,
            "read_iphys_opt_tcl_file": self.read_iphys_opt_tcl_file,
            "tcl_sources": [
                self.outputs_str["setup_tcl"],
                self.outputs_str["impl_tcl"],
                self.outputs_str["reports_tcl"],
            ],
            "inputs": self.inputs_str,
        }
        if impl_options:
            self.impl_build.update(impl_options)

        self._init_outputs()
        self.rule_snippet_path = COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache"
        self.rules_render_dict = {
            "vivado_path": config.VIVADO_BIN_PATH,
            "utils_path": BFASST_UTILS_PATH,
        }

    def create_build_snippets(self):
        """Create build snippets in ninja file"""
        impl_json = json.dumps(self.impl_build, indent=4)
        json_write_if_changed(self.build_path / "impl.json", impl_json)

        self._append_build_snippets_default(
            __file__,
            {
                "in_context": not self.ooc,
                "impl_output": str(self.build_path),
                "synth_edf": str(self.synth_edf),
                "impl_library": self._my_dir_path,
                "cwd": self.build_path,
                "outputs": self.outputs_str,
                "common_tools_path": str(COMMON_TOOLS_PATH),
                "inputs": self.inputs_str,
                "tcl_sources": [str(i) for i in self.impl_build["tcl_sources"]],
            },
        )

    def _init_outputs(self):
        self.outputs["run_tcl"] = self.build_path / "run.tcl"
        self.outputs["setup_tcl"] = self.build_path / "setup.tcl"
        self.outputs["reports_tcl"] = self.build_path / "reports.tcl"
        self.outputs["impl_tcl"] = self.build_path / "impl.tcl"
        self.outputs["impl_json"] = self.build_path / "impl.json"
        self.outputs["impl_verilog"] = self.build_path / "viv_impl.v"
        self.outputs["impl_edf"] = self.build_path / "viv_impl.edf"
        self.outputs["impl_dcp"] = self.build_path / "impl.dcp"
        self.outputs["post_place_dcp"] = self.build_path / "post_place.dcp"
        self.outputs["post_phys_opt_dcp"] = self.build_path / "post_phys_opt.dcp"
        self.outputs["write_iphys_opt_tcl_file"] = self.build_path / "iphys_opt.tcl"
        self.outputs["phys_opt"] = self.build_path / "phys_opt"
        self.outputs["utilization"] = self.build_path / "utilization.txt"
        self.outputs["timing"] = self.build_path / "timing_summary.txt"
        self.outputs["journal"] = self.build_path / "vivado.jou"
        self.outputs["log"] = self.build_path / "vivado.log"
        self.outputs["bitstream"] = self.build_path / "design.bit" if not self.ooc else ""

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified."""
        self._add_ninja_deps_default(deps, __file__)
        for dep in self._my_dir_path.glob("*.mustache"):
            if "vivado" in dep.name:
                deps.append(dep)
        for tcl in self.impl_build["tcl_sources"]:
            deps.append(tcl)
        deps.append(self.synth_edf)
