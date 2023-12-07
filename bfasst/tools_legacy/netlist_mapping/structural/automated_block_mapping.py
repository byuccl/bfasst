"""Algorithm used to mapped netlists based on their structure"""

from bfasst.netlist_mapping.structural.updating_reversed_netlist import (
    update_wires_in_reversed_netlist,
)


def find_potential_instances(golden_netlist, reversed_instance, potential_instances):
    """Finds potential instances that match with the reversed_instance"""

    # Loop through golden netlist blocks
    for impl_instance in golden_netlist:
        # If instances have same # of wires as input, output, and other
        # That means that they are structurally the same!
        if (
            (reversed_instance.input_wires["number"] == impl_instance.input_wires["number"])
            and (reversed_instance.output_wires["number"] == impl_instance.output_wires["number"])
            and (reversed_instance.other_wires["number"] == impl_instance.other_wires["number"])
        ):
            # Check for matching in inputs
            input_wires_matching = 0
            for reversed_wire in reversed_instance.input_wires["names"]:
                for impl_wire in impl_instance.input_wires["names"]:
                    if reversed_wire == impl_wire:
                        input_wires_matching += 1
            # Check for matching in outputs
            output_wires_matching = 0
            for reversed_wire in reversed_instance.output_wires["names"]:
                for impl_wire in impl_instance.output_wires["names"]:
                    if reversed_wire == impl_wire:
                        output_wires_matching += 1
            # If they match, add to potential_instances
            if (input_wires_matching > 0) or (output_wires_matching > 0):
                wires_matching = input_wires_matching + output_wires_matching
                potential_pair = [impl_instance, wires_matching]
                potential_instances.append(potential_pair)

    return potential_instances


def get_higher_potential_instances(potential_instances, higher_potential_instances):
    """Gets the potential instances with the highest matching wires number"""

    # Getting the max number of matching wires
    max_num = 0
    potential_instances_len = len(potential_instances)
    for i in range(potential_instances_len):
        matching_wires = potential_instances[i][1]
        if matching_wires > max_num:
            max_num = matching_wires
    # Getting the instances with the max number of matching wires
    for i in range(potential_instances_len):
        matching_wires = potential_instances[i][1]
        if matching_wires == max_num:
            higher_potential_instances.append(potential_instances[i])

    return higher_potential_instances


def check_for_potential_mapping(
    golden_netlist,
    reversed_instance,
    saved_instance,
    instances_matching,
):
    """Used to check if the reversed instance can be mapped"""

    potential_instances = []
    higher_potential_instances = []

    potential_instances = find_potential_instances(
        golden_netlist, reversed_instance, potential_instances
    )

    # Check if it is only one, if not get the ones with highest number of matching wires
    if len(potential_instances) == 1:
        instances_matching += 1
        saved_instance = potential_instances[0][0]
    elif len(potential_instances) > 1:
        higher_potential_instances = get_higher_potential_instances(
            potential_instances, higher_potential_instances
        )

        # If it is only one save the instance, if not prepare for no mapping!
        if len(higher_potential_instances) == 1:
            instances_matching += 1
            saved_instance = higher_potential_instances[0][0]
        else:
            instances_matching += 2

    return saved_instance, instances_matching


def update_matching_wires_number(reversed_instance, saved_instance, maps_performed):
    """Updates matching wire number for their first time"""

    for reversed_wire in reversed_instance.input_wires["names"]:
        for impl_wire in saved_instance.input_wires["names"]:
            if reversed_wire == impl_wire:
                reversed_instance.input_wires["matching_number"] += 1
    for reversed_wire in reversed_instance.output_wires["names"]:
        for impl_wire in saved_instance.output_wires["names"]:
            if reversed_wire == impl_wire:
                reversed_instance.output_wires["matching_number"] += 1
    maps_performed += 1

    return maps_performed


def get_reversed_input_index(reversed_instance, saved_instance):
    """Gets the reversed input index to map"""

    reversed_input_index = 0
    reversed_input_found = False
    for i, reversed_wire in enumerate(reversed_instance.input_wires["names"]):
        for impl_wire in saved_instance.input_wires["names"]:
            if reversed_wire == impl_wire:
                reversed_input_found = True
        if reversed_input_found is False:
            reversed_input_index = i
        reversed_input_found = False

    return reversed_input_index


def get_impl_input_index(saved_instance, reversed_instance):
    """Gets the implemented input index to map"""

    impl_input_index = 0
    impl_input_found = False
    for i, impl_wire in enumerate(saved_instance.input_wires["names"]):
        for reversed_wire in reversed_instance.input_wires["names"]:
            if reversed_wire == impl_wire:
                impl_input_found = True
        if impl_input_found is False:
            impl_input_index = i
        impl_input_found = False

    return impl_input_index


def update_reversed_netlist(reversed_netlist, old_wire_name, new_wire_name):
    """Updates the reversed netlist after mapping an input"""

    update_wires_in_reversed_netlist(reversed_netlist, old_wire_name, new_wire_name)

    return reversed_netlist


