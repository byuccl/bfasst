"""Tool to inject errors into a netlist"""
from random import randrange, sample
import spydrnet as sdn
from spydrnet.util.selection import Selection
from bfasst.transform.base import TransformTool
from bfasst.status import Status, TransformStatus

class SpydrNetErrorInjector(TransformTool):
    """Tool to inject errors into a netlist"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "spydrnet_injector"

    def __init__(self, cwd, design) -> None:
        super().__init__(cwd, design)
        self.clean_netlist = sdn.parse(self.design.reversed_netlist_path)
        self.hierarchical_luts = []
        self.flattened_luts = None
        self.output_pins = []

    def inject(self, error_type):
        """Injects an error into the netlist of the given type"""
        if error_type == "BIT_FLIP":
            self.inject_bit_flip()
        elif error_type == "WIRE_SWAP":
            self.inject_wire_swap()
        else:
            return Status(TransformStatus.ERROR, "Invalid error type")
        return Status(TransformStatus.SUCCESS)

    def inject_bit_flip(self):
        """Injects a bit flip error into the netlist"""
        num_luts = self.pick_luts_from_netlist()
        self.flatten_luts()
        lut_number = randrange(num_luts)
        lut_size = self.get_lut_size(lut_number)
        bit_number = randrange(lut_size)
        self.flip_bit(lut_number, bit_number)
        self.compose_corrupt_netlist()

    def pick_luts_from_netlist(self):
        """Calculates the number of LUTs in the netlist"""
        num_luts = 0
        for library in self.clean_netlist.libraries:
            for definition in library.definitions:
                if "lut" in definition.name.lower():
                    num_luts += len(definition.references)
                    self.hierarchical_luts.append(definition.references)
        return num_luts

    def flatten_luts(self):
        """Flattens the LUTs into a single list"""
        self.flattened_luts = [lut for sublist in self.hierarchical_luts for lut in sublist]

    def get_lut_size(self, lut_number):
        """Gets the size of the LUT init string for the given LUT"""
        lut = self.flattened_luts[lut_number]
        init_string = lut.data["VERILOG.Parameters"]["INIT"].upper()
        return int(init_string.split("'")[0])

    def flip_bit(self, lut_number, bit_number):
        """Flips the bit at the given index"""
        lut = self.flattened_luts[lut_number]
        lut_properties = lut.data["VERILOG.Parameters"]

        config_string_prefixed = lut_properties["INIT"].upper()
        config_string_digits = config_string_prefixed.split("H")[1]
        lut_size = self.get_lut_size(lut_number)
        config_as_binary = bin(int(config_string_digits, 16))[2:].zfill(lut_size)

        if config_as_binary[bit_number] == "1":
            config_as_binary = (
                config_as_binary[:bit_number] +
                "0" + 
                config_as_binary[bit_number + 1:]
            )
        else:
            config_as_binary = (
                config_as_binary[:bit_number] +
                "1" + 
                config_as_binary[bit_number + 1:]
            )

        config_as_hex = hex(int(config_as_binary, 2))
        lut_properties["INIT"] = (
            config_string_prefixed.split("H")[0] +
            "h" +
            str(config_as_hex).upper()[2:]
        )

    def compose_corrupt_netlist(self):
        """Writes the netlist to the corrupted netlist path in the design"""
        sdn.compose(self.clean_netlist, self.design.corrupted_netlist_path)

    def inject_wire_swap(self):
        """Injects a wire swap error into the netlist"""

        #Algorithm
        # 1. Get all the output pins in the netlist that have a wire
        self.collect_input_pins()
        # 2. Pick 2 random output pins
        two_pins = sample(self.output_pins, 2)
        # 3. Get all of the inputs for the first output pin
        input_pins = self.get_sinks(two_pins[0])
        # 4. Pick a random input pin from the first output pin
        selected_input = input_pins[randrange(len(input_pins))]
        # 5. Disconnect the wire from that pin
        self.disconnect_wire(selected_input)
        # 6. Connect the second output pin to the input pin
        self.connect_wire(two_pins[1], selected_input)
        # 7. Compose the corrupted netlist
        self.compose_corrupt_netlist()

    def collect_output_pins(self):
        """Gets all the output pins in the netlist that have a wire"""
        for instance in self.clean_netlist.get_instances():
            for outgoing_pin in instance.get_pins(
                selection = Selection.OUTSIDE,
                filter = lambda x: x.inner_pin.port.direction is sdn.OUT
            ):
                if outgoing_pin.wire:
                    self.output_pins.append(outgoing_pin)

    def get_sinks(self, pin):
        """Gets all the sinks of the given source pin"""
        sinks = []
        for outer_pin in pin.wire.pins:
            if outer_pin.inner_pin.port.direction is sdn.IN:
                sinks.append(outer_pin)
        return sinks

    def disconnect_wire(self, pin):
        """Disconnects the wire from the given pin"""
        pin.wire.disconnect_pin(pin)

    def connect_wire(self, source, sink):
        """Connects the given pin to the given sink"""
        source.wire.connect_pin(sink)



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
            else:
                pin_direction = self.get_direction_for_unisim(
                    pin.instance.reference.name, pin.inner_pin.port.name
                )
                if pin_direction == sdn.ir.Port.Direction.OUT:
                    self.set_driver_pin(pin)

        # if self.driver_pin is None:
        #     print(self.name)
        # assert self.driver_pin is not None

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
        return self.wire.cable.name

    @staticmethod
    def get_direction_for_unisim(cell_type_name, port_name):
        """Get a pin direction for a UNISIM cell"""

        cell_inputs_and_outputs = (
            (("LUT6_2",), ("I0", "I1", "I2", "I3", "I4", "I5"), ("O5", "O6")),
            (("IBUF", "OBUF", "OBUFT"), ("I", "T"), ("O",)),
            (("GND",), (), ("G",)),
            (("VCC",), (), ("P",)),
            (("FDSE", "FDRE"), ("D", "CE", "R", "C", "S"), ("Q",)),
            (("CARRY4",), ("CI", "CYINIT", "DI", "S"), ("O", "CO")),
            (("BUFGCTRL",), ("CE0", "CE1", "I0", "I1", "IGNORE0", "IGNORE1", "S0", "S1"), ("O",)),
            (("MUXF7", "MUXF8"), ("I0", "I1", "S"), ("O",)),
        )

        for cell_types, inputs, outputs in cell_inputs_and_outputs:
            if cell_type_name in cell_types:
                if port_name in inputs:
                    return sdn.ir.Port.Direction.IN
                if port_name in outputs:
                    return sdn.ir.Port.Direction.OUT
                raise NotImplementedError(cell_type_name, port_name)

        if cell_type_name.startswith("SDN_VERILOG_ASSIGNMENT"):
            if port_name == "i":
                return sdn.ir.Port.Direction.IN
            # Shouldn't be possible to get here.  The way the code is set up, this function
            # is never called on alias wires (wires driven by assign statement)
            assert False

        raise NotImplementedError(cell_type_name, port_name)

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
