import abc


class ReverseBitTool(abc.ABC):
    # Save directory in which to run the tool
    def __init__(self, cwd):
        self.cwd = cwd

    # This method should run bitstream reversal.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def reverse_bitstream(self, bitstream_path, build_dir):
        pass
