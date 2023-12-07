""" Base class for implementation tools """
import abc
import pathlib

from bfasst.tools_legacy.tool import Tool, ToolProduct
from bfasst.tools_legacy.tool import BfasstException


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
        self.log("Running implementation")

    def print_skipping_impl(self):
        self.log("Implementation already run")

    def up_to_date(self, log_check_fcn, file):
        """Commmon startup code for Implementation tools that first checks if
        prevous run can be used, and if not starts a new run"""

        # Save edif netlist path to design object
        self.design.netlist_path = self.cwd / f"{self.design.top}.edf"
        self.design.constraints_path = self.cwd / "constraints.xdc"

        if not self.need_to_rerun(
            tool_products=[ToolProduct(self.design.bitstream_path, self.log_path, log_check_fcn)],
            dependency_modified_time=max(
                pathlib.Path(file).stat().st_mtime, self.design.netlist_path.stat().st_mtime
            ),
        ):
            self.print_skipping_impl()
            return True

        self.print_running_impl()
        return False
