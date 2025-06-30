import argparse
import logging
import pathlib

import boolean

import spydrnet as sdn
from bfasst.utils.general import convert_verilog_literal_to_int, properties_are_equal
from bfasst.utils.sdn_helpers import SdnInstanceWrapper, SdnNetlistWrapper

from bfasst import jpype_jvm

jpype_jvm.start()
from com.xilinx.rapidwright.design.tools import LUTTools


# from gmt_tools.sop_eqn import SopEqn


class NetlistPhysToLogical:
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
        self.top = netlist_ir.top_instance

        for library in netlist_ir.get_libraries():
            if library.name == "hdi_primitives":
                self.library_hdi_primitives = library

        # Get or create contsant nets (used by constant generator LUTs)
        netlist_wrapper = SdnNetlistWrapper(self.top)
        self.const0 = netlist_wrapper.get_const_wire(is_gnd=True)
        self.const1 = netlist_wrapper.get_const_wire(is_gnd=False)

        # Next split all LUT6_2s into logical LUTs
        netlist_wrapper = SdnNetlistWrapper(self.top)
        for instance_wrapper in netlist_wrapper.instances:
            assert isinstance(instance_wrapper, SdnInstanceWrapper)
            if instance_wrapper.instance.reference.name != "LUT6_2":
                continue

            logging.info("=" * 80)
            logging.info("Creating logical LUT(s) for LUT6_2 instance: %s", instance_wrapper.name)
            o6_pin_wrapper = instance_wrapper.get_pin("O6")
            o6_wire = o6_pin_wrapper.pin.wire
            assert o6_wire
            o6_net = netlist_wrapper.wire_to_net[o6_wire]
            assert o6_net
            o6_net_connected = o6_net.is_connected

            o5_pin_wrapper = instance_wrapper.get_pin("O5")
            o5_wire = o5_pin_wrapper.pin.wire
            assert o5_wire
            o5_net = netlist_wrapper.wire_to_net[o5_wire]
            assert o5_net
            o5_net_connected = o5_net.is_connected

            assert o6_net_connected or o5_net_connected

            # Get equation for LUT outputs
            eqn = LUTTools.getLUTEquation(instance_wrapper.properties["INIT"])[2:].replace("!", "~")
            eqn = boolean.BooleanAlgebra().parse(eqn)

            if  o5_net_connected:
                # 05 output uses only half the equation, so perform the substitution and simplification
                o5_eqn = eqn.subs({boolean.Symbol("I5"): eqn.FALSE}).simplify()
                self.create_new_lut(
                    netlist_wrapper,
                    o5_eqn,
                    instance_wrapper,
                    name=instance_wrapper.name + "O5",
                    output_pin="O5",
                )

            if o6_net_connected:
                if o5_net_connected:
                    # 06 output when O5 is also present uses only half the equation, 
                    # so perform the substitution and simplification
                    o6_eqn = eqn.subs({boolean.Symbol("I5"): eqn.TRUE}).simplify()
                    self.create_new_lut(
                        netlist_wrapper,
                        o6_eqn,
                        instance_wrapper,
                        name=instance_wrapper.name + "O6",
                        output_pin="O6",
                    )

                else:
                    # O6 is connected, but O5 is not. 
                    name = instance_wrapper.name
                    instance_wrapper.instance.name = instance_wrapper.instance.name + ".OLD"
                    self.create_new_lut(
                        netlist_wrapper, eqn, instance_wrapper, name=name, output_pin="O6"
                    )

            logging.info("Removing instance: %s", instance_wrapper.name)
            self.top.reference.remove_child(instance_wrapper.instance)

        # Write out netlist
        sdn.compose(netlist_ir, self.netlist_out, write_blackbox=False)

    def replace_lut_with_constant(self, old_pin_wrapper, is_gnd):
        """Replace a LUT with a constant generator"""

        logging.info(" Creating constant-%d generator", 0 if is_gnd else 1)

        assert old_pin_wrapper

        wire = old_pin_wrapper.pin.wire
        assert wire

        # Collect pin to disconnect from old wire
        pins_to_remove = []
        for pin in wire.pins:
            if pin == old_pin_wrapper.pin:
                continue
            pins_to_remove.append(pin)

        # Disconnect and replace with constant
        for pin in pins_to_remove:
            logging.info(
                "  Disconnecting wire %s from %s.%s[%d]",
                pin.wire.cable.name,
                pin.instance.name,
                pin.inner_pin.port.name,
                pin.inner_pin.port.pins.index(pin.inner_pin),
            )
            wire.disconnect_pin(pin)

            logging.info(
                r"  Connecting \<const%d> to %s.%s[%d]",
                0 if is_gnd else 1,
                pin.instance.name,
                pin.inner_pin.port.name,
                pin.inner_pin.port.pins.index(pin.inner_pin),
            )
            if is_gnd:
                self.const0.connect_pin(pin)
            else:
                self.const1.connect_pin(pin)

    def remove_lut_routethru(self, input_pin_wrapper, output_pin_wrapper):
        """Remove a LUT routethru by connecting the input wire to the output wire"""

        logging.info("  LUT routethru detected.  LUT can be removed and wiring fixed.")

        output_wire = output_pin_wrapper.pin.wire
        input_wire = input_pin_wrapper.pin.wire

        # Loop through all pins this wire drives, and drive them by the
        # input wire instead
        pins_to_remove = []
        for pin in output_wire.pins:
            if pin == output_pin_wrapper.pin:
                continue
            pins_to_remove.append(pin)

        for pin in pins_to_remove:
            logging.info(
                "  Disconnecting wire %s from %s.%s[%d]",
                output_wire.cable.name,
                pin.instance.name,
                pin.inner_pin.port.name,
                pin.inner_pin.port.pins.index(pin.inner_pin),
            )
            output_wire.disconnect_pin(pin)

            logging.info(
                "  Connecting wire %s to %s.%s[%d]",
                input_wire.cable.name,
                pin.instance.name,
                pin.inner_pin.port.name,
                pin.inner_pin.port.pins.index(pin.inner_pin),
            )
            input_wire.connect_pin(pin)

    def create_new_lut(self, netlist_wrapper, eqn, old_instance_wrapper, name, output_pin):
        """Create a new logical LUT given the old physical LUT instance wrapper and a new name"""

        assert isinstance(old_instance_wrapper, SdnInstanceWrapper)
        logging.info("Creating new LUT %s", name)

        old_output_pin_wrapper = old_instance_wrapper.get_pin(output_pin)

        logging.info("  equation: %s", eqn)

        # Replace constant inputs in equation
        inputs = eqn.symbols
        for lut_input in inputs:
            old_pin_wrapper = old_instance_wrapper.get_pin(str(lut_input))
            assert old_pin_wrapper.net, old_pin_wrapper.name

            if old_pin_wrapper.net.is_vdd:
                eqn = eqn.subs({lut_input: eqn.TRUE}).simplify()
            elif old_pin_wrapper.net.is_gnd:
                eqn = eqn.subs({lut_input: eqn.FALSE}).simplify()
        logging.info("  equation after constant inputs: %s", eqn)

        # If constant generator, handle and exit out here
        if eqn == eqn.FALSE:
            self.replace_lut_with_constant(old_output_pin_wrapper, is_gnd=True)
            return
        elif eqn == eqn.TRUE:
            self.replace_lut_with_constant(old_output_pin_wrapper, is_gnd=False)
            return

        num_inputs = len(eqn.symbols)
        assert num_inputs >= 1

        # Handle buffer equation (LUT routethru)
        # These are cases where the logic equation would be something like "I3" (not "~I3")
        if num_inputs == 1 and str(eqn).startswith("I"):
            self.remove_lut_routethru(
                input_pin_wrapper=old_instance_wrapper.get_pin(str(eqn)),
                output_pin_wrapper=old_output_pin_wrapper,
            )
            return

        try:
            defn = next(
                d for d in self.library_hdi_primitives.definitions if d.name == "LUT%d" % num_inputs
            )
        except StopIteration:
            defn = self.library_hdi_primitives.create_definition(name="LUT%d" % num_inputs)
            for i in range(num_inputs):
                defn.create_port(name=f"I{i}", direction=sdn.IN, pins=1)
            defn.create_port(name="O", direction=sdn.OUT, pins=1)
        logging.info("  New LUT will be created using definition %s", defn.name)

        # Establish mapping from physical to logical inputs
        mapping = {}
        logical_idx = 0
        for symbol in eqn.symbols:
            mapping[symbol] = boolean.Symbol("I%d" % logical_idx)
            logical_idx += 1
        logging.info(
            "  physical to logical mapping: %s", {str(k): str(v) for k, v in mapping.items()}
        )
        eqn = eqn.subs(mapping).simplify()
        logging.info("  equation after mapping: %s", eqn)

        # Create INIT string for logical LUT
        eqn = str(eqn)
        eqn = eqn.replace("~", "!")
        eqn = eqn.replace("|", "+")
        eqn = "O=" + eqn
        init = str(LUTTools.getLUTInitFromEquation(eqn, num_inputs))
        logging.info("  INIT: %s", init)

        # Create new LUT instance
        instance = self.top.reference.create_child(
            name, reference=defn, properties={"VERILOG.Parameters": {"INIT": init}}
        )
        instance_wrapper = SdnInstanceWrapper(instance, netlist_wrapper)
        netlist_wrapper.instances.append(instance_wrapper)

        # Wire up the inputs
        for physical, logical in mapping.items():
            logging.info("  Wiring %s to %s", logical, physical)
            old_pin_wrapper = old_instance_wrapper.get_pin(str(physical))
            new_pin_wrapper = instance_wrapper.get_pin(str(logical))
            wire_driver = old_pin_wrapper.pin.wire
            logging.info(
                "  Connecting %s to %s.%s",
                wire_driver.cable.name,
                instance_wrapper.name,
                new_pin_wrapper.name,
            )
            wire_driver.connect_pin(new_pin_wrapper.pin)

        # Wire up the output
        new_pin_wrapper = instance_wrapper.get_pin("O")
        assert new_pin_wrapper.pin.inner_pin.port.name == "O"
        wire_driver = old_output_pin_wrapper.pin.wire
        logging.info(
            "  Connecting %s to %s.%s",
            wire_driver.cable.name,
            instance_wrapper.name,
            new_pin_wrapper.name,
        )
        wire_driver.connect_pin(new_pin_wrapper.pin)

        return instance


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_path", type=pathlib.Path, help="Path to build directory")
    parser.add_argument("netlist_in", type=pathlib.Path, help="Path to input netlist")
    parser.add_argument("netlist_out", type=pathlib.Path, help="Path to output netlist")
    args = parser.parse_args()

    netlist_cleaner = NetlistPhysToLogical(args.build_path, args.netlist_in, args.netlist_out)
