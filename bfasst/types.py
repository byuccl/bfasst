from enum import Enum, auto


class Vendor(Enum):
    """Enum differentiating between different fpga vendors"""

    LATTICE = auto()
    XILINX = auto()
