"""File with functions to print mapped points"""

def print_conformal_input_output_points(
    top_instance, golden_module_name, reversed_module_name
):
    """Prints the mapped input and output points for conformal"""

    for top_port in top_instance.get_ports():
        if "IN" in str(top_port.direction):
            if len(top_port.pins) > 1:
                for pin in top_port.pins:
                    if pin.wire is not None:
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
                    if pin.wire is not None:
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
    """Prints the structurally mapped points for conformal"""

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
                ("LUT" in mapped_pair_and_types[2])
                and ("LUT" in mapped_pair_and_types[3])
            ):
            pass
        elif (
                (mapped_pair_and_types[2] == "BUFG")
                and (mapped_pair_and_types[3] == "BUFG")
            ):
            pass
        elif (
                (mapped_pair_and_types[2] == "IBUF")
                and (mapped_pair_and_types[3] == "IBUF")
            ):
            pass
        elif (
                (mapped_pair_and_types[2] == "OBUF")
                and (mapped_pair_and_types[3] == "OBUF")
            ):
            pass
        elif (
                (mapped_pair_and_types[2] == "MUXF7")
                and (mapped_pair_and_types[3] == "MUXF7")
            ):
            pass
        else:
            print("Unable to recognize the types of the mapped points!")
            print(mapped_pair_and_types[2])
            print(mapped_pair_and_types[3])


def print_conformal_ff_points(
    mapped_flipflops, golden_module_name, reversed_module_name, printing_structural
):
    """Prints the mapped flipflops for conformal"""

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
    """Prints the Sum Of Products"""

    tabs = ""
    for _ in range(level):
        tabs += "\t"
    print(tabs + "SOP:")

    for product in sop:
        print(
            tabs
            + "("
            + str(product.lut_inputs_num)
            + ", "
            + str(product.negated_inputs_num)
            + ")"
        )

        for lut_input in product.lut_inputs:
            print(tabs + "\t" + lut_input.input)
            if lut_input.sop is not None:
                level += 1
                level = print_sop(lut_input.sop, level)
            else:
                print(tabs + "\t" + "-")
    level -= 1
    return level


def print_data(data):
    """Prints the LUT data from the conf bits"""

    for flipflop_data in data:
        print(flipflop_data.flipflop_name)
        level = 1
        level = print_sop(flipflop_data.sop, level)
        print("\n")
