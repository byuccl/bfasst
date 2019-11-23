import abc


class ImplementationTool(abc.ABC):
    # Save directory in which to run the tool
    def __init__(self, cwd):
        self.cwd = cwd

    # This method should run implementation.  It should return
    # (bitstream, status), where:
    #   - bitstream is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def implement_bitstream(self, netlist_path, build_dir):
        pass
