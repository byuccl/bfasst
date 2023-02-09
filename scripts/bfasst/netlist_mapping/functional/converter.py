# For each hex char that it gets, it adds 4 binary numbers to the list
def hex_to_bin(conf_bits):
    new_list = []
    # Transforming each hex conf_bit to a bin
    for char in conf_bits:
        if char == "0":
            new_list.extend(["0", "0", "0", "0"])
        if char == "1":
            new_list.extend(["0", "0", "0", "1"])
        if char == "2":
            new_list.extend(["0", "0", "1", "0"])
        if char == "3":
            new_list.extend(["0", "0", "1", "1"])
        if char == "4":
            new_list.extend(["0", "1", "0", "0"])
        if char == "5":
            new_list.extend(["0", "1", "0", "1"])
        if char == "6":
            new_list.extend(["0", "1", "1", "0"])
        if char == "7":
            new_list.extend(["0", "1", "1", "1"])
        if char == "8":
            new_list.extend(["1", "0", "0", "0"])
        if char == "9":
            new_list.extend(["1", "0", "0", "1"])
        if char == "a":
            new_list.extend(["1", "0", "1", "0"])
        if char == "b":
            new_list.extend(["1", "0", "1", "1"])
        if char == "c":
            new_list.extend(["1", "1", "0", "0"])
        if char == "d":
            new_list.extend(["1", "1", "0", "1"])
        if char == "e":
            new_list.extend(["1", "1", "1", "0"])
        if char == "f":
            new_list.extend(["1", "1", "1", "1"])

    return new_list


# For 4 bin chars, it returns a hex char
def bin_to_hex(conf_bits):
    new_list = []
    # Iterate through all the binary lists
    i = 0
    bin_num = ""
    for bin_char in conf_bits:
        bin_num += bin_char
        # Select the hex character to append to the new list
        if bin_num == "0000":
            new_list.append("0")
        if bin_num == "0001":
            new_list.append("1")
        if bin_num == "0010":
            new_list.append("2")
        if bin_num == "0011":
            new_list.append("3")
        if bin_num == "0100":
            new_list.append("4")
        if bin_num == "0101":
            new_list.append("5")
        if bin_num == "0110":
            new_list.append("6")
        if bin_num == "0111":
            new_list.append("7")
        if bin_num == "1000":
            new_list.append("8")
        if bin_num == "1001":
            new_list.append("9")
        if bin_num == "1010":
            new_list.append("a")
        if bin_num == "1011":
            new_list.append("b")
        if bin_num == "1100":
            new_list.append("c")
        if bin_num == "1101":
            new_list.append("d")
        if bin_num == "1110":
            new_list.append("e")
        if bin_num == "1111":
            new_list.append("f")

        if i == 3:
            i = 0
            bin_num = ""
        else:
            i += 1

    return new_list


def get_reversed_bin_for_each_hex(conf_bits):
    new_list = []
    # Transforming each hex conf_bit to a bin
    for char in conf_bits:
        if char == "0":
            new_list.extend(["0", "0", "0", "0"])
        if char == "1":
            new_list.extend(["1", "0", "0", "0"])
        if char == "2":
            new_list.extend(["0", "1", "0", "0"])
        if char == "3":
            new_list.extend(["1", "1", "0", "0"])
        if char == "4":
            new_list.extend(["0", "0", "1", "0"])
        if char == "5":
            new_list.extend(["1", "0", "1", "0"])
        if char == "6":
            new_list.extend(["0", "1", "1", "0"])
        if char == "7":
            new_list.extend(["1", "1", "1", "0"])
        if char == "8":
            new_list.extend(["0", "0", "0", "1"])
        if char == "9":
            new_list.extend(["1", "0", "0", "1"])
        if char == "a":
            new_list.extend(["0", "1", "0", "1"])
        if char == "b":
            new_list.extend(["1", "1", "0", "1"])
        if char == "c":
            new_list.extend(["0", "0", "1", "1"])
        if char == "d":
            new_list.extend(["1", "0", "1", "1"])
        if char == "e":
            new_list.extend(["0", "1", "1", "1"])
        if char == "f":
            new_list.extend(["1", "1", "1", "1"])

    return new_list