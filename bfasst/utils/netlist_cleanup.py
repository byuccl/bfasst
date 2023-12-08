""" Clean up a netlist 
(tested primarily on post-fasm2bels netlists)
"""
import argparse
import logging
import pathlib

import spydrnet as sdn

from bfasst.utils.sdn_helpers import SdnNetlistWrapper


class NetlistCleaner:
    """Clean a netlist."""

    def __init__(self, build_path, netlist_in_path, netlist_out_path):
        self.build_path = build_path
        self.netlist_in = netlist_in_path
        self.netlist_out = netlist_out_path

        self.log_path = self.build_path / "log.txt"
        self.log_path.unlink(missing_ok=True)

        logging.basicConfig(
            filename=self.log_path,
            format="%(asctime)s %(message)s",
            level=logging.DEBUG,
            datefmt="%Y-%m-%d %H:%M:%S",
        )

        # Read netlist with spydrnet
        netlist_ir = sdn.parse(self.netlist_in)
        top = netlist_ir.top_instance

        # Find all ASSIGN instances and remove them
        for instance in top.get_instances():
            if instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT"):
                for pin in instance.pins:
                    if pin.inner_pin.port.name == "i":
                        pass
                        # pin_in = pin
                        # logging.info("in: %s", pin_in.wire.cable.name)
                    else:
                        pin_out = pin
                        # logging.info("out: %s", pin_out.wire.cable.name)

                for pin in pin_out.wire.pins:
                    if pin == pin_out:
                        continue
                    raise NotImplementedError

                logging.info("Removing instance: %s", instance)
                top.reference.remove_child(instance)

        # Remove unused instances
        unused_instance_types = {"LUT6_2": ("O5", "O6"), "IBUF": ("O",)}
        netlist_wrapper = SdnNetlistWrapper(top)

        for instance_type, pin_names in unused_instance_types.items():
            for instance_wrapper in netlist_wrapper.instances:
                if instance_wrapper.instance.reference.name != instance_type:
                    continue
                logging.info("Processing %s %s", instance_type, instance_wrapper.name)

                connected_pins = (
                    netlist_wrapper.wire_to_net.get(
                        instance_wrapper.get_pin(pin_name).pin.wire
                    ).is_connected
                    for pin_name in pin_names
                    if (pin_name, 0) in instance_wrapper.pins_by_name_and_index and instance_wrapper.get_pin(pin_name).pin.wire is not None
                )
                if not any(connected_pins):
                    top.reference.remove_child(instance_wrapper.instance)

        # Write out netlist
        sdn.compose(netlist_ir, self.netlist_out, write_blackbox=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_path", type=pathlib.Path, help="Path to build directory")
    parser.add_argument("netlist_in", type=pathlib.Path, help="Path to input netlist")
    parser.add_argument("netlist_out", type=pathlib.Path, help="Path to output netlist")
    args = parser.parse_args()

    netlist_cleaner = NetlistCleaner(args.build_path, args.netlist_in, args.netlist_out)
