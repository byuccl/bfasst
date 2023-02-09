def make_configuration_bits_list_to_compare(conf_bits):
    list = []

    for num in conf_bits:
        pair = []
        pair.append(num)
        pair.append("not_found")
        list.append(pair)

    return list


def conf_bits_match(list_1, list_2):

    for pair_1 in list_1:
        for pair_2 in list_2:
            if (
                (pair_1[0] == pair_2[0])
                and (pair_1[1] == "not_found")
                and (pair_2[1] == "not_found")
            ):
                pair_1[1] = "found"
                pair_2[1] = "found"

    for pair_1 in list_1:
        if pair_1[1] == "not_found":
            return False

    for pair_2 in list_2:
        if pair_2[1] == "not_found":
            return False

    return True


def map_flipflops_based_on_conf_bits(flipflops_data_1, flipflops_data_2):
    mapped_flipflops = []
    # Loop through each pair in the mapped FFs data_1
    for data_1 in flipflops_data_1:
        conf_bits_1 = make_configuration_bits_list_to_compare(data_1.configuration_bits)
        # Loop through each pair in the mapped FFs data_2
        for data_2 in flipflops_data_2:
            conf_bits_2 = make_configuration_bits_list_to_compare(
                data_2.configuration_bits
            )
            # Check if they match
            if conf_bits_match(conf_bits_1, conf_bits_2):
                mapped_flipflops.append([data_1.flipflop_name, data_2.flipflop_name])

    return mapped_flipflops