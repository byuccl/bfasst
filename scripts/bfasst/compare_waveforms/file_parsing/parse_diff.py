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
    t=0
    h=0
    unequivalent_data = {}
    unequivalent_data["name"] = []
    unequivalent_data["impl"] = []
    unequivalent_data["reversed"] = []
    unequivalent_data["time"] = []
    for i, j in zip(time_related_data[0][0], time_related_data[1][0]):
        if i != j:
            unequivalent_data["name"].append(binary_name[h])
            unequivalent_data["impl"].append(i)
            unequivalent_data["reversed"].append(j)
            unequivalent_data["time"].append(t)
        if h<len(binary_signal)-1:
            h=h+1
        else:
            h=0
            t=t+1
    t=0
    h=0
    for i, j in zip(time_related_data[0][1], time_related_data[1][1]):
        if i != j:
            unequivalent_data["name"].append(name[h])
            unequivalent_data["impl"].append(i)
            unequivalent_data["reversed"].append(j)
            unequivalent_data["time"].append(t)
        if h<len(signal)-1:
            h=h+1
        else:
            h=0
            t=t+1

    # If there are more than 32 lines different, the two designs must be unequivalent.
    if len(unequivalent_data["impl"]) > 0:
        total = 0
        if(paths["diff"].exists()):
            paths["diff"].unlink()
        with paths["diff"].open("x") as output:
            output.write(f"Differences between implicit and reversed waveforms for design {paths['modules'][0]}\n\n\n")
            for name, impl, reversed, time in zip(unequivalent_data["name"], unequivalent_data["impl"], unequivalent_data["reversed"], unequivalent_data["time"]):
                output.write(f"{time}ns, Signal {name}, Impl {impl}, Reversed {reversed}\n\n")
                total = total + 1
            output.write(f"\nThere are {total} total lines where these waveforms are unequivalent")
        with paths["diff"].open("r") as file:
            print(file.read())
        print(f"See {paths['diff']} for more info")

    else:
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
