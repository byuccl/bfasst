# Structural Mapping Algorithm developed for the bfasst project in the BYU CCL
# Inputs: golden_netlist reversed_netlist
# Outputs: Mapped Points to be compared (It is focused on IBUFs, OBUFs, and FFs)
# Follows the format to be used with Conformal Equivalence Checking
# WARNING: Netlists neet to have the exact same input and output ports!
# WARNING: Netlists need to have different names for their internal wires!
# WARNING: All blocks need to only have one output!

from operator import truediv
from unicodedata import name
import spydrnet as sdn
import argparse
from sys import stdout

print_file = None


def print_out(*args, **kwargs):
    global print_file
    return print(*args, file=print_file, **kwargs)


class Instance:
    def __init__(
        self,
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
    ):
        self.instance_name = instance_name
        self.instance_type = instance_type
        self.input_wires_names = input_wires_names
        self.input_wires_number = input_wires_number
        self.input_wires_matching_number = input_wires_matching_number
        self.output_wires_names = output_wires_names
        self.output_wires_number = output_wires_number
        self.output_wires_matching_number = output_wires_matching_number
        self.other_wires_names = other_wires_names
        self.other_wires_number = other_wires_number


def generate_conformal_mapped_points_file(
    top_instance, golden_module_name, reversed_module_name
):
    # Loop through each of the ports in the instance
    for top_port in top_instance.get_ports():
        if "IN" in str(top_port.direction):
            if len(top_port.pins) > 1:
                for pin in top_port.pins:
                    if pin.wire is not None:
                        input_name = (
                            pin.wire.cable.name + "[" + str(pin.wire.index()) + "]"
                        )
                        print_out(
                            f"add mapped points {input_name} {input_name} "
                            + f"-type PI PI -module {golden_module_name} "
                            + f"{reversed_module_name}"
                        )
            else:
                print_out(
                    f"add mapped points {top_port.name} {top_port.name}"
                    + f" -type PI PI -module {golden_module_name} "
                    + f"{reversed_module_name}"
                )
        elif "OUT" in str(top_port.direction):
            if len(top_port.pins) > 1:
                for pin in top_port.pins:
                    if pin.wire is not None:
                        input_name = f"{pin.wire.cable.name}[{pin.wire.index()}]"
                        print_out(
                            f"add mapped points {input_name} {input_name}"
                            + f" -type PO PO -module {golden_module_name} "
                            + f"{reversed_module_name}"
                        )
            else:
                print_out(
                    f"add mapped points {top_port.name} {top_port.name}"
                    + f" -type PO PO -module {golden_module_name} "
                    + f"{reversed_module_name}"
                )
        else:
            print_out("Unable to recognize port of the top module!")


def generate_mapped_points_file(
    mapped_points, golden_module_name, reversed_module_name
):
    for mapped_pair_and_types in mapped_points:
        if (mapped_pair_and_types[2] == "IBUF") and (
            mapped_pair_and_types[3] == "IBUF"
        ):
            print_out(
                "add mapped points "
                + mapped_pair_and_types[0]
                + " "
                + mapped_pair_and_types[1]
                + " -type PI PI -module "
                + golden_module_name
                + " "
                + reversed_module_name
            )
        elif (mapped_pair_and_types[2] == "OBUF") and (
            mapped_pair_and_types[3] == "OBUF"
        ):
            print_out(
                "add mapped points "
                + mapped_pair_and_types[0]
                + " "
                + mapped_pair_and_types[1]
                + " -type PO PO -module "
                + golden_module_name
                + " "
                + reversed_module_name
            )
        elif (mapped_pair_and_types[2] == "FDRE") and (
            mapped_pair_and_types[3] == "FDRE"
        ):
            print_out(
                "add mapped points "
                + mapped_pair_and_types[0]
                + " "
                + mapped_pair_and_types[1]
                + " -type DFF DFF -module "
                + golden_module_name
                + " "
                + reversed_module_name
            )
        elif (
            ("LUT" in mapped_pair_and_types[2]) and ("LUT" in mapped_pair_and_types[3])
        ) or (
            (mapped_pair_and_types[2] == "BUFG")
            and (mapped_pair_and_types[3] == "BUFG")
        ):
            pass
        else:
            print_out("Unable to recognize the types of the mapped points!")
            print_out(
                "Add more code to the generate_mapped_points_file function in netlist_mapping.py"
            )


def print_mapped_blocks(mapped_points):
    for mapped_pair in mapped_points:
        print_out(mapped_pair[0] + " <-> " + mapped_pair[1])


def print_netlist(netlist):
    for instance in netlist:
        print_out(instance.instance_name)
        print_out(instance.instance_type)
        print_out("Inputs")
        print_out(instance.input_wires_names)
        print_out(instance.input_wires_number)
        print_out(instance.input_wires_matching_number)
        print_out("Outputs")
        print_out(instance.output_wires_names)
        print_out(instance.output_wires_number)
        print_out(instance.output_wires_matching_number)
        print_out("Others")
        print_out(instance.other_wires_names)
        print_out(instance.other_wires_number, "\n")


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
                if "I" in pin.inner_pin.port.name:
                    input_wires_names.append(wire_name)
                elif "D" in pin.inner_pin.port.name:
                    input_wires_names.append(wire_name)
                elif "O" in pin.inner_pin.port.name:
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


