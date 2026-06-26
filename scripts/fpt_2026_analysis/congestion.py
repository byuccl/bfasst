"""Analyze routing congestion from Vivado implementation logs for a RandSoC dataset."""

import argparse
import sys
from pathlib import Path

import numpy as np

sys.path.insert(0, str(Path(__file__).parent))
from parsers import DIRECTIONS, parse_congestion, read_dataset_csv
from plot_utils import figure


def collect_data(build_dir: Path) -> tuple[list[str], list[dict]]:
    logs = sorted(build_dir.glob("*/vivado_impl/vivado.log"))
    designs, data = [], []
    skipped = 0
    for log in logs:
        d = parse_congestion(log)
        if d is not None:
            designs.append(log.parent.parent.name)
            data.append(d)
        else:
            skipped += 1
    if skipped:
        print(f"Skipped {skipped} logs with missing congestion data")
    return designs, data


def load_csv(rows: list[dict]) -> tuple[list[str], list[dict]]:
    """Build (labels, data) from joined-dataset rows, skipping rows without congestion data."""
    designs, data = [], []
    for r in rows:
        if r["congestion_max_pct"] is None:
            continue
        designs.append(f"{r['machine']}/d{r['seed']}")
        data.append({
            "North": r["congestion_north_pct"],
            "South": r["congestion_south_pct"],
            "East": r["congestion_east_pct"],
            "West": r["congestion_west_pct"],
            "max": r["congestion_max_pct"],
            "has_congested_region": bool(r["has_congestion_hotspot"]),
        })
    return designs, data


def print_summary(data: list[dict]) -> None:
    hotspot = sum(1 for d in data if d["has_congested_region"])
    print(f"Designs with congestion hotspots: {hotspot}/{len(data)}\n")

    header = f"{'Direction':<10} {'Min':>7} {'Median':>8} {'Mean':>7} {'Max':>7}"
    print(header)
    print("-" * len(header))
    for key in DIRECTIONS + ["max"]:
        vals = np.array([d[key] for d in data])
        label = key if key != "max" else "Overall max"
        print(
            f"{label:<10} {vals.min():>6.1f}% {np.median(vals):>7.1f}%"
            f" {vals.mean():>6.1f}% {vals.max():>6.1f}%"
        )


def plot_congestion(data: list[dict], out_dir: Path) -> None:
    """One PDF each: per-direction box plots, overall max histogram, hotspot count."""
    dir_colors = {
        "North": "#4e79a7",
        "South": "#f28e2b",
        "East":  "#e15759",
        "West":  "#59a14f",
    }

    # --- Box plots per direction ---
    with figure(out_dir / "congestion_by_direction.pdf") as (_fig, ax1):
        box_data = [[d[direction] for d in data] for direction in DIRECTIONS]
        bp = ax1.boxplot(box_data, patch_artist=True, widths=0.5)
        for patch, direction in zip(bp["boxes"], DIRECTIONS):
            patch.set_facecolor(dir_colors[direction])
            patch.set_alpha(0.7)
        ax1.set_xticklabels(DIRECTIONS)
        ax1.set_ylabel("Peak routing segment utilization (%)")
        ax1.axhline(85, color="gray", linewidth=0.8, linestyle="--", label="85% threshold")
        ax1.legend(fontsize=8)

    # --- Overall max histogram ---
    with figure(out_dir / "congestion_max.pdf") as (_fig, ax2):
        max_vals = [d["max"] for d in data]
        # Congestion can exceed 100% (Vivado reports routing overuse that way), so
        # the upper bin edge tracks the actual max rather than being capped at 100.
        bins = np.linspace(min(max_vals) - 1, max(max(max_vals), 100) + 1, 25)
        ax2.hist(max_vals, bins=bins, color="#4e79a7", alpha=0.8)
        ax2.set_xlabel("Peak routing segment utilization (%)")
        ax2.set_ylabel("Number of designs")

    # --- Hotspot count bar ---
    with figure(out_dir / "congestion_hotspots.pdf") as (_fig, ax3):
        hotspot = sum(1 for d in data if d["has_congested_region"])
        clean = len(data) - hotspot
        ax3.bar(["Clean", "Hotspot"], [clean, hotspot],
                color=["#4e79a7", "#e15759"], edgecolor="white")
        ax3.bar_label(ax3.containers[0], padding=3)
        ax3.set_ylabel("Number of designs")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Analyze RandSoC routing congestion from Vivado impl logs."
    )
    src = parser.add_mutually_exclusive_group(required=True)
    src.add_argument(
        "build_dir", type=Path, nargs="?",
        help="Root rand_soc build directory (parse raw logs directly)"
    )
    src.add_argument(
        "--csv", type=Path, help="Joined dataset CSV to plot from (e.g. output/dataset.csv)"
    )
    parser.add_argument(
        "--out-dir", type=Path, default=Path("output"), help="Directory for output plots"
    )
    args = parser.parse_args()

    if args.csv:
        designs, data = load_csv(read_dataset_csv(args.csv))
        source = args.csv
    else:
        designs, data = collect_data(args.build_dir)
        source = args.build_dir
    if not data:
        print(f"No congestion data found in {source}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} designs from {source}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_congestion(data, args.out_dir)


if __name__ == "__main__":
    main()
