"""Analyze Vivado timing summary reports from a RandSoC dataset."""

import argparse
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).parent))
from parsers import parse_timing, read_dataset_csv
from plot_utils import figure


def collect_data(build_dir: Path) -> tuple[list[str], list[dict]]:
    """Find all timing_summary.txt files and parse them."""
    paths = sorted(build_dir.glob("*/vivado_impl/timing_summary.txt"))
    designs, data = [], []
    unconstrained = 0
    for p in paths:
        d = parse_timing(p)
        if d is None:
            unconstrained += 1
        else:
            designs.append(p.parent.parent.name)
            data.append(d)
    if unconstrained:
        print(f"Skipped {unconstrained} unconstrained designs (no clock_period set)")
    return designs, data


def fmax_mhz(d: dict) -> float | None:
    """Achieved max frequency (MHz) = 1000 / (target_period - WNS)."""
    period = d.get("clk_period")
    wns = d.get("wns")
    if period is None or wns is None:
        return None
    slack_period = period - wns
    return 1000.0 / slack_period if slack_period > 0 else None


def load_csv(rows: list[dict]) -> tuple[list[str], list[dict]]:
    """Build (labels, data) from joined-dataset rows, skipping unconstrained designs."""
    designs, data = [], []
    for r in rows:
        if r["wns_ns"] is None:
            continue
        designs.append(f"{r['machine']}/d{r['seed']}")
        data.append({
            "wns": r["wns_ns"],
            "tns": r["tns_ns"],
            "failing_endpoints": r["failing_endpoints"],
            "total_endpoints": r["total_endpoints"],
            "logic_levels": r["logic_levels"],
            "data_path_delay": r["data_path_delay_ns"],
            "clk_period": r["clk_period_ns"],
        })
    return designs, data


def print_summary(data: list[dict]) -> None:
    meeting = sum(1 for d in data if d["wns"] >= 0)
    failing = len(data) - meeting
    print(f"Timing closure: {meeting}/{len(data)} designs meet timing ({failing} failing)\n")

    rows = [
        ("WNS (ns)", lambda d: d["wns"]),
        ("TNS (ns)", lambda d: d["tns"]),
        ("Fmax (MHz)", fmax_mhz),
        ("Failing endpoints", lambda d: d["failing_endpoints"]),
        ("Logic levels (worst path)", lambda d: d["logic_levels"]),
        ("Data path delay (ns)", lambda d: d["data_path_delay"]),
    ]
    header = f"{'Metric':<28} {'Min':>8} {'Median':>8} {'Mean':>8} {'Max':>8}"
    print(header)
    print("-" * len(header))
    for label, getter in rows:
        vals = np.array([v for v in (getter(d) for d in data) if v is not None], dtype=float)
        if len(vals):
            print(
                f"{label:<28} {vals.min():>8.3f} {np.median(vals):>8.3f}"
                f" {vals.mean():>8.3f} {vals.max():>8.3f}"
            )


def _clip_range(vals: np.ndarray, clip: str, k: float = 1.5) -> tuple[float, float, int]:
    """Return (lo, hi, n_outliers) trimming the requested tail(s) to a Tukey fence.

    These timing metrics are extremely heavy-tailed/bimodal — designs that fail
    timing have catastrophic values (logic depth, slack, endpoints) while the
    rest cluster tightly — so a percentile clip is far too loose. The Tukey fence
    (Q1 - k·IQR, Q3 + k·IQR) tracks the bulk and the panel reports how many
    designs fall outside the shown range.
    """
    q1, q3 = np.percentile(vals, [25, 75])
    iqr = q3 - q1
    lo, hi = float(vals.min()), float(vals.max())
    n_out = 0
    if clip in ("lower", "both"):
        lo = float(q1 - k * iqr)
        n_out += int((vals < lo).sum())
    if clip in ("upper", "both"):
        hi = float(q3 + k * iqr)
        n_out += int((vals > hi).sum())
    return lo, hi, n_out


