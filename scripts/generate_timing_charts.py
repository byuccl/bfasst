#!/usr/bin/env python3
"""
Summarize BFASST timing delta CSV.

Input format (as pasted above):
design,metric,delta,golden,test
byu/foo,clocks.fixed_clk_gen.wns,-0.123,6.0,5.877
...

We collapse multiple per-clock rows down to one canonical row per metric per design,
preferring the `overall_*` metrics. If not present, we fall back to the first row
whose metric name ends with the metric's suffix (e.g., ".wns").
"""

import argparse
import math
from pathlib import Path
import pandas as pd
import numpy as np
import re
import sys


# ---------------------------------------------------------------------------
# Canonical metrics you want in the final table.
# Order here = column order in output.
# key = canonical short name -> (preferred_exact_metric_name, fallback_regex_suffix)
# If you don't want TPWS/WPWS, just comment them out in CANON_METRICS below.
# ---------------------------------------------------------------------------
CANON_METRICS = {
    "tns": ("overall_tns", r"\.tns$"),
    "tns_endpoints": ("overall_tns_endpoints", r"\.tns_endpoints$"),
    "tns_fail": ("overall_tns_fail", r"\.tns_fail$"),
    "wns": ("overall_wns", r"\.wns$"),
    "tpws": ("overall_tpws", r"\.tpws$"),
    "wpws": ("overall_wpws", r"\.wpws$"),
}


def load_df(csv_path: Path) -> pd.DataFrame:
    df = pd.read_csv(csv_path, dtype={"design": str, "metric": str})
    # Normalize whitespace just in case
    df["design"] = df["design"].str.strip()
    df["metric"] = df["metric"].str.strip()
    return df


def pick_metric_rows(df: pd.DataFrame, canon_metrics=CANON_METRICS) -> pd.DataFrame:
    """
    For each design & canonical metric, pick exactly one source row:
    1) Prefer exact match to preferred metric name (e.g., 'overall_wns').
    2) Else first row whose metric matches fallback regex (e.g., endswith '.wns').
    """
    rows = []
    designs = df["design"].unique()

    for d in designs:
        df_d = df[df["design"] == d]
        for canon, (pref_name, fallback_pat) in canon_metrics.items():
            # exact preferred?
            exact = df_d[df_d["metric"] == pref_name]
            if not exact.empty:
                row = exact.iloc[0].copy()
            else:
                # fallback regex
                pat = re.compile(fallback_pat)
                fb = df_d[df_d["metric"].str.contains(pat)]
                if fb.empty:
                    continue  # design just doesn't have this metric
                row = fb.iloc[0].copy()

            row = row.copy()
            row["canon_metric"] = canon
            rows.append(row)

    if not rows:
        return pd.DataFrame(columns=["design", "canon_metric", "delta", "golden", "test"])

    out = pd.DataFrame(rows)
    # Keep only the columns we need
    return out[["design", "canon_metric", "delta", "golden", "test"]]


def pct_change(golden: float, test: float) -> float:
    """
    Percent change = (test - golden) / abs(golden) * 100.
    Handles golden == 0:
        - if test == 0 -> 0.0
        - else -> np.inf * sign(test)  (represented as np.inf or -np.inf)
    """
    if golden == 0:
        if test == 0:
            return 0.0
        # sign of change; use positive inf if test>0, negative if test<0
        return math.copysign(math.inf, test)
    return (test - golden) / abs(golden) * 100.0


def build_wide(df_canon: pd.DataFrame) -> pd.DataFrame:
    """
    Convert long canonical df -> wide table:
    index=design
    columns=multi-level: (metric, golden/test/delta/pct_change)
    Flatten columns.
    """
    # Compute pct_change row-wise
    df_canon = df_canon.copy()
    df_canon["pct_change"] = [
        pct_change(g, t) for g, t in zip(df_canon["golden"], df_canon["test"])
    ]

    # Pivot
    wide = df_canon.pivot(index="design", columns="canon_metric")
    # wide has multi-index columns: ('delta', 'tns') etc
    # Let's reorder/flatten.
    new_cols = []
    for level0, level1 in wide.columns:
        new_cols.append(f"{level1}_{level0}")  # e.g., tns_delta
    wide.columns = new_cols

    # Reorder columns to a sensible grouping
    order = []
    for m in CANON_METRICS.keys():
        for sub in ("golden", "test", "delta", "pct_change"):
            col = f"{m}_{sub}"
            if col in wide.columns:
                order.append(col)
    # Add any stragglers
    order += [c for c in wide.columns if c not in order]
    wide = wide[order]

    # Sort designs alphabetically for reproducibility
    wide = wide.sort_index()
    return wide.reset_index()


def pretty_print(df_wide: pd.DataFrame, max_rows=50):
    """
    Print a trimmed view to stdout; full table is written to CSV.
    """
    with pd.option_context("display.max_rows", max_rows, "display.max_columns", None, "display.width", 180):
        print(df_wide)


def write_csv(df_wide: pd.DataFrame, out_path: Path):
    df_wide.to_csv(out_path, index=False)
    print(f"\nWrote summary CSV: {out_path}")


def maybe_plot(df_wide: pd.DataFrame, out_dir: Path):
    """
    Generate bar charts for WNS% and TNS% (change). Saves PNGs.
    Designs with infinite pct (golden=0,test!=0) are excluded from plot.
    """
    import matplotlib.pyplot as plt

    def plot_metric(metric_key: str, title: str):
        col = f"{metric_key}_pct_change"
        if col not in df_wide.columns:
            return
        sub = df_wide.replace([np.inf, -np.inf], np.nan).dropna(subset=[col])
        if sub.empty:
            return
        sub = sub.sort_values(col)
        plt.figure(figsize=(8, 0.4 * len(sub)))
        plt.barh(sub["design"], sub[col])
        plt.axvline(0, linestyle="--")
        plt.xlabel("% Change vs Golden")
        plt.title(title)
        plt.tight_layout()
        png = out_dir / f"{metric_key}_pct_change.png"
        plt.savefig(png, dpi=150)
        print(f"Wrote plot: {png}")

    out_dir.mkdir(parents=True, exist_ok=True)
    plot_metric("wns", "WNS Percent Change (Test vs Golden)")
    plot_metric("tns", "TNS Percent Change (Test vs Golden)")


def main():
    p = argparse.ArgumentParser(description="Summarize BFASST timing deltas.")
    p.add_argument("csv", type=Path, help="Input timing_delta_summary.csv")
    p.add_argument("--out", type=Path, help="Output CSV path (default: <input>_pct.csv)")
    p.add_argument("--plot", action="store_true", help="Generate simple bar charts (PNG).")
    args = p.parse_args()

    in_csv = args.csv
    if not in_csv.exists():
        sys.exit(f"Input CSV not found: {in_csv}")

    df = load_df(in_csv)
    df_canon = pick_metric_rows(df)
    if df_canon.empty:
        sys.exit("No canonical metrics found in input CSV.")

    df_wide = build_wide(df_canon)

    out_path = args.out if args.out else in_csv.with_name(in_csv.stem + "_pct.csv")
    write_csv(df_wide, out_path)
    pretty_print(df_wide)

    if args.plot:
        maybe_plot(df_wide, out_path.parent)


if __name__ == "__main__":
    main()

