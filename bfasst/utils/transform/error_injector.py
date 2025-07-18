"""Inject errors into a xrev netlist"""

import logging
import random
from argparse import ArgumentParser
from enum import Enum
from pathlib import Path

import spydrnet as sdn

from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.rw_helpers import get_sdn_direction_for_unisim, get_unisim_inputs


class ErrorType(Enum):
    """Types of errors that can be injected"""

    BIT_FLIP = "BIT_FLIP"
    WIRE_SWAP = "WIRE_SWAP"


class ErrorInjectorException(Exception):
    """Exception for ErrorInjector"""


class ErrorInjector:
    """Inject errors into an xrev netlist"""

    # pylint: disable=too-many-positional-arguments
    def __init__(
        self, build_dir, log_path, seed, error_type, reversed_netlist, logging_level=logging.DEBUG
    ):
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / "error_injection"
        self.log_path = self.stage_dir / log_path
        self.logging_level = logging_level
        logging.basicConfig(
            filename=self.log_path,
            level=self.logging_level,
            format="%(asctime)s %(message)s",
            datefmt="%Y%m%d%H%M%S",
        )

        self.hierarchical_luts = []
        self.all_luts = []
        self.all_rams = []
        self.random_generator = random.Random(seed)
        self.corrupted_netlist_path = None
        self.old_lut_init = None
        self.new_lut_init = None

        self.clean_netlist = sdn.parse(reversed_netlist)
        self.corrupted_netlist_path = self.log_path.with_suffix(".v")

        self.all_instances = self.__get_all_instances()

        self.injector = self.__get_injection_function(ErrorType[error_type.upper()])
        self.injector()

    # pylint: enable=too-many-positional-arguments

    def __get_injection_function(self, error_type):
        """Injects an error into the netlist of the given type"""
        if error_type == ErrorType.BIT_FLIP:
            return self.inject_bit_flip
        if error_type == ErrorType.WIRE_SWAP:
            return self.inject_wire_swap
        raise ErrorInjectorException("Invalid error type")

    def __get_all_instances(self):
        """Get all the instances in the netlist, sorted by their name"""
        unsorted_instances = [
            instance
            for instance in self.clean_netlist.get_instances()
            if "GND" not in instance.reference.name.upper()
            and "VCC" not in instance.reference.name.upper()
            and "VDD" not in instance.reference.name.upper()
            and "IBUF" not in instance.reference.name.upper()
            and "OBUF" not in instance.reference.name.upper()
            and not instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT")
        ]

        return sorted(unsorted_instances, key=lambda x: x.name)

    def inject_bit_flip(self):
        """Injects a bit flip error into the netlist"""
        self.__pick_luts_from_netlist()
        num_luts = len(self.all_luts)
        prims = self.all_luts
        if not num_luts:
            self.__pick_rams_from_netlist()
            if not self.all_rams:
                logging.error("No LUTs eligible for bit flip")
                raise ErrorInjectorException("No LUTs eligible for bit flip")
            num_luts = len(self.all_rams)
            prims = self.all_rams

        lut_number = self.random_generator.randrange(num_luts)
        lut_size = self.__get_lut_init_size(prims[lut_number])
        bit_number = self.random_generator.randrange(lut_size)
        self.__flip_bit(prims[lut_number], bit_number)
        self.__compose_corrupt_netlist()
        self.__log_bit_flip(prims[lut_number], bit_number)

    def __pick_luts_from_netlist(self):
        """Gets LUTS from netlist"""
        for library in self.clean_netlist.libraries:
            for definition in library.definitions:
                if "LUT" in definition.name.upper():
                    for lut in definition.references:
                        init_string = lut.data["VERILOG.Parameters"]["INIT"]
                        init_val = int(init_string[4:], base=16)
                        if init_val:  # Avoid hanging luts in f2b netlist
                            self.all_luts.append(lut)
        self.all_luts.sort(key=lambda x: x.name)

    def __pick_rams_from_netlist(self):
        """Gets RAMs"""
        for library in self.clean_netlist.libraries:
            for definition in library.definitions:
                if "RAM" in definition.name.upper():
                    self.all_rams.extend(definition.references)
        self.all_rams.sort(key=lambda x: x.name)

    def __get_lut_init_size(self, lut):
        """
        Gets the size of the LUT init string for the given LUT by reading the init string.
        The init string is "X'h####" where X is the size of the LUT init string in bits.
        X is always 2^n where n is the number of inputs to the LUT.
        For example, a LUT5 would have an init string of "32'h####"
        and this function would return 32 as the size.
        """
        init_string = lut.data["VERILOG.Parameters"]["INIT"].upper()
        return int(init_string.split("'")[0])

    def __flip_bit(self, lut, bit_number):
        """Flips the bit at the given index"""
        init = lut.data["VERILOG.Parameters"]["INIT"]
        self.old_lut_init = init
        init_size = init.split("'")[0]
        corrupted_init = convert_verilog_literal_to_int(init) ^ (1 << bit_number)
        hex_str = f"{corrupted_init:0{int(init_size) // 4}X}"
        self.new_lut_init = f"{init_size}'h{hex_str}"
        lut.data["VERILOG.Parameters"]["INIT"] = self.new_lut_init

    def __compose_corrupt_netlist(self):
        """Writes the netlist to the corrupted netlist path in the design"""
        sdn.compose(self.clean_netlist, self.corrupted_netlist_path)

    def __log_bit_flip(self, lut, bit_number):
        """Logs the bit flip that occurred to a log file"""
        lut_name = lut.name
        lut_type = lut.reference.name
        logging.info(
            "LUT %s of type %s had bit %s flipped resulting in a change from %s to %s",
            lut_name,
            lut_type,
            bit_number,
            self.old_lut_init,
            self.new_lut_init,
        )

    def inject_wire_swap(self):
        """Injects a wire swap error into the netlist"""
        # Pick two random instances
        instances = [None, None]
        inputs = [None, None]
        drivers = [None, None]
        for i in (0, 1):
            while drivers[i] is None or (drivers[0] == drivers[1]):
                instances[i] = self.__get_random_instances(1)[0]
                instance_pins = self.__get_outer_pin_inputs(instances[i])
                inputs[i] = instance_pins[self.random_generator.randrange(len(instance_pins))]
                drivers[i] = self.__get_source(inputs[i])

        # Detach the wire from both inputs, and swap their driving pins
        self.__detach_wire(inputs[0])
        self.__detach_wire(inputs[1])
        self.__attach_wire(inputs[0], drivers[1])
        self.__attach_wire(inputs[1], drivers[0])

        self.__compose_corrupt_netlist()

        self.__log_wire_swap(inputs[0], inputs[1], instances)

    def __get_random_instances(self, num_instances):
        """Gets a sample of random instances from the netlist"""
        return self.random_generator.sample(self.all_instances, num_instances)

    def __get_outer_pin_inputs(self, instance):
        """Gets all the outer pins of the given instance that are inputs"""
        outer_pin_inputs = [pin for pin in instance.pins if pin.inner_pin.port.direction is sdn.IN]
        if not outer_pin_inputs:
            cell_inputs = get_unisim_inputs(instance.reference.name)
            pins = list(instance.pins)
            for pin in pins:
                if pin.inner_pin.port.name in cell_inputs:
                    outer_pin_inputs.append(pin)
        return outer_pin_inputs

    def __get_source(self, pin):
        """Gets the source pin of the given pin. The pin must be a sink pin."""
        # Check for const0/const1 that may not have any driver
        if pin.wire.cable.name == r"\<const0>":
            return None
        if pin.wire.cable.name == r"\<const1>":
            return None
        for conn in pin.wire.pins:
            # If connected to top-level input
            if (
                isinstance(conn, sdn.ir.InnerPin)
                and conn.port.direction == sdn.ir.Port.Direction.IN
            ):
                return conn

            pin_direction = self.get_direction_for_unisim(
                conn.instance.reference.name, conn.inner_pin.port.name
            )
            if pin_direction == sdn.ir.Port.Direction.OUT:
                return conn
        return None

    def get_direction_for_unisim(self, cell_type_name, port_name):
        """Get a pin direction for a UNISIM cell"""

        if cell_type_name.startswith("SDN_VERILOG_ASSIGNMENT"):
            if port_name == "i":
                return sdn.ir.Port.Direction.IN
            # Shouldn't be possible to get here.  The way the code is set up, this function
            # is never called on alias wires (wires driven by assign statement)
            assert False

        return get_sdn_direction_for_unisim(cell_type_name, port_name)

    def __detach_wire(self, pin):
        """Detaches the wire from the given pin"""
        pin.wire.disconnect_pin(pin)

    def __attach_wire(self, sink_pin, new_driver):
        """Attaches the given sink to the new_driver"""
        new_driver.wire.connect_pin(sink_pin)

    def __log_wire_swap(self, selected_input, selected_input2, two_instances):
        """Logs the wire swap to the log file"""
        if isinstance(selected_input, sdn.OuterPin):
            pin1 = selected_input.inner_pin.port.name
        else:
            pin1 = selected_input.port.name
        if isinstance(selected_input2, sdn.OuterPin):
            pin2 = selected_input2.inner_pin.port.name
        else:
            pin2 = selected_input2.port.name
        logging.info(
            "Wire swap of %s %s %s and %s %s %s was successful.",
            two_instances[0].name,
            pin1,
            selected_input.wire.cable.name,
            two_instances[1].name,
            pin2,
            selected_input2.wire.cable.name,
        )


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--build_dir", type=str, help="Parent build director for all design artifacts"
    )
    parser.add_argument("--log_path", help="Path to log file")
    parser.add_argument("--seed", help="Seed for random number generator")
    parser.add_argument("--error_type", type=str, help="Type of error to inject")
    parser.add_argument("--reversed_netlist", type=str, help="Path to reversed netlist")
    parser.add_argument("--logging_level", help="Decides what levels of logs to display")
    args = parser.parse_args()

    ErrorInjector(
        args.build_dir,
        args.log_path,
        args.seed,
        args.error_type,
        args.reversed_netlist,
        args.logging_level,
    )
