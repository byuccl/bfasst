from pathlib import Path
import subprocess
import math

def check_duplicates(line, data, write):
    if line[0] is "0" or line[0] is "1":
        if line[1 : len(line) - 1] in data["binary_signal"]:
            j = data["binary_signal"].index(line[1 : len(line) - 1])
            if data["binary_state"][j] != line[0]:
                write.write(line)
            data["binary_state"][j] = line[0]
    elif " " in line:
        if (
            line[line.index(" ") + 1 : len(line) - 1]
        ) in data["signal"]:
            j = data["signal"].index(
                line[line.index(" ") + 1 : len(line) - 1]
            )
            if data["state"][j] != line[0 : line.index(" ")]:
                write.write(line)
            data["state"][j] = line[0 : line.index(" ")]
    elif line[0] is "#":
        data["time"] = (line[1:len(line)-1])
        write.write(line)
    else:
        write.write(line)
    return(data)

def past_initial_data(line, data):
    if data["past_header"] is True:
        if "$dumpvars" in line:
            data["past_definitions"] = True
        else:
            if (
                "$upscope" not in line
                and "$enddefinitions" not in line
                and "#0" not in line
                ):
                data["returned_signal"] = parse_signals(line)
                if data["returned_signal"][0] is "1":
                    data["binary_name"].append(data["returned_signal"][2])
                    data["binary_signal"].append(data["returned_signal"][1])
                    data["binary_state"].append("0")
                else:
                    data["name"].append(data["returned_signal"][2])
                    data["signal"].append(data["returned_signal"][1])
                    data["state"].append("b0")
    if "$scope module" in line:
        data["past_header"] = True
    return(data)

def check_diff(paths):
    """This function will run through all of the differences between the two VCD files and then determine equivalence based upon the number of different lines."""
    is_equivalent = False
    time_related_data = []
    for i in range(2):
        data = {}
        signal = []
        name = []
        binary_signal = []
        binary_state = []
        binary_name = []
        state = []
        data["time"] = '0'
        data["name"] = []
        data["binary_name"] = []
        data["signal"] = []
        data["binary_signal"] = []
        data["state"] = []
        data["binary_state"] = []
        data["returned_signal"] = []
        data["past_header"] = False
        data["past_definitions"] = False
        curr_time = '0'
        if paths["temp_vcd"][i].exists():
            paths["temp_vcd"][i].unlink()
        with paths["vcd"][i].open("r") as file:
            with paths["temp_vcd"][i].open("x") as write:
                for line in file:
                    if(data["past_definitions"] is False):
                        data = past_initial_data(line, data)
                    else:
                        binary_signal = data["binary_signal"]
                        signal = data["signal"]
                        name = data["name"]
                        binary_name = data["binary_name"]
                        data = check_duplicates(line, data, write)
                        if data["time"] != curr_time:
                            for i in data["binary_state"]:
                                binary_state.append(i)
                            for i in data["state"]:
                                state.append(i)
                            curr_time = data["time"]
        time_related_data.append([binary_state, state])
    print(signal)
    t=0
    h=0
    for i, j in zip(time_related_data[0][0], time_related_data[1][0]):
        if i != j:
            print(h)
            print(binary_name[h])
            print("not equivalent with")
            print(i)
            print(j)
            print(int(math.ceil((t-h)/(len(binary_signal)))))
            print("\n")
        if h<len(binary_signal)-1:
            h=h+1
        else:
            h=0
        t = t + 1
    t=0
    h=0
    for i, j in zip(time_related_data[0][1], time_related_data[1][1]):
        if i != j:
            print(h)
            print(name[h])
            print("not equivalent with")
            print(i)
            print(j)
            print(int(math.ceil((t-h)/(len(signal)))))
            print("\n")
        if h<len(signal)-1:
            h=h+1
        else:
            h=0
        t = t + 1
    dif = subprocess.getoutput(
        [f"diff -c {paths['temp_vcd'][0]} {paths['temp_vcd'][1]}"]
    )
    if paths["diff"].exists():
        paths["diff"].unlink()
    with paths["diff"].open("x") as file:
        for line in dif:
            file.write(line)

    lines = 0
    with paths["diff"].open("r") as file:
        for line in file:
            if len(line)!=0:
                lines = lines + 1
    print(f"{lines} lines found non-equivalent!")
    # If there are more than 32 lines different, the two designs must be unequivalent.
    if lines > 0:
        print(f"NOT EQUIVALENT! SEE {paths['parsed_diff']} for more info")
        parse_diff(paths)
        if paths["parsed_diff"].exists():
            with paths["parsed_diff"].open("r") as file:
                for line in file:
                    if (len(line) != 0) & (
                        (line[0] == "-") | (line[0] == "!") | (line[0] == "+")
                    ):
                        if (
                            (line[0:3] != "---")
                            & (line[1:3] != " 0")
                            & (line[0:8] != "! $scope")
                            & (line[0:3] != "! \t")
                            & (line[1:3] != " 1")
                        ):
                            print(line)
        else:
            subprocess.run(
                ["diff", "-c", str(paths["temp_vcd"][0]), str(paths["temp_vcd"][1])]
            )

    else:
        paths["diff"].unlink()
        is_equivalent = True
    return is_equivalent


