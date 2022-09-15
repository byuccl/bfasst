import subprocess
import time


"""Uses IVerilog to create a VCD file for viewing waveforms"""

def generate_VCD(paths, path, tb, tcl, vcd, fst):
    # Generate wavefiles
    subprocess.run(
        [
            "iverilog",
            "-o",
            str(paths["dsn"]),
            str(tb),
            path,
            str(paths["cells_sim"]),
        ]
    )
    subprocess.run(["vvp", str(paths["dsn"])])
    subprocess.run(["mv", "test.vcd", str(vcd)])
    paths["dsn"].unlink()

    gtkwave(vcd, tcl, fst)

"""Creates a waveform that only takes into account the inputs/outputs (totally ignores all internal components) and then
takes the input/output graph and turns it into a VCD file to be compared against."""

def gtkwave(vcd, tcl, fst):
    # gtkwave is run in the background. If the temporary fst file doesn't exist, then the output we need hasn't been created.
    # The process is killed within 5ms of creating the file so the user doesn't have to physically close gtkwave.
    subprocess.Popen(["gtkwave", "-T", str(tcl), "-o", str(vcd)])
    while not fst.exists():
        time.sleep(0.005)
    if fst.exists():
        subprocess.run(["pkill", "gtkwave"])
    fst.unlink()
    vcd.unlink()