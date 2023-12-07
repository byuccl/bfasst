"""Builds new netlist structured used with automated block mapping"""


from bfasst.netlist_mapping.structural.instance import Instance


def append_wires_names(pin, input_wires_names, output_wires_names, other_wires_names):
    """Adds new wire names to the instance"""

    cable_name = pin.wire.cable.name
    wire_index = str(pin.wire.index())
    wire_name = cable_name + "[" + wire_index + "]"
    if ("I" in pin.inner_pin.port.name) or ("S" in pin.inner_pin.port.name):
        # Added filter for CARRY (CARRIES are mapped through the real netlist)
        if (
            ("DI" in pin.inner_pin.port.name)
            or ("CYINIT" in pin.inner_pin.port.name)
            or ("CI" in pin.inner_pin.port.name)
        ):
            pass
        else:
            input_wires_names.append(wire_name)
    elif "D" in pin.inner_pin.port.name:
        # Added filter for CARRY (CARRIES are mapped through the real netlist)
        if (
            ("DI" in pin.inner_pin.port.name)
            or ("CYINIT" in pin.inner_pin.port.name)
            or ("CI" in pin.inner_pin.port.name)
        ):
            pass
        else:
            input_wires_names.append(wire_name)
    elif "O" in pin.inner_pin.port.name:
        # Check that the wire is connected to other Input Pins
        if len(pin.wire.pins) > 1:
            # Check that it is not a CO signal (CARRIES!)
            if "CO" in pin.inner_pin.port.name:
                pass
            else:
                output_wires_names.append(wire_name)
    elif "Q" in pin.inner_pin.port.name:
        output_wires_names.append(wire_name)
    else:
        other_wires_names.append(wire_name)

    return input_wires_names, output_wires_names, other_wires_names


def get_number_of_constant_inputs(input_wires):
    """Used to get the number of constant inputs"""

    number_of_constant_inputs = 0
    for wire_name in input_wires["names"]:
        if wire_name == "\\<constb> [0]":
            number_of_constant_inputs += 1

    return number_of_constant_inputs


