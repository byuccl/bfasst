"""
Parse results.json file from run_experiments flow and generate a CSV file
with statuses and utilization data for each design.
"""

from argparse import ArgumentParser
import csv
import json
from pathlib import Path
import xlsxwriter


from bfasst import yaml_parser
from bfasst.paths import ROOT_PATH, BUILD_PATH


class TransformStats:
    def __init__(self) -> None:
        self.lut_comb = [0, 0, 0]
        self.retime = [0, 0, 0]
        self.fanout = [0, 0, 0]
        self.dsp_reg = [0, 0, 0]
        self.shift_reg_to_pipe = [0, 0, 0]
        self.shift_reg = [0, 0, 0]
        self.bram = [0, 0, 0]
        self.net_repl = [0, 0, 0]


def analyze_impl_log_line(line, stats):
    """
    Pull timing transformation summary data for a line of a Vivado
    Implementation log.
    """
    if "LUT Combining" in line:
        stats.lut_comb[0] += int(line.split()[3])
        stats.lut_comb[1] += int(line.split()[5])
        stats.lut_comb[2] += int(line.split()[7])
    elif "Retime" in line:
        stats.retime[0] += int(line.split()[3])
        stats.retime[1] += int(line.split()[5])
        stats.retime[2] += int(line.split()[7])
    elif "Very High Fanout" in line:
        stats.fanout[0] += int(line.split()[5])
        stats.fanout[1] += int(line.split()[7])
        stats.fanout[2] += int(line.split()[9])
    elif "DSP Register" in line:
        stats.dsp_reg[0] += int(line.split()[4])
        stats.dsp_reg[1] += int(line.split()[6])
        stats.dsp_reg[2] += int(line.split()[8])
    elif "Shift Register to Pipeline" in line:
        stats.shift_reg_to_pipe[0] += int(line.split()[6])
        stats.shift_reg_to_pipe[1] += int(line.split()[8])
        stats.shift_reg_to_pipe[2] += int(line.split()[10])
    elif "Shift Register" in line:
        stats.shift_reg[0] += int(line.split()[4])
        stats.shift_reg[1] += int(line.split()[6])
        stats.shift_reg[2] += int(line.split()[8])
    elif "BRAM Register" in line:
        stats.bram[0] += int(line.split()[4])
        stats.bram[1] += int(line.split()[6])
        stats.bram[2] += int(line.split()[8])
    elif "Dynamic/Static Region Interface Net Replication" in line:
        stats.net_repl[0] += int(line.split()[7])
        stats.net_repl[1] += int(line.split()[9])
        stats.net_repl[2] += int(line.split()[11])
    else:
        return False
    return True


def transform_stats(designs_yaml):
    """
    Get information about timing tranformations made by running
    phys_opt_design post-placement in Vivado.
    """
    design_paths = yaml_parser.RunParser(designs_yaml).design_paths
    stats = TransformStats()
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
                    if not analyze_impl_log_line(line, stats) and "Total" in line:
                        cnt = 0
                        while cnt < 2:
                            if "Summary of Physical Synthesis Optimizations" in line:
                                cnt += 1
                            line = next(f)
                    line = next(f)
                except ValueError as e:
                    print(line.split())
                    raise e
                except StopIteration:
                    break
    # make xlsx file with values and averages
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
    for stat, title in zip(
        [
            stats.lut_comb,
            stats.retime,
            stats.fanout,
            stats.dsp_reg,
            stats.shift_reg_to_pipe,
            stats.shift_reg,
            stats.bram,
            stats.net_repl,
        ],
        [
            "LUT Combining",
            "Retime",
            "Very High Fanout",
            "DSP Register",
            "Shift Register to Pipeline",
            "Shift Register",
            "BRAM Register",
            "Dynamic/Static Region Interface Net Replication",
        ],
    ):
        worksheet.write(row, col, title)
        worksheet.write(row, col + 1, stat[0])
        worksheet.write(row, col + 2, stat[1])
        worksheet.write(row, col + 3, stat[2])
        worksheet.write(row, col + 4, stat[0] / len(design_paths))
        worksheet.write(row, col + 5, stat[1] / len(design_paths))
        worksheet.write(row, col + 6, stat[2] / len(design_paths))
        row += 1
    workbook.close()


def phys_cmp_results(flow):
    """
    Gather results from phys_cmp flow and create a CSV file with
    utilization data, transformation times, comparison times, and
    success status.
    """
    root_dir = ROOT_PATH

    out = "results.csv"

    fl = yaml_parser.RunParser(flow)

    designs = [
        BUILD_PATH / Path(design).parent.name / Path(design).name for design in fl.design_paths
    ]
    import code

    # code.interact(local=dict(globals(), **locals()))

    rows = []
    for design in designs:
        status = (
            "Success" if (design / "struct_cmp/struct_comparison_time.txt").exists() else "FAILED"
        )
        row = {
            "Design": design.name,
            "Status": status,
            "LUT": 0,
            "LUT_MEM": 0,
            "SRL": 0,
            "FF": 0,
            "CARRY4": 0,
            "BRAM": 0,
            "T_TIME": 0,
            "C_TIME": 0,
            "S_TIME": 0,
        }
        if status == "FAILED":
            rows.append(row)
            continue
        utilization_file = design / "vivado_impl/utilization.txt"
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

        with open(design / "vivado_phys_netlist/transformation_time.txt", "r") as f:
            row["T_TIME"] = round(float(f.read().strip()), 2)
        if (design / "netlist_cleanup/log.txt").exists():
            with open(design / "netlist_cleanup/log.txt", "r") as f:
                time = 0
                for line in f:
                    if "time" in line:
                        time += float(line.split(" ")[-1])
                row["C_TIME"] = round(time, 2)
        if (design / "struct_cmp/struct_comparison_time.txt").exists():
            with open(design / "struct_cmp/struct_comparison_time.txt", "r") as f:
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
            "C_TIME",
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
