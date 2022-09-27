import numpy as np


"""A simple function to return the amount of data stored in the input list."""


def input_num(data):
    """A simple function to return the total amount of data being stored as both inputs"""
    return len(data["input_list"])


def total_num(data):
    """A simple function to return the total amount of data being stored as both inputs and outputs."""
    return len(data["input_list"]) + len(data["output_list"])


def generate_first_testbench(paths, test_num, data, i):
    """This function creates the initial testbench that will be modified by the reversed-netlist. It reads in a sample testbench
    and replaces certain variables with the corresponding information from the data structure. It also sets the variables equal
    to random numbers that are generated to be within the corresponding variable's bit range."""
    random_list = []
    with paths["sample_tb"].open("r") as sample:
        with paths["tb"][i].open("x") as tb:
            for line in sample:
                if "TB_NAME;" in line:
                    line = f"module {paths['modules'][1]}_tb;"
                    tb.write(line)
                    line = "\n"

                if "TB_NAME)" in line:
                    line = f"    $dumpvars(1,{paths['modules'][1]}_tb);\n"

                if "INPUTS" in line:
                    for signal_in, bits in zip(
                        data["input_list"], data["input_bits_list"]
                    ):
                        signal_in = str(signal_in)
                        bits = str(bits)
                        if signal_in != "clk":
                            line = f"reg [{bits}:0] {signal_in} = 0;\n"
                            tb.write(line)
                        else:
                            line = "reg clk = 0;\n"
                            tb.write(line)
                        line = ""

                if "OUTPUTS" in line:
                    for signal_out, bits in zip(
                        data["output_list"], data["output_bits_list"]
                    ):
                        signal_out = str(signal_out)
                        bits = str(bits)
                        line = f"wire [{bits}:0] {signal_out};\n"
                        tb.write(line)
                    line = ""

                if "MODULE_NAME" in line:
                    line = f"{paths['modules'][1]} instanceOf ("
                    for total, j in zip(data["total_list"], range(total_num(data))):
                        total = str(total)
                        if j == total_num(data) - 1:
                            line = f"{line}{total});\n"
                        else:
                            line = f"{line}{total}, "

                if "reg clk = 0;" in line:
                    for input in data["input_list"]:
                        if input == "clk":
                            line = ""

                if "/*SIGNALS" in line:
                    for bits in data["input_bits_list"]:
                        if bits == 0:
                            random_list.append(
                                np.random.randint(low=0, high=2, size=int(test_num))
                            )
                        else:
                            random_list.append(
                                np.random.randint(
                                    low=0,
                                    high=(2 ** (int(bits) + 1) - 1),
                                    size=int(test_num),
                                )
                            )

                    # The actual logic for adding random numbers to the testbench.
                    for j in range(int(test_num)):
                        for input, k in zip(data["input_list"], range(input_num(data))):
                            if input != "clk":
                                if k == 0:
                                    line = f"    # 5 {input} = {random_list[k][j]};\n"
                                else:
                                    line = f"    {input} = {random_list[k][j]};\n"
                            else:
                                if k == 0:
                                    line = "    # 5 "
                            tb.write(line)
                            line = ""
                        tb.write("\n")
                    line = "    # 5 $finish;"

                tb.write(line)


def generate_testbench(paths, data, i):
    """Rather than generating a whole new testbench, this one takes the first generated testbench and replaces everything that
    is specific to that module with this module's information."""
    with (paths["tb"][0]).open("r") as sample:
        with paths["tb"][i].open("x") as tb:
            for line in sample:
                if f"{paths['modules'][1]}_tb;" in line:
                    line = line.replace(paths["modules"][1], paths["modules"][i + 1])

                if f"{paths['modules'][1]}_tb);" in line:
                    line = f"    $dumpvars(1,{paths['modules'][i+1]}_tb);\n"

                if f"{paths['modules'][1]} instanceOf (" in line:
                    line = f"{paths['modules'][i+1]} instanceOf ("

                    for totalData, i in zip(data["total_list"], range(total_num(data))):
                        if i == total_num(data) - 1:
                            line = f"{line}{totalData});\n"
                        else:
                            line = f"{line}{totalData}, "

                tb.write(line)
