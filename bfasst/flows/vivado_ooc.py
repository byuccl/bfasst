"""Out-of-context Vivado flow"""
from bfasst.flows.vivado import Vivado
from bfasst.paths import FLOWS_PATH


class VivadoOoc(Vivado):
    """Out of context Vivado flow"""

    def __init__(self, design):
        super().__init__(design, ooc=True)

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado_ooc.py"
