""" Clean up a netlist 
(tested primarily on post-fasm2bels netlists)
"""

import argparse
import logging
import pathlib
import time

import spydrnet as sdn

from bfasst.utils.sdn_helpers import SdnNetlistWrapper


class NetlistCleaner:
    """Clean a netlist."""

    def __init__(self, build_path, netlist_in_path, netlist_out_path, logging_level):
        self.build_path = build_path
        self.netlist_in = netlist_in_path
        self.netlist_out = netlist_out_path
        self.logging_level = logging_level

        self.log_path = self.build_path / "log.txt"
        self.log_path.unlink(missing_ok=True)
        self.start_time = time.perf_counter()
        self.cleanup_time_log = self.build_path / "cleanup_time.txt"

        logging.basicConfig(
            filename=self.log_path,
            format="%(asctime)s %(message)s",
            level=self.logging_level,
            datefmt="%Y-%m-%d %H:%M:%S",
        )

        # Read netlist with spydrnet
        netlist_ir = sdn.parse(self.netlist_in)
        top = netlist_ir.top_instance
        self.remove_assign_instances(top)
        self.remove_unused_instances(top)
        self.write_netlist(netlist_ir)

    def valid_assign_instance(self, instance):
        """Check which instances are ASSIGN instances which need to be removed"""
        if not instance.reference.name.startswith("SD"):
            return False
        try:
            pin_out = next(pin for pin in instance.pins if pin.inner_pin.port.name != "i")
        except StopIteration:
            return False
        if len(pin_out.wire.pins) > 1:
            raise NotImplementedError("Multiple connections for ASSIGN instance not supported")
        return True

    def remove_assign_instances(self, top):
        """Remove all ASSIGN instances"""
        logging.info("Finding and removing all ASSIGN instances")
        t_begin = time.perf_counter()

        top_ref = top.reference

        instances_to_remove = {
            instance for instance in top.get_instances() if self.valid_assign_instance(instance)
        }

        top_ref.remove_children_from(instances_to_remove)

        logging.info("Total time to remove ASSIGN instances: %s", time.perf_counter() - t_begin)

    def remove_unused_instances(self, top):
        """Remove unused instances"""
        logging.info("Removing unused instances")
        unused_instance_types = {"LUT6_2": ("O5", "O6"), "IBUF": ("O",)}
        netlist_wrapper = SdnNetlistWrapper(top)

        wire_to_net = netlist_wrapper.wire_to_net
        instances = netlist_wrapper.instances

        t_begin = time.perf_counter()

        # Group instances by type so we don't have to iterate over instances multiple times
        instances_by_type = {}
        for instance in instances:
            inst_type = instance.instance.reference.name
            instances_by_type.setdefault(inst_type, []).append(instance)

        for instance_type, pin_names in unused_instance_types.items():
            for instance in instances_by_type.get(instance_type, []):
                if not any(
                    wire_to_net[instance.get_pin(pin_name).pin.wire].is_connected
                    for pin_name in pin_names
                ):
                    top.reference.remove_child(instance.instance)

        logging.info("Total time to remove unused instances: %s", time.perf_counter() - t_begin)

    def write_netlist(self, netlist_ir):
        logging.info("Writing out netlist")
        t_begin = time.perf_counter()
        sdn.compose(netlist_ir, self.netlist_out, write_blackbox=False)
        logging.info("Total time to write out netlist: %s", time.perf_counter() - t_begin)
        logging.info("Total time to clean netlist: %s", time.perf_counter() - self.start_time)
        with open(self.cleanup_time_log, "w") as f:
            f.write(f"{time.perf_counter() - self.start_time}\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_path", type=pathlib.Path, help="Path to build directory")
    parser.add_argument("netlist_in", type=pathlib.Path, help="Path to input netlist")
    parser.add_argument("netlist_out", type=pathlib.Path, help="Path to output netlist")
    parser.add_argument("--logging_level", help="Decides what levels of logs to display")
    args = parser.parse_args()

    netlist_cleaner = NetlistCleaner(
        args.build_path, args.netlist_in, args.netlist_out, args.logging_level
    )
