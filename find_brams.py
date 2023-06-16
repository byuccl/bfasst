from pathlib import Path
import os, sys

p = Path.cwd() / "build" / "xilinx_ooc" / "ooc"

for i in p.iterdir():
    tmp_f = i / "vivado_impl" / "design.dcp"
    if not tmp_f.exists():
        continue
    with open("util.tcl", "w") as tcl:
        tcl.write(f"open_checkpoint -quiet {str(tmp_f)}\n")
        tcl.write(f"report_utilization -force -file {tmp_f.parent / 'util.rpt'}\n")
        tcl.write("exit\n")
    os.system("/tools/Xilinx/Vivado/2022.2/bin/vivado -mode batch -source util.tcl")
    with open(tmp_f.parent / "util.rpt", "r") as rpt:
        for line in rpt.readlines():
            if ("RAMB" in line) and ("0.00" not in line) and ("* Note:" not in line):
                print(f"{str(i)} {line.strip()}", file=sys.stderr)
