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

        netlist_wrapper = SdnNetlistWrapper(top)

        # Remove unused LUTs
        for instance_wrapper in netlist_wrapper.instances:
            if instance_wrapper.instance.reference.name != "LUT6_2":
                continue
            logging.info("Processing LUT %s", instance_wrapper.name)

            pin_o5_net = netlist_wrapper.wire_to_net[instance_wrapper.get_pin("O5").pin.wire]
            pin_o6_net = netlist_wrapper.wire_to_net[instance_wrapper.get_pin("O6").pin.wire]

            if not pin_o6_net.is_connected and not pin_o5_net.is_connected:
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
