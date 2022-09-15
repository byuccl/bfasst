"""Generates the first TCL that will be used in gtkwave to create a VCD output."""

def generate_first_TCL(paths, file_name, file_num, data):
    path = paths["build_dir"] / (file_name[file_num] + ".tcl")
    if path.exists():
        path.unlink()
    with path.open("x") as TCL:
        line = "set filter [list "
        for totalData in data["total_list"]:
            line = line + file_name[file_num] + "_tb." + totalData.strip() + " "
        line = line + "]\n"
        TCL.write(line)
        TCL.write("gtkwave::addSignalsFromList $filter\n")
        TCL.write(
            'gtkwave::/File/Export/Write_VCD_File_As "'
            + str(paths["build_dir"])
            + "/"
            + file_name[file_num]
            + '.vcd"\n'
        )
        TCL.write("gtkwave::File/Quit")

"""Replaces information in the last TCL with information specific to this testbench."""

def generate_TCL(paths, file_name, file_num):
    path = paths["build_dir"] / (file_name[file_num] + ".tcl")
    sample_path = paths["build_dir"] / (file_name[file_num - 1] + ".tcl")
    if path.exists():
        path.unlink()
    with path.open("x") as TCL:
        with sample_path.open() as sample:
            for line in sample:
                if file_name[file_num - 1] in line:
                    line = line.replace(
                        file_name[file_num - 1], file_name[file_num]
                    )
                TCL.write(line)