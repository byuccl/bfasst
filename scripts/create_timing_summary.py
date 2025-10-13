#!/usr/bin/env python3
"""
Timing degradation by design (percent change) for WNS and TNS.

INPUT CSV columns: design, metric, delta, golden, test
We prefer rows where metric == "overall_wns"/"overall_tns".
If absent, we fall back to metrics ending with ".wns"/".tns" (one per design).

Outputs to ./timing_outputs:
  - wns_degradation_summary.csv  (sorted: most negative % first)
  - tns_degradation_summary.csv  (sorted: largest positive % first; inf means golden=0 -> regression)
  - wns_degradation.png
  - tns_degradation.png
"""

import argparse
from pathlib import Path
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def load_df(path: Path) -> pd.DataFrame:
    df = pd.read_csv(path)
    for c in ("delta","golden","test"):
        df[c] = pd.to_numeric(df[c], errors="coerce")
    return df

def pick_rows(df: pd.DataFrame, exact_metric: str, fallback_suffix: str) -> pd.DataFrame:
    # Prefer exact metric per design
    exact = df[df["metric"] == exact_metric].copy()
    if len(exact):
        # If multiple rows per design, keep first; customize if you need an agg
        return (exact.sort_values(["design","metric"])
                     .groupby("design", as_index=False).first())
    # Fallback: use any metric that ends with the suffix; keep first per design
    fb = df[df["metric"].str.endswith(fallback_suffix, na=False)].copy()
    if len(fb):
        return (fb.sort_values(["design","metric"])
                 .groupby("design", as_index=False).first())
    return exact  # empty

def percent_change_wns(golden: pd.Series, test: pd.Series) -> pd.Series:
    # WNS higher is better → negative % = worse
    denom = np.maximum(np.abs(golden), 1e-12)
    return (test - golden) / denom * 100.0

def percent_change_tns(golden: pd.Series, test: pd.Series) -> pd.Series:
    # TNS lower is better; 0 is ideal.
    # golden==0 & test>0  => pure regression ⇒ +inf
    # golden==0 & test==0 => 0%
    out = pd.Series(np.zeros(len(golden)), index=golden.index, dtype=float)
    both_zero = (golden == 0) & (test == 0)
    pos_reg   = (golden == 0) & (test > 0)
    normal    = ~(both_zero | pos_reg)
    out[both_zero] = 0.0
    out[pos_reg]   = np.inf
    out[normal]    = (test[normal] - golden[normal]) / np.maximum(np.abs(golden[normal]), 1e-12) * 100.0
    return out

def save_barh(df: pd.DataFrame, xcol: str, ycol: str, title: str, xlabel: str, path: Path):
    plt.figure(figsize=(10, max(4, 0.3 * len(df))))
    plt.barh(df[ycol], df[xcol])
    plt.xlabel(xlabel)
    plt.title(title)
    plt.tight_layout()
    plt.savefig(path)
    plt.close()

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("csv", type=Path, help="timing CSV (design,metric,delta,golden,test)")
    ap.add_argument("-o", "--outdir", type=Path, default=Path("timing_outputs"))
    args = ap.parse_args()

    args.outdir.mkdir(parents=True, exist_ok=True)
    df = load_df(args.csv)

    # Select one WNS/TNS row per design
    wns = pick_rows(df, "overall_wns", ".wns")
    tns = pick_rows(df, "overall_tns", ".tns")

    # --- WNS ---
    if len(wns):
        wns["percent_change"] = percent_change_wns(wns["golden"], wns["test"])
        # Most degraded first (more negative)
        wns_sorted = (wns.loc[:, ["design","metric","golden","test","percent_change"]]
                         .sort_values("percent_change", ascending=True))
        wns_sorted.to_csv(args.outdir / "wns_degradation_summary.csv", index=False)
        save_barh(
            wns_sorted,
            xcol="percent_change",
            ycol="design",
            title="Timing Degradation by Design (WNS)",
            xlabel="% Change in WNS (negative = worse)",
            path=args.outdir / "wns_degradation.png",
        )

    # --- TNS ---
    if len(tns):
        tns["percent_change"] = percent_change_tns(tns["golden"], tns["test"])
        # Sort with +inf at top (worst). Use a key to substitute inf for sorting only.
        tns_sorted = (tns.loc[:, ["design","metric","golden","test","percent_change"]]
                         .sort_values("percent_change", ascending=False,
                                      key=lambda s: s.replace(np.inf, 1e12)))
        tns_sorted.to_csv(args.outdir / "tns_degradation_summary.csv", index=False)

        # Cap inf at 1000% for plotting to keep axes reasonable (CSV still has inf)
        plot_df = tns_sorted.copy()
        plot_df["plot_percent_change"] = plot_df["percent_change"].replace(np.inf, 1000.0)
        save_barh(
            plot_df,
            xcol="plot_percent_change",
            ycol="design",
            title="Timing Degradation by Design (TNS)",
            xlabel="% Change in TNS (positive = worse; ∞ shown as 1000%)",
            path=args.outdir / "tns_degradation.png",
        )

    print(f"Done. Outputs in: {args.outdir.resolve()}")

if __name__ == "__main__":
    main()

