import spydrnet as sdn

from bfasst.utils import sdn_helpers
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
        netlist = sdn_helpers.Netlist(library)

        cell_depth = {}
        cells_to_visit = []

        # Initialize instances connected to inputs
        for input_pin in [
            p
            for p in netlist.library.get_pins()
            if isinstance(p, sdn.InnerPin) and p.port.direction == sdn.IN
        ]:
            print(input_pin)

            net = netlist.wire_to_net[input_pin.wire]
            assert isinstance(net, sdn_helpers.Net)

            for pin in net.all_pins():
                if pin == input_pin:
                    continue
                print("  ", pin)
                cell_depth[pin.instance] = 0
                print(f"{pin.instance.name} -> {cell_depth[pin.instance]}")
                cells_to_visit.append(pin.instance)

        while cells_to_visit:
            cell = cells_to_visit.pop(0)
            print("Visiting", cell.name, cell.reference.name)

            # Iterate through ouput pins
            for p in cell.get_pins():
                # We only care about outputs of instances
                if isinstance(p, sdn.InnerPin):
                    continue

                if (
                    sdn_helpers.Net.get_direction_for_unisim(
                        p.instance.reference.name, p.inner_pin.port.name
                    )
                    != sdn.OUT
                ):
                    continue

                print("  ", p.inner_pin.port.name)
