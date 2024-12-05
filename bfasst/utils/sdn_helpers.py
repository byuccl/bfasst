"""Wrapper classes for SDN objects"""

import logging
import spydrnet as sdn
import bfasst.utils.rw_helpers as rw


class SdnNetlistWrapper:
    """Wrapper class around spydernet top level library"""

    GND_NAMES = set()
    VCC_NAMES = set()

    def __init__(self, top_instance) -> None:
        self.top = top_instance

        # Nets
        self.wire_to_net = {}

        self.build_nets()

        # Instances
        instances = [SdnInstanceWrapper(i, self) for i in top_instance.get_instances()]
        self.instances = instances

        SdnNetlistWrapper.GND_NAMES = {i.name for i in self.instances if i.cell_type == "GND"}
        SdnNetlistWrapper.VCC_NAMES = {i.name for i in self.instances if i.cell_type == "VCC"}

        # Top-level IO pins
        self.pins = [SdnPinWrapper(pin, None, self) for pin in top_instance.get_pins()]

        self.pins_by_name_and_idx = {}
        for pin in self.pins:
            assert isinstance(pin, SdnPinWrapper)
            key = (pin.name, pin.index)
            assert key not in self.pins_by_name_and_idx
            self.pins_by_name_and_idx[key] = pin

    def get_pin(self, name, index):
        return self.pins_by_name_and_idx[(name, index)]

    def num_wires(self):
        return len(list(self.top.get_wires()))

    def build_nets(self):
        """Setup Net objects"""
        # First construct net objects for each wire, skipping alias wires
        non_alias_wires = [wire for wire in self.top.get_wires() if not SdnNet.wire_is_alias(wire)]
        for wire in non_alias_wires:
            net = SdnNet(wire)
            # logging.info(f"New Net for wire {wire.cable.name}[{wire.index()}]")
            self.wire_to_net[wire] = net

        # Now add alias wires iteratively until they are all added
        alias_wires = [wire for wire in self.top.get_wires() if SdnNet.wire_is_alias(wire)]

        logging.info("Processing alias wires (derived from assign statements)")

        progress = True
        while alias_wires and progress:
            progress = False
            processed_alias_wires = []
            for wire in alias_wires:
                driver_wire = SdnNet.wire_derived_from(wire)
                if driver_wire not in self.wire_to_net:
                    continue

                net = self.wire_to_net[driver_wire]
                # logging.info(
                #     f"Adding alias wire {wire.cable.name}[{wire.index()}]",
                #     f"to net {net.name}[{net.wire.index()}]",
                # )
                net.add_alias_wire(wire)
                self.wire_to_net[wire] = net
                processed_alias_wires.append(wire)

            # Remove wires we processed
            old_len = len(alias_wires)
            alias_wires = [wire for wire in alias_wires if wire not in processed_alias_wires]
            if len(alias_wires) != old_len:
                progress = True

        if alias_wires and not progress:
            logging.info(
                "Failed to process all alias wires: %s",
                " ".join([w.cable.name for w in alias_wires]),
            )
            raise RuntimeError("Failed to process all alias wires")

        # Now determine the driver for each net
        for net in self.nets:
            net.find_driver()

        # Now determine whether they are connected
        for net in self.nets:
            net.determine_is_connected()

    def get_const_wire(self, is_gnd):
        """Get the const0 or const1 wire"""
        name = r"\<const1>" if not is_gnd else r"\<const0>"

        const = [wire for wire in self.top.get_wires() if wire.cable.name == name]
        if not const:
            # Create const0 wire
            const_cable = self.top.reference.create_cable(
                name=name, is_downto=True, is_scalar=True, lower_index=0, wires=1
            )
            const = const_cable.wires[0]
        else:
            const = const[0]
        return const

    @property
    def nets(self):
        return set(self.wire_to_net.values())

    def get_connected_nets(self):
        """Return a list of nets that are connected to something"""
        return [net for net in self.nets if net.is_connected]


