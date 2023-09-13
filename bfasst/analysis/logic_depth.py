import spydrnet as sdn

from bfasst.utils.sdn_helpers import Netlist
from .base import AnalysisTool


class LogicDepthAnalysis(AnalysisTool):
    TOOL_WORK_DIR = "analysis/logic_depth"
    pass

    def run_analysis(self):
        netlist_path = self.design.reversed_netlist_path

        assert netlist_path.is_file()
        ir = sdn.parse(
            str(
            "/home/jgoeders/bfasst/build/xilinx_and_reversed/byu/accumulator/block1_c_accum_0_0_reversed.v"
        )
        )

        library = ir.libraries[0]
        netlist = Netlist(library)

        current_depth = 0

        for pin in [
            p for p in netlist.library.get_pins() if isinstance(p, sdn.InnerPin) and p.port.direction == sdn.IN
        ]:
            print(pin)