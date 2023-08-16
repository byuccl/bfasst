"""Out-of-context Vivado flow"""
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado import Vivado


class VivadoOoc(Flow):
    """Out of context Vivado flow"""

    def __new__(self, design):
        return Vivado(design, ooc=True)
