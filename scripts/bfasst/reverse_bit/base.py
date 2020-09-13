import abc

import bfasst.flow
from bfasst.utils import print_color


class ReverseBitTool(bfasst.flow.Tool):

    # This method should run bitstream reversal.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def reverse_bitstream(self, design):
        pass

    def print_running_reverse_bit(self):
        print_color(self.TERM_COLOR_STAGE, "Running bitstream reversal")

    def print_skipping_reverse_bit(self):
        print_color(self.TERM_COLOR_STAGE, "Bitstream reversal already run")