import abc

import bfasst.flow
from bfasst.utils import print_color


class SynthesisTool(bfasst.flow.Tool):

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
