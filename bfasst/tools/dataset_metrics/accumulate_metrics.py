"""Accumulate metrics from the graph_metrics tool."""

import chevron

from bfasst.paths import (
    BFASST_BUILD,
    BFASST_UTILS,
    DATASET_METRICS_TOOLS,
    NINJA_BUILD_PATH,
)
from bfasst.tools.tool import ToolBase


class AccumulateMetrics(ToolBase):
    """Accumulate metrics from the graph_metrics tool."""

    def __init__(self, flow, pieces):
        super().__init__(flow)
        self.pieces = pieces
        self.build_path = BFASST_BUILD / "dataset_metrics"
        self.metrics_path = self.build_path / "master_metrics.log"
        self.summary_stats = self.build_path / "summary_stats.log"

        self._init_outputs()
        self.rule_snippet_path = DATASET_METRICS_TOOLS / "accumulate_metrics_rules.ninja.mustache"

    def create_build_snippets(self):
        with open(DATASET_METRICS_TOOLS / "accumulate_metrics_build.ninja.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "metrics_file": self.metrics_path,
                    "summary_stats": self.summary_stats,
                    "aggregation_dir": self.build_path,
                    "pieces": self.pieces,
                    "accumulate_metrics_util": BFASST_UTILS / "accumulate_metrics.py",
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self):
        self.outputs["metrics_path"] = self.metrics_path
        self.outputs["summary_stats"] = self.summary_stats

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS / "accumulate_metrics.py")