def parse_signals(line):
    words = []
    newWord = False
    if "$var wire" in line:
        word = ""
        for i in line:
            if i == " ":
                newWord = True
            if newWord is False:
                word = word + i
            else:
                if (word != "$var") & (word != "wire"):
                    if "[" not in word:
                        words.append(word)
                    word = ""
                    newWord = False
                else:
                    word = ""
                    newWord = False
    if "$var reg" in line:
        word = ""
        for i in line:
            if i == " ":
                newWord = True
            if newWord is False:
                word = word + i
            else:
                if (word != "$var") & (word != "reg"):
                    if "[" not in word:
                        words.append(word)
                    word = ""
                    newWord = False
                else:
                    word = ""
                    newWord = False
    return words


def parse_diff(paths):
    """This function reads through the diff.txt file generated by running a diff function on the two vcd files (text representation of a wave file). Since the VCD files represent each signal as a symbol (IE: $, #, !, etc), this script replaces those names with the actual signal names.This script also tells you the exact times, in ms, that these differences occur. The output of this script is saved in the waveform folder AND is printed out anytime 
    unequivalent waveforms are viewed."""
    words = []
    symbols = []
    signals = []

    # We gather up all of the signals with this script. They are stored as follows: bit_length, Symbol, Signal_name.
    # Because we don't need the bit_length, it will be discarded. Each symbol and signal are stored in individual arrays and
    # each entry will correspond with each other. (Note: Could be replaced with a map in the future.)
    with paths["vcd"][0].open("r") as file:
        for line in file:
            word = parse_signals(line)
            if len(word) != 0:
                words.append(word)
    # J increments through the 3 entries for words (bit_length, symbol, signal_name.) If j==0, the bit_length is discarded.
    # If j==1, the symbol is saved. If j==2, the signal_name is saved and j is set back to 0.
    for i in words:
        symbols.append(i[1])
        signals.append(i[2])

    if Path(paths["parsed_diff"]).exists():
        Path(paths["parsed_diff"]).unlink()

    # A lot of logic here. Essentially, all of the excess information is discarded and everything is renamed so that
    # it can be easier to read for a normal individual. A HOW TO READ: section is added for first-time users.
    with paths["diff"].open("r") as file:
        with paths["parsed_diff"].open("x") as output:
            output.write("HOW TO READ: \n")
            output.write(
                "+ indicates this data was added and is not present in the other file.\n"
            )
            output.write(
                "- indicates this data was removed and is present in the other file.\n"
            )
            output.write(
                "All differences are seperated by file. The Implicit and Reversed Files are labeled as such.\n"
            )
            output.write(
                "To better debug, re-open the VCD files using the Compare Waveforms script and use this file to find where to look for differences.\n"
            )
            output.write(
                "For further confirmation, open both testbenches with Vivado and compare the results to this diff file.\n\n"
            )
            firstDif = True
            isDif = False
            for line in file:
                isParsed = False
                for symbol, signal in zip(symbols, signals):
                    if symbol == "#":
                        if "#\n" in line:
                            line = line.replace(symbol, signal)
                            isParsed = True
                        elif "#" in line:
                            if line[line.index("#") + 1] != " ":
                                if line[len(line) - 1] == "\n":
                                    num = line[line.index("#") + 1 : line.index("\n")]
                                    num = int(num)
                                    num = int(num / 1000)
                                    line = f" {num} ns\n"
                                    isParsed = True
                                else:
                                    num = line[line.index("#") + 1 :]
                                    num = int(num)
                                    num = int(num / 1000)
                                    line = f" {num} ns\n"
                                    isParsed = True
                    elif symbol == "$":
                        if "$scope" not in line:
                            if "$var wire" not in line:
                                if "$timescale" not in line:
                                    if "$end" not in line:
                                        if isParsed is False:
                                            line = line.replace(symbol, f" {signal}")
                                            isParsed = True
                    elif symbol in line:
                        if line[line.index(symbol) :] == (f"{symbol}\n"):
                            line = line.replace(symbol, f" {signal}")
                            isParsed = True

                if firstDif:
                    if isDif:
                        if "*****" in line:
                            firstDif = False
                        else:
                            line = ""
                    else:
                        if "*****" in line:
                            line = ""
                            isDif = True
                        else:
                            line = ""
                else:
                    if "*****" in line:
                        line = "*******************\n"

                    if "*** " in line:
                        line = f"*** IMPL: P{line[line.index(' ') + 1 :]}"

                    if "--- " in line:
                        line = f"--- REVERSED: {line[line.index(' ') + 1 :]}"

                output.write(line)
