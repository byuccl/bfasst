import abc

from bfasst import tool
from bfasst.utils import print_color
from bfasst.status import SynthStatus, Status


class SynthesisTool(tool.Tool):
    success_status = Status(SynthStatus.SUCCESS)
    
    def __init__(self, cwd, flow_args="") -> None:
        super().__init__(cwd, flow_args)

    # This method should run synthesis.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def create_netlist(self, design, build_dir):
        pass

    opt_tool = None

    def print_running_synth(self):
        print_color(self.TERM_COLOR_STAGE, "Running synthesis")

    def print_skipping_synth(self):
        print_color(self.TERM_COLOR_STAGE, "Synthesis already run")
