"""
Parse results.json file from run_experiments flow and generate a CSV file 
with statuses and utilization data for each design.
"""

from argparse import ArgumentParser
import csv
import json
from pathlib import Path

from bfasst import yaml_parser
from bfasst.paths import ROOT_PATH, BUILD_PATH


def transform_stats(designs_yaml):
    """
    Get information about timing tranformations made by running
    phys_opt_design post-placement in Vivado.
    """
    design_paths = yaml_parser.RunParser(designs_yaml).design_paths
    lut_comb = [0, 0, 0]
    retime = [0, 0, 0]
    fanout = [0, 0, 0]
    dsp_reg = [0, 0, 0]
    shift_reg_to_pipe = [0, 0, 0]
    shift_reg = [0, 0, 0]
    bram = [0, 0, 0]
    net_repl = [0, 0, 0]
    for design in design_paths:
        design = Path(design)
        stats = BUILD_PATH / design.parent.name / design.name / "impl/vivado.log"
        with open(stats) as f:
            line = next(f)
            while True:
                if "Summary of Physical Synthesis Optimizations" in line:
                    break
                line = next(f)
            line = next(f)
            while True:
                try:
                    if "LUT Combining" in line:
                        lut_comb[0] += int(line.split()[4])
                        lut_comb[1] += int(line.split()[6])
                        lut_comb[2] += int(line.split()[8])
                    elif "Retime" in line:
                        retime[0] += int(line.split()[3])
                        retime[1] += int(line.split()[5])
                        retime[2] += int(line.split()[7])
                    elif "Very High Fanout" in line:
                        fanout[0] += int(line.split()[5])
                        fanout[1] += int(line.split()[7])
                        fanout[2] += int(line.split()[9])
                        # if int(line.split()[5]) > 0:
                        #     print(design.name)
                    elif "DSP Register" in line:
                        dsp_reg[0] += int(line.split()[4])
                        dsp_reg[1] += int(line.split()[6])
                        dsp_reg[2] += int(line.split()[8])
                    elif "Shift Register to Pipeline" in line:
                        shift_reg_to_pipe[0] += int(line.split()[6])
                        shift_reg_to_pipe[1] += int(line.split()[8])
                        shift_reg_to_pipe[2] += int(line.split()[10])
                    elif "Shift Register" in line:
                        shift_reg[0] += int(line.split()[4])
                        shift_reg[1] += int(line.split()[6])
                        shift_reg[2] += int(line.split()[8])
                    elif "BRAM Register" in line:
                        bram[0] += int(line.split()[4])
                        bram[1] += int(line.split()[6])
                        bram[2] += int(line.split()[8])
                    elif "Dynamic/Static Region Interface Net Replication" in line:
                        net_repl[0] += int(line.split()[7])
                        net_repl[1] += int(line.split()[9])
                        net_repl[2] += int(line.split()[11])
                    elif "Total" in line:
                        cnt = 0
                        while True:
                            if "Summary of Physical Synthesis Optimizations" in line:
                                cnt += 1
                                if cnt == 2:
                                    break
                            line = next(f)
                    line = next(f)
                except ValueError as e:
                    print(line.split())
                    raise e
                except StopIteration:
                    break
    # make xlsx file with values and averages
    import xlsxwriter

    workbook = xlsxwriter.Workbook("stats.xlsx")
    worksheet = workbook.add_worksheet()
    row = 0
    col = 0
    worksheet.write(row, col, "Optimization")
    worksheet.write(row, col + 1, "Added Cells")
    worksheet.write(row, col + 2, "Removed Cells")
    worksheet.write(row, col + 3, "Optimized Cells/Nets")
    worksheet.write(row, col + 4, "Average Added Cells")
    worksheet.write(row, col + 5, "Average Removed Cells")
    worksheet.write(row, col + 6, "Average Optimized Cells/Nets")
    row += 1
    worksheet.write(row, col, "LUT Combining")
    worksheet.write(row, col + 1, lut_comb[0])
    worksheet.write(row, col + 2, lut_comb[1])
    worksheet.write(row, col + 3, lut_comb[2])
    worksheet.write(row, col + 4, lut_comb[0] / len(design_paths))
    worksheet.write(row, col + 5, lut_comb[1] / len(design_paths))
    worksheet.write(row, col + 6, lut_comb[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "Retime")
    worksheet.write(row, col + 1, retime[0])
    worksheet.write(row, col + 2, retime[1])
    worksheet.write(row, col + 3, retime[2])
    worksheet.write(row, col + 4, retime[0] / len(design_paths))
    worksheet.write(row, col + 5, retime[1] / len(design_paths))
    worksheet.write(row, col + 6, retime[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "Very High Fanout")
    worksheet.write(row, col + 1, fanout[0])
    worksheet.write(row, col + 2, fanout[1])
    worksheet.write(row, col + 3, fanout[2])
    worksheet.write(row, col + 4, fanout[0] / len(design_paths))
    worksheet.write(row, col + 5, fanout[1] / len(design_paths))
    worksheet.write(row, col + 6, fanout[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "DSP Register")
    worksheet.write(row, col + 1, dsp_reg[0])
    worksheet.write(row, col + 2, dsp_reg[1])
    worksheet.write(row, col + 3, dsp_reg[2])
    worksheet.write(row, col + 4, dsp_reg[0] / len(design_paths))
    worksheet.write(row, col + 5, dsp_reg[1] / len(design_paths))
    worksheet.write(row, col + 6, dsp_reg[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "Shift Register to Pipeline")
    worksheet.write(row, col + 1, shift_reg_to_pipe[0])
    worksheet.write(row, col + 2, shift_reg_to_pipe[1])
    worksheet.write(row, col + 3, shift_reg_to_pipe[2])
    worksheet.write(row, col + 4, shift_reg_to_pipe[0] / len(design_paths))
    worksheet.write(row, col + 5, shift_reg_to_pipe[1] / len(design_paths))
    worksheet.write(row, col + 6, shift_reg_to_pipe[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "Shift Register")
    worksheet.write(row, col + 1, shift_reg[0])
    worksheet.write(row, col + 2, shift_reg[1])
    worksheet.write(row, col + 3, shift_reg[2])
    worksheet.write(row, col + 4, shift_reg[0] / len(design_paths))
    worksheet.write(row, col + 5, shift_reg[1] / len(design_paths))
    worksheet.write(row, col + 6, shift_reg[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "BRAM Register")
    worksheet.write(row, col + 1, bram[0])
    worksheet.write(row, col + 2, bram[1])
    worksheet.write(row, col + 3, bram[2])
    worksheet.write(row, col + 4, bram[0] / len(design_paths))
    worksheet.write(row, col + 5, bram[1] / len(design_paths))
    worksheet.write(row, col + 6, bram[2] / len(design_paths))
    row += 1
    worksheet.write(row, col, "Dynamic/Static Region Interface Net Replication")
    worksheet.write(row, col + 1, net_repl[0])
    worksheet.write(row, col + 2, net_repl[1])
    worksheet.write(row, col + 3, net_repl[2])
    worksheet.write(row, col + 4, net_repl[0] / len(design_paths))
    worksheet.write(row, col + 5, net_repl[1] / len(design_paths))
    worksheet.write(row, col + 6, net_repl[2] / len(design_paths))
    workbook.close()


def phys_cmp_results(flow):
    """
    Gather results from phys_cmp flow and create a CSV file with
    utilization data, transformation times, comparison times, and
    success status.
    """
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
    phys_cmp_results(args.flow)
