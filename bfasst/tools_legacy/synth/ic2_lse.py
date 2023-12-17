"""
Wrapper class for IC2 LSE Synthesis Tool.
"""

import bfasst
from bfasst.tools_legacy.synth.ic2_base import Ic2BaseSynthesisTool


class Ic2LseSynthesisTool(Ic2BaseSynthesisTool):
    """
    Class to run IC2 LSE Synthesis Tool.
    """

    def get_tool(self):
        return bfasst.tools_legacy.opt.ic2_lse.Ic2LseOptTool(self.cwd, self.design)
