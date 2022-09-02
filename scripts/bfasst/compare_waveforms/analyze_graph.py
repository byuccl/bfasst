from re import X
import bfasst
import bfasst.paths
import subprocess
import shutil
from subprocess import Popen
from pathlib import Path
from bfasst.config import VIVADO_BIN_PATH

'''A function to launch the graphs for designs that have already been tested. Mainly meant
for checking designs that came back unequivalent to see what was wrong with them.'''
def analyze_graphs(path, module):
    impl_v = path / module + "_impl.v"
    viv_impl_v = path / module + "_temp_impl.v"
    impl_tb = path / module + "_impl_tb.v"
    reversed_v = path / module + "_reversed.v"
    viv_reversed_v = path / module + "_temp_reversed.v"
    reversed_tb = path / module + "_reversed_tb.v"
    impl_vcd = path / module + "_impl.vcd"
    reversed_vcd = path / module + "_reversed.vcd"
    impl_tcl = path / module + "_impl.tcl"
    reversed_tcl = path / module + "_reversed.tcl"
    impl_fst = path / module + "_impl.vcd.fst"
    reversed_fst = path / module + "_reversed.vcd.fst"
    diff = path / "diff.txt"
    parsed = path / "parsed_diff.txt"
    run_vivado = bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms/run_vivado.py"
    base_path = bfasst.paths.ROOT_PATH / "scripts/bfasst/compare_waveforms"

    gtkwave = Path(".gtkwaverc")
    if(gtkwave.exists()):
        gtkwave.unlink()
    with gtkwave.open("x") as wavefile:
        wavefile.write("do_initial_zoom_fit 1\n")

        #Optional: Functionality to detect a system's monitor size is added so that
        # gtkwave can launch in full-screen mode.
        choice = input("Do you want to launch in full-screen mode? 1 for yes, 0 for no.")
        if(choice != "0"): 
            (x,y) = find_resolution()
            x = str(x)
            y = str(y)
            wavefile.write("initial_window_x " + x + "\n")
            wavefile.write("initial_window_y " + y + "\n")
        
        choice = input("Compare with Vivado? 1 for yes, 0 for no.")
        vivado = False
        if(choice != "0"):
            vivado=True
    
    if (parsed.exists()):
        with parsed.open() as file:
            for line in file:
                print(line)
    elif(diff.exists()):
        with diff.open() as file:
            for line in file:
                print(line)

    if(vivado):

        if(viv_impl_v.exists()):
            viv_impl_v.unlink()
        if(viv_reversed_v.exists()):
            viv_reversed_v.unlink()

        with impl_v.open() as source:
            with viv_impl_v.open("x") as output:
                for line in source:
                    if module in line:
                        line = line.replace(module, module + "_impl")
                    output.write(line)
        with reversed_v.open() as source:
            with viv_reversed_v.open("x") as output:
                for line in source:
                    if "top" in line:
                        line = line.replace("top", module + "_reversed")
                    output.write(line)

        commands = [
            ["gtkwave", "-T", str(impl_tcl), "-o", str(impl_vcd)],
            ["gtkwave", "-T", str(reversed_tcl), "-o", str(reversed_vcd)],
            ["python", str(run_vivado), str(viv_impl_v), 
            str(impl_tb), module + "_impl_tb", str(viv_reversed_v), str(reversed_tb), module + "_reversed_tb", str(VIVADO_BIN_PATH),
            str(base_path)]
        ]
    else:
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
    if(viv_impl_v.exists()):
        viv_impl_v.unlink()
    if(viv_reversed_v.exists()):
        viv_reversed_v.unlink()



'''A function primarily meant to check the user's monitor resolution so gtkwave can launch in full-screen mode.'''
def find_resolution():
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
                #The user-resolution is indicated by the * character in a line.
                if "*" in line:
                    if foundDisplay == False:
                        line = line.strip()
                        #The user-resolution is always in the format ____x____, so the width is before the x and the
                        # height is after the x. 
                        x = line[0:line.index("x")]
                        y = line[line.index("x")+1:line.index(" ")]
                        foundDisplay = True
                        temp.unlink()
                        return(x, y)
    #If, for whatever reason, the screen resolution can't be found, it defaults to the absolute lowest screen resolution.
    if(foundDisplay == False):
        temp.unlink()
        return(320, 200)
    
    temp.unlink()