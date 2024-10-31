"""Analyze dataset metrics."""

from pathlib import Path
from bfasst.flows.flow import Flow
from bfasst.paths import FLOWS_PATH
from bfasst.tools.dataset_metrics.accumulate_metrics import AccumulateMetrics
from bfasst.tools.dataset_metrics.graph_metrics import GraphMetrics


class AnalyzeDataset(Flow):
    """Analyze dataset metrics."""

    def __init__(self, design, dataset):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.design = design
        self.dataset = Path(dataset)

        # only used for configuring ninja rule snippets
        self.graph_metrics_default_tool = GraphMetrics(self, design, None, None)
        self.accumulate_metrics_tool = AccumulateMetrics(self, design, None)
        # pylint: enable=duplicate-code

    def create_build_snippets(self):
        # get the size of the dataset
        directories = [x for x in self.dataset.iterdir() if x.is_dir()]
        iterations = len(directories)
        pieces = []

        for i in range(1, iterations + 1):
            num = int(directories[i - 1].name.split("_")[-1])
            graph_metrics_tool = GraphMetrics(
                self, self.design, directories[i - 1] / f"{directories[i - 1].name}.dump", num
            )
            pieces.append(graph_metrics_tool.metrics_path)
            graph_metrics_tool.create_build_snippets()

        AccumulateMetrics(self, self.design, pieces).create_build_snippets()

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "analyze_dataset.py"
