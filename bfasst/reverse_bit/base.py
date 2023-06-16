""" Base class for bitstream to netlist tools"""
import abc

from bfasst.tool import Tool
from bfasst.utils import print_color
from bfasst.status import Status, BitReverseStatus
from bfasst.tool import BfasstException


class ReverseBitException(BfasstException):
    """Base class for all exceptions in the reverse_bit package"""


class ReverseBitTool(Tool):
    """Base class for bitstream to netlist tools"""

    success_status = Status(BitReverseStatus.SUCCESS)

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)

        # Implementation options
        self.create_arg_parser("bit_to_netlist", flow_args)

    def add_args(self):
        """Default arguments for all reverse tools"""

    # This method should run bitstream reversal.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def reverse_bitstream(self):
        pass

    def print_running_reverse_bit(self):
        print_color(self.TERM_COLOR_STAGE, "Running bitstream reversal")

    def print_skipping_reverse_bit(self):
        print_color(self.TERM_COLOR_STAGE, "Bitstream reversal already run")
