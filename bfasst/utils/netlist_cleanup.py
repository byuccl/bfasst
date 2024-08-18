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

    def __init__(self, build_path, netlist_in_path, netlist_out_path, logging_level=logging.DEBUG):
        self.build_path = build_path
        self.netlist_in = netlist_in_path
        self.netlist_out = netlist_out_path
        self.logging_level = logging_level

        self.log_path = self.build_path / "log.txt"
        self.log_path.unlink(missing_ok=True)

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

    def remove_assign_instances(self, top):
        """Remove all ASSIGN instances"""
        logging.info("Finding and removing all ASSIGN instances")
        t_begin = time.perf_counter()
        for instance in top.get_instances():
            if instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT"):
                pin_out = None

                for pin in instance.pins:
                    if pin.inner_pin.port.name == "i":
                        pass
                    else:
                        pin_out = pin

                for pin in pin_out.wire.pins:
                    if pin == pin_out:
                        continue
                    raise NotImplementedError
                top.reference.remove_child(instance)
        logging.info("Total time to remove ASSIGN instances: %s", time.perf_counter() - t_begin)

    def remove_unused_instances(self, top):
        """Remove unused instances"""
        logging.info("Removing unused instances")
        unused_instance_types = {"LUT6_2": ("O5", "O6"), "IBUF": ("O",)}
        netlist_wrapper = SdnNetlistWrapper(top)
        t_begin = time.perf_counter()
        for instance_type, pin_names in unused_instance_types.items():
            for instance_wrapper in [
                instance_wrapper
                for instance_wrapper in netlist_wrapper.instances
                if instance_wrapper.instance.reference.name == instance_type
            ]:

                connected_pins = (
                    netlist_wrapper.wire_to_net[
                        instance_wrapper.get_pin(pin_name).pin.wire
                    ].is_connected
                    for pin_name in pin_names
                )
                if not any(connected_pins):
                    top.reference.remove_child(instance_wrapper.instance)
        logging.info("Total time to remove unused instances: %s", time.perf_counter() - t_begin)

    def write_netlist(self, netlist_ir):
        logging.info("Writing out netlist")
        t_begin = time.perf_counter()
        sdn.compose(netlist_ir, self.netlist_out, write_blackbox=False)
        logging.info("Total time to write out netlist: %s", time.perf_counter() - t_begin)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_path", type=pathlib.Path, help="Path to build directory")
    parser.add_argument("netlist_in", type=pathlib.Path, help="Path to input netlist")
    parser.add_argument("netlist_out", type=pathlib.Path, help="Path to output netlist")
    args = parser.parse_args()

    netlist_cleaner = NetlistCleaner(args.build_path, args.netlist_in, args.netlist_out)
