""" Base class for comparison tools"""
import abc
import pathlib

from bfasst.tool import Tool, ToolProduct
from bfasst.utils import print_color
from bfasst.tool import BfasstException


class CompareException(BfasstException):
    """Base class for all exceptions in the compare package"""


class CompareTool(Tool):
    """Base class for comparison tools"""

    LOG_FILE_NAME = "log.txt"

    def __init__(self, cwd, design, gold_netlist, rev_netlist, flow_args="") -> None:
        super().__init__(cwd, design)
        # Implementation options
        self.create_arg_parser("compare", flow_args)

        self.gold_netlist = gold_netlist
        self.rev_netlist = rev_netlist

    def add_args(self):
        """Default arguments for all compare tools"""

    # This method should run netlist comparison.  It should return
    # a status
    @abc.abstractmethod
    def compare_netlists(self):
        pass

    def print_running_compare(self):
        print_color(self.TERM_COLOR_STAGE, "Running comparison")

    def print_skipping_compare(self):
        print_color(self.TERM_COLOR_STAGE, "Comparison already run")

    def generate_comparison(self, check_log_fcn):
        """Check if comparison was successful"""
        log_path = self.work_dir / self.LOG_FILE_NAME

        return ToolProduct(None, log_path, check_log_fcn)

    def up_to_date(self, check_log_fcn):
        """Determine whether to skip or run the comparison"""
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