def _hist(ax, raw, color, title, xlabel, clip="upper", integer=False):
    vals = np.array([v for v in raw if v is not None], dtype=float)
    if len(vals) == 0:
        ax.set_visible(False)
        return
    lo, hi, n_out = _clip_range(vals, clip)
    if hi <= lo:
        hi = lo + 1
    if integer:
        edges = np.arange(int(np.floor(lo)), int(np.ceil(hi)) + 2) - 0.5
        ax.hist(vals, bins=edges, color=color, edgecolor="white", linewidth=0.5)
        ax.xaxis.set_major_locator(plt.MaxNLocator(integer=True))
    else:
        ax.hist(vals, bins=30, range=(lo, hi), color=color, edgecolor="white", linewidth=0.5)
    ax.set_xlim(lo, hi)
    if n_out:
        print(f"  {title}: {n_out} outliers not shown")
    ax.set_xlabel(xlabel)
    ax.set_ylabel("Number of designs")


def plot_timing(data: list[dict], out_dir: Path) -> None:
    """One PDF each: WNS, Fmax, TNS, failing endpoints, logic levels, data path delay."""
    # --- WNS (pass/fail coloured, negative tail clipped) ---
    with figure(out_dir / "timing_wns.pdf") as (_fig, ax):
        wns_vals = np.array([d["wns"] for d in data], dtype=float)
        lo, hi, n_out = _clip_range(wns_vals, "lower")
        hi = max(hi, 0.1)
        bins = np.linspace(lo, hi, 30)
        neg = wns_vals[wns_vals < 0]
        pos = wns_vals[wns_vals >= 0]
        if len(neg):
            ax.hist(neg, bins=bins, color="#e15759", label=f"Failing ({len(neg)})")
        if len(pos):
            ax.hist(pos, bins=bins, color="#4e79a7", label=f"Meeting ({len(pos)})")
        ax.axvline(0, color="black", linewidth=1, linestyle="--")
        ax.set_xlim(lo, hi)
        if n_out:
            print(f"  WNS Distribution: {n_out} outliers not shown")
        ax.set_xlabel("WNS (ns)")
        ax.set_ylabel("Number of designs")
        ax.legend(fontsize=9)

    # --- Fmax (achieved) ---
    # Clip only the high tail: the low tail is the failing/hard-design population
    # (fmax well below target), which is exactly what we want to keep visible.
    periods = np.array([d["clk_period"] for d in data if d.get("clk_period")], dtype=float)
    with figure(out_dir / "timing_fmax.pdf") as (_fig, ax):
        fmax_vals = [fmax_mhz(d) for d in data]
        _hist(ax, fmax_vals, "#af7aa1", "Achieved Fmax", "Fmax (MHz)", clip="upper")
        # Mark the median target frequency for reference.
        if len(periods):
            target_mhz = 1000.0 / float(np.median(periods))
            ax.axvline(target_mhz, color="black", linewidth=1, linestyle="--")
            ax.text(target_mhz, ax.get_ylim()[1] * 0.92,
                    f" target {target_mhz:.0f} MHz", fontsize=8, color="black")
        # Anchor the Fmax axis at 0 so the slow/failing tail reads on an absolute scale.
        ax.set_xlim(left=0)

    # --- TNS (negative tail clipped) ---
    with figure(out_dir / "timing_tns.pdf") as (_fig, ax):
        _hist(ax, [d["tns"] for d in data], "#9c755f", "TNS Distribution",
              "TNS (ns)", clip="lower")

    # --- Failing endpoints (upper tail clipped) ---
    with figure(out_dir / "timing_failing_endpoints.pdf") as (_fig, ax):
        _hist(ax, [d["failing_endpoints"] for d in data], "#f28e2b",
              "Failing Timing Endpoints", "Count", clip="upper")

    # --- Logic levels (integer, upper tail clipped) ---
    with figure(out_dir / "timing_logic_levels.pdf") as (_fig, ax):
        _hist(ax, [d["logic_levels"] for d in data], "#59a14f",
              "Critical Path Logic Levels", "Logic levels", clip="upper", integer=True)

    # --- Data path delay (upper tail clipped) ---
    with figure(out_dir / "timing_data_path_delay.pdf") as (_fig, ax):
        _hist(ax, [d["data_path_delay"] for d in data], "#76b7b2",
              "Worst-Case Data Path Delay", "Delay (ns)", clip="upper")


def main() -> None:
    parser = argparse.ArgumentParser(description="Analyze RandSoC Vivado timing reports.")
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
        print(f"No constrained timing data found in {source}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsed {len(data)} constrained designs from {source}\n")
    print_summary(data)
    print()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    plot_timing(data, args.out_dir)


if __name__ == "__main__":
    main()
