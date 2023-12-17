"""This file contains functions used to map FFs based on their logic function trees"""


def restore_sop_to_not_found_state(sop):
    """Function used to return all products to their "not_found" state"""

    for product in sop:
        product.state = "not_found"
        for input_sop in product.lut_inputs:
            input_sop.state = "not_found"
            if input_sop.sop is not None:
                restore_sop_to_not_found_state(input_sop.sop)


def restore_product_inputs(product_1, product_2):
    """Function used to restore original "not_found" state for each input_sop in the products"""

    for input_sop_1 in product_1.lut_inputs:
        input_sop_1.state = "not_found"
        if input_sop_1.sop is not None:
            restore_sop_to_not_found_state(input_sop_1.sop)

    for input_sop_2 in product_2.lut_inputs:
        input_sop_2.state = "not_found"
        if input_sop_2.sop is not None:
            restore_sop_to_not_found_state(input_sop_2.sop)


def inputs_sops_match(matching_input_sops_counter, product_1, product_2):
    """Function used to map inputs to the SOPs"""

    # Loop through the LUT Inputs for sop_1
    for input_sop_1 in product_1.lut_inputs:
        # Loop throguh the LUT Inputs for sop_2
        for input_sop_2 in product_2.lut_inputs:
            # Check that both Input SOPs have not been mapped
            if (input_sop_1.state == "not_found") and (input_sop_2.state == "not_found"):
                # Check if both don't have a SOP or if their SOPs match
                if (input_sop_1.sop is None) and (input_sop_2.sop is None):
                    # Update matching status for both SOPs
                    input_sop_1.state = "found"
                    input_sop_2.state = "found"
                    # Increase number of counter for matching SOPs
                    matching_input_sops_counter += 1
                elif (input_sop_1.sop is not None) and (input_sop_2.sop is not None):
                    if sop_match(input_sop_1.sop, input_sop_2.sop):
                        # Update matching status for both SOPs
                        input_sop_1.state = "found"
                        input_sop_2.state = "found"
                        # Increase number of counter for matching SOPs
                        matching_input_sops_counter += 1

    return matching_input_sops_counter


def sop_match(sop_1, sop_2):
    """Function used to match SOPs"""

    sop_1_len = len(sop_1)
    sop_2_len = len(sop_2)
    # print(sop_1_len)
    # print(sop_2_len)
    # Check if they have the same number of products
    if sop_1_len == sop_2_len:
        products_found = 0
        # Loop through their products
        for product_1 in sop_1:
            # print("P_1")
            # print(product_1)
            for product_2 in sop_2:
                # print("P_2")
                # print(product_2)
                # Check if products match in Inputs Number and Negated Inputs
                if (
                    (product_1.num["lut_inputs"] == product_2.num["lut_inputs"])
                    and (product_1.num["negative_inputs"] == product_2.num["negative_inputs"])
                    and (product_1.state == "not_found")
                    and (product_2.state == "not_found")
                ):
                    # print("Products match in Inputs Number and Negated Inputs")
                    # print(
                    #     "product_1_lut_inputs_num: ",
                    #     product_1.num["lut_inputs"],
                    #     " product_2_lut_inputs_num: ",
                    #     product_2.num["lut_inputs"],
                    # )
                    # print(
                    #     "product_1_negative_inputs_num: ",
                    #     product_1.num["negative_inputs"],
                    #     " product_2_negative_inputs_num: ",
                    #     product_2.num["negative_inputs"],
                    # )
                    # print(
                    #     "product_1_state: ",
                    #     product_1.state,
                    #     " product_2_state: ",
                    #     product_2.state,
                    # )
                    # Check that the SOPs in their inputs also match!!!!!!!!!!!!!!!!!!!!!!!!!
                    # Reset counter for matching SOPs
                    matching_input_sops_counter = 0
                    matching_input_sops_counter = inputs_sops_match(
                        matching_input_sops_counter, product_1, product_2
                    )
                    # Check if all inputs in the product matched
                    if matching_input_sops_counter == product_1.num["lut_inputs"]:
                        # Then map this products (Say that they are found!)
                        product_1.state = "found"
                        product_2.state = "found"
                        products_found += 1
                        restore_product_inputs(product_1, product_2)
                    else:
                        restore_product_inputs(product_1, product_2)

        # print("Found " + str(products_found) + " out of " + str(sop_1_len))

        # Restore Original not_found values for each product
        restore_sop_to_not_found_state(sop_1)
        restore_sop_to_not_found_state(sop_2)

        # Check that the number of products matches the number of products found
        if products_found == sop_1_len:
            return True
        return False
    return False


def map_ffs_based_on_logic_func(flipflops_data_1, flipflops_data_2):
    """This function is used to functionally map all the FFs in the netlists"""

    mapped_flipflops = []

    for data_1 in flipflops_data_1:
        for data_2 in flipflops_data_2:
            # print("\n")
            # print("SOP to compare")
            # print(data_1.sop)
            # print(data_2.sop)
            if sop_match(data_1.sop, data_2.sop):
                # print("\t", data_1.flipflop_name)
                # print("\t", data_2.flipflop_name)
                # print("\t MADE IT!!!!!!!!!!!!")
                mapped_flipflops.append([data_1.flipflop_name, data_2.flipflop_name])

    return mapped_flipflops
