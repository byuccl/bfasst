"""Flow to create Vivado synthesis and implementation ninja snippets."""
from bfasst.ninja_flows.flow import Flow
from bfasst.paths import NINJA_FLOWS_PATH


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, flow_args=None, ooc=False):
        super().__init__()
        self.ooc = ooc
        self.vivado_tool = self.configure_vivado_tool(design, flow_args, ooc)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado.py ")
        if self.ooc:
            deps.append(f"{NINJA_FLOWS_PATH}/vivado_ooc.py ")

    def get_top_level_flow_path(self) -> str:
        return (
            f"{NINJA_FLOWS_PATH}/vivado.py" if not self.ooc else f"{NINJA_FLOWS_PATH}/vivado_ooc.py"
        )
