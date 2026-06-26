"""Box-and-whisker plot of per-IP resource size across the RandSoC dataset.

Reads one or more ``ip_sizes.csv`` files (produced by ``ip_sizes_dataset.py`` on
each build machine) and draws, for each IP type, the distribution of its size --
how big each IP lands after implementation, across every design it appears in.

Size metric defaults to Total LUTs (the hierarchical utilization report has no
"slice" column, so LUTs/FFs are the natural per-instance size proxy).

Usage:
    python ip_sizes.py output/raw/*_ip_sizes.csv --out-dir output
    python ip_sizes.py output/ip_sizes.csv --metric ffs
"""

import argparse
import csv
import sys
from pathlib import Path

import numpy as np

sys.path.insert(0, str(Path(__file__).parent))
from plot_utils import figure

# Auto-inserted connectivity glue and SoC scaffolding -- excluded by default so
# the plot shows the functional IP pool. Pass --all to include them.
GLUE = {"slice_and_concat", "axis_dwidth_converter", "axis_broadcaster",
        "axis_combiner", "reduce"}
INFRA = {"intc", "reset", "clk_wiz", "axi", "axi_legacy", "jtag_axi"}

# Synthetic metrics: a sum over several raw hierarchical-report columns. The
# hierarchical report has no slice/CLB (or CARRY) column, so "luts_ffs" -- the
# slice-resident logic primitives -- is the closest available proxy to per-IP
# slice usage. DSP/BRAM are intentionally excluded: they are hard blocks counted
# in their own units and would distort a raw cell-count sum.
SYNTHETIC_METRICS = {
    "luts_ffs": ["total_luts", "ffs"],
}

METRIC_LABELS = {
    "total_luts": "Total LUTs",
    "logic_luts": "Logic LUTs",
    "ffs": "Flip-flops",
    "dsp": "DSP blocks",
    "ramb36": "RAMB36",
    "ramb18": "RAMB18",
    "luts_ffs": "LUTs + FFs",
}


def load(csv_paths: list[Path], metric: str) -> dict[str, list[int]]:
    """Map ip_type -> list of metric values across all instances in all CSVs.

    ``metric`` may be a raw column or a SYNTHETIC_METRICS key (summed columns).
    """
    columns = SYNTHETIC_METRICS.get(metric, [metric])
    by_type: dict[str, list[int]] = {}
    for path in csv_paths:
        with open(path, newline="") as f:
            for row in csv.DictReader(f):
                try:
                    val = sum(int(row[c]) for c in columns)
                except (KeyError, ValueError, TypeError):
                    continue  # missing/blank/short-row cell -> skip this instance
                by_type.setdefault(row["ip_type"], []).append(val)
    return by_type


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=Path, nargs="+", help="One or more ip_sizes.csv files")
    parser.add_argument("--out-dir", type=Path, default=Path("output"))
    parser.add_argument("--metric", default="total_luts", choices=sorted(METRIC_LABELS),
                        help="Resource to plot (default: total_luts)")
    parser.add_argument("--min-count", type=int, default=20,
                        help="Drop IP types with fewer than this many instances (default: 20)")
    parser.add_argument("--all", action="store_true",
                        help="Include glue/scaffolding IPs (slice/concat, converters, intc, ...)")
    parser.add_argument("--types",
                        help="Comma-separated IP types to include explicitly (overrides the "
                             "default filtering and --min-count). Matches exact or by suffix, "
                             "so 'quad_spi' selects axi_quad_spi. Output gets a '_subset' suffix.")
    args = parser.parse_args()

    by_type = load(args.csv, args.metric)
    if not by_type:
        print(f"No IP-size data found in {args.csv}", file=sys.stderr)
        sys.exit(1)

    out_suffix = ""
    if args.types:
        # Explicit list: keep exactly these types (in the order requested), no
        # min-count/glue filtering. Tokens match an ip_type exactly or by suffix.
        requested = [t.strip() for t in args.types.split(",") if t.strip()]
        types = {}
        for tok in requested:
            if tok in by_type:
                match = tok
            else:
                cands = sorted((t for t in by_type if t.endswith(tok)), key=len)
                match = cands[0] if cands else None
            if match is None:
                print(f"  ! no IP type matches '{tok}' -- skipping", file=sys.stderr)
            else:
                types[match] = by_type[match]
        out_suffix = "_subset"
    else:
        excluded = set() if args.all else (GLUE | INFRA)
        types = {
            t: v for t, v in by_type.items()
            if t not in excluded and len(v) >= args.min_count
        }
    if not types:
        print("No IP types passed the filters", file=sys.stderr)
        sys.exit(1)

    # Sort by median size so the plot reads small -> large.
    order = sorted(types, key=lambda t: np.median(types[t]))
    data = [types[t] for t in order]
    labels = [f"{t}  (n={len(types[t])})" for t in order]

    print(f"{'IP type':<22} {'n':>6} {'min':>7} {'median':>8} {'max':>8}")
    print("-" * 53)
    for t in order:
        v = np.array(types[t])
        print(f"{t:<22} {len(v):>6} {v.min():>7} {int(np.median(v)):>8} {v.max():>8}")

    label = METRIC_LABELS[args.metric]
    # Horizontal boxes so the IP-type names stay readable; height scales with the
    # number of types shown.
    height = max(4, 0.45 * len(order) + 1)
    out = args.out_dir / f"ip_sizes_{args.metric}{out_suffix}.pdf"
    with figure(out, figsize=(8, height), savefig_kw=dict(bbox_inches="tight")) as (_fig, ax):
        ax.boxplot(data, orientation="horizontal", showfliers=False, widths=0.6)
        ax.set_yticklabels(labels)
        ax.set_xlabel(label)
        # symlog (linear below linthresh, log above) so hard-block IPs with 0 LUTs
        # still render while the ~0..25k range stays readable.
        ax.set_xscale("symlog", linthresh=10)
        ax.grid(axis="x", which="both", linestyle=":", linewidth=0.5, alpha=0.6)


if __name__ == "__main__":
    main()
