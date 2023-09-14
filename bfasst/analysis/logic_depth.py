from matplotlib import pyplot as plt
import numpy as np
import spydrnet as sdn

from bfasst.utils import sdn_helpers
from .base import AnalysisTool


class LogicDepthAnalysis(AnalysisTool):
    TOOL_WORK_DIR = "analysis/logic_depth"

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

        instance_depth = {}
        instances_to_visit = []

        # Initialize instances connected to inputs
        self.log_title("Initializing instances connected to inputs")
        for input_pin in [
            p
            for p in netlist.library.get_pins()
            if isinstance(p, sdn.InnerPin) and p.port.direction == sdn.IN
        ]:
            self.log(input_pin.port.name)

            net = netlist.wire_to_net[input_pin.wire]
            assert isinstance(net, sdn_helpers.Net)

            for pin in net.all_pins():
                if pin == input_pin:
                    continue

                # Ignore clock going to flip-flops
                if pin.instance.reference.name.startswith("FD") and pin.inner_pin.port.name == "C":
                    self.log(f"  Ignoring clock connected to flip-flop {pin.instance.name}")
                    continue

                instance_depth[pin.instance] = 0
                self.log(f"{pin.instance.name} -> {instance_depth[pin.instance]}")
                instances_to_visit.append(pin.instance)

        self.log_title("Propagating depths")
        while instances_to_visit:
            instance = instances_to_visit.pop(0)
            self.log("Visiting", instance.name, instance.reference.name)

            # Iterate through ouput pins
            for p in instance.pins:
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

                # For each output pin, find all instances that it connects to
                net = netlist.wire_to_net[p.wire]
                assert isinstance(net, sdn_helpers.Net)

                for pin in net.all_pins():
                    if pin == p or isinstance(pin, sdn.InnerPin):
                        continue
                    next_instance = pin.instance
                    if next_instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT"):
                        continue

                    next_depth = instance_depth[instance]
                    if instance.reference.name.startswith("FD"):
                        next_depth += 1

                    if (
                        next_instance not in instance_depth
                        or instance_depth[next_instance] > next_depth
                    ):
                        instance_depth[next_instance] = next_depth
                        self.log(f"    {next_instance.name} -> {next_depth}")
                        instances_to_visit.append(next_instance)

        print("Instance depths:")
        for instance, depth in instance_depth.items():
            print(instance.name, depth)

        # Create histogram of depths
        depths = [depth for depth in instance_depth.values()]

        labels, counts = np.unique(depths, return_counts=True)
        plt.bar(labels, counts, align="center")
        plt.gca().set_xticks(labels)
        plt.savefig(self.work_dir / "histogram.png")
