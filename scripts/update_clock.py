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
                    lines[idx] = f"    period: {period}\n"
                    try:
                        if "waveform" in lines[idx + 1]:
                            lines.pop(idx + 1)
                    except IndexError:
                        pass
                    break
        with open(design_yaml, "w") as f:
            f.writelines(lines)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("experiment_yaml", type=str, help="Path to yaml with list of designs")
    args = parser.parse_args()
    update_clocks(args.experiment_yaml)
