"""Tool to inject errors into a netlist"""
from random import randrange
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
                if "lut" in definition['EDIF.identifier'].lower():
                    num_luts += len(definition.references)
                    self.hierarchical_luts.append(definition.references)
        return num_luts

    def flatten_luts(self):
        """Flattens the LUTs into a single list"""
        self.flattened_luts = [lut for sublist in self.hierarchical_luts for lut in sublist]

    def get_lut_size(self, lut_number):
        """Gets the size of the LUT at the given index"""
        num_inputs = 0
        lut = self.flattened_luts[lut_number]
        for port in lut.get_ports():
            if port.direction == sdn.IN:
                num_inputs += 1
        return num_inputs

    def flip_bit(self, lut_number, bit_number):
        """Flips the bit at the given index"""
        lut = self.flattened_luts[lut_number]
        lut_properties = lut["EDIF.properties"]

        config_string_prefixed = lut_properties[0]["value"].upper()
        config_string_digits = config_string_prefixed[2:]
        config_as_binary = bin(int(config_string_digits, 16))[2:]

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
        lut_properties[0]["value"] = config_string_prefixed[:3] + str(config_as_hex).upper()[2:]

    # TODO: Fix the path so it's absolute in design.py
    def compose_corrupt_netlist(self):
        """Writes the netlist to the corrupted netlist path in the design"""
        sdn.compose(self.clean_netlist, self.design.corrupted_netlist_path)

    def inject_wire_swap(self):
        """Injects a wire swap error into the netlist"""

        #Algorithm
        # 1. Get all the wires in the design into a list
        
        # 2. Pick two random wires from the list
            # 2a. Pick one random wire
            # 2b. Pick another random wire. If the two wires have the same source, pick another random wire.
        # 3. Swap the two wires
        # 4. Write the netlist to the corrupted netlist path in the design
