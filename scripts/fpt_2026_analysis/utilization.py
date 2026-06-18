"""Analyze Vivado utilization reports from a RandSoC dataset."""

import argparse
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).parent))
from parsers import RESOURCES, parse_utilization, read_dataset_csv
from plot_utils import figure

COLORS = {
    "LUT": "#4e79a7",
    "FF": "#f28e2b",
    "SLICE": "#b07aa1",
    "BRAM": "#59a14f",
    "DSP": "#e15759",
    "IO": "#76b7b2",
}


def collect_data(build_dir: Path) -> tuple[list[str], list[dict]]:
    """Find all utilization.txt files under build_dir and parse them."""
    paths = sorted(build_dir.glob("*/vivado_impl/utilization.txt"))
    designs, data = [], []
    skipped = 0
    for p in paths:
        d = parse_utilization(p)
        if d is not None:
            designs.append(p.parent.parent.name)
            data.append(d)
        else:
            skipped += 1
    if skipped:
        print(f"Skipped {skipped} reports with missing resource rows")
    return designs, data


def load_csv(rows: list[dict]) -> tuple[list[str], list[dict]]:
    """Build (labels, data) from joined-dataset rows, skipping rows without util data."""
    designs, data = [], []
    for r in rows:
        vals = {
            "LUT": r["lut_util_pct"], "FF": r["ff_util_pct"], "SLICE": r["slice_util_pct"],
            "BRAM": r["bram_util_pct"], "DSP": r["dsp_util_pct"], "IO": r["io_util_pct"],
        }
        if any(v is None for v in vals.values()):
            continue
        designs.append(f"{r['machine']}/d{r['seed']}")
        data.append(vals)
    return designs, data


def print_summary(data: list[dict]) -> None:
    header = f"{'Resource':<8} {'Min':>7} {'Median':>8} {'Mean':>7} {'Max':>7} {'Std':>7}"
    print(header)
    print("-" * len(header))
    for key in RESOURCES:  # pylint: disable=consider-using-dict-items
        vals = np.array([d[key] for d in data])
        print(
            f"{key:<8} {vals.min():>6.1f}% {np.median(vals):>7.1f}% "
            f"{vals.mean():>6.1f}% {vals.max():>6.1f}% {vals.std():>6.1f}%"
        )


def plot_histograms(data: list[dict], out_dir: Path, log: bool = False) -> None:
    """One histogram, in its own PDF, per resource type.

    With ``log=True`` the y-axis (design count) is log-scaled so sparse, heavy
    tails stay visible; the files get a ``_log`` suffix.
    """
    suffix = "_log" if log else ""
    for key in RESOURCES:  # pylint: disable=consider-using-dict-items
        with figure(out_dir / f"utilization_{key.lower()}{suffix}.pdf") as (_fig, ax):
            vals = [d[key] for d in data]
            ax.hist(vals, bins=30, color=COLORS[key], edgecolor="white", linewidth=0.5)
            if log:
                ax.set_yscale("log")
            ax.set_xlabel("Utilization (%)")
            ax.set_ylabel("Number of designs")
            ax.set_xlim(0, 100)


def plot_radar(data: list[dict], out_dir: Path) -> None:
    """Radar chart showing the most extreme design for each resource type."""
    keys = list(RESOURCES.keys())
    N = len(keys)
    angles = np.linspace(0, 2 * np.pi, N, endpoint=False).tolist()
    angles += angles[:1]  # close polygon

    # Find the design index with highest utilization for each resource
    extreme_idx = {key: max(range(len(data)), key=lambda i: data[i][key]) for key in keys}

    # Deduplicate while preserving first-occurrence order
    shown_indices = list(dict.fromkeys(extreme_idx.values()))

    with figure(
        out_dir / "utilization_radar.pdf", figsize=(7, 7),
        subplot_kw=dict(polar=True), savefig_kw=dict(bbox_inches="tight"),
    ) as (_fig, ax):
        ax.set_xticks(angles[:-1])
        ax.set_xticklabels(keys, fontsize=12)
        ax.set_ylim(0, 100)
        ax.set_yticks([20, 40, 60, 80, 100])
        ax.set_yticklabels(["20%", "40%", "60%", "80%", "100%"], fontsize=7)

        cmap = plt.cm.tab10
        for ci, idx in enumerate(shown_indices):
            d = data[idx]
            vals = [d[k] for k in keys] + [d[keys[0]]]
            dominant = [k for k, v in extreme_idx.items() if v == idx]
            label = f"max {'/'.join(dominant)}"
            ax.plot(angles, vals, color=cmap(ci), linewidth=2, label=label)
            ax.fill(angles, vals, color=cmap(ci), alpha=0.12)

        ax.legend(loc="upper right", bbox_to_anchor=(1.4, 1.15), fontsize=8)


def main() -> None:
    parser = argparse.ArgumentParser(description="Analyze RandSoC Vivado utilization reports.")
    src = parser.add_mutually_exclusive_group(required=True)
    src.add_argument(
        "build_dir", type=Path, nargs="?",
        help="Root rand_soc build directory (parse raw reports directly)"
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
        print(f"No utilization data found in {source}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} designs from {source}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_histograms(data, args.out_dir)
    plot_histograms(data, args.out_dir, log=True)
    plot_radar(data, args.out_dir)


if __name__ == "__main__":
    main()
