import abc

import bfasst.flow
from bfasst.utils import print_color


class ImplementationTool(bfasst.flow.Tool):

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
