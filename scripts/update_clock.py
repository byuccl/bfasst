"""
Update design.yaml with the clock rate found in the timing summary report
"""

import argparse
from pathlib import Path
from bfasst import yaml_parser
from bfasst.paths import BUILD_PATH, DESIGNS_PATH


def get_clock_period(timing_summary):
    with open(timing_summary, "r") as f:
        for line in f:
            if "Requirement:" in line:
                period = line.split()[1].strip()[:-2]
                return period
    return None


def update_clocks(designs_yaml):
    """Update design.yaml with new clock rates for each design in test yaml"""
    design_paths = yaml_parser.RunParser(designs_yaml).design_paths
    for design in design_paths:
        design = Path(design)
        timing_summary = BUILD_PATH / design.parent.name / design.name / "impl/timing_summary.txt"
        period = get_clock_period(timing_summary)
        if period is None:
            print(f"Warning: Could not find clock period in {timing_summary}")
            continue
        design_yaml = DESIGNS_PATH / design / "design.yaml"
        with open(design_yaml, "r") as f:
            lines = f.readlines()
            for idx, line in enumerate(lines):
                if "period:" in line:
                    new_period = float(period) * 0.75
                    lines[idx] = f"    period: {new_period}\n"
                    try:
                        if "waveform" in lines[idx + 1]:
                            lines.pop(idx + 1)
                    except IndexError:
                        pass
                    break
        with open(design_yaml, "w") as f:
            f.writelines(lines)


def transform_stats(designs_yaml):
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
            """
            -----------------------------------------------------------------------------------------------------------------------------------------------------------
            |  Optimization                                     |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
            -----------------------------------------------------------------------------------------------------------------------------------------------------------
            |  LUT Combining                                    |           61  |              1  |                    62  |           0  |           1  |  00:00:00  |
            |  Retime                                           |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  Very High Fanout                                 |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  DSP Register                                     |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  Shift Register to Pipeline                       |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  Shift Register                                   |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  BRAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  URAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  Dynamic/Static Region Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
            |  Total                                            |           61  |              1  |                    62  |           0  |           9  |  00:00:00  |
            -----------------------------------------------------------------------------------------------------------------------------------------------------------

            """
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
                        break
                except ValueError as e:
                    print(line.split())
                    raise e
                line = next(f)
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


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("experiment_yaml", type=str, help="Path to yaml with list of designs")
    args = parser.parse_args()
    # update_clocks(args.experiment_yaml)
    transform_stats(args.experiment_yaml)