def main(golden_netlist, reversed_netlist, file=stdout):
    global print_file
    if file != stdout:
        print_file = open(file, "w")
    else:
        print_file = stdout
    try:
        ################ Fetching Data from Golden netlist ################
        # Loads the first netlist as intermediate representation (ir1)
        ir1 = sdn.parse(golden_netlist)
        # Get the first library in the netlist
        library1 = ir1.libraries[0]
        golden_netlist = get_netlist(library1)

        ################ Fetching Data from Reversed netlist ################
        # Loads the second netlist as intermediate representation (ir2)
        ir2 = sdn.parse(reversed_netlist)
        # Get the first library in the netlist
        library2 = ir2.libraries[0]
        reversed_netlist = get_netlist(library2)

        # Print Data Before Mapping
        # ################ Printing Data from Golden netlist ##################
        # print_out("golden_netlist")
        # print_netlist(golden_netlist)

        # ################ Printing Data from Reversed netlist ################
        # print_out("reversed_netlist")
        # print_netlist(reversed_netlist)

        ########################## Mapping Algorithm ##########################
        mapped_points = []
        mapped_blocks = 0
        progress = True
        while ((len(reversed_netlist) - 2) != mapped_blocks) and (
            progress
        ):  # - 2 for G and P (Which should stay unmapped for now)
            progress = False
            # Loop through reversed netlist blocks
            for reversed_instance in reversed_netlist:
                # If instance has unmatching wires
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
                        # If instances have same # of wires as input, output, and other
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
                            # print_out(reversed_instance.instance_name + " vs " + impl_instance.instance_name)
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
                            if (input_wires_matching > 0) or (
                                output_wires_matching > 0
                            ):
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
                                higher_potential_instances.append(
                                    potential_instances[i]
                                )
                        # If it is only one save the instance, if not prepare for no mapping!
                        if len(higher_potential_instances) == 1:
                            instances_matching += 1
                            saved_instance = higher_potential_instances[0][0]
                        else:
                            instances_matching += 2
                    if instances_matching == 1:
                        # Mapping the nets of the block!
                        maps_performed = 0
                        # Updating the number of matching wires the first time
                        if (reversed_instance.input_wires_matching_number == 0) and (
                            reversed_instance.output_wires_matching_number == 0
                        ):
                            for reversed_wire in reversed_instance.input_wires_names:
                                for impl_wire in saved_instance.input_wires_names:
                                    if reversed_wire == impl_wire:
                                        reversed_instance.input_wires_matching_number += (
                                            1
                                        )
                            for reversed_wire in reversed_instance.output_wires_names:
                                for impl_wire in saved_instance.output_wires_names:
                                    if reversed_wire == impl_wire:
                                        reversed_instance.output_wires_matching_number += (
                                            1
                                        )
                            maps_performed += 1
                        # Update the ummaped wire
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
                            for i, impl_wire in enumerate(
                                saved_instance.input_wires_names
                            ):
                                for (
                                    reversed_wire
                                ) in reversed_instance.input_wires_names:
                                    if reversed_wire == impl_wire:
                                        impl_input_found = True
                                if impl_input_found == False:
                                    impl_input_index = i
                                impl_input_found = False
                            # Map the net
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
                                        reversed_block.input_wires_names[
                                            i
                                        ] = new_wire_name
                                for i, reversed_block_output_wire in enumerate(
                                    reversed_block.output_wires_names
                                ):
                                    if reversed_block_output_wire == old_wire_name:
                                        reversed_block.output_wires_names[
                                            i
                                        ] = new_wire_name
                            maps_performed += 1
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
                                        reversed_instance.output_wires_names[
                                            i
                                        ] = impl_wire
                                        reversed_instance.output_wires_matching_number += (
                                            1
                                        )
                                        # Loop through all the reversed blocks, and if they have inputs
                                        # equal to the reversed_wire change them to be the impl_wire
                                        for reversed_block in reversed_netlist:
                                            for (
                                                i,
                                                reversed_block_input_wire,
                                            ) in enumerate(
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
                        if maps_performed > 0:
                            mapped_blocks += 1
                            progress = True
                            mapped_pair_and_types = []
                            mapped_pair_and_types.append(saved_instance.instance_name)
                            mapped_pair_and_types.append(
                                reversed_instance.instance_name
                            )
                            mapped_pair_and_types.append(saved_instance.instance_type)
                            mapped_pair_and_types.append(
                                reversed_instance.instance_type
                            )
                            mapped_points.append(mapped_pair_and_types)

        # ################ Prints all mapped blocks ################
        # print_mapped_blocks(mapped_points)

        # ################ Print all mapped instances following conformal syntax ################
        # generate_mapped_points_file(mapped_points, ir1.top_instance.reference.name, ir2.top_instance.reference.name)

        # ################ Print the Mapped Points File to be used by Conformal ################
        generate_conformal_mapped_points_file(
            ir1.top_instance,
            ir1.top_instance.reference.name,
            ir2.top_instance.reference.name,
        )

        # Print Data After Mapping
        # ################ Printing Data from Reversed netlist ################
        # print_out("///////////////////////////////// reversed_netlist /////////////////////////////////")
        # print_netlist(reversed_netlist)

        # ################ Printing Data from Golden netlist ##################
        # print_out("///////////////////////////////// golden_netlist /////////////////////////////////")
        # print_netlist(golden_netlist)
    except Exception as e:
        raise e
    finally:
        if print_file != stdout:
            print_file.close()


if __name__ == "__main__":
    ################ Parsing command line arguments ################
    parser = argparse.ArgumentParser()
    parser.add_argument("golden_netlist")
    parser.add_argument("reversed_netlist")
    args = parser.parse_args()
    main(args.golden_netlist, args.reversed_netlist)
