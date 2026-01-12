"""Base class for logic optimization tools"""

import abc

from bfasst.tools_legacy.tool import Tool
from bfasst.utils import print_color
from bfasst.tools_legacy.tool import BfasstException


class OptException(BfasstException):
    """Base class for all exceptions in the opt package"""


class OptTool(Tool):
    """Base class for logic optimization tools"""

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        self.yosys_netlist_path = [str(self.design.netlist_path)]
        self.flow_args = flow_args

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("opt", self.flow_args)

    def add_args(self):
        """Default arguments for all opt tools"""

    # This method should run an optimizer.  It should return
    # (netlist, status), where:
    #   - netlist is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    # Function Arguments are:
    #   - design: The design object for this design
    #   - in_files: A list of design files to run the optimizer on
    #   - lib_files: A list of tuples containing VHDL library paths and library files
    @abc.abstractmethod
    def create_netlist(self, lib_files):
        pass

    def print_running_opt(self):
        """Print when running opt"""
        print_color(self.TERM_COLOR_STAGE, "Running Logic Optimization")

    def print_skipping_opt(self):
        """Print when skipping opt"""
        print_color(self.TERM_COLOR_STAGE, "Logic Optimization already run")
