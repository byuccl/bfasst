"""Run synplify synthesis"""

from bfasst.tools_legacy.opt.ic2_synplify import Ic2SynplifyOptTool
from bfasst.tools_legacy.synth.ic2_base import Ic2BaseSynthesisTool


class Ic2SynplifySynthesisTool(Ic2BaseSynthesisTool):
    """Synplify synthesis tool"""

    def get_tool(self):
        return Ic2SynplifyOptTool(self.cwd, self.design)
