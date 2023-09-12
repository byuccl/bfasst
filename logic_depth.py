import spydrnet as sdn


def logic_depth(library):
    """Calculate the logic depth of a netlist"""
    # Get the top-level instance

    netlist = Netlist(library, None)

    # for i in netlist.get_instances():
    #     print(i)

    current_depth = 0

    for pin in [
        p for p in netlist.get_pins() if isinstance(p, sdn.InnerPin) and p.port.direction == sdn.IN
    ]:
        pass


class Netlist:
    """Wrapper class around spydernet top level library"""

    def __init__(self, library, tool) -> None:
        self.library = library
        self.tool = tool

        # Nets
        self.wire_to_net = {}
        self.build_nets()

        # Instances
        instances = [Instance(i, self) for i in library.get_instances()]
        # instances = [i for i in instances if i.cell_type not in ("VCC", "GND")]
        self.instances = instances

        self.instances_to_map = [i for i in self.instances if i.cell_type not in ("GND", "VCC")]

        # Top-level IO pins
        self.pins = [Pin(pin, None, self) for pin in library.get_pins()]

        self.pins_by_name_and_idx = {}
        for pin in self.pins:
            assert isinstance(pin, Pin)
            key = (pin.name, pin.index)
            assert key not in self.pins_by_name_and_idx
            self.pins_by_name_and_idx[key] = pin

    def get_pin(self, name, index):
        return self.pins_by_name_and_idx[(name, index)]

    def num_wires(self):
        return len(list(self.library.get_wires()))

    def build_nets(self):
        """Setup Net objects"""
        # First construct net objects for each wire, skipping alias wires
        non_alias_wires = [wire for wire in self.library.get_wires() if not Net.wire_is_alias(wire)]
        for wire in non_alias_wires:
            net = Net(wire, self.tool)
            self.tool.log(f"New Net for wire {wire.cable.name}[{wire.index()}]")
            self.wire_to_net[wire] = net

        # Now add alias wires iteratively until they are all added
        alias_wires = [wire for wire in self.library.get_wires() if Net.wire_is_alias(wire)]

        self.tool.log("Processing alias wires (derived from assign statements)")

        progress = True
        while alias_wires and progress:
            progress = False
            processed_alias_wires = []
            for wire in alias_wires:
                driver_wire = Net.wire_derived_from(wire)
                if driver_wire not in self.wire_to_net:
                    continue

                net = self.wire_to_net[driver_wire]
                self.tool.log(
                    f"Adding alias wire {wire.cable.name}[{wire.index()}]",
                    f"to net {net.name}[{net.wire.index()}]",
                )
                net.add_alias_wire(wire)
                self.wire_to_net[wire] = net
                processed_alias_wires.append(wire)

            # Remove wires we processed
            old_len = len(alias_wires)
            alias_wires = [wire for wire in alias_wires if wire not in processed_alias_wires]
            if len(alias_wires) != old_len:
                progress = True

        if alias_wires and not progress:
            self.tool.log("Failed to process all alias wires:", [w.cable.name for w in alias_wires])
            raise RuntimeError("Failed to process all alias wires")

        # Now determine the driver for each net
        for net in self.nets:
            net.find_driver()

    @property
    def nets(self):
        return set(self.wire_to_net.values())

    def get_connected_nets(self):
        """Return a list of nets that are connected to something"""
        return [net for net in self.nets if net.is_connected()]


class Pin:
    """Wrapper class around spydernet InnerPin/OuterPin to add some helper properties"""

    def __init__(self, pin, instance, netlist):
        self.pin = pin
        self.instance = instance
        self.netlist = netlist
        if isinstance(pin, sdn.OuterPin):
            self.name = self.pin.inner_pin.port.name
            self.index = self.pin.inner_pin.port.pins.index(self.pin.inner_pin)
            self.ignore_net_equivalency = self._ignore_net_equivalency(instance)
        else:
            self.name = self.pin.port.name
            self.index = self.pin.port.pins.index(self.pin)
            self.ignore_net_equivalency = False

    def _ignore_net_equivalency(self, instance):
        """Determines whether the net equivalency should be ignored on this pin."""
        # Ignore net equivalency on constant LUT inputs
        # The logic function PROBABLY doesn't depend on this LUT input
        # TODO: Verify this by looking at the LUT INIT
        if instance.cell_type == "LUT6_2" and self.net and (self.net.is_vdd or self.net.is_gnd):
            return True
        return False

        # This didn't work unfortunately
        # if instance.cell_type == "LUT6_2":
        #     eqn = LUTTools.getLUTEquation(instance.properties["INIT"])
        #     print(instance.properties["INIT"])
        #     # print(eqn)
        #     return self.name not in eqn
        # return False

    @property
    def net(self):
        # print(self.instance.name, self.name, self.pin.wire)
        return self.netlist.wire_to_net.get(self.pin.wire)

    @property
    def name_with_index(self):
        return f"{self.name}[{self.index}]"


class Net:
    """Wrapper class around spydernet Wire to add some helper properties"""

    def __init__(self, wire, tool):
        self.wire = wire
        self.tool = tool
        self.alias_wires = []
        self.driver_pin = None
        self.is_vdd = None
        self.is_gnd = None

    def add_alias_wire(self, wire):
        assert wire not in self.alias_wires
        self.alias_wires.append(wire)

    def is_connected(self):
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
        return bool(pins_that_drive)

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
        if self.wire.cable.name == r"\<const0>":
            self.is_gnd = True
        elif self.wire.cable.name == r"\<const1>":
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
        if isinstance(pin, sdn.OuterPin) and self.driver_pin.instance.reference.name == "VDD":
            self.is_vdd = True
        else:
            self.is_vdd = False

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

    # @staticmethod
    # def get_assign_statement(wire):
    #     """Check if a wire is connected to an assign statement and return the pin"""

    #     return None

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


class Instance:
    """Wrapper class around spydernet Instance to add some helper properties"""

    def __init__(self, instance, netlist):
        self.instance = instance
        self.netlist = netlist

        self.pins = []
        self.pins_by_name_and_index = {}

        for pin_spydernet in self.instance.pins:
            pin = Pin(pin_spydernet, self, self.netlist)
            self.pins.append(pin)
            self.pins_by_name_and_index[
                (
                    pin_spydernet.inner_pin.port.name,
                    pin_spydernet.inner_pin.port.pins.index(pin_spydernet.inner_pin),
                )
            ] = pin

    @property
    def name(self):
        return self.instance.name

    @property
    def cell_type(self):
        return self.instance.reference.name

    @property
    def properties(self):
        return self.instance.data.get("VERILOG.Parameters")

    def get_pin(self, name, index):
        return self.pins_by_name_and_index[(name, index)]


if __name__ == "__main__":
    # Create a netlist from a Verilog file
    ir = sdn.parse(
        str(
            "/home/jgoeders/bfasst/build/xilinx_and_reversed/byu/accumulator/block1_c_accum_0_0_reversed.v"
        )
    )
    library = ir.libraries[0]

    # Calculate the logic depth of the netlist
    logic_depth(library)