class SdnPinWrapper:
    """Wrapper class around spydernet InnerPin/OuterPin to add some helper properties"""

    def __init__(self, pin, instance, netlist):
        self.pin = pin
        self.instance = instance
        self.netlist = netlist
        if isinstance(pin, sdn.OuterPin):
            self.name = self.pin.inner_pin.port.name
            self.index = self.pin.inner_pin.port.pins.index(self.pin.inner_pin)
            self.ignore_net_equivalency = False
        else:
            self.name = self.pin.port.name
            self.index = self.pin.port.pins.index(self.pin)
            self.ignore_net_equivalency = False

    def _ignore_net_equivalency(self):
        """Determines whether the net equivalency should be ignored on this pin."""
        # Ignore net equivalency on constant LUT inputs
        # The logic function PROBABLY doesn't depend on this LUT input
        # TODO: Verify this by looking at the LUT INIT
        # if instance.cell_type == "LUT6_2" and self.net and (self.net.is_vdd or self.net.is_gnd):
        #     return True
        return False

        # This didn't work unfortunately
        # if instance.cell_type == "LUT6_2":
        #     eqn = LUTTools.getLUTEquation(instance.properties["INIT"])
        #     logging.info(instance.properties["INIT"])
        #     # logging.info(eqn)
        #     return self.name not in eqn
        # return False

    @property
    def net(self):
        # logging.info("%s %s %s", self.instance.name, self.name, self.pin.wire)
        return self.netlist.wire_to_net.get(self.pin.wire)

    @property
    def name_with_index(self):
        return f"{self.name}[{self.index}]"


