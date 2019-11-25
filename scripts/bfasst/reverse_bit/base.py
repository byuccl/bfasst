import abc

import bfasst.flow

class ReverseBitTool(bfasst.flow.Tool):

    # This method should run bitstream reversal.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def reverse_bitstream(self, bitstream_path, build_dir):
        pass
