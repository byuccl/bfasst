""" Base class for comparison tools"""
import abc
import pathlib

from bfasst.tool import Tool, ToolProduct
from bfasst.tool import BfasstException


class CompareException(BfasstException):
    """Base class for all exceptions in the compare package"""


class CompareTool(Tool):
    """Base class for comparison tools"""

    LOG_FILE_NAME = "log.txt"

    def __init__(self, cwd, design, gold_netlist, rev_netlist, flow_args="") -> None:
        super().__init__(cwd, design)
        self.flow_args = flow_args
        self.gold_netlist = gold_netlist
        self.rev_netlist = rev_netlist

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("compare", self.flow_args)

    def cleanup(self):
        """Perform cleanup after the tool has finished running"""
        self.arg_parser = None

    def add_args(self):
        """Default arguments for all compare tools"""

    # This method should run netlist comparison.  It should return
    # a status
    @abc.abstractmethod
    def compare_netlists(self):
        pass

    def print_running_compare(self):
        self.log("Running comparison")

    def print_skipping_compare(self):
        self.log("Comparison already run")

    def generate_comparison(self, check_log_fcn):
        """Check if comparison was successful"""
        log_path = self.work_dir / self.LOG_FILE_NAME

        return ToolProduct(None, log_path, check_log_fcn)

    def up_to_date(self, check_log_fcn):
        """Determine whether to skip or run the comparison"""
        self.design.reversed_netlist_path = self.cwd / f"{self.design.top}_reversed.v"

        if not self.need_to_rerun(
            tool_products=(self.generate_comparison(check_log_fcn),),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime,
                self.design.reversed_netlist_path.stat().st_mtime,
            ),
        ):
            self.print_skipping_compare()
            return True

        self.print_running_compare()
        return False
