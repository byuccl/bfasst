"""This file contains the functions used to retrieve the logic functions
from the LUTs before a FF"""


import math
from enum import Enum
from bfasst.netlist_mapping.functional.converter import (
    hex_to_bin,
    bin_to_hex,
    get_reversed_bin_for_each_hex,
)

# from timeit import default_timer as timer
from bfasst.netlist_mapping.functional.qm import qm_f
from bfasst.netlist_mapping.functional.configuration_bits_tree import (
    Node,
    create_tree,
    get_filtered_values,
)


class Parameter(Enum):
    """Enums used to get the conf bits and its number"""

    BIT_NUM = 0
    CONF_BITS = 1


class State(Enum):
    """States used to get conf bits"""

    INIT = 0
    GET_BIT_NUM = 1
    GET_CONF_BITS = 2


class FlipflopData:
    """This class contains the necessary information to map the FF"""

    def __init__(self, flipflop_name, configuration_bits, sop):
        self.flipflop_name = flipflop_name
        self.configuration_bits = configuration_bits
        self.sop = sop

    def set_flipflop_name(self, flipflop_name):
        """Sets the FF name"""
        self.flipflop_name = flipflop_name

    def add_configuration_bits(self, configuration_bits):
        """Adds the conf bits"""
        self.configuration_bits.append(configuration_bits)

    def set_sop(self, sop):
        """Sets the FF logic function tree"""
        self.sop = sop


class Product:
    """This class saves the information of a product in a SOP"""

    def __init__(self, string, lut_inputs, num, state):
        self.string = string
        self.lut_inputs = lut_inputs  # List of InputSOP objects
        self.num = num
        self.state = state

    def get_product_string(self):
        """Used to get the string used for the product"""
        return self.string

    def get_product_state(self):
        """Used to get the state of the product"""
        return self.state


class InputSOP:
    """This class saves the data for an input of a SOP"""

    def __init__(self, input_p, sop, state):
        self.input = input_p
        self.sop = sop  # List of Product objects
        self.state = state

    def get_input_sop(self):
        """Used to get the sop"""
        return self.sop

    def get_input_state(self):
        """Used to get the InputSOP state"""
        return self.state


def parse_instance_parameters(parameters):
    """Parser to get the configuration bits and how many they are."""

    parameters_data = []

    number_of_bits = ""
    configuration_bits = ""

    current_state = State.INIT
    next_state = State.INIT

    # Parsing Instance Parameters
    length = len(parameters)
    for i in range(length):
        current_state = next_state

        # SM for Transitions and Actions
        if current_state == State.INIT:
            if parameters[i] == '"':
                next_state = State.GET_BIT_NUM
            elif parameters[i] == "h":
                next_state = State.GET_CONF_BITS

        elif current_state == State.GET_BIT_NUM:
            if parameters[i] == "}" or parameters[i] == "'":
                next_state = State.INIT
            else:
                number_of_bits = number_of_bits + parameters[i]

        elif current_state == State.GET_CONF_BITS:
            if parameters[i] == '"':
                next_state = State.INIT
            else:
                configuration_bits = configuration_bits + parameters[i]

    parameters_data.append(number_of_bits)
    parameters_data.append(configuration_bits)

    return parameters_data


def get_reduced_lut_conf_bits(conf_bits_num, conf_bits, lut_inputs):
    """This function gets the reversed configuration bits
    for the correct reduction of the LUT!"""

    # This helps the mapping between the conf bits and the LUT inputs
    reversed_conf_bits = []
    for i in reversed(range(len(conf_bits))):
        reversed_conf_bits.append(conf_bits[i])

    lut_conf_bits = get_reversed_bin_for_each_hex(reversed_conf_bits)

    # Build Binary Search Tree based on the lut_conf_bits binary number
    root = Node()
    conf_bits_index = 0
    generations = int(math.log(conf_bits_num, 2))
    root, conf_bits_index = create_tree(root, generations, conf_bits_index, lut_conf_bits)

    # Getting values of the BST when some of the Inputs to the LUT are \<constb> (1'b1)
    filtered_bst_values = []
    filtered_bst_values = get_filtered_values(root, generations, lut_inputs, filtered_bst_values)

    # Getting the final conf bits following the Vivado format
    lut_conf_bits = bin_to_hex(get_reversed_bin_for_each_hex(bin_to_hex(filtered_bst_values)))
    final_conf_bits = []
    for i in reversed(range(len(lut_conf_bits))):
        final_conf_bits.append(lut_conf_bits[i])

    return final_conf_bits


