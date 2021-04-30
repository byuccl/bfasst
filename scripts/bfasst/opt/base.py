import abc
from bfasst.status import OptStatus

from bfasst.tool import Tool
from bfasst.status import Status


class OptTool(Tool):
    def __init__(self, cwd) -> None:
        super().__init__(cwd)
        self.success_status = Status(OptStatus.SUCCESS)

    # This method should run an optimizer.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    # Function Arguments are:
    #   - design: The design object for this design
    #   - in_files: A list of design files to run the optimizer on
    #   - lib_files: A list of tuples containing VHDL library paths and library files
    @abc.abstractmethod
    def create_netlist(self, design, in_files, lib_files):
        pass
