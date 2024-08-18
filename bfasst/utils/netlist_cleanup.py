""" Clean up a netlist 
(tested primarily on post-fasm2bels netlists)
"""

import argparse
import logging
import pathlib
import time

import spydrnet as sdn

from bfasst.utils.sdn_helpers import SdnNetlistWrapper
from bfasst.utils.general import log_with_banner


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
        log_with_banner("Finding and removing all ASSIGN instances")
        t_begin = time.perf_counter()
        for instance in top.get_instances():
            if instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT"):
                pin_out = None

                for pin in instance.pins:
                    if pin.inner_pin.port.name == "i":
                        pass
                    else:
                        pin_out = pin

                assert pin_out is not None
                for pin in pin_out.wire.pins:
                    if pin == pin_out:
                        continue
                    raise NotImplementedError
                top.reference.remove_child(instance)

        t_end = time.perf_counter()
        log_with_banner(f"Total time to remove ASSIGN instances: {t_end - t_begin}")

        # Remove unused instances
        log_with_banner("Removing unused instances")
        t_begin = time.perf_counter()
        unused_instance_types = {"LUT6_2": ("O5", "O6"), "IBUF": ("O",)}
        netlist_wrapper = SdnNetlistWrapper(top)

        for instance_type, pin_names in unused_instance_types.items():
            for instance_wrapper in netlist_wrapper.instances:
                if instance_wrapper.instance.reference.name != instance_type:
                    continue

                connected_pins = (
                    netlist_wrapper.wire_to_net[
                        instance_wrapper.get_pin(pin_name).pin.wire
                    ].is_connected
                    for pin_name in pin_names
                )
                if not any(connected_pins):
                    top.reference.remove_child(instance_wrapper.instance)

        t_end = time.perf_counter()
        log_with_banner(f"Total time to remove unused instances: {t_end - t_begin}")

        # Write out netlist
        log_with_banner("Writing out netlist")
        t_begin = time.perf_counter()
    
        sdn.compose(netlist_ir, self.netlist_out, write_blackbox=False)
        
        t_end = time.perf_counter()
        log_with_banner(f"Total time to write out netlist: {t_end - t_begin}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_path", type=pathlib.Path, help="Path to build directory")
    parser.add_argument("netlist_in", type=pathlib.Path, help="Path to input netlist")
    parser.add_argument("netlist_out", type=pathlib.Path, help="Path to output netlist")
    args = parser.parse_args()

    netlist_cleaner = NetlistCleaner(args.build_path, args.netlist_in, args.netlist_out)
