"""This file contains the necessary functions to map the carry chains"""

from bfasst.legacy.tools.netlist_mapping.structural.map_ffs import get_mapped_ffs
from bfasst.legacy.tools.netlist_mapping.structural.updating_reversed_netlist import (
    update_wires_in_reversed_netlist,
)


def check_for_ff_output(wire_pin, ffs):
    """Checks for FF Output"""

    if "Q" in wire_pin.inner_pin.port.name:
        # Case where a FF is connected directly to the carry or a lut!
        if ("FDRE" in wire_pin.instance.reference.name) or (
            "FDSE" in wire_pin.instance.reference.name
        ):
            # print("IT GETS HERE!!!!!!")
            # Add ff to the list
            ffs.append(wire_pin.instance.name)
            # print(ffs)

    return ffs


def look_for_ff(lut_pin, ffs):
    """Loops through the pins connected to the lut's wire"""

    for lut_wire_pin in lut_pin.wire.pins:
        ffs = check_for_ff_output(lut_wire_pin, ffs)

    return ffs


def check_for_lut_output(wire_pin, ffs):
    """Checks for LUT Output"""

    if "O" in wire_pin.inner_pin.port.name:
        # Case where a LUT is connected to the carry!
        if "LUT" in wire_pin.instance.reference.name:
            lut = wire_pin.instance
            # Loop through the pins of the LUT
            for lut_pin in lut.pins:
                # Find the pin with the I port
                if "I" in lut_pin.inner_pin.port.name:
                    # Check that it has a wire
                    if lut_pin.wire is not None:
                        ffs = look_for_ff(lut_pin, ffs)

    return ffs


def move_to_next_carry(pin, ffs, carries):
    """Used to move to the next carry!"""

    # Loop through the pins connected to the wire
    for wire_pin in pin.wire.pins:
        # Find the wire_pin with the CI port
        if "CI" in wire_pin.inner_pin.port.name:
            # Case where the carry is connected directly to the carry!
            if "CARRY" in wire_pin.instance.reference.name:
                # Jump to the new carry
                ffs, carries = get_ffs_through_carry(wire_pin.instance, ffs, carries)

    return ffs, carries


def get_ffs_through_carry(carry, ffs, carries):
    """Gets all the ffs in the carry chain"""

    # print(carry.name + "!!!!!!!!!!!!!!!!!!!!!!!!")
    carries.append(carry.name)
    # Loop through all the pins in the carry to add ffs
    for pin in carry.pins:
        # Find the pin with the S port
        if "S" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire is not None:
                # print(pin.wire.cable.name)
                # Loop through the pins connected to the wire
                for wire_pin in pin.wire.pins:
                    # print(wire_pin.instance.reference.name)
                    ffs = check_for_ff_output(wire_pin, ffs)
                    ffs = check_for_lut_output(wire_pin, ffs)
                    # Ignore all other cases!
    # Done with adding flipflops from the carry!
    # Loop through all the pins in the carry to move to the next carry, or to add the final ff
    for pin in carry.pins:
        # Find the pin with the CO port
        if "CO" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire is not None:
                ffs, carries = move_to_next_carry(pin, ffs, carries)
            # Else this is the last Carry!

    return ffs, carries


def check_for_first_carry(instance, pin, ffs, carries):
    """Used to find the first carry in the chain"""

    # Check if it is connected to a constant (ground);
    # b for reversed, 0 for impl
    if pin.wire.cable.name in ("\\<constb> ", "\\<const0> "):
        # Get FFs through carry
        ffs, carries = get_ffs_through_carry(instance, ffs, carries)

    return ffs, carries


def get_ffs_to_map_through_carries(library, ffs, carries):
    """Finds the first carry in the chain"""

    # Loop through each instance in the current library to find the first carry!
    for instance in library.get_instances():
        # Select carry
        if "CARRY" in instance.reference.name:
            # Loop through the pins of the CARRY
            for pin in instance.pins:
                # Find the pin with the CI port
                if "CI" in pin.inner_pin.port.name:
                    # Check that it has a wire
                    if pin.wire is not None:
                        ffs, carries = check_for_first_carry(instance, pin, ffs, carries)

    return ffs, carries


def print_mapped_carries(mapped_carries):
    """Prints carry chains"""

    for carry_pair in mapped_carries:
        print(carry_pair[0], " <-> ", carry_pair[1])


def print_mapped_ffs_through_carries(mapped_ffs):
    """Prints ffs"""

    for ff_pair in mapped_ffs:
        print(ff_pair[0], " <-> ", ff_pair[1])


