"""Tool to inject errors into a netlist"""
from enum import Enum
from random import randrange, sample
import spydrnet as sdn
from bfasst.transform.base import TransformTool
from bfasst.status import Status, TransformStatus
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.vendor_utils.xilinx import get_unisim_cell_inputs_and_outputs


class ErrorType(Enum):
    """Types of errors that can be injected"""

    BIT_FLIP = "BIT_FLIP"
    WIRE_SWAP = "WIRE_SWAP"


class ErrorInjector(TransformTool):
    """Tool to inject errors into a netlist"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "error_injection"

    def __init__(self, cwd, design) -> None:
        super().__init__(cwd, design)
        self.clean_netlist = sdn.parse(self.design.reversed_netlist_path)
        self.hierarchical_luts = []
        self.all_luts = None
        self.all_instances = self.get_all_instances()
        self.run_num = 1
        self.old_lut_init = None
        self.new_lut_init = None

    def get_all_instances(self):
        """Get all the instances in the netlist, sorted by their name"""
        unsorted_instances = [
            instance
            for instance in self.clean_netlist.get_instances()
            if "GND" not in instance.reference.name.upper()
            and "VCC" not in instance.reference.name.upper()
            and "VDD" not in instance.reference.name.upper()
        ]

        return sorted(unsorted_instances, key=lambda x: x.name)

    def inject(self, error_type):
        """Injects an error into the netlist of the given type"""
        if error_type == ErrorType.BIT_FLIP:
            self.inject_bit_flip()
        elif error_type == ErrorType.WIRE_SWAP:
            self.inject_wire_swap()
        else:
            return Status(TransformStatus.ERROR, "Invalid error type")
        return Status(TransformStatus.SUCCESS)

    def inject_bit_flip(self):
        """Injects a bit flip error into the netlist"""
        num_luts = self.pick_luts_from_netlist()
        self.get_all_luts()
        self.sort_all_luts()
        lut_number = randrange(num_luts)
        lut_size = self.get_lut_init_size(lut_number)
        bit_number = randrange(lut_size)
        self.flip_bit(lut_number, bit_number)
        self.compose_corrupt_netlist()
        self.log_bit_flip(lut_number, bit_number)

    def pick_luts_from_netlist(self):
        """Calculates the number of LUTs in the netlist"""
        num_luts = 0
        for library in self.clean_netlist.libraries:
            for definition in library.definitions:
                if "LUT" in definition.name.upper():
                    num_luts += len(definition.references)
                    self.hierarchical_luts.append(definition.references)
        return num_luts

    def get_all_luts(self):
        """Flattens the LUTs into a single list"""
        self.all_luts = [lut for sublist in self.hierarchical_luts for lut in sublist]

    def sort_all_luts(self):
        """Sorts all luts by their instance name"""
        self.all_luts.sort(key=lambda x: x.name)

    def get_lut_init_size(self, lut_number):
        """
        Gets the size of the LUT init string for the given LUT by reading the init string.
        The init string is "X'h####" where X is the size of the LUT init string in bits.
        X is always 2^n where n is the number of inputs to the LUT.
        For example, a LUT5 would have an init string of "32'h####"
        and this function would return 32 as the size.
        """
        lut = self.all_luts[lut_number]
        init_string = lut.data["VERILOG.Parameters"]["INIT"].upper()
        return int(init_string.split("'")[0])

    def flip_bit(self, lut_number, bit_number):
        """Flips the bit at the given index"""
        lut = self.all_luts[lut_number]
        lut_properties = lut.data["VERILOG.Parameters"]

        config_string_prefixed = lut_properties["INIT"].lower()  # must be lower for int conversion
        self.old_lut_init = config_string_prefixed
        config_string_int = convert_verilog_literal_to_int(config_string_prefixed)

        config_with_flipped_bit = config_string_int ^ (1 << bit_number)

        # Convert the config to hex and pad it with zeros to the size of the LUT init string
        config_as_hex = hex(config_with_flipped_bit)
        new_config = self.pad_hex_val(
            config_as_hex,
            self.get_lut_init_size(lut_number)
        )

        lut_properties["INIT"] = (
            config_string_prefixed.split("h")[0] + "h" + str(new_config)[2:]
        )
        self.new_lut_init = lut_properties["INIT"]

    def pad_hex_val(self, val, lut_size):
        """
        Takes a hex value, and pads it with zeros to
        the size of the LUT init string passed in.
        """
        padding = lut_size // 4
        return '0x' + val[2:].zfill(padding)

    def compose_corrupt_netlist(self):
        """Writes the netlist to the corrupted netlist path in the design"""
        sdn.compose(self.clean_netlist, self.design.corrupted_netlist_path)

    def log_bit_flip(self, lut_number, bit_number):
        """Logs the bit flip that occurred to a log file"""
        log_path = self.get_bit_flip_log()
        with open(log_path, "w") as fp:
            lut_name = self.all_luts[lut_number].name
            lut_type = self.all_luts[lut_number].reference.name
            fp.write(f"LUT {lut_name} of type {lut_type} ")
            fp.write(f"had bit {bit_number} flipped ")
            fp.write(f"resulting in a change from {self.old_lut_init} to {self.new_lut_init}")
            fp.write("\n")

    def get_bit_flip_log(self):
        return self.work_dir / f"bit_flip_log_{self.run_num}.log"

    def inject_wire_swap(self):
        """Injects a wire swap error into the netlist"""

        # Pick two random instances
        two_instances = self.get_random_instances(2)
        # Get the outer pins of the first instance that are inputs
        first_instance_pins = self.get_outer_pin_inputs(two_instances[0])
        # Get the outer pins of the second instance that are inputs
        second_instance_pins = self.get_outer_pin_inputs(two_instances[1])

        # Pick a random input from the first instance
        selected_input = first_instance_pins[randrange(len(first_instance_pins))]
        # Get the source of the input
        driving_pin = self.get_source(selected_input)
        # Do the same for the second instance
        selected_input2 = second_instance_pins[randrange(len(second_instance_pins))]
        driving_pin2 = self.get_source(selected_input2)

        # If the driving pin is the same for both inputs
        # or is a None type, we can't swap them.
        # Try the algorithm again.
        if driving_pin == driving_pin2 or driving_pin is None or driving_pin2 is None:
            self.inject_wire_swap()
            return

        # Detach the wire from both inputs, and swap their driving pins
        self.detach_wire(selected_input)
        self.detach_wire(selected_input2)
        self.attach_wire(selected_input, driving_pin2)
        self.attach_wire(selected_input2, driving_pin)

        self.compose_corrupt_netlist()

        self.log_wire_swap(selected_input, selected_input2)

    def get_random_instances(self, num_instances):
        """Gets a sample of random instances from the netlist"""
        return sample(self.all_instances, num_instances)

    def get_outer_pin_inputs(self, instance):
        """Gets all the outer pins of the given instance that are inputs"""
        outer_pin_inputs = [pin for pin in instance.pins if pin.inner_pin.port.direction is sdn.IN]
        if not outer_pin_inputs:
            outer_pin_inputs = self.get_unisim_outer_pin_inputs(instance)

        return outer_pin_inputs

    def get_unisim_outer_pin_inputs(self, instance):
        """Collect all the pins for a UNISIM cell that are inputs"""

        cell_inputs = get_unisim_cell_inputs_and_outputs()

        outer_pin_inputs = []
        for name, inputs, _ in cell_inputs:
            if instance.reference.name in name:
                pins = list(instance.pins)
                for pin in pins:
                    if pin.inner_pin.port.name in inputs:
                        outer_pin_inputs.append(pin)

        return outer_pin_inputs

    def get_outer_pin_outputs(self, instance):
        """Gets all the outer pins of the given instance that are outputs"""
        outer_pin_outputs = [
            pin for pin in instance.pins if pin.inner_pin.port.direction is sdn.OUT
        ]
        if not outer_pin_outputs:
            outer_pin_outputs = self.get_unisim_outer_pin_outputs(instance)

        return outer_pin_outputs

    def get_unisim_outer_pin_outputs(self, instance):
        """Collect all the pins for a UNISIM cell that are outputs"""

        cell_outputs = get_unisim_cell_inputs_and_outputs()

        outer_pin_outputs = []
        for name, _, outputs in cell_outputs:
            if instance.reference.name in name:
                pins = list(instance.pins)
                for pin in pins:
                    if pin.inner_pin.port.name in outputs:
                        outer_pin_outputs.append(pin)

        return outer_pin_outputs

    def get_source(self, pin):
        """Gets the source pin of the given pin. The pin must be a sink pin."""
        for curr_pin in pin.wire.pins:
            if self.get_direction(curr_pin) is sdn.OUT:
                return curr_pin
        return None

    def get_direction(self, pin):
        """Gets the direction of the given pin"""
        if isinstance(pin, sdn.InnerPin):
            return pin.port.direction
        return self.get_unisim_pin_direction(pin)

    def get_unisim_pin_direction(self, pin):
        """Gets the direction of the given outer pin"""
        cell_directions = get_unisim_cell_inputs_and_outputs()

        for name, _, outputs in cell_directions:
            if pin.instance.reference.name in name:
                if pin.inner_pin.port.name in outputs:
                    return sdn.OUT

        return sdn.IN

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

    def log_wire_swap(self, selected_input, selected_input2):
        """Logs the wire swap to the log file"""
        log_path = self.get_wire_swap_log()
        with open(log_path, "w") as fp:
            fp.write(f"Wire swap of {selected_input.wire.cable.name} ")
            fp.write(f"and {selected_input2.wire.cable.name} ")
            fp.write("was successful.\n")

    def get_wire_swap_log(self):
        return self.work_dir / f"wire_swap_log_{self.run_num}.log"
    