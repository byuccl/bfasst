"""A tool used to analyze graphs for equivalent/unequivalent data."""
import subprocess
from subprocess import Popen
from pathlib import Path
import bfasst.paths
from bfasst.config import VIVADO_BIN_PATH

def analyze_graphs(path, module):
    """A function to launch the graphs for designs that have already been tested. Mainly meant
    for checking designs that came back unequivalent to see what was wrong with them."""
    gtkwave = Path(".gtkwaverc")
    if gtkwave.exists():
        gtkwave.unlink()
    with gtkwave.open("x") as wavefile:
        wavefile.write("do_initial_zoom_fit 1\n")

        # Optional: Functionality to detect a system's monitor size is added so that
        # gtkwave can launch in full-screen mode.
        choice = input(
            "Do you want to launch in full-screen mode? 1 for yes, 0 for no."
        )
        if choice != "0":
            (x, cord_y) = find_resolution()
            x = str(x)
            cord_y = str(cord_y)
            wavefile.write(f"initial_window_x {x}\n")
            wavefile.write(f"initial_window_y {cord_y}\n")

        choice = input("Compare with Vivado? 1 for yes, 0 for no.")
        vivado = False
        if choice != "0":
            vivado = True

    if (path / "diff.txt").exists():
        with (path / "diff.txt").open("r") as file:
            for line in file:
                print(line)

    if vivado:

        commands = [
            ["gtkwave", "-T", str(path / (f"{module}_impl.tcl")), "-o",
            str(path / (f"{module}_impl.vcd"))],
            ["gtkwave", "-T", str(path / (f"{module}_reversed.tcl")), "-o",
            str(path / (f"{module}_reversed.vcd"))],
            [
                "python",
                str(bfasst.paths.ROOT_PATH /
                "scripts/bfasst/compare_waveforms" / "tools/run_vivado.py"),
                str(path / (f"{module}_impl.v")),
                str(path / (f"{module}_impl_tb.v")),
                f"{module}_impl_tb",
                str(path / (f"{module}_reversed.v")),
                str(path / (f"{module}_reversed_tb.v")),
                f"{module}_reversed_tb",
                str(VIVADO_BIN_PATH),
                str(bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"),
            ],
        ]
    else:
        commands = [
            ["gtkwave", "-T", str(path / (f"{module}_impl.tcl")), "-o",
            str(path / (f"{module}_impl.vcd"))],
            ["gtkwave", "-T", str(path / (f"{module}_reversed.tcl")), "-o",
            str(path / (f"{module}_reversed.vcd"))],
        ]

    procs = [Popen(i) for i in commands]
    for proc in procs:
        proc.wait()

    gtkwave.unlink()


def find_resolution():
    """A function primarily meant to check the user's monitor resolution so gtkwave can launch in
    full-screen mode."""
    output = subprocess.check_output("xrandr")
    output = output.decode()
    temp = Path("temp.txt")
    with temp.open("x") as file:
        file.write(output)

    found_display = False
    is_primary = False

    with temp.open("r") as file:
        for line in file:
            if "primary" in line:
                is_primary = True
            if is_primary:
                # The user-resolution is indicated by the * character in a line.
                if "*" in line:
                    if found_display is False:
                        line = line.strip()
                        # The user-resolution is always in the format ____x____, so the width is
                        # before the x and the
                        # height is after the x.
                        x = line[0 : line.index("x")]
                        cord_y = line[line.index("x") + 1 : line.index(" ")]
                        found_display = True
                        temp.unlink()
                        return (x, cord_y)
    # If, for whatever reason, the screen resolution can't be found, it defaults to the absolute
    # lowest screen resolution.
    temp.unlink()
    return (320, 200)
    