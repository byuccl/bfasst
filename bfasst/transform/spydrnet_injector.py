"""Tool to inject errors into a netlist"""
import spydrnet as sdn
from bfasst.transform.base import TransformTool
from bfasst.status import Status, TransformStatus

class SpydrNetErrorInjector(TransformTool):
    """Tool to inject errors into a netlist"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "spydrnet_injector"

    def __init__(self, cwd, design) -> None:
        super().__init__(cwd, design)
        self.clean_netlist = sdn.parse(self.design.reversed_netlist_path)

    def inject(self, error_type):
        """Injects an error into the netlist of the given type"""
        if error_type == "BIT_FLIP":
            self.inject_bit_flip()
        elif error_type == "WIRE_SWAP":
            self.inject_wire_swap()
        else:
            return Status(TransformStatus.ERROR, "Invalid error type")

    def inject_bit_flip(self):
        """Injects a bit flip error into the netlist"""
        #get the number of luts in the netlist
        


    def inject_wire_swap(self):
        """Injects a wire swap error into the netlist"""