def get_smaller_lut(lut_conf_bits, lut_inputs):
    """This function returns data for a LUT5"""

    new_conf_bits = ""
    new_lut_inputs = []
    # Get new conf bits
    for i in range(8, 16):
        new_conf_bits = new_conf_bits + lut_conf_bits[i]
    # Get new lut inputs
    for i in range(len(lut_inputs) - 1):
        new_lut_inputs.append(lut_inputs[i])
    return "32", new_conf_bits, new_lut_inputs


def lut_conf_bits_to_lower_case(lut_conf_bits):
    """This function puts all conf bits in lower case"""

    new_conf_bits = ""

    for num in lut_conf_bits:
        if num == "A":
            new_conf_bits += "a"
        elif num == "B":
            new_conf_bits += "b"
        elif num == "C":
            new_conf_bits += "c"
        elif num == "D":
            new_conf_bits += "d"
        elif num == "E":
            new_conf_bits += "e"
        elif num == "F":
            new_conf_bits += "f"
        else:
            new_conf_bits += num

    return new_conf_bits


def check_if_smaller_lut(smaller_lut, lut_conf_bits_num, lut_conf_bits, lut_inputs):
    """Checks if it is a smaller LUT to get it from the LUT6_2"""

    if smaller_lut:
        lut_conf_bits_num, lut_conf_bits, lut_inputs = get_smaller_lut(lut_conf_bits, lut_inputs)

    return lut_conf_bits_num, lut_conf_bits, lut_inputs


def get_reduced_inputs_sops(inputs_sops, constant_inputs):
    """This function gets the inputs to the SOP that are not constants."""

    new_inputs_sops = []
    new_input_index = 0

    for input_sop in inputs_sops:
        is_constant = False
        for input_i in constant_inputs:
            if input_sop.input == input_i:
                is_constant = True
        if not is_constant:
            new_input_sop = InputSOP("I" + str(new_input_index), input_sop.sop, input_sop.state)
            new_inputs_sops.append(new_input_sop)
            new_input_index += 1

    return new_inputs_sops


def check_for_lut_reduction(lut_inputs, lut_conf_bits, lut_conf_bits_num, inputs_sops):
    """Function used to check for reduction and perform it"""

    # Check if any of the LUT's inputs is a constant 1 to reduce the LUT
    needs_reduction = False
    constant_inputs = []
    for i, value in enumerate(lut_inputs):
        if str(value) == r"\<constb> ":
            needs_reduction = True
            constant_inputs.append("I" + str(i))

    # print("Constant Inputs")
    # print(constant_inputs)

    # LUT Reduction
    if needs_reduction and (len(constant_inputs) < 5):
        lut_conf_bits = get_reduced_lut_conf_bits(int(lut_conf_bits_num), lut_conf_bits, lut_inputs)
        inputs_sops = get_reduced_inputs_sops(inputs_sops, constant_inputs)

    return lut_conf_bits, inputs_sops


def get_minterms(conf_bits, lut_inputs_length):
    """This function gets the minterms and zeroes from the conf bits"""

    # Convert configuration bits to binary
    bin_conf_bits = hex_to_bin(conf_bits)
    # print(bin_conf_bits)
    # Loop through the bits in reverse order to grab the correct index of the minterm
    minterms = []
    zeroes = []
    min_index = 0
    for i in reversed(range(len(bin_conf_bits))):
        # Logic used to select minterms and zeroes for 1 Input Luts
        if (lut_inputs_length != 1) or ((lut_inputs_length == 1) and (min_index < 2)):
            if bin_conf_bits[i] == "1":
                minterms.append(min_index)
            elif bin_conf_bits[i] == "0":
                zeroes.append(min_index)
            min_index += 1
    # print(minterms)
    # print(zeroes)
    return minterms, zeroes


