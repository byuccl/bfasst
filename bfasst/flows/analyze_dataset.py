"""Analyze dataset metrics."""

from pathlib import Path
from bfasst.flows.flow import Flow
from bfasst.paths import FLOWS_PATH
from bfasst.tools.dataset_metrics.graph_metrics import GraphMetrics


class AnalyzeDataset(Flow):
    """Analyze dataset metrics."""

    def __init__(self, design, dataset):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.design = design
        self.dataset = Path(dataset)

        self.graph_metrics_default_tool = GraphMetrics(
            self, design, None, None
        )  # only used for configuring ninja
        # pylint: enable=duplicate-code

    def create_build_snippets(self):
        # get the size of the dataset
        directories = [x for x in self.dataset.iterdir() if x.is_dir()]
        iterations = len(directories)

        for i in range(1, iterations + 1):
            graph_metrics_tool = GraphMetrics(
                self, self.design, directories[i - 1] / f"{directories[i-1].name}.dump", i
            )
            graph_metrics_tool.create_build_snippets()

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "analyze_dataset.py"
