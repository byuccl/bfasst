from structural.instance import Instance

def get_netlist(library):
    netlist = []
    # Loop through each instance in the current library
    for instance in library.get_instances():
        instance_name = instance.name
        instance_type = instance.reference.name
        input_wires_names = []
        output_wires_names = []
        other_wires_names = []
        # Loop through each of the pins in the instance
        for pin in instance.pins:
            # Check to see that there is a wire connected to the pin
            if pin.wire != None:
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
                        # Check that it is not a CO signal (CARRIES are mapped through the real netlist)
                        if "CO" in pin.inner_pin.port.name:
                            pass
                        else:
                            output_wires_names.append(wire_name)
                elif "Q" in pin.inner_pin.port.name:
                    output_wires_names.append(wire_name)
                else:
                    other_wires_names.append(wire_name)
        # Getting the lengths
        input_wires_number = len(input_wires_names)
        output_wires_number = len(output_wires_names)
        other_wires_number = len(other_wires_names)
        # Setting initial matching numbers
        input_wires_matching_number = 0
        output_wires_matching_number = 0
        # Check if the instance is a LUT for special LUT cases!
        if "LUT" in instance_name:
            # Check if the instance is a LUT with all constant inputs to ignore it!
            number_of_constant_inputs = 0
            for wire_name in input_wires_names:
                if wire_name == "\\<constb> [0]":
                    number_of_constant_inputs += 1
            if number_of_constant_inputs == input_wires_number:
                pass  # Ignore these LUTs!
            else:
                # Check for 2 Output LUT
                if output_wires_number > 1:
                    # Divide LUT5 from LUT6 in the LUT6_2 and perform analysis on each of them !!!
                    #  Getting O5 LUT
                    new_instance_name = instance_name + "_LUT5"
                    new_instance_type = "LUT5"
                    new_input_wires_names = []
                    new_output_wires_names = []
                    # Loop to get the LUT5 inputs
                    i = 0
                    for i in range(0, 6):
                        new_input_wires_names.append(input_wires_names[i])
                    new_input_wires_number = len(new_input_wires_names)
                    # Get the LUT5 output
                    new_output_wires_names.append(output_wires_names[0])
                    new_output_wires_number = len(new_output_wires_names)
                    # Check if the LUT5 has constant inputs to reduce it!
                    number_of_new_constant_inputs = 0
                    for wire_name in new_input_wires_names:
                        if wire_name == "\\<constb> [0]":
                            number_of_new_constant_inputs += 1
                    if number_of_new_constant_inputs > 0:
                        # Reduce the LUT5!
                        reduced_input_wires_names = []
                        for wire_name in new_input_wires_names:
                            if wire_name != "\\<constb> [0]":
                                reduced_input_wires_names.append(wire_name)
                        # Get reduced input wires number
                        reduced_input_wires_number = len(reduced_input_wires_names)
                        # Get reduced instance type
                        reduced_instance_type = "LUT" + str(reduced_input_wires_number)
                        # Get reduced instance name
                        reduced_instance_name = instance_name + reduced_instance_type
                        # Creating reduced instance object
                        reduced_instance = Instance(
                            reduced_instance_name,
                            reduced_instance_type,
                            reduced_input_wires_names,
                            reduced_input_wires_number,
                            input_wires_matching_number,
                            new_output_wires_names,
                            new_output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(reduced_instance)
                    else:
                        # Add LUT5 to the netlist!
                        # Creating new instance object
                        new_instance = Instance(
                            new_instance_name,
                            new_instance_type,
                            new_input_wires_names,
                            new_input_wires_number,
                            input_wires_matching_number,
                            new_output_wires_names,
                            new_output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(new_instance)
                    # Continuing with O6 LUT
                    new_instance_type = "LUT6"
                    new_output_wires_names = []
                    # Get the LUT6 output
                    new_output_wires_names.append(output_wires_names[1])
                    new_output_wires_number = len(new_output_wires_names)
                    # Check if the LUT6 has constant inputs in order to reduce it!
                    if number_of_constant_inputs > 0:
                        # Reduce the LUT by creating new instance!
                        # Get new input wires names
                        reduced_input_wires_names = []
                        for wire_name in input_wires_names:
                            if wire_name != "\\<constb> [0]":
                                reduced_input_wires_names.append(wire_name)
                        # Get new input wires number
                        reduced_input_wires_number = len(reduced_input_wires_names)
                        # Get new instance type
                        reduced_instance_type = "LUT" + str(reduced_input_wires_number)
                        # Creating new instance object
                        reduced_instance = Instance(
                            instance_name,
                            reduced_instance_type,
                            reduced_input_wires_names,
                            reduced_input_wires_number,
                            input_wires_matching_number,
                            new_output_wires_names,
                            new_output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(reduced_instance)
                    else:
                        # Add LUT6 to the netlist!
                        # Creating new instance object
                        new_instance = Instance(
                            instance_name,
                            new_instance_type,
                            input_wires_names,
                            input_wires_number,
                            input_wires_matching_number,
                            new_output_wires_names,
                            new_output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(new_instance)
                else:
                    # Given that it is a one output LUT
                    # Check if the LUT has constant inputs in order to reduce it!
                    if number_of_constant_inputs > 0:
                        # Reduce the LUT by creating new instance!
                        # Get new input wires names
                        reduced_input_wires_names = []
                        for wire_name in input_wires_names:
                            if wire_name != "\\<constb> [0]":
                                reduced_input_wires_names.append(wire_name)
                        # Get new input wires number
                        reduced_input_wires_number = len(reduced_input_wires_names)
                        # Get new instance type
                        reduced_instance_type = "LUT" + str(reduced_input_wires_number)
                        # Creating new instance object
                        new_instance = Instance(
                            instance_name,
                            reduced_instance_type,
                            reduced_input_wires_names,
                            reduced_input_wires_number,
                            input_wires_matching_number,
                            output_wires_names,
                            output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(new_instance)
                    else:
                        # Add LUT to the netlist!
                        # Creating new instance object
                        new_instance = Instance(
                            instance_name,
                            instance_type,
                            input_wires_names,
                            input_wires_number,
                            input_wires_matching_number,
                            output_wires_names,
                            output_wires_number,
                            output_wires_matching_number,
                            other_wires_names,
                            other_wires_number,
                        )
                        # Adding instance to the netlist
                        netlist.append(new_instance)
        else:
            # Add instance to the netlist!
            # Creating new instance object
            new_instance = Instance(
                instance_name,
                instance_type,
                input_wires_names,
                input_wires_number,
                input_wires_matching_number,
                output_wires_names,
                output_wires_number,
                output_wires_matching_number,
                other_wires_names,
                other_wires_number,
            )
            # Adding instance to the netlist
            netlist.append(new_instance)

    return netlist

def print_netlist(netlist):
    for instance in netlist:
        if "CARRY" in instance.instance_type:
            print(instance.instance_name)
            print(instance.instance_type)
            print("Inputs")
            print(instance.input_wires_names)
            print(instance.input_wires_number)
            print(instance.input_wires_matching_number)
            print("Outputs")
            print(instance.output_wires_names)
            print(instance.output_wires_number)
            print(instance.output_wires_matching_number)
            print("Others")
            print(instance.other_wires_names)
            print(instance.other_wires_number, "\n")