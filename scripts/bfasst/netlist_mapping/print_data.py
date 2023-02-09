# File used to define functions used to print mapped points

def print_conformal_input_output_points(
    top_instance, golden_module_name, reversed_module_name
):
    # Loop through each of the ports in the instance
    for top_port in top_instance.get_ports():
        if "IN" in str(top_port.direction):
            if len(top_port.pins) > 1:
                for pin in top_port.pins:
                    if pin.wire != None:
                        input_name = (
                            pin.wire.cable.name + "[" + str(pin.wire.index()) + "]"
                        )
                        print(
                            "add mapped points "
                            + input_name
                            + " "
                            + input_name
                            + " -type PI PI -module "
                            + golden_module_name
                            + " "
                            + reversed_module_name
                        )
            else:
                print(
                    "add mapped points "
                    + top_port.name
                    + " "
                    + top_port.name
                    + " -type PI PI -module "
                    + golden_module_name
                    + " "
                    + reversed_module_name
                )
        elif "OUT" in str(top_port.direction):
            if len(top_port.pins) > 1:
                for pin in top_port.pins:
                    if pin.wire != None:
                        input_name = (
                            pin.wire.cable.name + "[" + str(pin.wire.index()) + "]"
                        )
                        print(
                            "add mapped points "
                            + input_name
                            + " "
                            + input_name
                            + " -type PO PO -module "
                            + golden_module_name
                            + " "
                            + reversed_module_name
                        )
            else:
                print(
                    "add mapped points "
                    + top_port.name
                    + " "
                    + top_port.name
                    + " -type PO PO -module "
                    + golden_module_name
                    + " "
                    + reversed_module_name
                )
        else:
            print("Unable to recognize port of the top module!")


def print_conformal_structural_points(
    mapped_points, golden_module_name, reversed_module_name
):
    for mapped_pair_and_types in mapped_points:
        if (
            (mapped_pair_and_types[2] == "FDRE")
            and (mapped_pair_and_types[3] == "FDRE")
        ) or (
            (mapped_pair_and_types[2] == "FDSE")
            and (mapped_pair_and_types[3] == "FDSE")
        ):
            print(
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
            (
                ("LUT" in mapped_pair_and_types[2])
                and ("LUT" in mapped_pair_and_types[3])
            )
            or (
                (mapped_pair_and_types[2] == "BUFG")
                and (mapped_pair_and_types[3] == "BUFG")
            )
            or (
                (mapped_pair_and_types[2] == "IBUF")
                and (mapped_pair_and_types[3] == "IBUF")
            )
            or (
                (mapped_pair_and_types[2] == "OBUF")
                and (mapped_pair_and_types[3] == "OBUF")
            )
            or (
                (mapped_pair_and_types[2] == "MUXF7")
                and (mapped_pair_and_types[3] == "MUXF7")
            )
        ):
            pass
        else:
            print("Unable to recognize the types of the mapped points!")
            print(
                "Add more code to the print_conformal_structural_points function in print_data.py to recognize:"
            )
            print(mapped_pair_and_types[2])
            print(mapped_pair_and_types[3])


def print_conformal_ff_points(
    mapped_flipflops, golden_module_name, reversed_module_name, printing_structural
):
    for ff_names in mapped_flipflops:
        if printing_structural:
            impl_ff_name = ff_names[0][1:]
            reversed_ff_name = ff_names[1]
            print(
                "add mapped points "
                + impl_ff_name
                + " "
                + reversed_ff_name
                + " -type DFF DFF -module "
                + golden_module_name
                + " "
                + reversed_module_name
            )
        else:
            impl_ff_name = ff_names[0]
            reversed_ff_name = ff_names[1]
            print(
                "add mapped points "
                + impl_ff_name
                + " "
                + reversed_ff_name
                + " -type DFF DFF -module "
                + golden_module_name
                + " "
                + reversed_module_name
            )


def print_sop(sop, level):
    # Prepare identation based on the level
    tabs = ""
    for i in range(level):
        tabs += "\t"
    print(tabs + "SOP:")
    # Loop through the products
    for product in sop:
        print(
            tabs
            + "("
            + str(product.lut_inputs_num)
            + ", "
            + str(product.negated_inputs_num)
            + ")"
        )
        # Loop through the inputs
        for lut_input in product.lut_inputs:
            print(tabs + "\t" + lut_input.input)
            if lut_input.sop != None:
                level += 1
                level = print_sop(lut_input.sop, level)
            else:
                print(tabs + "\t" + "-")
    level -= 1
    return level


def print_data(data):
    # Loop through the flipflop data list
    for flipflop_data in data:
        print(flipflop_data.flipflop_name)
        level = 1
        level = print_sop(flipflop_data.sop, level)
        print("\n")
    pass
