import subprocess
import time


def generate_VCD(paths, i):
    """Uses IVerilog to create a VCD file for viewing waveforms"""
    subprocess.run(
        [
            "iverilog",
            "-o",
            str(paths["dsn"]),
            str(paths["tb"][i]),
            paths["file"][i],
            str(paths["cells_sim"]),
        ]
    )
    subprocess.run(["vvp", str(paths["dsn"])])
    subprocess.run(["mv", "test.vcd", paths["temp_vcd"][i]])
    paths["dsn"].unlink()

    gtkwave(paths, i)


def gtkwave(paths, i):
    """Creates a waveform that only takes into account the inputs/outputs (totally ignores all internal components) and then
    takes the input/output graph and turns it into a VCD file to be compared against."""
    subprocess.Popen(["gtkwave", "-T", paths["tcl"][i], "-o", paths["temp_vcd"][i]])
    # gtkwave is run in the background. If the temporary fst file doesn't exist, then the output we need hasn't been created.
    # The process is killed within 5ms of creating the file so the user doesn't have to physically close gtkwave.
    while not paths["fst"][i].exists() & paths["vcd"][i].exists():
        time.sleep(0.005)
    if paths["fst"][i].exists():
        subprocess.run(["pkill", "gtkwave"])
    paths["fst"][i].unlink()
    paths["temp_vcd"][i].unlink()
