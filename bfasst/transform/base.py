""" This is use to perform some transformation on a design file(s)"""

from bfasst import tool


class TransformTool(tool.Tool):
    def __init__(self, cwd) -> None:
        super().__init__(cwd)
