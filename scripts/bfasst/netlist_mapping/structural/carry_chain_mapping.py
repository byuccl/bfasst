def get_flipflops_through_carry(carry, ffs, carries):
    # print(carry.name + "!!!!!!!!!!!!!!!!!!!!!!!!")
    carries.append(carry.name)
    # Loop through all the pins in the carry to add ffs
    for pin in carry.pins:
        # Find the pin with the S port
        if "S" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire != None:
                # print(pin.wire.cable.name)
                # Loop through the pins connected to the wire
                for wire_pin in pin.wire.pins:
                    # print(wire_pin.instance.reference.name)
                    # Check for FF Output
                    if "Q" in wire_pin.inner_pin.port.name:
                        # Case where a FF is connected directly to the carry!
                        if ("FDRE" in wire_pin.instance.reference.name) or (
                            "FDSE" in wire_pin.instance.reference.name
                        ):
                            # print("IT GETS HERE!!!!!!")
                            # Add ff to the list
                            ffs.append(wire_pin.instance.name)
                            # print(ffs)
                    # Check for LUT Output
                    elif "O" in wire_pin.inner_pin.port.name:
                        # Case where a LUT is connected to the carry!
                        if "LUT" in wire_pin.instance.reference.name:
                            lut = wire_pin.instance
                            # Loop through the pins of the LUT
                            for lut_pin in lut.pins:
                                # Find the pin with the I port
                                if "I" in lut_pin.inner_pin.port.name:
                                    # Check that it has a wire
                                    if lut_pin.wire != None:
                                        # Loop through the pins connected to the lut's wire
                                        for lut_wire_pin in lut_pin.wire.pins:
                                            # Check for FF Output
                                            if "Q" in lut_wire_pin.inner_pin.port.name:
                                                # Case where a FF is connected directly to the LUT!
                                                if (
                                                    "FDRE"
                                                    in lut_wire_pin.instance.reference.name
                                                ) or (
                                                    "FDSE"
                                                    in lut_wire_pin.instance.reference.name
                                                ):
                                                    # Add ff to the list
                                                    ffs.append(
                                                        lut_wire_pin.instance.name
                                                    )
                                                    # print(ffs)
                        # Ignore all other cases!
    # Done with adding flipflops from the carry!
    # Loop through all the pins in the carry to move to the next carry, or to add the final ff
    for pin in carry.pins:
        # Find the pin with the CO port
        if "CO" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire != None:
                # Move to the next carry!
                # Loop through the pins connected to the wire
                for wire_pin in pin.wire.pins:
                    # Find the wire_pin with the CI port
                    if "CI" in wire_pin.inner_pin.port.name:
                        # Case where the carry is connected directly to the carry!
                        if "CARRY" in wire_pin.instance.reference.name:
                            # Jump to the new carry
                            ffs, carries = get_flipflops_through_carry(
                                wire_pin.instance, ffs, carries
                            )
            # Else this is the last Carry!
    return ffs, carries


def get_flipflops_to_map_through_carries(library, ffs, carries):
    # Loop through each instance in the current library to find the first carry!
    for instance in library.get_instances():
        # Select carry
        if "CARRY" in instance.reference.name:
            # Loop through the pins of the CARRY
            for pin in instance.pins:
                # Find the pin with the CI port
                if "CI" in pin.inner_pin.port.name:
                    # Check that it has a wire
                    if pin.wire != None:
                        # Check if it is connected to a constant (ground); b for reversed, 0 for impl
                        if ("\<constb> " == pin.wire.cable.name) or (
                            "\<const0> " == pin.wire.cable.name
                        ):
                            # Get FFs through carry
                            ffs, carries = get_flipflops_through_carry(
                                instance, ffs, carries
                            )
    return ffs, carries


def print_mapped_carries(mapped_carries):
    for carry_pair in mapped_carries:
        print(carry_pair[0], " <-> ", carry_pair[1])


def print_mapped_flipflops_through_carries(mapped_ffs):
    for ff_pair in mapped_ffs:
        print(ff_pair[0], " <-> ", ff_pair[1])


