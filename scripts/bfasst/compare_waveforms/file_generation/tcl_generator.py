"""Handles TCL generation that is used by GTKWave for viewing waveforms."""


def generate_first_tcl(paths, data, i):

    """Generates the first TCL that will be used in gtkwave to create a VCD output."""

    path = paths["build_dir"] / (f"{paths['modules'][i+1]}.tcl")

    if path.exists():
        path.unlink()

    with path.open("x") as TCL:
        line = "set filter [list "
        for total_data in data["total_list"]:
            line = f"{line}{(paths['modules'][i+1])}_tb.{total_data.strip()} "

        line = f"{line}]\n"
        TCL.write(line)
        TCL.write("gtkwave::addSignalsFromList $filter\n")


def generate_tcl(paths, i):

    """Replaces information in the last TCL with information specific to this testbench."""

    path = paths["build_dir"] / (f"{paths['modules'][i+1]}.tcl")
    sample_path = paths["build_dir"] / (f"{paths['modules'][1]}.tcl")

    if path.exists():
        path.unlink()

    with path.open("x") as TCL:
        with sample_path.open("r") as sample:
            for line in sample:
                if paths["modules"][1] in line:
                    line = line.replace(paths["modules"][1], paths["modules"][i + 1])
                TCL.write(line)
