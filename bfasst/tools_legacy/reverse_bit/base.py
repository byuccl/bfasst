""" Base class for bitstream to netlist tools"""
import abc

from bfasst.tools_legacy.tool import Tool
from bfasst.tools_legacy.tool import BfasstException


class ReverseBitException(BfasstException):
    """Base class for all exceptions in the reverse_bit package"""


class ReverseBitTool(Tool):
    """Base class for bitstream to netlist tools"""

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        self.flow_args = flow_args

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("bit_to_netlist", self.flow_args)

    def cleanup(self):
        """Perform cleanup after the tool has finished running"""
        self.arg_parser = None

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
        self.log("Running bitstream reversal")

    def print_skipping_reverse_bit(self):
        self.log("Bitstream reversal already run")