def map_carries_and_ffs(library1, library2):
    """Maps ffs connected to the carry chain in the circuit"""

    impl_carries = []
    reversed_carries = []
    impl_ffs = []
    reversed_ffs = []

    impl_ffs, impl_carries = get_ffs_to_map_through_carries(library1, impl_ffs, impl_carries)

    reversed_ffs, reversed_carries = get_ffs_to_map_through_carries(
        library2, reversed_ffs, reversed_carries
    )

    mapped_carries = []
    # Map carry chains
    if len(impl_carries) == len(reversed_carries):
        length = len(impl_carries)
        for i in range(length):
            mapped_pair = []
            mapped_pair.append(impl_carries[i])
            mapped_pair.append(reversed_carries[i])
            mapped_carries.append(mapped_pair)

    # print_mapped_carries(mapped_carries)

    # Map flipflops gathered from the carries
    mapped_flipflops = []

    mapped_flipflops = get_mapped_ffs(mapped_flipflops, impl_ffs, reversed_ffs)

    # print_mapped_flipflops_through_carries(mapped_flipflops)

    # return mapped_carries, mapped_flipflops

    return mapped_flipflops


def update_inputs_in_reversed_carry(reversed_instance, impl_instance, reversed_netlist):
    """Updates Inputs in the reversed_carry"""

    for i, reversed_wire in enumerate(reversed_instance.input_wires["names"]):
        # Update Input in cell
        old_wire_name = reversed_wire
        new_wire_name = impl_instance.input_wires["names"][i]
        reversed_instance.input_wires["names"][i] = new_wire_name
        reversed_instance.input_wires["matching_number"] += 1

        reversed_netlist = update_wires_in_reversed_netlist(
            reversed_netlist, old_wire_name, new_wire_name
        )

    return reversed_instance, reversed_netlist


def update_outputs_in_reversed_carry(reversed_instance, impl_instance, reversed_netlist):
    """Updates Outputs in the reversed_carry"""

    for i, reversed_wire in enumerate(reversed_instance.output_wires["names"]):
        # Update Output in cell
        old_wire_name = reversed_wire
        new_wire_name = impl_instance.output_wires["names"][i]
        reversed_instance.output_wires["names"][i] = new_wire_name
        reversed_instance.output_wires["matching_number"] += 1
        # Update wire in netlist
        for reversed_block in reversed_netlist:
            # Updating Inputs
            for i, reversed_block_input_wire in enumerate(reversed_block.input_wires_names):
                if reversed_block_input_wire == old_wire_name:
                    reversed_block.input_wires_names[i] = new_wire_name

    return reversed_instance, reversed_netlist


def update_other_wires_in_reversed_carry(reversed_instance, impl_instance, reversed_netlist):
    """Update Other wires in the reversed_carry"""

    for i, reversed_wire in enumerate(reversed_instance.other_wires["names"]):
        # Update Other wire in cell
        old_wire_name = reversed_wire
        new_wire_name = impl_instance.other_wires["names"][i]
        reversed_instance.other_wires["names"][i] = new_wire_name
        # reversed_instance.other_wires["matching_number"] += 1
        # Update wire in netlist
        for reversed_block in reversed_netlist:
            # Updating Inputs
            for i, reversed_block_input_wire in enumerate(reversed_block.input_wires_names):
                if reversed_block_input_wire == old_wire_name:
                    reversed_block.input_wires_names[i] = new_wire_name
            # Updating Outputs
            for i, reversed_block_output_wire in enumerate(reversed_block.output_wires["names"]):
                if reversed_block_output_wire == old_wire_name:
                    reversed_block.output_wires["names"][i] = new_wire_name
            # Updating Other wires
            for i, reversed_block_other_wire in enumerate(reversed_block.other_wires["names"]):
                if reversed_block_other_wire == old_wire_name:
                    reversed_block.other_wires["names"][i] = new_wire_name

    return reversed_instance, reversed_netlist


def update_netlists_from_carries_and_ffs_mapping(mapped_carries, golden_netlist, reversed_netlist):
    """Updates the nets of the netlist structure with the new mapped ffs"""

    # Update netlist with the mapped carries
    # Loop through the mapped carries
    for mapped_pair in mapped_carries:
        # Loop through the impl_netlist
        for impl_instance in golden_netlist:
            # Find impl_carry
            if mapped_pair[0] == impl_instance.instance["name"]:
                # print(mapped_pair[0], " with ", impl_instance.instance["name"])
                # Loop through the reversed_netlist
                for reversed_instance in reversed_netlist:
                    # Find reversed_carry
                    if mapped_pair[1] == reversed_instance.instance["name"]:
                        # print(mapped_pair[1], " with ", reversed_instance.instance["name"])
                        reversed_instance, reversed_netlist = update_inputs_in_reversed_carry(
                            reversed_instance, impl_instance, reversed_netlist
                        )
                        reversed_instance, reversed_netlist = update_outputs_in_reversed_carry(
                            reversed_instance, impl_instance, reversed_netlist
                        )
                        reversed_instance, reversed_netlist = update_other_wires_in_reversed_carry(
                            reversed_instance, impl_instance, reversed_netlist
                        )
                        # Done updating CARRY

    # Update netlist with the mapped flipflops (May not be needed)

    return golden_netlist, reversed_netlist
