"""
Parse results files from build directory and generate a CSV file
with statuses and utilization data for each design.
"""

import csv
from argparse import ArgumentParser
from pathlib import Path

import xlsxwriter

from bfasst import yaml_parser
from bfasst.paths import BUILD_PATH


class TransformStats:
    """Class to hold timing transformation summary data."""

    categories = (
        "lut_comb",
        "retime",
        "fanout",
        "dsp_reg",
        "shift_reg_to_pipe",
        "shift_reg",
        "bram",
        "net_repl",
    )

    def __init__(self) -> None:
        for cat in self.categories:
            setattr(self, cat, [0, 0, 0])

    def __iter__(self):
        for cat in self.categories:
            yield getattr(self, cat)


def analyze_impl_log_line(line, stats):
    """
    Pull timing transformation summary data for a line of a Vivado
    Implementation log.
    """
    if not line or line[0] != "|":
        return False
    fields = line.split("|")[1:]
    try:
        added = int(fields[1])
    except ValueError:
        return False
    removed, optimized = int(fields[2]), int(fields[3])
    stats_list = None
    match fields[0].strip():
        case "LUT Combining":
            stats_list = stats.lut_comb
        case "Retime":
            stats_list = stats.retime
        case "Very High Fanout":
            stats_list = stats.fanout
        case "DSP Register":
            stats_list = stats.dsp_reg
        case "Shift Register to Pipeline":
            stats_list = stats.shift_reg_to_pipe
        case "Shift Register":
            stats_list = stats.shift_reg
        case "BRAM Register":
            stats_list = stats.bram
        case "Dynamic/Static Region Interface Net Replication":
            stats_list = stats.net_repl
        case _:
            return False
    # Sum to account for possible multiple phys_opt_design calls
    stats_list[0] += added
    stats_list[1] += removed
    stats_list[2] += optimized
    return True


def transform_stats(designs_yaml):
    """
    Get information about timing tranformations made by running
    phys_opt_design post-placement in Vivado.
    """
    design_paths = yaml_parser.RunParser(designs_yaml).design_paths
    design_stats = {}
    for design in design_paths:
        design = Path(design)
        key = f"{design.parent.name}_{design.name}"
        log = BUILD_PATH / design.parent.name / design.name / "vivado_impl/vivado.log"
        stats = None
        with open(log) as f:
            try:
                line = next(f)
                while True:
                    if "Summary of Physical Synthesis Optimizations" in line:
                        stats = TransformStats()
                        break
                    line = next(f)
                line = next(f)
                while True:
                    if not analyze_impl_log_line(line.strip(), stats) and "Total" in line:
                        cnt = 0
                        while cnt < 2:
                            if "Summary of Physical Synthesis Optimizations" in line:
                                cnt += 1
                            line = next(f)
                    line = next(f)
            except StopIteration:
                if stats is None:
                    print(f"Possibly no clock for {design.name}")
                design_stats[key] = stats
    filter_lut_comb(design_stats)
    export_design_stats_xlxs(design_stats, len(design_paths))


def filter_lut_comb(design_stats):
    """Filter out designs that only have LUT combining."""
    remove = []
    for design, stats in design_stats.items():
        if stats is None:
            remove.append(design)
            continue
        stats_iter = iter(stats)
        next(stats_iter)  # Skip LUT combining
        for stat in stats_iter:
            if sum(stat) > 0:
                break
        else:
            remove.append(design)
    _ = [design_stats.pop(design) for design in remove]


def export_design_stats_xlxs(design_stats, num_designs):
    """make xlsx file with values and averages"""
    workbook = xlsxwriter.Workbook("timing_stats.xlsx")
    worksheet = workbook.add_worksheet("Summary")
    row = 0
    col = 0
    worksheet.write(row, col, "Design")
    optimizations = [
        "LUT Combining",
        "Retime",
        "Very High Fanout",
        "DSP Register",
        "Shift Register to Pipeline",
        "Shift Register",
        "BRAM Register",
        "Dynamic/Static Region Interface Net Replication",
    ]
    for offset, title in enumerate(optimizations, 1):
        worksheet.write(row, col + offset, title)
    row += 1
    for design, stats in design_stats.items():
        worksheet.write(row, col, design)
        if stats is None:
            row += 1
            continue
        for offset, stat in enumerate(stats, 1):
            opt_present = sum(stat) > 0
            worksheet.write(row, col + offset, opt_present)
        row += 1

    for design, stats in design_stats.items():
        if stats is None:
            continue
        if len(design) > 23:
            design = design[:19] + "..." + design[-1]
        worksheet = workbook.add_worksheet(f"{design}_details")
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
            optimizations,
        ):
            worksheet.write(row, col, title)
            worksheet.write(row, col + 1, stat[0])
            worksheet.write(row, col + 2, stat[1])
            worksheet.write(row, col + 3, stat[2])
            worksheet.write(row, col + 4, stat[0] / num_designs)
            worksheet.write(row, col + 5, stat[1] / num_designs)
            worksheet.write(row, col + 6, stat[2] / num_designs)
            row += 1
    workbook.close()


def phys_capnp_results(flow, out="fast_results.csv"):
    """
    Gather results from phys_cmp flow and create a CSV file with
    utilization data, transformation times, comparison times, and
    success status.
    """

    fl = yaml_parser.RunParser(flow)

    designs = [
        BUILD_PATH / Path(design).parent.name / Path(design).name for design in fl.design_paths
    ]

    rows = []
    for design in designs:
        status = "Success" if (design / "capnp_cmp/cmp_time.txt").exists() else "FAILED"
        row = {
            "Design": design.name,
            "Status": status,
            "LUT": 0,
            "LUT_MEM": 0,
            "SRL": 0,
            "FF": 0,
            "DSP48E1": 0,
            "CARRY4": 0,
            "BRAM": 0,
            "T_TIME": 0,
            "S_TIME": 0,
        }
        if status == "FAILED":
            rows.append(row)
            continue
        utilization_file = design / "vivado_impl/utilization.txt"
        with open(utilization_file, "r") as f:
            for line in f:
                if "| LUT as Logic" in line:
                    row["LUT"] = line.split("|")[2].strip()
                elif "|   LUT as Distributed RAM" in line:
                    row["LUT_MEM"] = line.split("|")[2].strip()
                elif "|   LUT as Shift Register" in line:
                    row["SRL"] = line.split("|")[2].strip()
                elif "| DSP48E1" in line:
                    row["DSP48E1"] = line.split("|")[2].strip()
                elif "| Slice Registers" in line:
                    row["FF"] = line.split("|")[2].strip()
                elif "| CARRY4" in line:
                    row["CARRY4"] = line.split("|")[2].strip()
                elif "| Block RAM Tile" in line:
                    row["BRAM"] = line.split("|")[2].strip()

        with open(design / "vivado_phys_netlist/transformation_time.txt", "r") as f:
            row["T_TIME"] = round(float(f.read().strip()), 2)
        rows.append(row)

        with open(design / "capnp_cmp/cmp_time.txt", "r") as f:
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
            "DSP48E1",
            "BRAM",
            "T_TIME",
            "S_TIME",
        ]
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def phys_cmp_results(flow, out="results.csv"):
    """
    Gather results from phys_cmp flow and create a CSV file with
    utilization data, transformation times, comparison times, and
    success status.
    """

    fl = yaml_parser.RunParser(flow)

    designs = [
        BUILD_PATH / Path(design).parent.name / Path(design).name for design in fl.design_paths
    ]

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
        writer.writerows(rows)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("flow", help="The flow to process results for")
    args = parser.parse_args()
    transform_stats(args.flow)
