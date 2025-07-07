"""Base class for implementation tools"""

from bfasst.tools.tool import Tool


class ImplTool(Tool):
    """Base class for implementation tools"""

    def __init__(self, flow, design_path) -> None:
        super().__init__(flow, design_path)
        self.build_path = self.design_build_path / "impl"
