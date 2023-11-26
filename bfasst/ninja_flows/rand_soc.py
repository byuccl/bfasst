"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib

from bfasst.ninja_flows.flow import FlowNoDesign
from bfasst.ninja_tools.design_create.rand_soc import RandSoCTool


class RandSoc(FlowNoDesign):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, flow_args=None, num_designs=1):
        super().__init__()

        self.flow_args = flow_args
        self.rand_soc_tool = RandSoCTool(self, num_designs=num_designs)

    @classmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        return "rand_soc"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)
        self.rand_soc_tool.add_ninja_deps(deps)

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__).resolve()
