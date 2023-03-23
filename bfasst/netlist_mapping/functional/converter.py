"""This file contains functions used to transform numbers between hex and binary"""


def hex_to_bin_first_half(char, new_list):
    """Used to compare char for the first half"""

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

    return new_list


def hex_to_bin_second_half(char, new_list):
    """Used to compare char for the second half"""

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


def hex_to_bin(conf_bits):
    """Function used to transform each hex conf_bit to a binary number.
    For each hex char that it gets, it adds 4 binary numbers to the list."""

    new_list = []

    for char in conf_bits:
        new_list = hex_to_bin_first_half(char, new_list)
        new_list = hex_to_bin_second_half(char, new_list)

    return new_list


def bin_to_hex_first_half(bin_num, new_list):
    """Used to compare the first half of binary numbers"""

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

    return new_list


def bin_to_hex_second_half(bin_num, new_list):
    """Used to compare the second half of binary numbers"""

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

    return new_list


def bin_to_hex(conf_bits):
    """In this function for 4 bin chars, it returns a hex char."""

    new_list = []
    # Iterate through all the binary lists
    i = 0
    bin_num = ""
    for bin_char in conf_bits:
        bin_num += bin_char
        # Select the hex character to append to the new list
        new_list = bin_to_hex_first_half(bin_num, new_list)
        new_list = bin_to_hex_second_half(bin_num, new_list)

        if i == 3:
            i = 0
            bin_num = ""
        else:
            i += 1

    return new_list


def rev_hex_to_bin_compare_first_half(char, new_list):
    """Used to compare char for the first half"""

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

    return new_list


def rev_hex_to_bin_compare_second_half(char, new_list):
    """Used to compare char for the second half"""

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


def get_reversed_bin_for_each_hex(conf_bits):
    """This function transforms each hex conf_bit to a bin num"""

    new_list = []

    for char in conf_bits:
        new_list = rev_hex_to_bin_compare_first_half(char, new_list)
        new_list = rev_hex_to_bin_compare_second_half(char, new_list)

    return new_list