def update_reversed_netlist_inputs(reversed_netlist, reversed_wire, impl_wire):
    """Updates the inputs of the reversed netlist with the new output wire"""

    for reversed_block in reversed_netlist:
        for i, reversed_block_input_wire in enumerate(reversed_block.input_wires["names"]):
            if reversed_block_input_wire == reversed_wire:
                reversed_block.input_wires["names"][i] = impl_wire

    return reversed_netlist


def map_output_nets(reversed_netlist, reversed_instance, saved_instance):
    """Maps the output net of the reversed_instance and updates inputs in the netlist"""

    for i, reversed_wire in enumerate(reversed_instance.output_wires["names"]):
        for impl_wire in saved_instance.output_wires["names"]:
            if reversed_wire != impl_wire:
                reversed_instance.output_wires["names"][i] = impl_wire
                reversed_instance.output_wires["matching_number"] += 1
                # Loop through all the reversed blocks, and if they have inputs
                # equal to the reversed_wire change them to be the impl_wire
                reversed_netlist = update_reversed_netlist_inputs(
                    reversed_netlist, reversed_wire, impl_wire
                )

    return reversed_netlist


def automatically_map_blocks(golden_netlist, reversed_netlist, mapped_points, init_mapped_blocks):
    """Maps netlists based on their cells and nets"""

    mapped_blocks = init_mapped_blocks
    progress = True
    # Loop until all blocks have been mapped or there is no more progress
    while ((len(reversed_netlist) - 2) != mapped_blocks) and (
        progress
    ):  # - 2 for G and P (Which should stay unmapped for now)
        progress = False
        # Loop through reversed netlist blocks
        for reversed_instance in reversed_netlist:
            # If instance has unmatching wires (Not mapped yet)
            if (
                reversed_instance.input_wires["number"]
                != reversed_instance.input_wires["matching_number"]
            ) and (
                reversed_instance.output_wires["number"]
                != reversed_instance.output_wires["matching_number"]
            ):
                # Get the implemented potential instance to map
                saved_instance = None
                instances_matching = 0
                saved_instance, instances_matching = check_for_potential_mapping(
                    golden_netlist,
                    reversed_instance,
                    saved_instance,
                    instances_matching,
                )
                # ? Actual Mapping!!!
                if instances_matching == 1:
                    # Mapping the nets of the block!
                    maps_performed = 0
                    # Updating the number of matching wires the first time!
                    if (reversed_instance.input_wires["matching_number"] == 0) and (
                        reversed_instance.output_wires["matching_number"] == 0
                    ):
                        maps_performed = update_matching_wires_number(
                            reversed_instance, saved_instance, maps_performed
                        )
                    # Input Mapping!!!
                    if (
                        reversed_instance.input_wires["number"]
                        - reversed_instance.input_wires["matching_number"]
                    ) == 1:
                        # Map Input Net
                        # Find Input wire in the reversed_instance
                        # that is not found in the impl_instance
                        reversed_input_index = get_reversed_input_index(
                            reversed_instance, saved_instance
                        )
                        # Find Input wire in the impl_instance
                        # that is not found in the reversed_instance
                        impl_input_index = get_impl_input_index(saved_instance, reversed_instance)
                        # Map the input net
                        old_wire_name = reversed_instance.input_wires["names"][reversed_input_index]
                        new_wire_name = saved_instance.input_wires["names"][impl_input_index]
                        reversed_instance.input_wires["names"][reversed_input_index] = new_wire_name
                        reversed_instance.input_wires["matching_number"] += 1
                        # Loop through all the reversed blocks, and if they have inputs or
                        # outputs equal to the old_wire_name change them to be the new_wire_name
                        reversed_netlist = update_reversed_netlist(
                            reversed_netlist, old_wire_name, new_wire_name
                        )
                        maps_performed += 1
                    # Output Mapping!!!
                    if (
                        reversed_instance.output_wires["number"]
                        - reversed_instance.output_wires["matching_number"]
                    ) == 1:
                        # Map Output Net
                        # This should work if all blocks in the netlist only have one output wire!
                        reversed_netlist = map_output_nets(
                            reversed_netlist, reversed_instance, saved_instance
                        )
                        maps_performed += 1
                    # Important!
                    # > 0: The algorithm maps the most similar instances.
                    #      (Same structure and the most matching input and output wires)
                    # > 1: The algorithm only maps the most similar instances that
                    #      are only missing one output or input.
                    if maps_performed > 1:
                        mapped_blocks += 1
                        progress = True
                        mapped_pair_and_types = []
                        mapped_pair_and_types.append(saved_instance.instance["name"])
                        mapped_pair_and_types.append(reversed_instance.instance["name"])
                        mapped_pair_and_types.append(saved_instance.instance["type"])
                        mapped_pair_and_types.append(reversed_instance.instance["type"])
                        mapped_points.append(mapped_pair_and_types)

    return mapped_points


def print_mapped_blocks(mapped_points):
    """Prints blocks mapped through automated block mapping"""

    for mapped_pair in mapped_points:
        print(mapped_pair[0] + " <-> " + mapped_pair[1])
