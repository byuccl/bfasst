from pathlib import Path
from subprocess import Popen
import shutil
import sys

base_path = sys.argv[1]
tb_path = sys.argv[2]
tb_name = sys.argv[3]
base_path_r = sys.argv[4]
tb_path_r = sys.argv[5]
tb_name_r = sys.argv[6]

vivado = sys.argv[7]
base = sys.argv[8]

assert vivado is not None, "VIVADO_PATH environmental variable was not set!"

template = Path(base) / str("template.tcl")
temp_tcl = Path(base) / str("temp.tcl")
if temp_tcl.exists():
    temp_tcl.unlink()

with template.open() as file:
    with temp_tcl.open("x") as output:
        for line in file:
            if "PATH" in line:
                line = line.replace(
                    line[line.find("PATH") : line.find("PATH") + 4], base_path
                )
            if "FILE_T" in line:
                line = line.replace(
                    line[line.find("FILE_T") : line.find("FILE_T") + 6], tb_path
                )
            elif "TB" in line:
                line = line.replace(
                    line[line.find("TB") : line.find("TB") + 2], tb_name
                )
            output.write(line)

temp2_tcl = Path(base) / str("temp2.tcl")
if temp2_tcl.exists():
    temp2_tcl.unlink()

with template.open() as file:
    with temp2_tcl.open("x") as output:
        for line in file:
            if "temp" in line:
                line = line.replace(
                    line[line.find("temp") : line.find("temp") + 4], "temp2"
                )
            if "PATH" in line:
                line = line.replace(
                    line[line.find("PATH") : line.find("PATH") + 4], base_path_r
                )
            if "FILE_T" in line:
                line = line.replace(
                    line[line.find("FILE_T") : line.find("FILE_T") + 6], tb_path_r
                )
            elif "TB" in line:
                line = line.replace(
                    line[line.find("TB") : line.find("TB") + 2], tb_name_r
                )
            output.write(line)

commands = [
    [vivado, "-nolog", "-nojournal", "-source", str(temp_tcl)],
    [vivado, "-nolog", "-nojournal", "-source", str(temp2_tcl)],
]

procs = [Popen(i) for i in commands]
for p in procs:
    p.wait()

shutil.rmtree("temp")
shutil.rmtree("temp2")
temp_tcl.unlink()
temp2_tcl.unlink()
