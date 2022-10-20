"""A tool used to analyze graphs for equivalent/unequivalent data using gtkwave."""
import subprocess
from subprocess import Popen
from pathlib import Path
import bfasst.paths
from bfasst.config import VIVADO_BIN_PATH


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


def init_gtkwave():

    """Initializes gtkwave so that it can launch with the correct zoom and, if the user wants, can
    be launched in full-screen mode."""

    # .gtkwaverc is used to setup gtkwave with certain initializers such as launch in full-screen.
    gtkwave = Path(".gtkwaverc")

    if gtkwave.exists():
        gtkwave.unlink()

    with gtkwave.open("x") as wavefile:
        wavefile.write("do_initial_zoom_fit 1\n")
        choice = input(
            "Do you want to launch in full-screen mode? 1 for yes, 0 for no."
        )
        if choice != "0":
            (x_cord, y_cord) = find_resolution()
            x_cord = str(x_cord)
            y_cord = str(y_cord)
            wavefile.write(f"initial_window_x {x_cord}\n")
            wavefile.write(f"initial_window_y {y_cord}\n")

    return gtkwave


def launch_vivado(path, module, commands):

    """Checks if the user wants to launch vivado. If so, adds vivado to the list of
    commands to run."""

    choice = input("Compare with Vivado? 1 for yes, 0 for no.")

    # Sets up the subprocess commands to launch Vivado
    if choice != "0":
        commands.append(
            [
                "python",
                str(
                    bfasst.paths.ROOT_PATH
                    / "scripts/bfasst/compare_waveforms"
                    / "tools/run_vivado.py"
                ),
                str(path),
                f"{module}_impl",
                str(bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"),
                str(VIVADO_BIN_PATH),
            ]
        )
        commands.append(
            [
                "python",
                str(
                    bfasst.paths.ROOT_PATH
                    / "scripts/bfasst/compare_waveforms"
                    / "tools/run_vivado.py"
                ),
                str(path),
                f"{module}_reversed",
                str(bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"),
                str(VIVADO_BIN_PATH),
            ]
        )
    return commands


def analyze_graphs(path, module):

    """A function to launch the graphs for designs that have already been tested. Mainly meant
    for checking designs that came back unequivalent to see what was wrong with them."""

    gtkwave = init_gtkwave()

    # Initializes the subprocess commands to launch gtkwave.
    commands = [
        [
            "gtkwave",
            "-T",
            str(path / (f"{module}_impl.tcl")),
            "-o",
            str(path / (f"{module}_impl.vcd")),
        ],
        [
            "gtkwave",
            "-T",
            str(path / (f"{module}_reversed.tcl")),
            "-o",
            str(path / (f"{module}_reversed.vcd")),
        ],
    ]

    # Checks if the user wants to compare the gtkwave testbenches with Vivado's simulations,
    # then appends the run_vivado commands to the commands if the user chooses to do so.
    commands = launch_vivado(path, module, commands)

    # Prints the diff.txt file so the user can see where differences in simulation occured.
    if (path / "diff.txt").exists():
        with (path / "diff.txt").open("r") as file:
            for line in file:
                print(line)

    # Allows all processes to be run concurrently.
    procs = [Popen(i) for i in commands]
    for proc in procs:
        proc.wait()

    gtkwave.unlink()
