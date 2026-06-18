"""Analyze Vivado implementation runtimes from Vivado logs for a RandSoC dataset."""

import argparse
import sys
from pathlib import Path

import numpy as np
from matplotlib.colors import LogNorm

sys.path.insert(0, str(Path(__file__).parent))
from parsers import parse_runtime, read_dataset_csv
from plot_utils import figure

# Total slices on the fixed RandSoC target part (xc7a200tsbg484-1, Artix-7
# XC7A200T) used to turn Vivado's slice-utilization percentage back into an
# absolute occupied-slice count.
TOTAL_SLICES = 33650

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
            # Slice utilization lives in a separate report; only the joined-CSV
            # path supplies it, so it is absent (None) when parsing a build dir.
            d["slice"] = None
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
            "slice": r["slice_util_pct"],
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


def plot_runtime(labels: list[str], data: list[dict], out_dir: Path) -> None:
    """One PDF each: stacked runtime breakdown + histogram of total runtime."""
    # A handful of pathological designs (multi-hour routes) would otherwise
    # compress the whole plot, so cap the y-axis at the 99th percentile of total
    # runtime; the few designs above that just clip at the top edge.
    total_vals = np.array([d["total"] for d in data])
    p99 = float(np.percentile(total_vals, 99))
    n_outliers = int((total_vals > p99).sum())

    # --- Stacked area: time breakdown across designs (sorted by total) ---
    # Per-design x-tick labels are meaningless at thousands of designs, so we
    # render a filled stacked area over the sorted designs instead of labelled
    # bars: the shape still shows how phase composition shifts with total time.
    with figure(out_dir / "runtime_breakdown.pdf") as (_fig, ax1):
        order = sorted(range(len(data)), key=lambda i: data[i]["total"])
        sorted_data = [data[i] for i in order]
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
        ax1.set_xlim(0, max(n - 1, 1))
        ax1.set_ylim(0, p99 * 1.05)
        ax1.set_xlabel(f"Designs sorted by total runtime (n={n})")
        ax1.set_ylabel("Elapsed time (s)")
        ax1.legend(fontsize=9, loc="upper left")

    # --- Histogram of total time (clipped to p99 for readability) ---
    with figure(out_dir / "runtime_distribution.pdf") as (_fig, ax2):
        ax2.hist(total_vals, bins=30, range=(float(total_vals.min()), p99),
                 color="#76b7b2", edgecolor="white", linewidth=0.5)
        ax2.set_xlim(float(total_vals.min()), p99)
        ax2.set_xlabel("Total elapsed time (s)")
        ax2.set_ylabel("Number of designs")
        if n_outliers:
            print(f"  Total Runtime Distribution: {n_outliers} designs > {p99:.0f}s not shown")

        median_total = float(np.median(total_vals))
        ax2.axvline(median_total, color="gray", linestyle="--", linewidth=1)
        ax2.text(median_total + (p99 * 0.01), ax2.get_ylim()[1] * 0.9,
                 f"median={median_total:.0f}s", fontsize=9, color="gray")


def plot_size_vs_runtime(data: list[dict], out_dir: Path, log: bool = False) -> None:
    """Scatter of design size (slice utilization) vs total runtime.

    With ``log=True`` both axes are log-scaled (a power-law relationship shows up
    as a straight line) and the correlation is computed in log space; otherwise a
    linear plot is drawn with the y-axis capped at the 99th percentile.
    """
    pts = [(d["slice"], d["total"]) for d in data if d.get("slice") is not None]
    if not pts:
        print("No slice-utilization data available; skipping size-vs-runtime plot")
        return
    x = np.array([p[0] for p in pts], dtype=float)
    y = np.array([p[1] for p in pts], dtype=float)

    if log:
        # Express size as an absolute occupied-slice count (fixed part), then log
        # axes require strictly positive values, so drop any non-positive
        # size/runtime points and correlate the logarithms (a power-law fit).
        x = x * (TOTAL_SLICES / 100.0)
        mask = (x > 0) & (y > 0)
        n_drop = int((~mask).sum())
        x, y = x[mask], y[mask]
        r = float(np.corrcoef(np.log10(x), np.log10(y))[0, 1]) if len(x) > 1 else float("nan")
        out_path, label = out_dir / "runtime_size_vs_runtime_loglog.pdf", "Size vs runtime (log-log)"
        r_label, xlabel = "log-log Pearson r", "Occupied slices"
        drop_note = f"{n_drop} designs with zero size/runtime not shown" if n_drop else ""
    else:
        # Cap the y-axis at the 99th percentile so a few multi-hour designs don't
        # flatten everything else; the correlation still uses all points.
        p99 = float(np.percentile(y, 99))
        n_drop = int((y > p99).sum())
        r = float(np.corrcoef(x, y)[0, 1]) if len(x) > 1 else float("nan")
        out_path, label = out_dir / "runtime_size_vs_runtime.pdf", "Size vs runtime"
        r_label, xlabel = "Pearson r", "Slice utilization (%)"
        drop_note = f"{n_drop} designs > {p99:.0f}s not shown" if n_drop else ""

    print(f"  {label}: {r_label} = {r:.2f}, n={len(x)}"
          + (f"; {drop_note}" if drop_note else ""))
    with figure(out_path) as (_fig, ax):
        ax.scatter(x, y, s=8, alpha=0.4, color="#4e79a7", edgecolor="none")
        ax.set_xlabel(xlabel)
        ax.set_ylabel("Total runtime (s)")
        if log:
            ax.set_xscale("log")
            ax.set_yscale("log")
        else:
            ax.set_ylim(0, p99 * 1.05)


