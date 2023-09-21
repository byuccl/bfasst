"""
Parse results.json file from run_experiments flow and generate a CSV file 
with statuses and utilization data for each design.
"""

from argparse import ArgumentParser
import csv
import json

from bfasst.paths import ROOT_PATH


def main(flow):
    """Main entrypoint for processing results"""
    root_dir = ROOT_PATH / "build" / flow

    results = root_dir / "results.json"

    out = "results.csv"

    with open(results, "r") as f:
        data = json.load(f)

    rows = []
    for design, status in data.items():
        status = "Success" if not status else status
        row = {
            "Design": design.split("/")[1],
            "Status": status,
            "LUT": 0,
            "LUT_MEM": 0,
            "SRL": 0,
            "FF": 0,
            "CARRY4": 0,
            "BRAM": 0,
            "T_TIME": 0,
            "S_TIME": 0,
        }
        utilization_file = root_dir / f"{design}/vivado_impl/utilization.txt"
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

        with open(root_dir / f"{design}/xilinx_phys_netlist/transformation_time.txt", "r") as f:
            row["T_TIME"] = round(float(f.read().strip()), 2)
        with open(root_dir / f"{design}/struct_cmp/comparison_time.txt", "r") as f:
            row["S_TIME"] = round(float(f.read().strip()), 2)
        rows.append(row)

    with open(out, "w", newline="") as f:
        fieldnames = [
            "Design",
            "Status",
            "LUT",
            "LUT_MEM",
            "SRL",
            "FF",
            "CARRY4",
            "BRAM",
            "S_TIME",
            "T_TIME",
        ]
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("flow", help="The flow to process results for")
    args = parser.parse_args()
    main(args.flow)
