"""Create the rule and build snippets for computing gnn dataset metrics."""

import chevron

from bfasst.tools.tool import ToolBase
from bfasst.paths import BUILD_PATH, NINJA_BUILD_PATH, DATASET_METRICS_TOOLS_PATH, BFASST_UTILS_PATH


class GraphMetrics(ToolBase):
    """Create the rule and build snippets for computing gnn dataset metrics."""

    def __init__(
        self,
        flow,
        graph,
        num,
    ):
        super().__init__(flow)
        self.graph = graph
        self.num = num
        self.build_path = BUILD_PATH / "dataset_metrics"
        self.metrics_path = self.build_path / f"metrics_{num}.log"

        self._init_outputs()
        self.rule_snippet_path = DATASET_METRICS_TOOLS_PATH / "process_graph_rules.ninja.mustache"

    def create_build_snippets(self):
        with open(DATASET_METRICS_TOOLS_PATH / "process_graph_build.ninja.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "output": self.metrics_path,
                    "graph": self.graph,
                    "process_graph_util": BFASST_UTILS_PATH / "process_graph.py",
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def _init_outputs(self):
        self.outputs["metrics_path"] = self.metrics_path

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "process_graph.py")