def _ternary_xy(fracs: np.ndarray, verts: np.ndarray) -> np.ndarray:
    """Project barycentric (opt, place, route) fractions onto 2D triangle coords."""
    return fracs @ verts


def _ternary_gridlines(ax, verts: np.ndarray, levels=(0.2, 0.4, 0.6, 0.8)) -> None:
    """Draw faint constant-fraction gridlines for each of the three axes."""
    for i in range(3):
        j, k = (i + 1) % 3, (i + 2) % 3
        for t in levels:
            b1 = np.zeros(3); b1[i] = t; b1[j] = 1 - t
            b2 = np.zeros(3); b2[i] = t; b2[k] = 1 - t
            (x1, y1), (x2, y2) = b1 @ verts, b2 @ verts
            ax.plot([x1, x2], [y1, y2], color="0.85", linewidth=0.6, zorder=0)


def plot_phase_mix(data: list[dict], out_dir: Path) -> None:
    """Ternary plot of the relative opt/place/route runtime split per design.

    The three phases sum to a whole, so each design is a point inside a triangle
    whose corners are pure Opt / Place / Route. The spread shows how much the
    relative phase composition varies across designs; points are coloured by
    total runtime to reveal whether slow designs favour a particular phase.
    """
    fracs, totals = [], []
    for d in data:
        s = d["opt"] + d["place"] + d["route"]
        if s <= 0:
            continue
        fracs.append((d["opt"] / s, d["place"] / s, d["route"] / s))
        totals.append(d["total"])
    if not fracs:
        print("No opt/place/route runtime data; skipping phase-mix plot")
        return
    fracs = np.array(fracs)
    totals = np.array(totals, dtype=float)

    # Triangle vertices: Opt bottom-left, Place bottom-right, Route apex.
    verts = np.array([[0.0, 0.0], [1.0, 0.0], [0.5, np.sqrt(3) / 2]])
    xy = _ternary_xy(fracs, verts)

    with figure(
        out_dir / "runtime_phase_mix.pdf", figsize=(7, 6.5),
        savefig_kw=dict(bbox_inches="tight"),
    ) as (fig, ax):
        _ternary_gridlines(ax, verts)
        outline = np.vstack([verts, verts[0]])
        ax.plot(outline[:, 0], outline[:, 1], color="black", linewidth=1.2, zorder=1)

        sc = ax.scatter(xy[:, 0], xy[:, 1], c=totals, cmap="viridis",
                        norm=LogNorm(), s=9, alpha=0.5, edgecolor="none", zorder=2)
        cbar = fig.colorbar(sc, ax=ax, shrink=0.7, pad=0.02)
        cbar.set_label("Total runtime (s)")

        ax.text(0.0, -0.04, "Opt", ha="center", va="top",
                fontsize=12, fontweight="bold", color=PHASE_COLORS["opt"])
        ax.text(1.0, -0.04, "Place", ha="center", va="top",
                fontsize=12, fontweight="bold", color=PHASE_COLORS["place"])
        ax.text(0.5, np.sqrt(3) / 2 + 0.03, "Route", ha="center", va="bottom",
                fontsize=12, fontweight="bold", color=PHASE_COLORS["route"])

        ax.set_aspect("equal")
        ax.axis("off")


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
    plot_runtime(labels, data, args.out_dir)
    plot_size_vs_runtime(data, args.out_dir)
    plot_size_vs_runtime(data, args.out_dir, log=True)
    plot_phase_mix(data, args.out_dir)


if __name__ == "__main__":
    main()
