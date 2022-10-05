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
    subprocess.run(["mv", "test.vcd", paths["vcd"][i]])
    paths["dsn"].unlink()
