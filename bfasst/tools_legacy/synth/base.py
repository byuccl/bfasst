""" Base synthesis tool class"""

import abc

from bfasst.tools_legacy import tool
from bfasst.tools_legacy.tool import BfasstException


class SynthesisException(BfasstException):
    """Base class for all exceptions in the synth package"""


class SynthesisTool(tool.Tool):
    """Base synthesis tool class"""

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        self.flow_args = flow_args

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("synth", self.flow_args)

    def cleanup(self):
        """Perform cleanup after the tool has finished running"""
        self.arg_parser = None

    def add_args(self):
        """Default arguments for all synth tools"""
        self.arg_parser.add_argument("--flatten", action="store_true")
        self.arg_parser.add_argument("--max_dsp", type=int, default=None)
        self.arg_parser.add_argument("--out_of_context", action="store_true")

    # This method should run synthesis.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def create_netlist(self, build_dir):
        pass

    opt_tool = None

    def print_running_synth(self):
        self.log("Running synthesis")

    def print_skipping_synth(self):
        self.log("Synthesis already run")