class SdnNet:
    """Wrapper class around spydernet Wire to add some helper properties"""

    def __init__(self, wire):
        self.wire = wire
        self.alias_wires = []
        self.driver_pin = None
        self.is_vdd = False
        self.is_gnd = False
        self.is_connected = None

    def add_alias_wire(self, wire):
        assert wire not in self.alias_wires
        self.alias_wires.append(wire)

    def determine_is_connected(self):
        """Determine if this net drives anything"""

        # Net needs a driver pin (except VDD/GND have implicit drivers)
        if not self.driver_pin and not self.is_vdd and not self.is_gnd:
            return False

        pins_that_drive = [
            p
            for wire in ([self.wire] + self.alias_wires)
            for p in wire.pins
            if p != self.driver_pin
            and (
                isinstance(p, sdn.InnerPin)
                or not p.instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT_1")
            )
        ]
        self.is_connected = bool(pins_that_drive)
        return self.is_connected

    def find_driver(self):
        """Determine the pin that drives this wire"""

        # If wire is not connected to any pins, just return
        if not self.wire.pins:
            return

        # Find the pin that drives this wire
        for pin in self.wire.pins:
            # If connected to top-level input
            if isinstance(pin, sdn.ir.InnerPin):
                if pin.port.direction == sdn.ir.Port.Direction.IN:
                    self.set_driver_pin(pin)
                    return
            else:
                pin_direction = self.get_direction_for_unisim(
                    pin.instance.reference.name, pin.inner_pin.port.name
                )
                if pin_direction == sdn.ir.Port.Direction.OUT:
                    self.set_driver_pin(pin)
                    return

        # Check for const0/const1 that may not have any driver
        if (
            self.wire.cable.name == r"\<const0>"
            or self.wire.cable.name in SdnNetlistWrapper.GND_NAMES
        ):
            self.is_gnd = True
        elif (
            self.wire.cable.name == r"\<const1>"
            or self.wire.cable.name in SdnNetlistWrapper.VCC_NAMES
        ):
            self.is_vdd = True

    def set_driver_pin(self, pin):
        """Set the driver pin"""
        assert self.driver_pin is None
        self.driver_pin = pin

        # Check for constant GND/VDD.  Top-level I/O will not be GND/VDD
        if isinstance(pin, sdn.OuterPin) and self.driver_pin.instance.reference.name == "GND":
            self.is_gnd = True
        else:
            self.is_gnd = False
        if isinstance(pin, sdn.OuterPin) and self.driver_pin.instance.reference.name in (
            "VDD",
            "VCC",
        ):
            self.is_vdd = True
        else:
            self.is_vdd = False

    def filter_connected_instances(self, cell_type):
        """Get the names of the instances connected to this pin. Filtered by cell_type"""
        pins = set(self.wire.pins)
        for i in self.alias_wires:
            pins = pins | set(i.pins)
        return {
            i.instance.name
            for i in pins
            if (type(i) != sdn.ir.InnerPin) and (i.instance.reference.name == cell_type)
        }

    @property
    def name(self):
        if len(self.wire.cable.wires) > 1:
            return f"{self.wire.cable.name}[{self.wire.index()}]"
        return self.wire.cable.name

    @staticmethod
    def get_direction_for_unisim(cell_type_name, port_name):
        """Get a pin direction for a UNISIM cell"""

        if cell_type_name.startswith("SDN_VERILOG_ASSIGNMENT"):
            if port_name == "i":
                return sdn.ir.Port.Direction.IN
            # Shouldn't be possible to get here.  The way the code is set up, this function
            # is never called on alias wires (wires driven by assign statement)
            assert False

        return rw.get_sdn_direction_for_unisim(cell_type_name, port_name)

    @staticmethod
    def wire_is_alias(wire):
        """Return whether wire is an alias of another wire (ie derived from assign statement)"""
        for pin in wire.pins:
            # assign statements don't have InnerPins
            if isinstance(pin, sdn.InnerPin):
                continue

            if (
                pin.instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT")
                and pin.inner_pin.port.name == "o"
            ):
                return True
        return False

    @staticmethod
    def wire_derived_from(wire):
        """If a wire is derived from another wire via assign statement, return the driver wire"""
        for pin in wire.pins:
            # assign statements don't have InnerPins
            if isinstance(pin, sdn.InnerPin):
                continue

            if (
                pin.instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT")
                and pin.inner_pin.port.name == "o"
            ):
                # Get the wire driving the assign statement
                if pin.inner_pin.port.name == list(pin.instance.pins)[0].inner_pin.port.name:
                    return list(pin.instance.pins)[1].wire
                return list(pin.instance.pins)[0].wire

        return None


class SdnInstanceWrapper:
    """Wrapper class around spydernet Instance to add some helper properties"""

    GND_PIN = None

    def __init__(self, instance, netlist):
        self.instance = instance
        self.netlist = netlist

        self.net_set = set()

        self.pins = []
        self.pins_by_name_and_index = {}

        for pin_spydernet in self.instance.pins:
            pin = SdnPinWrapper(pin_spydernet, self, self.netlist)
            if SdnInstanceWrapper.GND_PIN is None and pin.net is not None and pin.net.is_gnd:
                SdnInstanceWrapper.GND_PIN = pin
            self.pins.append(pin)
            self.pins_by_name_and_index[
                (
                    pin_spydernet.inner_pin.port.name,
                    pin_spydernet.inner_pin.port.pins.index(pin_spydernet.inner_pin),
                )
            ] = pin
        self.pins.sort(
            key=lambda p: (p.net.is_vdd if p.net is not None else False)
            or (p.net.is_gnd if p.net is not None else False)
        )

    def init_connectivity(self):
        """Initialize connectivity for this instance"""
        for pin in self.pins:
            if pin.net is not None:
                self.net_set.add(pin.net.name)

    @property
    def name(self):
        return self.instance.name

    @property
    def cell_type(self):
        return self.instance.reference.name

    @property
    def properties(self):
        return self.instance.data.get("VERILOG.Parameters")

    def get_pin(self, name, index=0):
        return self.pins_by_name_and_index.get((name, index), SdnInstanceWrapper.GND_PIN)
