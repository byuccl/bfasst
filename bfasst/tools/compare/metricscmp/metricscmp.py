"""Metrics comparison tool for comparing implementations."""

from pathlib import Path

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH


class MetricsCmp(Tool):
    """Compare timing, resource, and compilation metrics between implementations.

    Supports two comparison modes:
    1. Standard: golden vs test for both bitstream and metrics
    2. Super golden: golden vs test for bitstream, baseline (super golden) vs test for metrics
    """

    def __init__(
        self,
        flow,
        design,
        *,
        golden_bitstream: Path,
        test_bitstream: Path,
        golden_timing: Path,
        golden_utilization: Path,
        golden_log: Path,
        test_timing: Path,
        test_utilization: Path,
        test_log: Path,
        baseline_timing: Path = None,
        baseline_utilization: Path = None,
        baseline_log: Path = None,
    ):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "metricscmp"

        # Bitstream comparison is always golden vs test
        self.golden_bitstream = golden_bitstream
        self.test_bitstream = test_bitstream

        # Metrics comparison uses baseline if provided, otherwise golden
        self.baseline_timing = baseline_timing or golden_timing
        self.baseline_utilization = baseline_utilization or golden_utilization
        self.baseline_log = baseline_log or golden_log
        self.test_timing = test_timing
        self.test_utilization = test_utilization
        self.test_log = test_log

        self._init_outputs()

        self.rule_snippet_path = (
            COMPARE_TOOLS_PATH / "metricscmp" / "metricscmp_rules.ninja.mustache"
        )

        self.rules_render_dict = {
            "compare_script_path": str(BFASST_UTILS_PATH / "compare" / "metricscmp.py"),
            "golden_bitstream": str(self.golden_bitstream),
            "test_bitstream": str(self.test_bitstream),
            "baseline_timing": str(self.baseline_timing),
            "baseline_utilization": str(self.baseline_utilization),
            "baseline_log": str(self.baseline_log),
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
