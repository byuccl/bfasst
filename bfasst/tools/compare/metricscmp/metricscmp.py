"""Metrics comparison tool for comparing implementations."""

from dataclasses import dataclass
from pathlib import Path
from typing import Optional

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH


@dataclass
class MetricsCmpPaths:
    """Paths for metrics comparison inputs."""

    golden_bitstream: Path
    test_bitstream: Path
    golden_timing: Path
    golden_utilization: Path
    golden_log: Path
    test_timing: Path
    test_utilization: Path
    test_log: Path
    baseline_timing: Optional[Path] = None
    baseline_utilization: Optional[Path] = None
    baseline_log: Optional[Path] = None
    golden_congestion: Optional[Path] = None
    test_congestion: Optional[Path] = None
    baseline_congestion: Optional[Path] = None
    synth_log: Optional[Path] = None
    redact_log: Optional[Path] = None
    unredact_log: Optional[Path] = None


class MetricsCmp(Tool):
    """Compare timing, resource, and compilation metrics between implementations.

    Supports two comparison modes:
    1. Standard: golden vs test for both bitstream and metrics
    2. Super golden: golden vs test for bitstream, baseline (super golden) vs test for metrics
    """

    def __init__(self, flow, design, **path_kwargs):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "metricscmp"

        # Build paths config from kwargs
        paths = MetricsCmpPaths(**path_kwargs)
        self._paths = self._resolve_paths(paths)

        self._init_outputs()
        self.rule_snippet_path = (
            COMPARE_TOOLS_PATH / "metricscmp" / "metricscmp_rules.ninja.mustache"
        )
        self.rules_render_dict = self._build_render_dict()

    def _resolve_paths(self, paths: MetricsCmpPaths) -> dict:
        """Resolve paths, using golden as fallback for baseline if not provided."""
        return {
            "golden_bitstream": paths.golden_bitstream,
            "test_bitstream": paths.test_bitstream,
            "baseline_timing": paths.baseline_timing or paths.golden_timing,
            "baseline_utilization": paths.baseline_utilization or paths.golden_utilization,
            "baseline_log": paths.baseline_log or paths.golden_log,
            "baseline_congestion": paths.baseline_congestion or paths.golden_congestion,
            "test_timing": paths.test_timing,
            "test_utilization": paths.test_utilization,
            "test_log": paths.test_log,
            "test_congestion": paths.test_congestion,
            "synth_log": paths.synth_log,
            "redact_log": paths.redact_log,
            "unredact_log": paths.unredact_log,
        }

    def _build_render_dict(self):
        """Build the render dictionary for ninja templates."""
        render_dict = {
            "compare_script_path": str(BFASST_UTILS_PATH / "compare" / "metricscmp.py"),
            "output_json": str(self.outputs["metrics_json"]),
        }
        # Add all paths, converting to string (empty string if None)
        for key, path in self._paths.items():
            render_dict[key] = str(path) if path else ""
        return render_dict

    def _init_outputs(self):
        self.outputs["metrics_json"] = self.build_path / "metrics_comparison.json"

    def create_build_snippets(self):
        self._append_build_snippets_default(__file__, self.rules_render_dict)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "compare" / "metricscmp.py")
