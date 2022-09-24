import abc

from bfasst.status import ImplStatus, Status
from bfasst.utils import print_color
from bfasst.tool import Tool


class ImplementationTool(Tool):
    success_status = Status(ImplStatus.SUCCESS)

    def __init__(self, cwd, flow_args="") -> None:
        super().__init__(cwd, flow_args)

    # This method should run implementation.  It should return
    # (bitstream, status), where:
    #   - bitstream is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def implement_bitstream(self, netlist_path, build_dir):
        pass

    def print_running_impl(self):
        print_color(self.TERM_COLOR_STAGE, "Running Implementation")

    def print_skipping_impl(self):
        print_color(self.TERM_COLOR_STAGE, "Implementation already run")
