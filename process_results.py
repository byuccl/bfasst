import csv
import json
from pathlib import Path

ROOT_DIR = Path("/home/reilly/equiv/bfasst/build/xilinx_phys_netlist_cmp")

results = "build/xilinx_phys_netlist_cmp/results.json"

out = "results.csv"

with open(results, "r") as f:
    data = json.load(f)

# designs = [k for k, v in data.items() if v == ""]

rows = []
for design, status in data.items():
    status = "success" if not status else "failed"
    row = {
        "Design": design,
        "Status": status,
        "LUT": 0,
        "LUT_MEM": 0,
        "SRL": 0,
        "FF": 0,
        "CARRY4": 0,
        "BRAM": 0,
    }
    utilization_file = ROOT_DIR / f"ooc/{design}/vivado_impl/utilization.txt"
    if not utilization_file.is_file():
        utilization_file = ROOT_DIR / f"byu/{design}/vivado_impl/utilization.txt"
    if not utilization_file.is_file():
        continue
    with open(utilization_file, "r") as f:
        for line in f:
            if "| LUT as Logic" in line:
                row["LUT"] = line.split("|")[2].strip()
            elif "|   LUT as Distributed RAM" in line:
                row["LUT_MEM"] = line.split("|")[2].strip()
            elif "|   LUT as Shift Register" in line:
                row["SRL"] = line.split("|")[2].strip()
            elif "| Slice Registers" in line:
                row["FF"] = line.split("|")[2].strip()
            elif "| CARRY4" in line:
                row["CARRY4"] = line.split("|")[2].strip()
            elif "| Block RAM Tile" in line:
                row["BRAM"] = line.split("|")[2].strip()
    rows.append(row)

with open(out, "w", newline="") as f:
    fieldnames = ["Design", "Status", "LUT", "LUT_MEM", "SRL", "FF", "CARRY4", "BRAM"]
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    for row in rows:
        writer.writerow(row)
