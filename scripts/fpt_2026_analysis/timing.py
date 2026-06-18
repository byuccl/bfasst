"""Analyze Vivado timing summary reports from a RandSoC dataset."""

import argparse
import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


def parse_timing(path: Path) -> dict | None:
    """Parse a Vivado timing_summary.txt; returns timing metrics or None if unconstrained."""
    text = path.read_text()

    if "There are no user specified timing constraints" in text:
        return None

    # WNS, TNS, failing endpoints, total endpoints from the Intra Clock Table row for clk_out1
    # Row format:  clk_out1_<name>  WNS  TNS  TNS_fail  TNS_total  WPWS  TPWS  ...
    clock_row = re.search(
        r"^\s+clk_out1_\S+\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+(\d+)",
        text,
        re.MULTILINE,
    )
    if not clock_row:
        return None

    wns = float(clock_row.group(1))
    tns = float(clock_row.group(2))
    failing_endpoints = int(clock_row.group(3))
    total_endpoints = int(clock_row.group(4))

    # Logic levels and data path delay from the first constrained Max Delay Paths section.
    # Find the first path that is clocked (VIOLATED or MET, not inf).
    # The constrained paths appear before unconstrained (inf) ones.
    logic_levels = None
    data_path_delay = None

    # Locate the first Slack line that is not "inf"
    for m in re.finditer(r"Slack\s*(?:\(VIOLATED\)|\(MET\))\s*:\s*([-\d.]+)ns", text):
        # From this position, grab the next Logic Levels and Data Path Delay lines
        tail = text[m.start() :]
        ll_m = re.search(r"Logic Levels:\s+(\d+)", tail)
        dp_m = re.search(r"Data Path Delay:\s+([\d.]+)ns", tail)
        if ll_m and dp_m:
            logic_levels = int(ll_m.group(1))
            data_path_delay = float(dp_m.group(1))
        break

    return {
        "wns": wns,
        "tns": tns,
        "failing_endpoints": failing_endpoints,
        "total_endpoints": total_endpoints,
        "logic_levels": logic_levels,
        "data_path_delay": data_path_delay,
    }


def collect_data(build_dir: Path) -> tuple[list[Path], list[dict]]:
    """Find all timing_summary.txt files and parse them."""
    paths = sorted(build_dir.glob("*/vivado_impl/timing_summary.txt"))
    designs, data = [], []
    unconstrained = 0
    for p in paths:
        d = parse_timing(p)
        if d is None:
            unconstrained += 1
        else:
            designs.append(p.parent.parent)
            data.append(d)
    if unconstrained:
        print(f"Skipped {unconstrained} unconstrained designs (no clock_period set)")
    return designs, data


def print_summary(data: list[dict]) -> None:
    meeting = sum(1 for d in data if d["wns"] >= 0)
    failing = len(data) - meeting
    print(f"Timing closure: {meeting}/{len(data)} designs meet timing ({failing} failing)\n")

    rows = [
        ("WNS (ns)", "wns"),
        ("TNS (ns)", "tns"),
        ("Failing endpoints", "failing_endpoints"),
        ("Logic levels (worst path)", "logic_levels"),
        ("Data path delay (ns)", "data_path_delay"),
    ]
    header = f"{'Metric':<28} {'Min':>8} {'Median':>8} {'Mean':>8} {'Max':>8}"
    print(header)
    print("-" * len(header))
    for label, key in rows:
        vals = np.array([d[key] for d in data if d[key] is not None], dtype=float)
        if len(vals):
            print(
                f"{label:<28} {vals.min():>8.3f} {np.median(vals):>8.3f}"
                f" {vals.mean():>8.3f} {vals.max():>8.3f}"
            )


def plot_timing(data: list[dict], out_path: Path) -> None:
    """2x2 grid: WNS, failing endpoints, logic levels, data path delay."""
    fig, axes = plt.subplots(2, 2, figsize=(12, 9))

    # --- WNS ---
    ax = axes[0, 0]
    wns_vals = [d["wns"] for d in data]
    colors = ["#e15759" if v < 0 else "#4e79a7" for v in wns_vals]
    ax.bar(range(len(wns_vals)), sorted(wns_vals), color=sorted(colors, key=lambda c: c != "#e15759"))
    # Histogram instead of bar
    ax.cla()
    neg = [v for v in wns_vals if v < 0]
    pos = [v for v in wns_vals if v >= 0]
    bins = np.linspace(min(wns_vals) - 0.1, max(wns_vals) + 0.1, 30)
    if neg:
        ax.hist(neg, bins=bins, color="#e15759", label=f"Failing ({len(neg)})")
    if pos:
        ax.hist(pos, bins=bins, color="#4e79a7", label=f"Meeting ({len(pos)})")
    ax.axvline(0, color="black", linewidth=1, linestyle="--")
    ax.set_title("WNS Distribution", fontweight="bold")
    ax.set_xlabel("WNS (ns)")
    ax.set_ylabel("Number of designs")
    ax.legend(fontsize=9)

    # --- Failing endpoints ---
    ax = axes[0, 1]
    fe_vals = [d["failing_endpoints"] for d in data]
    ax.hist(fe_vals, bins=20, color="#f28e2b", edgecolor="white", linewidth=0.5)
    ax.set_title("Failing Timing Endpoints", fontweight="bold")
    ax.set_xlabel("Count")
    ax.set_ylabel("Number of designs")

    # --- Logic levels ---
    ax = axes[1, 0]
    ll_vals = [d["logic_levels"] for d in data if d["logic_levels"] is not None]
    ax.hist(ll_vals, bins=range(min(ll_vals), max(ll_vals) + 2), color="#59a14f",
            edgecolor="white", linewidth=0.5, align="left")
    ax.set_title("Critical Path Logic Levels", fontweight="bold")
    ax.set_xlabel("Logic levels")
    ax.set_ylabel("Number of designs")
    ax.xaxis.set_major_locator(plt.MaxNLocator(integer=True))

    # --- Data path delay ---
    ax = axes[1, 1]
    dp_vals = [d["data_path_delay"] for d in data if d["data_path_delay"] is not None]
    ax.hist(dp_vals, bins=20, color="#76b7b2", edgecolor="white", linewidth=0.5)
    ax.set_title("Worst-Case Data Path Delay", fontweight="bold")
    ax.set_xlabel("Delay (ns)")
    ax.set_ylabel("Number of designs")

    meeting = sum(1 for d in data if d["wns"] >= 0)
    fig.suptitle(
        f"Timing Analysis — {len(data)} designs, {meeting} meeting timing at 120 MHz",
        fontsize=13,
    )
    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    print(f"Saved {out_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Analyze RandSoC Vivado timing reports.")
    parser.add_argument(
        "build_dir", type=Path, help="Root rand_soc build directory (e.g. build/rand_soc)"
    )
    parser.add_argument(
        "--out-dir", type=Path, default=Path("output"), help="Directory for output plots"
    )
    args = parser.parse_args()

    designs, data = collect_data(args.build_dir)
    if not data:
        print(f"No constrained timing reports found under {args.build_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} constrained designs from {args.build_dir}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_timing(data, args.out_dir / "timing.png")


if __name__ == "__main__":
    main()
