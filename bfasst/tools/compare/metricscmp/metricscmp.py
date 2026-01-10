"""Metrics comparison tool for comparing implementations."""

from pathlib import Path

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH


class MetricsCmp(Tool):
    """Compare timing, resource, and compilation metrics between implementations."""

    def __init__(
        self,
        flow,
        design,
        *,
        golden_timing: Path,
        golden_utilization: Path,
        golden_log: Path,
        test_timing: Path,
        test_utilization: Path,
        test_log: Path,
    ):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "metricscmp"

        self.golden_timing = golden_timing
        self.golden_utilization = golden_utilization
        self.golden_log = golden_log
        self.test_timing = test_timing
        self.test_utilization = test_utilization
        self.test_log = test_log

        self._init_outputs()

        self.rule_snippet_path = (
            COMPARE_TOOLS_PATH / "metricscmp" / "metricscmp_rules.ninja.mustache"
        )

        self.rules_render_dict = {
            "compare_script_path": str(BFASST_UTILS_PATH / "compare" / "metricscmp.py"),
            "golden_timing": str(self.golden_timing),
            "golden_utilization": str(self.golden_utilization),
            "golden_log": str(self.golden_log),
            "test_timing": str(self.test_timing),
            "test_utilization": str(self.test_utilization),
            "test_log": str(self.test_log),
            "output_json": str(self.outputs["metrics_json"]),
        }

    def _init_outputs(self):
        self.outputs["metrics_json"] = self.build_path / "metrics_comparison.json"

    def create_build_snippets(self):
        self._append_build_snippets_default(__file__, self.rules_render_dict)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "compare" / "metricscmp.py")
        deps.append(BFASST_UTILS_PATH / "compare" / "metrics_parser.py")
        deps.append(BFASST_UTILS_PATH / "compare" / "metrics_data_types.py")
