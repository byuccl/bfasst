"""
Add a clock signal "clk" if a clock is not already defined in the design's
.yaml file.

Read timing_sumamry.txt from ClockCrank flow to update design.yaml with the
new clock period.
"""

import re
from argparse import ArgumentParser

from bfasst.paths import BFASST_BUILD, BFASST_DESIGNS


def get_clock_wns(timing_summary: str) -> tuple[float, float]:
    """Get design clock period and negative slack if any"""
    clock_period = None
    neg_slack = None
    with open(timing_summary, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith("Requirement:"):
                line = line.split()[1]
                clock_period = re.match(r"\d+\.?\d*", line)
                break
            if line.startswith("Slack") and "VIOLATED" in line:
                line = line.split()[3]
                # Also match a negative slack value
                neg_slack = re.match(r"-?\d+\.?\d*", line)
    return clock_period, neg_slack


def update_clock(designs: list[str]):
    """Update clock period based on timing_summary.txt."""
    for d in designs:
        src_dir = BFASST_DESIGNS / d
        design_config = src_dir / "design.yaml"
        timing_summary = BFASST_BUILD / d / "vivado_impl/timing_summary.txt"

        if not timing_summary.exists():
            print(f"Timing summary file not found for design {d}. Skipping update.")
            continue

        # Extract clock period from timing summary
        clock_period, neg_slack = get_clock_wns(timing_summary)

        if clock_period is None:
            print(f"No clock period found in timing summary for design {d}. Skipping update.")
            continue

        clk = float(clock_period.group(0))
        if neg_slack is not None:
            neg_slack = float(neg_slack.group(0))
            if neg_slack < -0.5:
                neg_slack += 0.49
                clk = clk + abs(neg_slack)

        new_lines = []
        with open(design_config, "r") as f:
            for ln in f:
                if "period" in ln:
                    fix = ln.find("include_all")
                    if fix != -1:
                        tmp = ln[:fix]
                        fix = ln[fix:]
                        ln = tmp
                    new_lines.append(f"    period:  {clk}\n")
                    if fix != -1:
                        new_lines.append("\n")
                        new_lines.append(fix)
                else:
                    new_lines.append(ln)
        with open(design_config, "w") as f:
            f.writelines(new_lines)


def init_clock(designs: list[str], clock_name: str = "clk", period: int = 100):
    """Add defualt clock signal and period to design.yaml if not already defined."""
    for d in designs:
        src_dir = BFASST_DESIGNS / d
        design_config = src_dir / "design.yaml"
        if not design_config.exists():
            design_config.touch()

        with open(design_config, "r") as f:
            if [ln for ln in f if "clocks" in ln]:
                continue

        with open(design_config, "a") as f:
            f.write(f"\nclocks:\n  - name: {clock_name}\n    period: {period}\n")


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "flow_file",
        type=str,
        help="Path to the flow file containing design names",
    )
    parser.add_argument(
        "-i", "--init", action="store_true", default=False, help="Initialize clock in design.yaml"
    )
    parser.add_argument(
        "-u",
        "--update",
        action="store_true",
        default=False,
        help="Update clock period in design.yaml",
    )
    args = parser.parse_args()

    design_list = []
    with open(args.flow_file, "r") as ff:
        gen = (ln.strip() for ln in ff if ln and ln.strip().startswith("-"))
        design_list = [ln.split(" ")[1] for ln in gen]

    if args.init:
        init_clock(design_list)

    if args.update:
        update_clock(design_list)