def get_lut5(
    netlist,
    instance_data,
    input_wires,
    output_wires,
    other_wires,
):
    """Used to build a LUT5 out of the LUT6_2"""

    #  Getting O5 LUT
    new_instance_data = {"name": instance_data["name"] + "_LUT5", "type": "LUT5"}
    new_input_wires = {
        "names": [],
        "number": 0,
        "matching_number": 0,
    }
    new_output_wires = {
        "names": [],
        "number": 0,
        "matching_number": 0,
    }
    # Loop to get the LUT5 inputs
    for i in range(0, 6):
        new_input_wires["names"].append(input_wires["names"][i])
    new_input_wires["number"] = len(new_input_wires["names"])
    # Get the LUT5 output
    new_output_wires["names"].append(output_wires["names"][0])
    new_output_wires["number"] = len(new_output_wires["names"])
    # Check if the LUT5 has constant inputs to reduce it!
    number_of_new_constant_inputs = 0
    for wire_name in new_input_wires["names"]:
        if wire_name == "\\<constb> [0]":
            number_of_new_constant_inputs += 1
    if number_of_new_constant_inputs > 0:
        # Reduce the LUT5!
        reduced_input_wires = {
            "names": [],
            "number": 0,
            "matching_number": input_wires["matching_number"],
        }
        for wire_name in new_input_wires["names"]:
            if wire_name != "\\<constb> [0]":
                reduced_input_wires["names"].append(wire_name)
        # Get reduced input wires number
        reduced_input_wires["number"] = len(reduced_input_wires["names"])
        # Creating reduced instance object
        reduced_instance_data = {
            "name": instance_data["name"] + "LUT" + str(reduced_input_wires["number"]),
            "type": "LUT" + str(reduced_input_wires["number"]),
        }
        new_output_wires = {
            "names": new_output_wires["names"],
            "number": new_output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        reduced_instance = Instance(
            reduced_instance_data,
            reduced_input_wires,
            new_output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(reduced_instance)
    else:
        # Add LUT5 to the netlist!
        # Creating new instance object
        instance_data = {
            "name": new_instance_data["name"],
            "type": new_instance_data["type"],
        }
        new_input_wires = {
            "names": new_input_wires["names"],
            "number": new_input_wires["number"],
            "matching_number": input_wires["matching_number"],
        }
        new_output_wires = {
            "names": new_output_wires["names"],
            "number": new_output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        new_instance = Instance(
            instance_data,
            new_input_wires,
            new_output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(new_instance)

    return netlist


def get_lut6(
    netlist,
    instance_data,
    input_wires,
    output_wires,
    other_wires,
):
    """Used to build a LUT6 out of the LUT6_2"""

    number_of_constant_inputs = get_number_of_constant_inputs(input_wires)
    # Continuing with O6 LUT
    new_instance_type = "LUT6"
    new_output_wires = {
        "names": [],
        "number": 0,
        "matching_number": 0,
    }
    # Get the LUT6 output
    new_output_wires["names"].append(output_wires["names"][1])
    new_output_wires["number"] = len(new_output_wires["names"])
    # Check if the LUT6 has constant inputs in order to reduce it!
    if number_of_constant_inputs > 0:
        # Reduce the LUT by creating new instance!
        # Get new input wires names
        reduced_input_wires = {
            "names": [],
            "number": 0,
            "matching_number": 0,
        }
        for wire_name in input_wires["names"]:
            if wire_name != "\\<constb> [0]":
                reduced_input_wires["names"].append(wire_name)
        # Get new input wires number
        reduced_input_wires["number"] = len(reduced_input_wires["names"])
        # Get new instance type
        reduced_instance_type = "LUT" + str(reduced_input_wires["number"])
        # Creating new instance object
        instance = {
            "name": instance_data["name"],
            "type": reduced_instance_type,
        }
        reduced_input_wires = {
            "names": reduced_input_wires["names"],
            "number": reduced_input_wires["number"],
            "matching_number": input_wires["matching_number"],
        }
        new_output_wires = {
            "names": new_output_wires["names"],
            "number": new_output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        reduced_instance = Instance(
            instance,
            reduced_input_wires,
            new_output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(reduced_instance)
    else:
        # Add LUT6 to the netlist!
        # Creating new instance object
        instance = {
            "name": instance_data["name"],
            "type": new_instance_type,
        }
        input_wires = {
            "names": input_wires["names"],
            "number": input_wires["number"],
            "matching_number": input_wires["matching_number"],
        }
        new_output_wires = {
            "names": new_output_wires["names"],
            "number": new_output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        new_instance = Instance(
            instance,
            input_wires,
            new_output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(new_instance)

    return netlist


def get_lut(
    netlist,
    instance_data,
    input_wires,
    output_wires,
    other_wires,
):
    """Used to build a LUT"""

    number_of_constant_inputs = get_number_of_constant_inputs(input_wires)
    # Check if the LUT has constant inputs in order to reduce it!
    if number_of_constant_inputs > 0:
        # Reduce the LUT by creating new instance!
        # Get new input wires names
        reduced_input_wires = {
            "names": [],
            "number": 0,
            "matching_number": 0,
        }
        for wire_name in input_wires["names"]:
            if wire_name != "\\<constb> [0]":
                reduced_input_wires["names"].append(wire_name)
        # Get new input wires number
        reduced_input_wires["number"] = len(reduced_input_wires["names"])
        # Get new instance type
        reduced_instance_type = "LUT" + str(reduced_input_wires["number"])
        # Creating new instance object
        instance = {
            "name": instance_data["name"],
            "type": reduced_instance_type,
        }
        reduced_input_wires = {
            "names": reduced_input_wires["names"],
            "number": reduced_input_wires["number"],
            "matching_number": input_wires["matching_number"],
        }
        new_output_wires = {
            "names": output_wires["names"],
            "number": output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        new_instance = Instance(
            instance,
            reduced_input_wires,
            new_output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(new_instance)
    else:
        # Add LUT to the netlist!
        # Creating new instance object
        instance = {
            "name": instance_data["name"],
            "type": instance_data["type"],
        }
        input_wires = {
            "names": input_wires["names"],
            "number": input_wires["number"],
            "matching_number": input_wires["matching_number"],
        }
        output_wires = {
            "names": output_wires["names"],
            "number": output_wires["number"],
            "matching_number": output_wires["matching_number"],
        }
        other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
        new_instance = Instance(
            instance,
            input_wires,
            output_wires,
            other_wires,
        )
        # Adding instance to the netlist
        netlist.append(new_instance)

    return netlist


def get_netlist(library):
    """Builds new netlist structure out of SpyDrNet netlist"""

    netlist = []
    # Loop through each instance in the current library
    for instance in library.get_instances():
        instance_data = {
            "name": instance.name,
            "type": instance.reference.name,
        }
        input_wires = {
            "names": [],
            "number": 0,
            "matching_number": 0,
        }
        output_wires = {
            "names": [],
            "number": 0,
            "matching_number": 0,
        }
        other_wires = {
            "names": [],
            "number": 0,
        }
        # Loop through each of the pins in the instance
        for pin in instance.pins:
            # Check to see that there is a wire connected to the pin
            if pin.wire is not None:
                (
                    input_wires["names"],
                    output_wires["names"],
                    other_wires["names"],
                ) = append_wires_names(
                    pin, input_wires["names"], output_wires["names"], other_wires["names"]
                )
        # Getting the lengths
        input_wires["number"] = len(input_wires["names"])
        output_wires["number"] = len(output_wires["names"])
        other_wires["number"] = len(other_wires["names"])
        # Setting initial matching numbers
        input_wires["matching_number"] = 0
        output_wires["matching_number"] = 0
        # Check if the instance is a LUT for special LUT cases!
        if "LUT" in instance_data["name"]:
            # Check if the instance is a LUT with all constant inputs to ignore it!
            number_of_constant_inputs = get_number_of_constant_inputs(input_wires)

            if number_of_constant_inputs == input_wires["number"]:
                pass  # Ignore these LUTs!
            else:
                # Check for 2 Output LUT
                if output_wires["number"] > 1:
                    # Divide LUT5 from LUT6 in the LUT6_2 and perform analysis on each of them !!!
                    netlist = get_lut5(
                        netlist,
                        instance_data,
                        input_wires,
                        output_wires,
                        other_wires,
                    )
                    netlist = get_lut6(
                        netlist,
                        instance_data,
                        input_wires,
                        output_wires,
                        other_wires,
                    )

                else:
                    # Given that it is a one output LUT
                    netlist = get_lut(
                        netlist,
                        instance_data,
                        input_wires,
                        output_wires,
                        other_wires,
                    )

        else:
            # Add instance to the netlist!
            # Creating new instance object
            input_wires = {
                "names": input_wires["names"],
                "number": input_wires["number"],
                "matching_number": input_wires["matching_number"],
            }
            output_wires = {
                "names": output_wires["names"],
                "number": output_wires["number"],
                "matching_number": output_wires["matching_number"],
            }
            other_wires = {"names": other_wires["names"], "number": other_wires["number"]}
            new_instance = Instance(
                instance_data,
                input_wires,
                output_wires,
                other_wires,
            )
            # Adding instance to the netlist
            netlist.append(new_instance)

    return netlist


def print_netlist(netlist):
    """Prints the netlist structure"""

    for instance in netlist:
        if "CARRY" in instance.type:
            print(instance["name"])
            print(instance["type"])
            print("Inputs")
            print(instance.input_wires["names"])
            print(instance.input_wires["number"])
            print(instance.input_wires["matching_number"])
            print("Outputs")
            print(instance.output_wires["names"])
            print(instance.output_wires["number"])
            print(instance.output_wires["matching_number"])
            print("Others")
            print(instance.other_wires["names"])
            print(instance.other_wires["number"], "\n")
