"""
Wrapper class for IC2 LSE Synthesis Tool.
"""

import bfasst
from bfasst.synth.ic2_base import Ic2BaseSynthesisTool


class Ic2LseSynthesisTool(Ic2BaseSynthesisTool):
    """
    Class to run IC2 LSE Synthesis Tool.
    """

    def get_tool(self):
        return bfasst.opt.ic2_lse.Ic2LseOptTool(self.cwd)
