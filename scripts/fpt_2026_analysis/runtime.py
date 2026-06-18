"""Analyze Vivado implementation runtimes from Vivado logs for a RandSoC dataset."""

import argparse
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).parent))
from parsers import parse_runtime, read_dataset_csv

PHASES = ["synth", "opt", "place", "route"]
PHASE_LABELS = {"synth": "Synthesis", "opt": "Opt", "place": "Place", "route": "Route"}
PHASE_COLORS = {
    "synth": "#4e79a7",
    "opt":   "#f28e2b",
    "place": "#59a14f",
    "route": "#e15759",
}


def collect_data(build_dir: Path) -> tuple[list[str], list[dict]]:
    labels, data = [], []
    skipped = 0
    for design_dir in sorted(build_dir.glob("design_*")):
        d = parse_runtime(
            design_dir / "vivado_synth" / "vivado.log",
            design_dir / "vivado_impl" / "vivado.log",
        )
        if d is not None:
            labels.append(design_dir.name)
            data.append(d)
        else:
            skipped += 1
    if skipped:
        print(f"Skipped {skipped} designs with missing logs")
    return labels, data


def load_csv(rows: list[dict]) -> tuple[list[str], list[dict]]:
    """Build (labels, data) from joined-dataset rows, skipping rows without runtime data."""
    labels, data = [], []
    for r in rows:
        if r["total_elapsed_s"] is None:
            continue
        labels.append(f"{r['machine']}/d{r['seed']}")
        # Phase totals default to 0 when a phase is absent, matching the
        # build-dir path's dict.get(phase, 0) usage in the plotting code.
        data.append({
            "synth": r["synth_elapsed_s"] or 0.0, "opt": r["opt_elapsed_s"] or 0.0,
            "place": r["place_elapsed_s"] or 0.0, "route": r["route_elapsed_s"] or 0.0,
            "impl": r["impl_elapsed_s"], "total": r["total_elapsed_s"],
        })
    return labels, data


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


def plot_runtime(labels: list[str], data: list[dict], out_path: Path) -> None:
    """Two-panel figure: stacked runtime breakdown + histogram of total runtime."""
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

    # Sort by total time for the stacked area
    order = sorted(range(len(data)), key=lambda i: data[i]["total"])
    sorted_data = [data[i] for i in order]

    # --- Stacked area: time breakdown across designs (sorted by total) ---
    # Per-design x-tick labels are meaningless at thousands of designs, so we
    # render a filled stacked area over the sorted designs instead of labelled
    # bars: the shape still shows how phase composition shifts with total time.
    n = len(sorted_data)
    x = np.arange(n)
    bottoms = np.zeros(n)
    for phase in PHASES:
        vals = np.array([d.get(phase, 0) for d in sorted_data])
        ax1.fill_between(
            x, bottoms, bottoms + vals,
            color=PHASE_COLORS[phase], label=PHASE_LABELS[phase], linewidth=0,
        )
        bottoms += vals
    # A handful of pathological designs (multi-hour routes) would otherwise
    # compress the whole plot, so cap the y-axis at the 99th percentile of total
    # runtime; the few designs above that just clip at the top edge.
    total_vals = np.array([d["total"] for d in data])
    p99 = float(np.percentile(total_vals, 99))
    n_outliers = int((total_vals > p99).sum())
    ax1.set_xlim(0, max(n - 1, 1))
    ax1.set_ylim(0, p99 * 1.05)
    ax1.set_xlabel(f"Designs sorted by total runtime (n={n})")
    ax1.set_ylabel("Elapsed time (s)")
    ax1.set_title("Runtime Breakdown per Design\n(sorted by total)", fontweight="bold")
    ax1.legend(fontsize=9, loc="upper left")

    # --- Histogram of total time (clipped to p99 for readability) ---
    ax2.hist(total_vals, bins=30, range=(float(total_vals.min()), p99),
             color="#76b7b2", edgecolor="white", linewidth=0.5)
    ax2.set_xlim(float(total_vals.min()), p99)
    ax2.set_xlabel("Total elapsed time (s)")
    ax2.set_ylabel("Number of designs")
    title = "Total Runtime Distribution"
    if n_outliers:
        title += f"\n({n_outliers} designs > {p99:.0f}s not shown)"
    ax2.set_title(title, fontweight="bold")

    mean_total = float(total_vals.mean())
    median_total = float(np.median(total_vals))
    ax2.axvline(median_total, color="gray", linestyle="--", linewidth=1)
    ax2.text(median_total + (p99 * 0.01), ax2.get_ylim()[1] * 0.9,
             f"median={median_total:.0f}s", fontsize=9, color="gray")

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
        labels, data = load_csv(read_dataset_csv(args.csv))
        source = args.csv
    else:
        labels, data = collect_data(args.build_dir)
        source = args.build_dir
    if not data:
        print(f"No runtime data found in {source}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} designs from {source}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_runtime(labels, data, args.out_dir / "runtime.png")


if __name__ == "__main__":
    main()
