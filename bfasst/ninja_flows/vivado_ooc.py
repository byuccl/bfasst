"""Out-of-context Vivado flow"""
from bfasst.ninja_flows.vivado import Vivado


class VivadoOoc:
    """Out of context Vivado flow"""

    def __new__(self, design, flow_args=None):
        if isinstance(flow_args, dict) and "synth" in flow_args:
            return Vivado(design, flow_args["synth"], ooc=True)
        return Vivado(design, ooc=True)
