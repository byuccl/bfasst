# This file contains an automated algorithm used to mapped netlists based on their structure

def automatically_map_blocks(
    golden_netlist, reversed_netlist, mapped_points, init_mapped_blocks
):
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
                reversed_instance.input_wires_number
                != reversed_instance.input_wires_matching_number
            ) and (
                reversed_instance.output_wires_number
                != reversed_instance.output_wires_matching_number
            ):
                potential_instances = []
                higher_potential_instances = []
                saved_instance = None
                instances_matching = 0
                # Loop through golden netlist blocks
                for impl_instance in golden_netlist:
                    # If instances have same # of wires as input, output, and other (Are structurally the same)
                    if (
                        (
                            reversed_instance.input_wires_number
                            == impl_instance.input_wires_number
                        )
                        and (
                            reversed_instance.output_wires_number
                            == impl_instance.output_wires_number
                        )
                        and (
                            reversed_instance.other_wires_number
                            == impl_instance.other_wires_number
                        )
                    ):
                        # print(reversed_instance.instance_name + " vs " + impl_instance.instance_name)
                        # Check for matching in inputs
                        input_wires_matching = 0
                        for reversed_wire in reversed_instance.input_wires_names:
                            for impl_wire in impl_instance.input_wires_names:
                                if reversed_wire == impl_wire:
                                    input_wires_matching += 1
                        # Check for matching in outputs
                        output_wires_matching = 0
                        for reversed_wire in reversed_instance.output_wires_names:
                            for impl_wire in impl_instance.output_wires_names:
                                if reversed_wire == impl_wire:
                                    output_wires_matching += 1
                        # If they match, add to potential_instances
                        if (input_wires_matching > 0) or (output_wires_matching > 0):
                            wires_matching = (
                                input_wires_matching + output_wires_matching
                            )
                            potential_pair = [impl_instance, wires_matching]
                            potential_instances.append(potential_pair)
                # Check if it is only one, if not get the ones with highest number of matching wires
                if len(potential_instances) == 1:
                    instances_matching += 1
                    saved_instance = potential_instances[0][0]
                elif len(potential_instances) > 1:
                    # Getting the max number of matching wires
                    max_num = 0
                    for i in range(len(potential_instances)):
                        matching_wires = potential_instances[i][1]
                        if matching_wires > max_num:
                            max_num = matching_wires
                    # Getting the instances with the max number of matching wires
                    for i in range(len(potential_instances)):
                        matching_wires = potential_instances[i][1]
                        if matching_wires == max_num:
                            higher_potential_instances.append(potential_instances[i])
                    # If it is only one save the instance, if not prepare for no mapping!
                    if len(higher_potential_instances) == 1:
                        instances_matching += 1
                        saved_instance = higher_potential_instances[0][0]
                    else:
                        instances_matching += 2
                # ? Actual Mapping!!!
                if instances_matching == 1:
                    # Mapping the nets of the block!
                    maps_performed = 0
                    # Updating the number of matching wires the first time!
                    if (reversed_instance.input_wires_matching_number == 0) and (
                        reversed_instance.output_wires_matching_number == 0
                    ):
                        for reversed_wire in reversed_instance.input_wires_names:
                            for impl_wire in saved_instance.input_wires_names:
                                if reversed_wire == impl_wire:
                                    reversed_instance.input_wires_matching_number += 1
                        for reversed_wire in reversed_instance.output_wires_names:
                            for impl_wire in saved_instance.output_wires_names:
                                if reversed_wire == impl_wire:
                                    reversed_instance.output_wires_matching_number += 1
                        maps_performed += 1
                    # Input Mapping!!!
                    if (
                        reversed_instance.input_wires_number
                        - reversed_instance.input_wires_matching_number
                    ) == 1:
                        # Map Input Net
                        # Find Input wire in the reversed_instance that is not found in the impl_instance
                        reversed_input_index = 0
                        reversed_input_found = False
                        for i, reversed_wire in enumerate(
                            reversed_instance.input_wires_names
                        ):
                            for impl_wire in saved_instance.input_wires_names:
                                if reversed_wire == impl_wire:
                                    reversed_input_found = True
                            if reversed_input_found == False:
                                reversed_input_index = i
                            reversed_input_found = False
                        # Find Input wire in the impl_instance that is not found in the reversed_instance
                        impl_input_index = 0
                        impl_input_found = False
                        for i, impl_wire in enumerate(saved_instance.input_wires_names):
                            for reversed_wire in reversed_instance.input_wires_names:
                                if reversed_wire == impl_wire:
                                    impl_input_found = True
                            if impl_input_found == False:
                                impl_input_index = i
                            impl_input_found = False
                        # Map the input net
                        old_wire_name = reversed_instance.input_wires_names[
                            reversed_input_index
                        ]
                        new_wire_name = saved_instance.input_wires_names[
                            impl_input_index
                        ]
                        reversed_instance.input_wires_names[
                            reversed_input_index
                        ] = new_wire_name
                        reversed_instance.input_wires_matching_number += 1
                        # Loop through all the reversed blocks, and if they have inputs or
                        # outputs equal to the old_wire_name change them to be the new_wire_name
                        for reversed_block in reversed_netlist:
                            for i, reversed_block_input_wire in enumerate(
                                reversed_block.input_wires_names
                            ):
                                if reversed_block_input_wire == old_wire_name:
                                    reversed_block.input_wires_names[i] = new_wire_name
                            for i, reversed_block_output_wire in enumerate(
                                reversed_block.output_wires_names
                            ):
                                if reversed_block_output_wire == old_wire_name:
                                    reversed_block.output_wires_names[i] = new_wire_name
                        maps_performed += 1
                    # Output Mapping!!!
                    if (
                        reversed_instance.output_wires_number
                        - reversed_instance.output_wires_matching_number
                    ) == 1:
                        # Map Output Net
                        # This should work if all blocks in the netlist only have one output wire!
                        for i, reversed_wire in enumerate(
                            reversed_instance.output_wires_names
                        ):
                            for impl_wire in saved_instance.output_wires_names:
                                if reversed_wire != impl_wire:
                                    reversed_instance.output_wires_names[i] = impl_wire
                                    reversed_instance.output_wires_matching_number += 1
                                    # Loop through all the reversed blocks, and if they have inputs
                                    # equal to the reversed_wire change them to be the impl_wire
                                    for reversed_block in reversed_netlist:
                                        for i, reversed_block_input_wire in enumerate(
                                            reversed_block.input_wires_names
                                        ):
                                            if (
                                                reversed_block_input_wire
                                                == reversed_wire
                                            ):
                                                reversed_block.input_wires_names[
                                                    i
                                                ] = impl_wire
                        maps_performed += 1
                    # This is an impotant statement
                    # > 0: The algorithm maps the most similar instances. (They have the same structure and the most matching input and output wires)
                    # > 1: The algorithm only maps the most similar instances that are only missing one output or input.
                    if maps_performed > 1:
                        mapped_blocks += 1
                        progress = True
                        mapped_pair_and_types = []
                        mapped_pair_and_types.append(saved_instance.instance_name)
                        mapped_pair_and_types.append(reversed_instance.instance_name)
                        mapped_pair_and_types.append(saved_instance.instance_type)
                        mapped_pair_and_types.append(reversed_instance.instance_type)
                        mapped_points.append(mapped_pair_and_types)

    return mapped_points


def print_mapped_blocks(mapped_points):
    for mapped_pair in mapped_points:
        print(mapped_pair[0] + " <-> " + mapped_pair[1])