"""Analyze dataset metrics."""

from pathlib import Path
import pathlib
from bfasst.flows.flow import FlowNoDesign
from bfasst.tools.dataset_metrics.accumulate_metrics import AccumulateMetrics
from bfasst.tools.dataset_metrics.graph_metrics import GraphMetrics


class AnalyzeDataset(FlowNoDesign):
    """Analyze dataset metrics."""

    def __init__(self, dataset):
        # pylint: disable=duplicate-code
        super().__init__()
        self.dataset = Path(dataset)

        # only used for configuring ninja rule snippets
        self.graph_metrics_default_tool = GraphMetrics(self, None, None)
        self.accumulate_metrics_tool = AccumulateMetrics(self, None)
        # pylint: enable=duplicate-code

    def create_build_snippets(self):
        # get the size of the dataset
        directories = [x for x in self.dataset.iterdir() if x.is_dir()]
        iterations = len(directories)
        pieces = []

        for i in range(1, iterations + 1):
            num = int(directories[i - 1].name.split("_")[-1])
            graph_metrics_tool = GraphMetrics(
                self, directories[i - 1] / f"{directories[i - 1].name}.dump", num
            )
            pieces.append(graph_metrics_tool.metrics_path)
            graph_metrics_tool.create_build_snippets()

        AccumulateMetrics(self, pieces).create_build_snippets()

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "dataset_metrics"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
