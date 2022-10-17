"""A module used to accurately check the difference between VCD files"""


def init_data():

    """Sets all of the initial variables for data"""

    data = {}
    data["time"] = "0"
    data["name"] = []
    data["binary_name"] = []
    data["signal"] = []
    data["binary_signal"] = []
    data["state"] = []
    data["binary_state"] = []
    data["returned_signal"] = []
    data["past_header"] = False
    data["past_definitions"] = False

    return data


def parse_io(line, input_output, words, new_word):

    """A function whose only purpose is to appease the coding standard by reducing the number of
    branches in parse_signals"""

    word = ""

    for i in line:

        if i == " ":
            new_word = True

        if new_word is False:
            word = word + i

        else:

            if (word != "$var") & (word != input_output):

                if "[" not in word:
                    words.append(word)
                word = ""
                new_word = False

            else:
                word = ""
                new_word = False

    return words


def parse_signals(line):

    """Is used in the header of a VCD file to find the names of every signal, it's corresponding
    symbol, and it's bitsize."""

    words = []
    new_word = False

    if "$var wire" in line:
        words = parse_io(line, "wire", words, new_word)

    if "$var reg" in line:
        words = parse_io(line, "reg", words, new_word)

    return words


def past_initial_data(line, data):

    """Parses all of the data at the start of the files to set the initial values for every
    variable."""

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

                if data["returned_signal"][0] == "1":
                    data["binary_name"].append(data["returned_signal"][2])
                    data["binary_signal"].append(data["returned_signal"][1])
                    data["binary_state"].append("0")

                else:
                    data["name"].append(data["returned_signal"][2])
                    data["signal"].append(data["returned_signal"][1])
                    data["state"].append("b0")

    if "$scope module" in line:
        data["past_header"] = True

    return data


def check_duplicates(line, data):

    """Checks if the signal is the same as it was previously or if it has changed at a specific
    time."""

    if line[0] == "0" or line[0] == "1":

        if line[1 : len(line) - 1] in data["binary_signal"]:
            j = data["binary_signal"].index(line[1 : len(line) - 1])
            data["binary_state"][j] = line[0]

    elif " " in line:

        if line[line.index(" ") + 1 : len(line) - 1] in data["signal"]:
            j = data["signal"].index(line[line.index(" ") + 1 : len(line) - 1])
            data["state"][j] = line[0 : line.index(" ")]

    elif line[0] == "#":
        data["time"] = line[1 : len(line) - 1]

    return data


def parse_data(paths, time_related_data, i):

    """Parses each vcd file, finds all occurences of a signal's state, then compares them against
    each other to confirm that the two signals are equivalent."""

    data = init_data()
    name = []
    binary_time = []
    time = []
    binary_state = []
    binary_name = []
    state = []
    curr_time = "0"

    with paths["vcd"][i].open("r") as file:

        for line in file:

            if data["past_definitions"] is False:
                data = past_initial_data(line, data)

            else:
                name = data["name"]
                binary_name = data["binary_name"]
                data = check_duplicates(line, data)

                if data["time"] != curr_time:
                    [binary_state.append(i) for i in data["binary_state"]]
                    [binary_time.append(i) for i in ([curr_time] * len(binary_name))]
                    [state.append(i) for i in data["state"]]
                    [time.append(i) for i in ([curr_time] * len(name))]
                    curr_time = data["time"]

    time_related_data.append(
        [binary_state, state, binary_name, name, binary_time, time]
    )

    return time_related_data


def init_unequivalent_data():

    """A function that initializes the data struct unequivalent data, a structure that keeps track
    of all data that is unequivalent at a specific time."""

    unequivalent_data = {}
    unequivalent_data["name"] = []
    unequivalent_data["impl"] = []
    unequivalent_data["rev"] = []
    unequivalent_data["time"] = []

    return unequivalent_data


def append_unequivalent_data(unequivalent_data, time_related_data, group):

    """Checks for any unequivalent data based upon the data's status at any given time."""

    name = time_related_data[0][2 + group]
    length = len(name)
    time = time_related_data[0][4 + group]
    index = 0
    time_group = 0

    for impl, rev in zip(time_related_data[0][group], time_related_data[1][group]):

        if impl != rev:
            unequivalent_data["name"].append(name[index])
            unequivalent_data["impl"].append(impl)
            unequivalent_data["rev"].append(rev)
            unequivalent_data["time"].append(int(time[index + time_group]) / 1000)

        if index < length - 1:
            index = index + 1

        else:
            index = 0
            time_group = time_group + length

    return unequivalent_data


def check_diff(paths):

    """This function will run through all of the differences between the two VCD files and then
    determine equivalence based upon the number of different states for each signal."""

    time_related_data = []
    for i in range(2):
        time_related_data = parse_data(paths, time_related_data, i)

    unequivalent_data = init_unequivalent_data()

    for i in range(2):
        unequivalent_data = append_unequivalent_data(
            unequivalent_data, time_related_data, i
        )

    # If any lines exist in the diff file, then there must be unequivalency at some point
    # in the design
    if len(unequivalent_data["impl"]) > 0:
        total = 0

        if paths["diff"].exists():
            paths["diff"].unlink()

        with paths["diff"].open("x") as output:

            output.write(
                f"Differences between implicit and reversed waveforms for design "
                f"{paths['modules'][0]}\n\n\n"
            )

            for name, impl, rev, time in zip(
                unequivalent_data["name"],
                unequivalent_data["impl"],
                unequivalent_data["rev"],
                unequivalent_data["time"],
            ):

                output.write(
                    f"{time}ns, Signal {name}, Impl {impl}, Reversed {rev}\n\n"
                )
                total = total + 1

            output.write(
                f"\nThere are {total} total lines where these waveforms are unequivalent"
            )

        with paths["diff"].open("r") as file:
            print(file.read())

        print(f"See {paths['diff']} for more info")

    else:
        return True

    return False
