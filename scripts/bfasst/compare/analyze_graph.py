import bfasst
import bfasst.paths
import subprocess
from subprocess import Popen
from pathlib import Path



def analyze_graphs(path, module):
    impl_vcd = path / Path(module + "_impl.vcd")
    reversed_vcd = path / Path(module + "_reversed.vcd")
    impl_tcl = path / Path(module + "_impl.tcl")
    reversed_tcl = path / Path(module + "_reversed.tcl")
    impl_fst = path / Path(module + "_impl.vcd.fst")
    reversed_fst = path / Path(module + "_reversed.vcd.fst")
    diff = path / Path("diff.txt")

    if(diff.exists()):
        with diff.open() as file:
            for line in file:
                print(line)

    gtkwave = Path(".gtkwaverc")
    if(gtkwave.exists()):
        gtkwave.unlink()
    with gtkwave.open("x") as wavefile:
        wavefile.write("do_initial_zoom_fit 1")

    commands = [
        ["gtkwave", "-T", str(impl_tcl), "-o", str(impl_vcd)],
        ["gtkwave", "-T", str(reversed_tcl), "-o", str(reversed_vcd)]
    ]

    procs = [Popen(i) for i in commands]
    for p in procs:
        p.wait()

    gtkwave.unlink()
    impl_fst.unlink()
    reversed_fst.unlink()

