"""Wrapper for Vivado class that returns instance for out-of-context run"""
from bfasst.ninja_flows.vivado import Vivado


class VivadoOoc:
    """Wrapper for Vivado class that returns instance for out-of-context run"""

    def __new__(self, design):
        return Vivado(design, ooc=True)
