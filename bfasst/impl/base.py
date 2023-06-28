""" Base class for implementation tools """
import abc
import pathlib

from bfasst.utils import print_color
from bfasst.tool import Tool, ToolProduct
from bfasst.tool import BfasstException


class ImplementationException(BfasstException):
    """Base class for all exceptions in the implementation package"""


class ImplementationTool(Tool):
    """Base class for implementation tools"""

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        self.flow_args = flow_args

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("impl", self.flow_args)

    def cleanup(self):
        """Perform cleanup after the tool has finished running"""
        self.arg_parser = None

    def add_args(self):
        """Default arguments for all impl tools"""
        self.arg_parser.add_argument("--out_of_context", action="store_true")

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

    def up_to_date(self, log_check_fcn):
        """Commmon startup code for Implementation tools that first checks if
        prevous run can be used, and if not starts a new run"""
        if not self.need_to_rerun(
            tool_products=[ToolProduct(self.design.bitstream_path, self.log_path, log_check_fcn)],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, self.design.netlist_path.stat().st_mtime
            ),
        ):
            self.print_skipping_impl()
            return True

        self.print_running_impl()
        return False
