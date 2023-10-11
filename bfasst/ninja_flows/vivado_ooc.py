"""Out-of-context Vivado flow"""
from bfasst.ninja_flows.vivado import Vivado
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoOoc(Vivado):
    """Out of context Vivado flow"""

    def __init__(self, design, flow_args=None):
        super().__init__(design, flow_args, ooc=True)

    def get_top_level_flow_path(self):
        return NINJA_FLOWS_PATH / "vivado_ooc.py"

    def add_ninja_deps(self, deps):
        super().add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_ooc.py")