def map_carries_and_flipflops(library1, library2):
    impl_carries = []
    reversed_carries = []
    impl_ffs = []
    reversed_ffs = []

    impl_ffs, impl_carries = get_flipflops_to_map_through_carries(
        library1, impl_ffs, impl_carries
    )

    reversed_ffs, reversed_carries = get_flipflops_to_map_through_carries(
        library2, reversed_ffs, reversed_carries
    )

    mapped_carries = []
    # Map carry chains
    if len(impl_carries) == len(reversed_carries):
        for i in range(len(impl_carries)):
            mapped_pair = []
            mapped_pair.append(impl_carries[i])
            mapped_pair.append(reversed_carries[i])
            mapped_carries.append(mapped_pair)

    #print_mapped_carries(mapped_carries)

    mapped_flipflops = []
    # Map flipflops gathered from the carries
    if len(impl_ffs) == len(reversed_ffs):
        for i in range(len(impl_ffs)):
            mapped_pair = []
            mapped_pair.append(impl_ffs[i])
            mapped_pair.append(reversed_ffs[i])
            mapped_flipflops.append(mapped_pair)

    # print_mapped_flipflops_through_carries(mapped_flipflops)

    return mapped_carries, mapped_flipflops

def update_netlists_from_carries_and_flipflops_mapping(
    mapped_carries, mapped_flipflops, golden_netlist, reversed_netlist
):
    # Update netlist with the mapped carries
    # Loop through the mapped carries
    for mapped_pair in mapped_carries:
        # Loop through the impl_netlist
        for impl_instance in golden_netlist:
            # Find impl_carry
            if mapped_pair[0] == impl_instance.instance_name:
                # print(mapped_pair[0], " with ", impl_instance.instance_name)
                # Loop through the reversed_netlist
                for reversed_instance in reversed_netlist:
                    # Find reversed_carry
                    if mapped_pair[1] == reversed_instance.instance_name:
                        # print(mapped_pair[1], " with ", reversed_instance.instance_name)
                        # Update Inputs in the reversed_carry
                        for i, reversed_wire in enumerate(
                            reversed_instance.input_wires_names
                        ):
                            # Update Input in cell
                            old_wire_name = reversed_wire
                            new_wire_name = impl_instance.input_wires_names[i]
                            reversed_instance.input_wires_names[i] = new_wire_name
                            reversed_instance.input_wires_matching_number += 1
                            # Update wire in netlist
                            for reversed_block in reversed_netlist:
                                # Updating Inputs
                                for i, reversed_block_input_wire in enumerate(
                                    reversed_block.input_wires_names
                                ):
                                    if reversed_block_input_wire == old_wire_name:
                                        reversed_block.input_wires_names[
                                            i
                                        ] = new_wire_name
                                # Updating Outputs
                                for i, reversed_block_output_wire in enumerate(
                                    reversed_block.output_wires_names
                                ):
                                    if reversed_block_output_wire == old_wire_name:
                                        reversed_block.output_wires_names[
                                            i
                                        ] = new_wire_name
                        # Update Outputs in the reversed_carry
                        for i, reversed_wire in enumerate(
                            reversed_instance.output_wires_names
                        ):
                            # Update Output in cell
                            old_wire_name = reversed_wire
                            new_wire_name = impl_instance.output_wires_names[i]
                            reversed_instance.output_wires_names[i] = new_wire_name
                            reversed_instance.output_wires_matching_number += 1
                            # Update wire in netlist
                            for reversed_block in reversed_netlist:
                                # Updating Inputs
                                for i, reversed_block_input_wire in enumerate(
                                    reversed_block.input_wires_names
                                ):
                                    if reversed_block_input_wire == old_wire_name:
                                        reversed_block.input_wires_names[
                                            i
                                        ] = new_wire_name
                        # Update Other wires in the reversed_carry
                        for i, reversed_wire in enumerate(
                            reversed_instance.other_wires_names
                        ):
                            # Update Other wire in cell
                            old_wire_name = reversed_wire
                            new_wire_name = impl_instance.other_wires_names[i]
                            reversed_instance.other_wires_names[i] = new_wire_name
                            # reversed_instance.other_wires_matching_number += 1
                            # Update wire in netlist
                            for reversed_block in reversed_netlist:
                                # Updating Inputs
                                for i, reversed_block_input_wire in enumerate(
                                    reversed_block.input_wires_names
                                ):
                                    if reversed_block_input_wire == old_wire_name:
                                        reversed_block.input_wires_names[
                                            i
                                        ] = new_wire_name
                                # Updating Outputs
                                for i, reversed_block_output_wire in enumerate(
                                    reversed_block.output_wires_names
                                ):
                                    if reversed_block_output_wire == old_wire_name:
                                        reversed_block.output_wires_names[
                                            i
                                        ] = new_wire_name
                                # Updating Other wires
                                for i, reversed_block_other_wire in enumerate(
                                    reversed_block.other_wires_names
                                ):
                                    if reversed_block_other_wire == old_wire_name:
                                        reversed_block.other_wires_names[
                                            i
                                        ] = new_wire_name
                        # Done updating CARRY

    # Update netlist with the mapped flipflops (May not be needed)

    return golden_netlist, reversed_netlist