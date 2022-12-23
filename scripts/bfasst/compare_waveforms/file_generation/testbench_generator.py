"""A simple function to return the amount of data stored in the input list."""

import random


def input_num(data):

    """A simple function to return the total amount of data being stored as both inputs"""

    return len(data["input_list"])


def total_num(data):

    """A simple function to return the total amount of data being stored as both inputs
    and outputs"""

    return len(data["input_list"]) + len(data["output_list"])


def generate_random(data, random_list, test_num):

    """Generates the random signals for the testbench"""

    for bits in data["input_bits_list"]:
        if bits == 0:
            random_list.append([random.randrange(0, 2) for i in range(int(test_num))])
        else:
            random_list.append(
                [
                    random.randrange(0, (2 ** (int(bits) + 1) - 1))
                    for i in range(int(test_num))
                ]
            )
    return random_list


def write_random_state(input_signal, input_number, index, random_list):

    """Writes the current state for the random number."""

    line = ""

    if input_signal != "clk":
        if input_number == 0:
            line = f"       # 2000 {input_signal} = {random_list[input_number][index]};\n"
        else:
            line = f"       {input_signal} = {random_list[input_number][index]};\n"
    else:
        if input_number == 0:
            line = "        # 2000 "
    return line


def write_tb_name(paths, tb, is_paren):

    """Returns the line with the testbench name included."""
    if is_paren:
        line = f"    $dumpvars(1,{paths['modules'][1]}_tb);"
    else:
        line = f"module {paths['modules'][1]}_tb;"
    tb.write(line)
    return "\n"


def write_module_name(paths, data):

    """Handles writing the module declaration."""

    line = f"{paths['modules'][0]} instanceOf ("
    for total, j in zip(data["total_list"], range(total_num(data))):
        total = str(total)
        if j == total_num(data) - 1:
            line = f"{line}{total});\n"
        else:
            line = f"{line}{total}, "
    return line


def write_inputs(data, tb):

    """Handles writing all of the input signals."""

    for signal_in, bits in zip(data["input_list"], data["input_bits_list"]):
        signal_in = str(signal_in)
        bits = str(bits)
        if signal_in != "clk":
            line = f"reg [{bits}:0] {signal_in} = 0;\n"
            tb.write(line)
        else:
            line = "reg clk = 0;\n"
            tb.write(line)
        line = ""
    return ""


def write_outputs(data, tb):

    """Handles writing all of the output signals."""

    for signal_out, bits in zip(data["output_list"], data["output_bits_list"]):
        signal_out = str(signal_out)
        bits = str(bits)
        line = f"wire [{bits}:0] {signal_out};\n"
        tb.write(line)
    return ""


def check_clk(data, line):
    """Confirms that a clock is not declared as input signal and is set to 0."""
    for input_signal in data["input_list"]:
        if input_signal == "clk":
            line = ""
    return line


def write_random_lines(data, test_num, random_list, tb):

    """Writes lines for all randomly generated numbers."""

    # The actual logic for adding random numbers to the testbench.
    for j in range(int(test_num)):
        for input_signal, input_number in zip(
            data["input_list"], range(input_num(data))
        ):
            line = write_random_state(input_signal, input_number, j, random_list)
            tb.write(line)
            line = ""
        tb.write("\n")
    return "        # 2000 $finish;"


def parse_line(line, data, tb, test_num, paths, random_list):

    """Parses the individual line."""

    if "TB_NAME;" in line:
        line = write_tb_name(paths, tb, False)

    if "TB_NAME)" in line:
        line = write_tb_name(paths, tb, True)

    if "INPUTS" in line:
        line = write_inputs(data, tb)

    if "OUTPUTS" in line:
        line = write_outputs(data, tb)

    if "MODULE_NAME" in line:
        line = write_module_name(paths, data)

    if "reg clk = 0;" in line:
        line = check_clk(data, line)

    if "/*SIGNALS" in line:
        line = write_random_lines(data, test_num, random_list, tb)

    tb.write(line)
    return test_num


def generate_first_testbench(paths, test_num, data, i):

    """This function creates the initial testbench that will be modified
    by the reversed-netlist.  It reads in a sample testbench and replaces
    certain variables with the corresponding information from the data
    structure. It also sets the variables equal to random numbers that
    are generated to be within the corresponding variable's bit range."""

    random_list = []
    with paths["sample_tb"].open("r") as sample:
        with paths["tb"][i].open("x") as tb:
            random_list = generate_random(data, random_list, test_num)
            for line in sample:
                parse_line(line, data, tb, test_num, paths, random_list)


def generate_testbench(paths, data, i):

    """Rather than generating a whole new testbench, this one takes the
    first generated testbench and replaces everything that is specific
    to that module with this module's information."""

    with (paths["tb"][0]).open("r") as sample:
        with paths["tb"][i].open("x") as tb:
            for line in sample:
                if f"{paths['modules'][1]}_tb;" in line:
                    line = line.replace(paths["modules"][1], paths["modules"][i + 1])

                if f"{paths['modules'][1]}_tb);" in line:
                    line = f"    $dumpvars(1,{paths['modules'][i+1]}_tb);\n"

                if f"{paths['modules'][0]} instanceOf (" in line:
                    line = "top instanceOf ("

                    for total_data, index in zip(
                        data["total_list"], range(total_num(data))
                    ):
                        if index == total_num(data) - 1:
                            line = f"{line}{total_data});\n"
                        else:
                            line = f"{line}{total_data}, "

                tb.write(line)
