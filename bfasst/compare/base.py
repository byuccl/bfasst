""" Base class for comparison tools"""
import abc
import pathlib

from bfasst.status import CompareStatus, Status

from bfasst.tool import Tool, ToolProduct
from bfasst.utils import print_color


class CompareTool(Tool):
    """Base class for comparison tools"""

    success_status = Status(CompareStatus.SUCCESS)

    LOG_FILE_NAME = "log.txt"

    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        # Implementation options
        self.create_arg_parser("compare", flow_args)

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
        status = self.get_prev_run_status(
            tool_products=(self.generate_comparison(check_log_fcn),),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime,
                self.design.reversed_netlist_path.stat().st_mtime,
            ),
        )

        if status is not None:
            self.print_skipping_compare()

        self.print_running_compare()
        return status
