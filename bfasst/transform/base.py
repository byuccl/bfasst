""" This is use to perform some transformation on a design file(s)"""

from bfasst import tool
from bfasst.bfasst_exception import BfasstException


class TransformException(BfasstException):
    """Base class for all exceptions in the transform package"""


class TransformTool(tool.Tool):
    def __init__(self, cwd, design) -> None:
        super().__init__(cwd, design)

    def add_args(self):
        """Default arguments for all transform tools"""
