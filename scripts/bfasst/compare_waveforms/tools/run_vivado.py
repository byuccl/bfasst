"""A launcher for Vivado to compare gtkwave wavefiles to Vivado's waveform analysis"""

import argparse
from pathlib import Path
import subprocess
import shutil


def parse_args():

    """Creates the argument parser for the Vivado Launcher."""

    parser = argparse.ArgumentParser(description="Launch Vivado.")
    parser.add_argument("base", metavar="Base", help="Base path to files.")
    parser.add_argument("module", metavar="Module", help="Module name.")
    parser.add_argument(
        "temp", metavar="Temp Folder", help="Temporary Location for TCL files."
    )
    parser.add_argument("vivado", metavar="Vivado", help="Location of Vivado Launcher.")

    return parser.parse_args()


def create_tcl(template, temp_tcl, base, module):

    """Creates a temporary TCL file to launch Vivado."""

    if temp_tcl.exists():
        temp_tcl.unlink()

    # Replaces portions of the template TCL file with info needed for Vivado to launch.
    with template.open("r") as file:
        with temp_tcl.open("x") as output:
            for line in file:
                if "PATH" in line:
                    line = line.replace(
                        line[line.find("PATH") : line.find("PATH") + 4],
                        f"{base}/{module}.v",
                    )
                if "FILE_T" in line:
                    line = line.replace(
                        line[line.find("FILE_T") : line.find("FILE_T") + 6],
                        f"{base}/{module}_tb.v",
                    )
                elif "TB" in line:
                    line = line.replace(
                        line[line.find("TB") : line.find("TB") + 2], f"{module}_tb"
                    )
                output.write(line)


def launch_vivado(base, module, temp, vivado):

    """Handles the logic for launching Vivado automatically."""

    assert vivado is not None, "VIVADO_PATH environmental variable was not set!"

    template = Path(temp) / ("templates/template.tcl")
    temp_tcl = Path(temp) / (f"temp_{module}.tcl")

    create_tcl(template, temp_tcl, base, module)

    # Creates a temporary directory so that multiple vivado simulations can occur at once.
    temp_dir = Path(f"{module}_vivado_sim")
    if temp_dir.exists():
        shutil.rmtree(str(temp_dir))

    temp_dir.mkdir()

    subprocess.run(
        [
            vivado,
            "-nolog",
            "-nojournal",
            "-source",
            str(temp_tcl),
        ],
        cwd=str(temp_dir),
    )

    # Removes the temporary directory since the Vivado folder is not needed.
    shutil.rmtree(str(temp_dir))
    temp_tcl.unlink()


def main():

    """The main function."""

    args = parse_args()

    launch_vivado(args.base, args.module, args.temp, args.vivado)


if __name__ == "__main__":
    main()
