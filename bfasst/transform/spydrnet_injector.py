"""Tool to inject errors into a netlist"""
from random import randrange, sample
import spydrnet as sdn
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
        # Algorithm
        # 1. Choose three instances (random)
        three_instances = self.get_random_instances(3)
        # 2. Get all the outer pins with inward direction from the definition of the first instance
        first_instance_pins = self.get_outer_pin_inputs(three_instances[0])
        # 3. Pick a random input pin from the first instance
        selected_input = first_instance_pins[randrange(len(first_instance_pins))]
        # 5. If it is an input, get the source pin
        driving_pin = self.get_source(selected_input)
            # 5a. If the source pin is from instance 2, get the source pin from instance 3
        new_driver = self.get_new_driver(driving_pin, three_instances[1], three_instances[2])
            # 5b. Attach the correct source pin to the input pin
        self.detach_wire(selected_input)
        self.attach_wire(selected_input, new_driver)
        self.compose_corrupt_netlist()

    def get_random_instances(self, num_instances):
        """Gets a list of random instances from the netlist"""
        instances = [
            instance for instance in self.clean_netlist.get_instances()
            if "GND" not in instance.reference.name.upper()
            and "VCC" not in instance.reference.name.upper()
            and "VDD" not in instance.reference.name.upper()
        ]
        return sample(instances, num_instances)

    def get_outer_pin_inputs(self, instance):
        """Gets all the outer pins of the given instance that are inputs"""
        outer_pin_inputs = [
            pin for pin in instance.pins
            if pin.inner_pin.port.direction is sdn.IN
        ]
        if not outer_pin_inputs:
            outer_pin_inputs = self.get_unisim_outer_pin_inputs(instance)

        return outer_pin_inputs

    def get_unisim_outer_pin_inputs(self, instance):
        """Collect all the pins for a UNISIM cell that are inputs"""

        cell_inputs_and_outputs = (
            (("LUT6_2",), ("I0", "I1", "I2", "I3", "I4", "I5")),
            (("IBUF", "OBUF", "OBUFT"), ("I", "T")),
            (("GND",), ()),
            (("VCC",), ()),
            (("FDSE", "FDRE"), ("D", "CE", "R", "C", "S")),
            (("CARRY4",), ("CI", "CYINIT", "DI", "S")),
            (("BUFGCTRL",), ("CE0", "CE1", "I0", "I1", "IGNORE0", "IGNORE1", "S0", "S1")),
            (("MUXF7", "MUXF8"), ("I0", "I1", "S")),
        )

        outer_pin_inputs = []
        for name, inputs in cell_inputs_and_outputs:
            if instance.reference.name in name:
                pins = [pin for pin in instance.pins]
                for pin in pins:
                    if pin.inner_pin.port.name in inputs:
                        outer_pin_inputs.append(pin)

        return outer_pin_inputs

    def get_outer_pin_outputs(self, instance):
        """Gets all the outer pins of the given instance that are outputs"""
        outer_pin_outputs = [
            pin for pin in instance.pins
            if pin.inner_pin.port.direction is sdn.OUT
        ]
        if not outer_pin_outputs:
            outer_pin_outputs = self.get_unisim_outer_pin_outputs(instance)

        return outer_pin_outputs

    def get_unisim_outer_pin_outputs(self, instance):
        """Collect all the pins for a UNISIM cell that are outputs"""

        cell_inputs_and_outputs = (
            (("LUT6_2",), ("O5", "O6")),
            (("IBUF", "OBUF", "OBUFT"), ("O",)),
            (("GND",), ("G",)),
            (("VCC",), ("P",)),
            (("FDSE", "FDRE"), ("Q",)),
            (("CARRY4",), ("O", "CO")),
            (("BUFGCTRL",), ("O",)),
            (("MUXF7", "MUXF8"), ("O",)),
        )

        outer_pin_outputs = []
        for name, outputs in cell_inputs_and_outputs:
            if instance.reference.name in name:
                pins = [pin for pin in instance.pins]
                for pin in pins:
                    if pin.inner_pin.port.name in outputs:
                        outer_pin_outputs.append(pin)

        return outer_pin_outputs

    def get_source(self, pin):
        """Gets the source pin of the given pin. The pin must be a sink pin."""
        sources = [pin for pin in pin.wire.pins if pin.inner_pin.port.direction is sdn.OUT]
        if sources:
            return sources[0]

    def get_new_driver(self, driving_pin, instance_2, instance_3):
        """Gets the new driver for the given driving pin"""
        if driving_pin in instance_2.pins:
            return self.get_outer_pin_outputs(instance_3)[0]

        return self.get_outer_pin_outputs(instance_2)[0]

    def detach_wire(self, pin):
        """Detaches the wire from the given pin"""
        pin.wire.disconnect_pin(pin)

    def attach_wire(self, sink_pin, new_driver):
        """Attaches the given sink to the new_driver"""
        new_driver.wire.connect_pin(sink_pin)
