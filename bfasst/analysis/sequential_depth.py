from collections import defaultdict
from matplotlib import pyplot as plt
import numpy as np
import spydrnet as sdn

from bfasst.utils import sdn_helpers
from .base import AnalysisTool


class SequentialDepthAnalysis(AnalysisTool):
    TOOL_WORK_DIR = "analysis/logic_depth"

    def run_analysis(self):
        """Run sequential depth analysis"""

        netlist_path = self.design.reversed_netlist_path

        assert netlist_path.is_file()
        netlist_ir = sdn.parse(str(netlist_path))

        library = netlist_ir.libraries[0]
        netlist = sdn_helpers.Netlist(library)

        netlist.print_stats()
        netlist.trim_dead_instances()
        netlist.print_stats()

        self.log_path = self.work_dir / "log_min_depth.txt"
        self.remove_logs()
        instance_depths = self.calculate_depths(netlist, max_not_min=False)
        self.plot_histogram(instance_depths, "depths_min.png")

        self.log_path = self.work_dir / "log_max_depth.txt"
        self.remove_logs()
        instance_depths = self.calculate_depths(netlist, max_not_min=True)
        self.plot_histogram(instance_depths, "depths_max.png")

    def calculate_depths(self, netlist, max_not_min):
        instance_depth = {}
        instances_to_visit = []
        dependencies = defaultdict(set)

        # Initialize instances connected to inputs
        self.log_title("Initializing instances connected to inputs")
        for input_pin in [
            p
            for p in netlist.library.get_pins()
            if isinstance(p, sdn.InnerPin) and p.port.direction == sdn.IN
        ]:
            self.log("Input pin:", input_pin.port.name)

            net = netlist.wire_to_net[input_pin.wire]
            assert isinstance(net, sdn_helpers.Net)

            # Loop through all output pins for this net
            for pin in [p for p in net.all_pins() if p != input_pin]:
                assert pin.instance.reference.name == "IBUF"

                instance_sdn = pin.instance
                instance = netlist.instance_wrappers[instance_sdn]

                instances_to_visit.append(instance)
                instance_depth[instance] = 0
                self.log(f"{instance.name} -> {instance_depth[instance]}")

                # self.log(f"{pin.instance.name} -> {instance_depth[pin.instance]}")

        while instances_to_visit:
            instance = instances_to_visit.pop(0)
            assert isinstance(instance, sdn_helpers.Instance)
            instance_sdn = instance.instance

            self.log("Visiting", instance_sdn.name, instance_sdn.reference.name)

            # Iterate through ouput pins
            for pin_out in instance_sdn.pins:
                # We only care about outputs of instances
                if isinstance(pin_out, sdn.InnerPin):
                    continue

                if (
                    sdn_helpers.Net.get_direction_for_unisim(
                        pin_out.instance.reference.name, pin_out.inner_pin.port.name
                    )
                    != sdn.OUT
                ):
                    continue

                # For each output pin, find all instances that it connects to
                net = netlist.wire_to_net[pin_out.wire]
                assert isinstance(net, sdn_helpers.Net)

                for pin in net.all_pins():
                    if pin == pin_out or isinstance(pin, sdn.InnerPin):
                        continue
                    next_instance_sdn = pin.instance
                    next_instance = netlist.instance_wrappers[next_instance_sdn]

                    if next_instance.is_assign():
                        continue

                    self.log(f"  {next_instance.name}")

                    # Check for feedback
                    if next_instance in dependencies[instance]:
                        self.log("    Feedback detected")
                        continue

                    # Add dependencies to track feedback
                    dependencies[next_instance].add(instance)
                    dependencies[next_instance].update(dependencies[instance])

                    # If this has already been visited, don't visit again,
                    # unless we are looking for max depth and the depth is going to increase
                    if next_instance in instance_depth and (
                        not max_not_min
                        or instance_depth[next_instance] >= instance_depth[instance] + 1
                    ):
                        continue

                    if next_instance.is_register():
                        instance_depth[next_instance] = instance_depth[instance] + 1
                    else:
                        instance_depth[next_instance] = instance_depth[instance]
                    instances_to_visit.append(next_instance)
                    self.log(f"    {next_instance.name} -> {instance_depth[next_instance]}")

        self.log_title("Instance depths:")
        for instance, depth in instance_depth.items():
            self.log(instance.name, depth)

        return instance_depth

    def plot_histogram(self, instance_depth, filename):
        """Create histogram of depths"""
        depths = [depth for depth in instance_depth.values()]

        labels, counts = np.unique(depths, return_counts=True)
        plt.bar(labels, counts, align="center")
        plt.gca().set_xticks(labels)
        plt.savefig(self.work_dir / filename)
        plt.close()
