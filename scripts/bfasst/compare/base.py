""" Base class for comparison tools"""
import abc
import shlex

from bfasst import tool
from bfasst.status import CompareStatus, Status

from bfasst.tool import Tool
from bfasst.utils import print_color


class CompareTool(Tool):
    """Base class for comparison tools"""

    success_status = Status(CompareStatus.SUCCESS)

    def __init__(self, cwd, flow_args="") -> None:
        super().__init__(cwd)

        # Implementation options
        parser = tool.ToolArgParser("compare")
        self.args = parser.parse_args(shlex.split(flow_args))

    # This method should run netlist comparison.  It should return
    # a status
    @abc.abstractmethod
    def compare_netlists(self, design):
        pass

    def print_running_compare(self):
        print_color(self.TERM_COLOR_STAGE, "Running comparison")

    def print_skipping_compare(self):
        print_color(self.TERM_COLOR_STAGE, "Comparison already run")
