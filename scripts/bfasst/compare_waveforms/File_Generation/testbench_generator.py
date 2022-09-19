from re import I
import numpy as np


"""A simple function to return the amount of data stored in the input list."""

def input_num(data):
    return len(data["input_list"])

"""A simple function to return the total amount of data being stored as both inputs and outputs."""

def total_num(data):
        return len(data["input_list"]) + len(data["output_list"])

"""This function creates the initial testbench that will be modified by the reversed-netlist. It reads in a sample testbench
and replaces certain variables with the corresponding information from the data structure. It also sets the variables equal
to random numbers that are generated to be within the corresponding variable's bit range."""

def generate_first_testbench(paths, test_num, data, i):
    with paths["sample_tb"].open() as sample:
        with paths["tb"][i].open("x") as tb:
            for line in sample:
                if "TB_NAME;" in line:
                    line = "module " + paths["modules"][1] + "_tb;"
                    tb.write(line)
                    line = "\n"

                if "TB_NAME)" in line:
                    line = "    $dumpvars(0," + paths["modules"][1] + "_tb);\n"

                if "INPUTS" in line:
                    for input, bits in zip(data["input_list"], data["input_bits_list"]):
                        input = str(input)
                        bits = str(bits)
                        if input != "clk":
                            line = "reg [" + bits + ":0] " + input + " = 0;\n"
                            tb.write(line)
                        else:
                            line = "reg clk = 0;\n"
                            tb.write(line)
                        line = ""

                if "OUTPUTS" in line:
                    for output, bits in zip(data["output_list"], data["output_bits_list"]):
                        output = str(output)
                        bits = str(bits)
                        line = "wire [" + bits + ":0] " + output + ";\n"
                        tb.write(line)
                    line = ""

                if "MODULE_NAME" in line:
                    line = paths["modules"][1] + " instanceOf ("
                    for total, j in zip(data["total_list"], range(total_num(data))):
                        total = str(total)
                        if j == total_num(data) - 1:
                            line = line + total + ");\n"
                        else:
                            line = line + total + ", "

                if "reg clk = 0;" in line:
                    for input in data["input_list"]:
                        if input == "clk":
                            line = ""

                if "/*SIGNALS" in line:
                    for bits in data["input_bits_list"]:
                        if bits == 0:
                            data["random_list"].append(
                                np.random.randint(low=0, high=2, size=int(test_num))
                            )
                        else:
                            data["random_list"].append(
                                np.random.randint(
                                    low=0, high=(2 ** (int(bits) + 1) - 1), size=int(test_num)
                                )
                            )

                    # The actual logic for adding random numbers to the testbench.
                    for j in range(int(test_num)):
                        for input, k in zip(data["input_list"], range(input_num(data))):
                            if input != "clk":
                                if k == 0:
                                    line = (
                                        "    # 5 "
                                        + str(input)
                                        + " = "
                                        + str(data["random_list"][k][j])
                                        + ";\n"
                                    )
                                else:
                                    line = (
                                        "    "
                                        + str(input)
                                        + " = "
                                        + str(data["random_list"][k][j])
                                        + ";\n"
                                    )
                            else:
                                if k == 0:
                                    line = "    # 5 "
                            tb.write(line)
                            line = ""
                        tb.write("\n")
                    line = "    # 5 $finish;"

                tb.write(line)

"""Rather than generating a whole new testbench, this one takes the first generated testbench and replaces everything that
is specific to that module with this module's information."""

def generate_testbench(paths, data, i):
    with (paths["tb"][0]).open() as sample:
        with paths["tb"][i].open("x") as tb:
            for line in sample:
                if paths["modules"][1] + "_tb;" in line:
                    line = line.replace(paths["modules"][1], paths["modules"][i+1])

                if paths["modules"][1] + "_tb);" in line:
                    line = "    $dumpvars(0," + paths["modules"][i+1] + "_tb);\n"

                if paths["modules"][1] + " instanceOf (" in line:
                    line =paths["modules"][i+1] + " instanceOf ("

                    for totalData, i in zip(data["total_list"], range(total_num(data))):
                        if i == total_num(data) - 1:
                            line = line + totalData + ");\n"
                        else:
                            line = line + totalData + ", "

                tb.write(line)