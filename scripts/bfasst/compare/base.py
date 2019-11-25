import abc

import bfasst

from bfasst.flow import Tool

class CompareTool(Tool):
    # This method should run netlist comparison.  It should return
    # a status
    @abc.abstractmethod
    def compare_netlists(self, design):
        pass
