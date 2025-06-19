"""Tool to create Vivado implementation‐report ninja snippets."""

import json
import pathlib
from bfasst import config
from bfasst.tools.impl.impl_tool import ImplTool
from bfasst.paths import COMMON_TOOLS_PATH, BFASST_UTILS_PATH
from bfasst.utils.general import json_write_if_changed


class ImplDetailedReports(ImplTool):
    """Tool to generate every post‐implementation Vivado report."""

    def __init__(self, flow, design, impl_dcp, tag=""):
        super().__init__(flow, design)

        base_name = "impl_detailed_reports"
        if tag:
            base_name += f"_{tag}"
        self.build_path = self.build_path.with_name(base_name)

        self._my_dir_path = pathlib.Path(__file__).parent

        self.impl_dcp = (
            pathlib.Path(impl_dcp)
            if impl_dcp
            else self.design_build_path / "vivado_impl" / "impl.dcp"
        )

        self._init_outputs()

        self.inputs_str = {"dcp": str(self.impl_dcp)}
        self.outputs_str = {k: str(v) for k, v in self.outputs.items() if v is not None}

        self.report_build = {
            "impl_dcp": self.inputs_str["dcp"],
            "outputs": self.outputs_str,
            "tcl_sources": [self.outputs_str["reports_tcl"]],
        }

        self.rule_snippet_path = COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache"
        self.rules_render_dict = {
            "vivado_path": config.VIVADO_BIN_PATH,
            "utils_path": BFASST_UTILS_PATH,
            "in_context": True,
        }

    def _init_outputs(self):
        """All of the possible report files we want."""
        bp = self.build_path
        self.outputs["run_tcl"] = bp / "run.tcl"
        self.outputs["reports_tcl"] = bp / "reports.tcl"
        self.outputs["timing_summary"] = bp / "timing_summary.txt"
        self.outputs["setup_timing"] = bp / "setup_timing.txt"
        self.outputs["hold_timing"] = bp / "hold_timing.txt"
        self.outputs["full_timing_summary"] = bp / "full_timing_summary.txt"
        self.outputs["utilization"] = bp / "utilization.txt"
        self.outputs["power_summary"] = bp / "power_summary.txt"
        self.outputs["clocks"] = bp / "clocks.txt"
        self.outputs["journal"] = bp / "vivado.jou"
        self.outputs["drc"] = bp / "drc_report.txt"
        self.outputs["bitstream"] = bp / "bitstream.bit"
        self.outputs["log"] = bp / "vivado.log"

    def create_build_snippets(self):
        rpt_json = json.dumps(self.report_build, indent=4)
        json_write_if_changed(self.build_path / "reports.json", rpt_json)

        self._append_build_snippets_default(
            __file__,
            {
                "impl_output": str(self.build_path),
                "cwd": str(self.build_path),
                "impl_library": self._my_dir_path,
                "inputs": self.inputs_str,
                "outputs": self.outputs_str,
                "common_tools_path": str(BFASST_UTILS_PATH),
                "tcl_sources": [self.outputs_str["reports_tcl"]],
            },
        )

    def add_ninja_deps(self, deps):
        """Add dependencies to the master ninja file that would cause it to rebuild if modified."""
        self._add_ninja_deps_default(deps, __file__)
        for dep in self._my_dir_path.glob("*.mustache"):
            if "vivado" in dep.name:
                deps.append(dep)
        if "reports_tcl" in self.outputs:
            deps.append(self.outputs["reports_tcl"])
