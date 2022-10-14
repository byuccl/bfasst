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


def create_tcl(template, temp_tcl, args):

    """Creates a temporary TCL file to launch Vivado."""

    if temp_tcl.exists():
        temp_tcl.unlink()

    with template.open("r") as file:
        with temp_tcl.open("x") as output:
            for line in file:
                if "PATH" in line:
                    line = line.replace(
                        line[line.find("PATH") : line.find("PATH") + 4],
                        f"{args.base}/{args.module}.v",
                    )
                if "FILE_T" in line:
                    line = line.replace(
                        line[line.find("FILE_T") : line.find("FILE_T") + 6],
                        f"{args.base}/{args.module}_tb.v",
                    )
                elif "TB" in line:
                    line = line.replace(
                        line[line.find("TB") : line.find("TB") + 2], f"{args.module}_tb"
                    )
                output.write(line)


def main():

    """The main function."""

    args = parse_args()

    assert args.vivado is not None, "VIVADO_PATH environmental variable was not set!"

    template = Path(args.temp) / ("templates/template.tcl")
    temp_tcl = Path(args.temp) / (f"temp_{args.module}.tcl")

    create_tcl(template, temp_tcl, args)

    temp_dir = Path(f"{args.module}_vivado_sim")
    if temp_dir.exists():
        shutil.rmtree(str(temp_dir))
    temp_dir.mkdir()
    print(str(temp_dir))

    subprocess.run(
        [
            args.vivado,
            "-nolog",
            "-nojournal",
            "-tempDir",
            str(temp_dir),
            "-source",
            str(temp_tcl),
        ]
    )

    shutil.rmtree(str(temp_dir))
    temp_tcl.unlink()


if __name__ == "__main__":
    main()
