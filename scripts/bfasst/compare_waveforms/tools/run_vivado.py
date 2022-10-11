"""A launcher for Vivado to compare gtkwave wavefiles to Vivado's waveform analysis"""
from pathlib import Path
from subprocess import Popen
import shutil
import sys

def main():
    """The main function."""
    assert sys.argv[7] is not None, "VIVADO_PATH environmental variable was not set!"

    template = Path(sys.argv[8]) / ("templates/template.tcl")
    temp_tcl = Path(sys.argv[8]) / str("temp.tcl")
    if temp_tcl.exists():
        temp_tcl.unlink()

    with template.open("r") as file:
        with temp_tcl.open("x") as output:
            for line in file:
                if "PATH" in line:
                    line = line.replace(
                        line[line.find("PATH") : line.find("PATH") + 4], sys.argv[1]
                    )
                if "FILE_T" in line:
                    line = line.replace(
                        line[line.find("FILE_T") : line.find("FILE_T") + 6], sys.argv[2]
                    )
                elif "TB" in line:
                    line = line.replace(
                        line[line.find("TB") : line.find("TB") + 2], sys.argv[3]
                    )
                output.write(line)

    temp2_tcl = Path(sys.argv[8]) / str("temp2.tcl")
    if temp2_tcl.exists():
        temp2_tcl.unlink()

    with template.open("r") as file:
        with temp2_tcl.open("x") as output:
            for line in file:
                line = parse_line(line)
                output.write(line)

    commands = [
        [sys.argv[7], "-nolog", "-nojournal", "-source", str(temp_tcl)],
        [sys.argv[7], "-nolog", "-nojournal", "-source", str(temp2_tcl)],
    ]

    procs = [Popen(i) for i in commands]
    for proc in procs:
        proc.wait()

    shutil.rmtree("temp")
    shutil.rmtree("temp2")
    temp_tcl.unlink()
    temp2_tcl.unlink()

def parse_line(line):
    """Why does this exist? So pylint will be happy about branch numbers"""
    if "temp" in line:
        line = line.replace(
            line[line.find("temp") : line.find("temp") + 4], "temp2"
        )
    if "PATH" in line:
        line = line.replace(
            line[line.find("PATH") : line.find("PATH") + 4], sys.argv[4]
        )
    if "FILE_T" in line:
        line = line.replace(
            line[line.find("FILE_T") : line.find("FILE_T") + 6], sys.argv[5]
        )
    elif "TB" in line:
        line = line.replace(
            line[line.find("TB") : line.find("TB") + 2], sys.argv[6]
        )
    return line

if __name__ == "__main__":
    main()
