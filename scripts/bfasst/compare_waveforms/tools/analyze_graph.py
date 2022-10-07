from re import X
import bfasst
import bfasst.paths
import subprocess
from subprocess import Popen
from pathlib import Path
from bfasst.config import VIVADO_BIN_PATH


def analyze_graphs(path, module):
    """A function to launch the graphs for designs that have already been tested. Mainly meant
    for checking designs that came back unequivalent to see what was wrong with them."""
    impl_v = path / (f"{module}_impl.v")
    impl_tb = path / (f"{module}_impl_tb.v")
    reversed_v = path / (f"{module}_reversed.v")
    reversed_tb = path / (f"{module}_reversed_tb.v")
    impl_vcd = path / (f"{module}_impl.vcd")
    reversed_vcd = path / (f"{module}_reversed.vcd")
    impl_tcl = path / (f"{module}_impl.tcl")
    reversed_tcl = path / (f"{module}_reversed.tcl")
    impl_fst = path / (f"{module}_impl.vcd.fst")
    reversed_fst = path / (f"{module}_reversed.vcd.fst")
    diff = path / "diff.txt"
    parsed = path / "parsed_diff.txt"
    base_path = bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"
    run_vivado = base_path / "tools/run_vivado.py"
    base_path = bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"

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
            (x, y) = find_resolution()
            x = str(x)
            y = str(y)
            wavefile.write(f"initial_window_x {x}\n")
            wavefile.write(f"initial_window_y {y}\n")

        choice = input("Compare with Vivado? 1 for yes, 0 for no.")
        vivado = False
        if choice != "0":
            vivado = True

    if parsed.exists():
        with parsed.open("r") as file:
            for line in file:
                print(line)
    elif diff.exists():
        with diff.open("r") as file:
            for line in file:
                print(line)

    if vivado:

        commands = [
            ["gtkwave", "-T", str(impl_tcl), "-o", str(impl_vcd)],
            ["gtkwave", "-T", str(reversed_tcl), "-o", str(reversed_vcd)],
            [
                "python",
                str(run_vivado),
                str(impl_v),
                str(impl_tb),
                f"{module}_impl_tb",
                str(reversed_v),
                str(reversed_tb),
                f"{module}_reversed_tb",
                str(VIVADO_BIN_PATH),
                str(base_path),
            ],
        ]
    else:
        commands = [
            ["gtkwave", "-T", str(impl_tcl), "-o", str(impl_vcd)],
            ["gtkwave", "-T", str(reversed_tcl), "-o", str(reversed_vcd)],
        ]

    procs = [Popen(i) for i in commands]
    for p in procs:
        p.wait()

    gtkwave.unlink()
    impl_fst.unlink()
    reversed_fst.unlink()


def find_resolution():
    """A function primarily meant to check the user's monitor resolution so gtkwave can launch in full-screen mode."""
    output = subprocess.check_output("xrandr")
    output = output.decode()
    temp = Path("temp.txt")
    with temp.open("x") as file:
        file.write(output)

    foundDisplay = False
    isPrimary = False

    with temp.open("r") as file:
        for line in file:
            if "primary" in line:
                isPrimary = True
            if isPrimary:
                # The user-resolution is indicated by the * character in a line.
                if "*" in line:
                    if foundDisplay is False:
                        line = line.strip()
                        # The user-resolution is always in the format ____x____, so the width is before the x and the
                        # height is after the x.
                        x = line[0 : line.index("x")]
                        y = line[line.index("x") + 1 : line.index(" ")]
                        foundDisplay = True
                        temp.unlink()
                        return (x, y)
    # If, for whatever reason, the screen resolution can't be found, it defaults to the absolute lowest screen resolution.
    if foundDisplay is False:
        temp.unlink()
        return (320, 200)

    temp.unlink()
