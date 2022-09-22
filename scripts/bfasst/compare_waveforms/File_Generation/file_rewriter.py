import shutil


def copy_files(paths):
    """Creates copies of the two designs so that they can be modified when they need to be fixed for parsing"""
    shutil.copyfile(paths["path"][0], paths["build_dir"] / paths["path"][0].name)
    shutil.copyfile(paths["path"][1], paths["build_dir"] / paths["path"][1].name)


def fix_file(paths, i):
    """A function to fix syntax issues that spydrnet commonly has with xilinx-generated or reverse-generated netlists."""
    path = paths["file"][i]
    file_name = paths["modules"][i + 1]
    with path.open("r") as fin:
        file_data = fin.read()
        if i == 1:
            file_data = file_data.replace("module top(", f"module {file_name}(")
        else:
            file_data = file_data.replace(
                f"module {file_name[0 : len(file_name) - 5]}\n", f"module {file_name}"
            )
    with path.open("w") as fin:
        fin.write(file_data)


def rewrite_tcl(paths):
    """Rewrite the TCL script for waveform viewing so it doesn't create new VCD files on re-view."""
    lines = []
    with paths["tcl"][0].open("r") as fp:
        lines = fp.readlines()
    with paths["tcl"][0].open("w") as fp:
        for number, line in enumerate(lines):
            if number not in [2, 3]:
                fp.write(line)
    with paths["tcl"][1].open("r") as fp:
        lines = fp.readlines()
    with paths["tcl"][1].open("w") as fp:
        for number, line in enumerate(lines):
            if number not in [2, 3]:
                fp.write(line)