def get_product(implicant):
    """This function is used to build the product object out of
    the prime implicant"""

    string = implicant
    lut_input_index = len(implicant) - 1
    lut_inputs = []
    negated_num = 0

    for char in implicant:
        if char == "X":
            pass
        else:
            if char == "0":
                negated_num += 1
            input_sop = InputSOP("I" + str(lut_input_index), None, "not_found")
            lut_inputs.append(input_sop)
        lut_input_index -= 1
    lut_inputs_number = len(lut_inputs)

    num = {"lut_inputs": lut_inputs_number, "negative_inputs": negated_num}

    product = Product(string, lut_inputs, num, "not_found")

    return product


def get_sop(prime_implicants):
    """Returns the SOP"""

    sop = []

    for implicant in prime_implicants:
        product = get_product(implicant)
        sop.append(product)

    return sop


def lut_data_through_pin(out_pin, configuration_bits, previous_luts, inputs_sops, port_name):
    """Function used to continue getting the LUT data"""

    # Check that it is the outer pin of an instance
    if "O" in out_pin.inner_pin.port.name:
        # Check if it is a smaller LUT inside
        new_smaller_lut = False
        if "O5" in out_pin.inner_pin.port.name:
            new_smaller_lut = True
        # If a LUT is connected to this LUT
        if "LUT" in out_pin.instance.reference.name:
            # Check that it is not a previous LUT to get data from it
            new_lut = True
            # Loop through the previous luts
            previous_luts_len = len(previous_luts)
            for i in range(previous_luts_len):
                # If found, not new
                if out_pin.instance.name == previous_luts[i]:
                    new_lut = False
            # If new, then get data from it
            if new_lut:
                sop, configuration_bits, previous_luts = get_lut_data(
                    out_pin.instance,
                    configuration_bits,
                    previous_luts,
                    new_smaller_lut,
                )
                # Connect the sop to the correct input_sop
                for input_sop in inputs_sops:
                    if input_sop.input == port_name:
                        input_sop.sop = sop

    return configuration_bits, previous_luts


def add_new_conf_bits(configuration_bits, lut_conf_bits):
    """Adds the LUT's configuration bits to the list"""

    lut_conf_bits_len = len(lut_conf_bits)
    for i in range(lut_conf_bits_len):
        # Adding each conf bit as a char to the conf bits list
        configuration_bits.append(lut_conf_bits[i])

    return configuration_bits


def build_sop(lut_conf_bits, lut_inputs, inputs_sops):
    """This function builds the SOP data structure based on the configuration bits"""
    minterms, zeroes = get_minterms(lut_conf_bits, len(lut_inputs))
    # start = timer()
    # print("LUT inputs number:")
    # print(len(lut_inputs))
    # print("minterms again:")
    # print(minterms)
    # print("zeroes again:")
    # print(zeroes)
    prime_implicants = qm_f(ones=minterms, zeros=zeroes)
    # dt = timer() - start
    # print("qm_f: %f sec" % dt)
    # print(prime_implicants)

    sop = get_sop(prime_implicants)
    # print(sop)

    # Connect the LUT's SOP with its Inputs' SOPs
    for product in sop:
        for input_sop_1 in product.lut_inputs:
            for input_sop_2 in inputs_sops:
                if input_sop_1.input == input_sop_2.input:
                    input_sop_1.sop = input_sop_2.sop

    return sop


def get_lut_conf_bits_and_num(instance):
    """Gets the LUT's Number of and the actual Configuration Bits"""

    parameters_data = []
    if "VERILOG.Parameters" in instance.data:
        parameters = str(instance.data["VERILOG.Parameters"])
        parameters_data = parse_instance_parameters(parameters)

    # print("Initial Configuration Bits:")
    # print(lut_conf_bits)

    return parameters_data[Parameter.CONF_BITS.value], parameters_data[Parameter.BIT_NUM.value]


