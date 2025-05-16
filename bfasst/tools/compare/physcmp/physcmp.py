"""Tool to create RapidWright-based physical comparison ninja snippets."""

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH, BFASST_PATH
import pathlib


class PhysCmp(Tool):
    def __init__(
        self,
        flow,
        design,
        *,
        golden_dcp,
        golden_edf,
        golden_setup_timing,
        golden_hold_timing,
        golden_timing_summary_full,
        golden_utilization,
        golden_power,
        test_dcp,
        test_edf,
        test_setup_timing,
        test_hold_timing,
        test_timing_summary_full,
        test_utilization,
        test_power,
        log_name="phys_cmp.log",
        logging_level="INFO"
    ):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "phys_cmp"

        self.golden_dcp = golden_dcp
        self.golden_edf = golden_edf
        self.golden_setup_timing = golden_setup_timing
        self.golden_hold_timing = golden_hold_timing
        self.golden_timing_summary_full = golden_timing_summary_full
        self.golden_utilization = golden_utilization
        self.golden_power = golden_power

        self.test_dcp = test_dcp
        self.test_edf = test_edf
        self.test_setup_timing = test_setup_timing
        self.test_hold_timing = test_hold_timing
        self.test_timing_summary_full = test_timing_summary_full
        self.test_utilization = test_utilization
        self.test_power = test_power

        self.log_name = log_name
        self.logging_level = logging_level

        self._init_outputs()

        self.rule_snippet_path = COMPARE_TOOLS_PATH / "physcmp" / "physcmp_rules.ninja.mustache"

        self.rules_render_dict = {
            "compare_script_path": str(BFASST_UTILS_PATH / "physcmp.py"),
            "golden_dcp": str(self.golden_dcp),
            "golden_edf": str(self.golden_edf),
            "golden_setup_timing": str(self.golden_setup_timing),
            "golden_hold_timing": str(self.golden_hold_timing),
            "golden_timing_summary_full": str(self.golden_timing_summary_full),
            "golden_utilization": str(self.golden_utilization),
            "golden_power": str(self.golden_power),
            "test_dcp": str(self.test_dcp),
            "test_edf": str(self.test_edf),
            "test_setup_timing": str(self.test_setup_timing),
            "test_hold_timing": str(self.test_hold_timing),
            "test_timing_summary_full": str(self.test_timing_summary_full),
            "test_utilization": str(self.test_utilization),
            "test_power": str(self.test_power),
            "log_path": str(self.outputs["physcmp_log"]),
            "logging_level": f"--logging_level {self.logging_level}",
            "bfasst_path": str(BFASST_PATH),
        }

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            self.rules_render_dict,
        )

    def _init_outputs(self):
        self.outputs["physcmp_log"] = self.build_path / self.log_name

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "physcmp.py")

