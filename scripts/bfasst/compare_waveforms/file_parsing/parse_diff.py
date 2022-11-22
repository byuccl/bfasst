"""A module used to accurately check the difference between VCD files"""


def parse_io(line, input_output, words, new_word):

    """Checks a line for if a word is new or not."""

    word = ""

    for i in line:

        if i == " ":
            new_word = True

        if new_word is False:
            word = word + i

        else:

            if word not in ("$var", input_output):

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


def past_initial_data(line, data, past_header):

    """Parses all of the data at the start of the files to set the initial values for every
    variable."""

    if past_header is True:

        if "$dumpvars" in line:
            return (True, data)

        if (
            "$upscope" not in line
            and "$enddefinitions" not in line
            and "#0" not in line
        ):
            found_data = parse_signals(line)

            if found_data[0] == "1":
                data["name"].append(found_data[2])
                data["signal"].append(found_data[1])

            else:
                data["name"].append(found_data[2])
                data["signal"].append(found_data[1])

    if "$scope module" in line:
        return (True, data)

    return (False, data)


def check_change(line, data, signals):

    """Updates the signals states and time"""

    if line[0] == "0" or line[0] == "1":
        if line[1 : len(line) - 1] in signals:
            j = signals.index(line[1 : len(line) - 1])
            data[j] = line[0]

    elif " " in line:
        if line[line.index(" ") + 1 : len(line) - 1] in signals:
            j = signals.index(line[line.index(" ") + 1 : len(line) - 1])
            data[j] = line[0 : line.index(" ")]

    elif line[0] == "#":
        return (True, data)

    return (False, data)


def parse_line(line, data, monitor):

    """Parses a singular line from the VCD file and stores the data in a data array."""

    if monitor["past_header"] is False:
        monitor["past_header"], data = past_initial_data(
            line, data, monitor["past_header"]
        )
    elif monitor["past_definitions"] is False:
        monitor["past_definitions"], data = past_initial_data(
            line, data, monitor["past_header"]
        )
    else:
        if not monitor["changed_data"]:
            monitor["changed_data"] = ["0" for i in range(len(data["signal"]))]
        if monitor["new_time"]:
            data["state"].append(monitor["changed_data"][0 : len(data["signal"])])
        monitor["new_time"], monitor["changed_data"] = check_change(
            line, monitor["changed_data"], data["signal"]
        )
    return data, monitor


def parse_data(paths, time_related_data, i):

    """Parses each vcd file, finds all occurences of a signal's state, then compares them against
    each other to confirm that the two signals are equivalent."""

    data = {}
    data["name"] = []
    data["signal"] = []
    data["state"] = []
    monitor = {}
    monitor["past_header"] = False
    monitor["past_definitions"] = False
    monitor["new_time"] = False
    monitor["changed_data"] = []

    with paths["vcd"][i].open("r") as file:
        for line in file:
            data, monitor = parse_line(line, data, monitor)

    time_related_data.append(data)
    return time_related_data


def append_unequivalent_data(unequivalent_data, data):

    """Checks for any unequivalent data based upon the data's status at any given time."""

    index = 0
    time = 0

    for impl, rev in zip(data[0]["state"], data[1]["state"]):

        for i_sig, r_sig in zip(impl, rev):

            if i_sig != r_sig:

                unequivalent_data["name"].append(data[0]["name"][index])
                unequivalent_data["impl"].append(i_sig)
                unequivalent_data["rev"].append(r_sig)
                unequivalent_data["time"].append((time) / 1000)

            index = index + 1

            if index == len(data[0]["name"]):
                index = 0

        time = time + 1000

    return unequivalent_data


def check_diff(paths):

    """This function will run through all of the differences between the two VCD files and then
    determine equivalence based upon the number of different states for each signal."""

    time_related_data = []

    for i in range(2):
        time_related_data = parse_data(paths, time_related_data, i)

    unequivalent_data = {}
    unequivalent_data["name"] = []
    unequivalent_data["impl"] = []
    unequivalent_data["rev"] = []
    unequivalent_data["time"] = []

    unequivalent_data = append_unequivalent_data(unequivalent_data, time_related_data)

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
        if paths["diff"].exists():
            paths["diff"].unlink()
        return True

    return False
