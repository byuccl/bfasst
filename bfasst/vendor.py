''' This is the Vendor enum'''

from enum import Enum

class Vendor(Enum):
    """Enum differentiating between different fpga vendors"""

    LATTICE = 1
    XILINX = 2
    