def get_lut_data(instance, configuration_bits, previous_luts, smaller_lut):
    """This function is used to build the SOP that represents the LUT"""

    previous_luts.append(instance.name)
    lut_inputs = []
    # Initialize the Inputs' SOPs (Max # of inputs is 6!)
    inputs_sops = []
    for i in range(6):
        input_sop = InputSOP("I" + str(i), None, "not_found")
        inputs_sops.append(input_sop)
    # Check if the LUT is connected in its inputs to any other LUTs to add their Configuration Bits
    # Loop through the pins of the LUT
    for lut_pin in instance.pins:
        # If the pin is an Input
        port_name = lut_pin.inner_pin.port.name
        if "I" in port_name:
            # Check for the wire
            if lut_pin.wire is not None:
                # Save the wire name for possible LUT reduction
                lut_inputs.append(str(lut_pin.wire.cable.name))
                # Loop through the pins connected to the wire connected to the LUT
                for out_pin in lut_pin.wire.pins:
                    configuration_bits, previous_luts = lut_data_through_pin(
                        out_pin, configuration_bits, previous_luts, inputs_sops, port_name
                    )
    lut_conf_bits, lut_conf_bits_num = get_lut_conf_bits_and_num(instance)
    lut_conf_bits = lut_conf_bits_to_lower_case(lut_conf_bits)
    lut_conf_bits_num, lut_conf_bits, lut_inputs = check_if_smaller_lut(
        smaller_lut, lut_conf_bits_num, lut_conf_bits, lut_inputs
    )
    lut_conf_bits, inputs_sops = check_for_lut_reduction(
        lut_inputs, lut_conf_bits, lut_conf_bits_num, inputs_sops
    )
    configuration_bits = add_new_conf_bits(configuration_bits, lut_conf_bits)
    sop = build_sop(lut_conf_bits, lut_inputs, inputs_sops)

    return sop, configuration_bits, previous_luts


def check_for_lut(out_pin, sop, configuration_bits, previous_luts):
    """Gets the LUT's data if it is connected to the FF"""

    if "LUT" in out_pin.instance.reference.name:
        # Check if it is a smaller LUT inside
        new_smaller_lut = False
        if "O5" in out_pin.inner_pin.port.name:
            new_smaller_lut = True
        sop, configuration_bits, previous_luts = get_lut_data(
            out_pin.instance,
            configuration_bits,
            previous_luts,
            new_smaller_lut,
        )

    return sop, configuration_bits, previous_luts


def get_ff_data(instance):
    """This function is used to start building the functions tree of the FF"""

    # Check for \ at the beginning of the name to ignore it
    flipflop_name = None
    if instance.name[0] == "\\":
        flipflop_name = instance.name[1:]
    else:
        flipflop_name = instance.name
    configuration_bits = []
    previous_luts = []
    sop = []
    # Loop through the pins of the FF
    for ff_pin in instance.pins:
        # If it is the Input pin on port 'D'
        if ff_pin.inner_pin.port.name == "D":
            # Check for the wire
            if ff_pin.wire is not None:
                # Loop through the pins connected to the wire connected to 'D' in the FF
                for out_pin in ff_pin.wire.pins:
                    sop, configuration_bits, previous_luts = check_for_lut(
                        out_pin, sop, configuration_bits, previous_luts
                    )

    flipflop_data = FlipflopData(flipflop_name, configuration_bits, sop)
    # print(flipflop_name)
    # print(configuration_bits)
    # print(previous_luts)
    # print(" ")

    return flipflop_data


def get_ffs_and_conf_bits(library, carry_chain_mapped_flipflops, impl):
    """Function used to find the FFs of the netlist and build their logic trees"""

    netlist_flipflops_data = []
    # Loop through each instance in the current library
    for instance in library.get_instances():
        instance_type = instance.reference.name
        # If the instance is a FF
        if instance_type in ("FDSE", "FDRE"):
            # Try to find this flipflop in the carry mapped flipflops
            flipflop_already_mapped = False
            for mapped_pair in carry_chain_mapped_flipflops:
                # Compare the flipflop name to the impl FF
                flipflop_name = ""
                if impl:
                    flipflop_name = mapped_pair[0]
                else:
                    flipflop_name = mapped_pair[1]
                if flipflop_name == instance.name:
                    flipflop_already_mapped = True
            if not flipflop_already_mapped:
                # Get data from it and append it to list
                # print("\\\\\\\\ " + instance.name + " \\\\\\\\")
                flipflop_data = get_ff_data(instance)
                netlist_flipflops_data.append(flipflop_data)

    # Return the flipflops names and their lists of configuration bits object
    return netlist_flipflops_data
