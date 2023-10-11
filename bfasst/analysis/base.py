""" This is use to perform some transformation on a design file(s)"""

from bfasst import tool
from bfasst.tool import BfasstException


class AnalysisException(BfasstException):
    """Base class for all exceptions in the transform package"""


class AnalysisTool(tool.Tool):
    def __init__(self, cwd, design, flow_args="") -> None:
        super().__init__(cwd, design)
        self.flow_args = flow_args

    def launch(self):
        """Perform setup for the tool to begin running"""
        self.create_arg_parser("analysis", self.flow_args)

    def cleanup(self):
        """Perform cleanup after the tool has finished running"""
        self.arg_parser = None

    def add_args(self):
        """Default arguments for all transform tools"""
