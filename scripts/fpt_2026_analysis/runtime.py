"""Analyze Vivado implementation runtimes from Vivado logs for a RandSoC dataset."""

import argparse
import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

PHASES = ["synth", "opt", "place", "route"]
PHASE_LABELS = {"synth": "Synthesis", "opt": "Opt", "place": "Place", "route": "Route"}
PHASE_COLORS = {
    "synth": "#4e79a7",
    "opt":   "#f28e2b",
    "place": "#59a14f",
    "route": "#e15759",
}


def _parse_elapsed(hms: str) -> float:
    """Convert HH:MM:SS or HH:MM:SS.ss to seconds."""
    parts = hms.split(":")
    return sum(float(p) * 60 ** (len(parts) - 1 - i) for i, p in enumerate(parts))


def parse_runtime(synth_log: Path, impl_log: Path) -> dict | None:
    """Parse elapsed wall-clock time for each Vivado phase."""
    result = {}

    if synth_log.exists():
        m = re.search(
            r"^synth_design: Time.*?elapsed = ([\d:]+)",
            synth_log.read_text(), re.MULTILINE,
        )
        if m:
            result["synth"] = _parse_elapsed(m.group(1))

    if impl_log.exists():
        text = impl_log.read_text()
        for phase in ["opt_design", "place_design", "route_design"]:
            m = re.search(rf"^{phase}: Time.*?elapsed = ([\d:]+)", text, re.MULTILINE)
            if m:
                result[phase.replace("_design", "")] = _parse_elapsed(m.group(1))

    if not result:
        return None

    result["impl"] = sum(result.get(p, 0) for p in ["opt", "place", "route"])
    result["total"] = result.get("synth", 0) + result["impl"]
    return result


def collect_data(build_dir: Path) -> tuple[list[int], list[dict]]:
    seeds, data = [], []
    skipped = 0
    for design_dir in sorted(build_dir.glob("design_*")):
        seed = int(design_dir.name.split("_")[1])
        d = parse_runtime(
            design_dir / "vivado_synth" / "vivado.log",
            design_dir / "vivado_impl" / "vivado.log",
        )
        if d is not None:
            seeds.append(seed)
            data.append(d)
        else:
            skipped += 1
    if skipped:
        print(f"Skipped {skipped} designs with missing logs")
    return seeds, data


def print_summary(data: list[dict]) -> None:
    header = f"{'Phase':<10} {'Min':>7} {'Median':>8} {'Mean':>7} {'Max':>7}"
    print(header)
    print("-" * len(header))
    for key in PHASES + ["impl", "total"]:
        vals = np.array([d[key] for d in data if key in d])
        if len(vals):
            label = PHASE_LABELS.get(key, key.capitalize())
            print(
                f"{label:<10} {vals.min():>6.0f}s {np.median(vals):>7.0f}s"
                f" {vals.mean():>6.0f}s {vals.max():>6.0f}s"
            )


def plot_runtime(seeds: list[int], data: list[dict], out_path: Path) -> None:
    """Two-panel figure: stacked bar per design + histogram of total runtime."""
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

    # Sort by total time for the stacked bar
    order = sorted(range(len(data)), key=lambda i: data[i]["total"])
    sorted_seeds = [seeds[i] for i in order]
    sorted_data = [data[i] for i in order]

    # --- Stacked bar: time breakdown per design ---
    bottoms = np.zeros(len(sorted_data))
    for phase in PHASES:
        vals = np.array([d.get(phase, 0) for d in sorted_data])
        ax1.bar(
            range(len(sorted_data)),
            vals,
            bottom=bottoms,
            color=PHASE_COLORS[phase],
            label=PHASE_LABELS[phase],
            edgecolor="white",
            linewidth=0.3,
        )
        bottoms += vals
    ax1.set_xticks(range(len(sorted_seeds)))
    ax1.set_xticklabels([f"d{s}" for s in sorted_seeds], fontsize=8)
    ax1.set_ylabel("Elapsed time (s)")
    ax1.set_title("Runtime Breakdown per Design\n(sorted by total)", fontweight="bold")
    ax1.legend(fontsize=9)

    # --- Histogram of total time ---
    total_vals = [d["total"] for d in data]
    ax2.hist(total_vals, bins=15, color="#76b7b2", edgecolor="white", linewidth=0.5)
    ax2.set_xlabel("Total elapsed time (s)")
    ax2.set_ylabel("Number of designs")
    ax2.set_title("Total Runtime Distribution", fontweight="bold")

    mean_total = np.mean(total_vals)
    ax2.axvline(mean_total, color="gray", linestyle="--", linewidth=1)
    ax2.text(mean_total + 1, ax2.get_ylim()[1] * 0.9, f"mean={mean_total:.0f}s",
             fontsize=9, color="gray")

    fig.suptitle(
        f"Vivado Runtime Analysis — {len(data)} designs  "
        f"(mean total: {mean_total:.0f}s = {mean_total/60:.1f} min)",
        fontsize=12,
    )
    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    print(f"Saved {out_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Analyze RandSoC Vivado runtimes.")
    parser.add_argument(
        "build_dir", type=Path, help="Root rand_soc build directory (e.g. build/rand_soc)"
    )
    parser.add_argument(
        "--out-dir", type=Path, default=Path("output"), help="Directory for output plots"
    )
    args = parser.parse_args()

    seeds, data = collect_data(args.build_dir)
    if not data:
        print(f"No runtime logs found under {args.build_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} designs from {args.build_dir}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_runtime(seeds, data, args.out_dir / "runtime.png")


if __name__ == "__main__":
    main()
