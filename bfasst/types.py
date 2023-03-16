""" Types used across BFASST """

from enum import Enum, auto


class ToolType(Enum):
    """An enum describing the different places arguments go"""

    SYNTH = 0
    IMPL = 1
    MAP = 2
    CMP = 3  # Currently only accepts "XILINX" or "LATTICE" for Conformal Comparison
    ERR = 4
    REVERSE = 5


class Vendor(Enum):
    """Enum differentiating between different fpga vendors"""

    LATTICE = auto()
    XILINX = auto()
