#!/usr/bin/env python3
import argparse
import csv
import json
import math
import re
import sys
from pathlib import Path
from statistics import mean, median
from typing import Dict, Tuple, List, Optional

TIMING_LINE_RE = re.compile(
    r"""^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+
        (?P<metric>[A-Za-z0-9_.]+)
        \s+golden=\s*(?P<golden>[+-]?\d+(?:\.\d+)?)
        \s+test=\s*(?P<test>[+-]?\d+(?:\.\d+)?)
        \s+delta=\s*(?P<delta>[+-]?\d+(?:\.\d+)?)
        """, re.VERBOSE
)

METRICS_CONFIG = {
    "overall_wns": {"better": "higher"},
    "overall_tns": {"better": "higher"},
    "overall_tns_endpoints": {"better": "lower"},
    "overall_tns_fail": {"better": "lower"},
    "overall_tpws": {"better": "higher"},
    "overall_wpws": {"better": "higher"},
}

EPS = 1e-12
REF_PERIOD_NS = 10.0

def find_physcmp_logs(root: Path, verbose: bool=False, print_all: bool=False) -> Dict[str, Path]:
    mapping: Dict[str, Path] = {}
    if not root.exists():
        if verbose:
            print(f"[WARN] Root does not exist: {root}", file=sys.stderr)
        return mapping
    for log_path in root.rglob("physcmp/physcmp.log"):
        physcmp_dir = log_path.parent
        design_dir  = physcmp_dir.parent
        coll_dir    = design_dir.parent if design_dir else None
        if not (design_dir and coll_dir and coll_dir.is_dir() and design_dir.is_dir()):
            if verbose:
                print(f"[SKIP] Could not infer collection/design for: {log_path}", file=sys.stderr)
            continue
        key = f"{coll_dir.name}/{design_dir.name}"
        if key not in mapping or len(str(log_path)) < len(str(mapping[key])):
            mapping[key] = log_path
            if print_all:
                print(f"FOUND {key} -> {log_path}")
    if verbose:
        print(f"[INFO] Scanned {root}: matched={len(mapping)} logs", file=sys.stderr)
    return mapping

def parse_physcmp_golden_metrics(log_path: Path, verbose: bool=False) -> Dict[str, float]:
    metrics: Dict[str, float] = {}
    try:
        with log_path.open("r", encoding="utf-8", errors="ignore") as f:
            for raw in f:
                line = raw.strip()
                m = TIMING_LINE_RE.match(line)
                if not m:
                    continue
                metric = m.group("metric")
                try:
                    metrics[metric] = float(m.group("golden"))
                except ValueError:
                    pass
    except FileNotFoundError:
        if verbose:
            print(f"[WARN] File not found: {log_path}", file=sys.stderr)
    return metrics

def compare_design(key: str, default_log: Path, custom_log: Path, verbose: bool=False) -> Tuple[List[Dict], Dict[str, float]]:
    default_metrics = parse_physcmp_golden_metrics(default_log, verbose=verbose)
    custom_metrics = parse_physcmp_golden_metrics(custom_log, verbose=verbose)

    common = sorted(set(default_metrics.keys()) & set(custom_metrics.keys()))

    rows = []
    for metric in common:
        d_val = default_metrics.get(metric)
        c_val = custom_metrics.get(metric)
        diff = (c_val - d_val) if (d_val is not None and c_val is not None) else math.nan
        rows.append({
            "key": key,
            "collection": key.split("/", 1)[0] if "/" in key else "",
            "design": key.split("/", 1)[1] if "/" in key else key,
            "metric": metric,
            "default_golden": d_val,
            "custom_golden": c_val,
            "diff_custom_minus_default": diff,
            "abs_diff": abs(diff) if not math.isnan(diff) else math.nan,
        })

    summary: Dict[str, float] = {}
    # Headline metrics incl. degradation
    for k, cfg in METRICS_CONFIG.items():
        if k in default_metrics and k in custom_metrics:
            d = default_metrics[k]
            c = custom_metrics[k]
            diff = c - d
            better = cfg["better"]
            if better == "higher":
                deg = max(0.0, -diff)
            else:
                deg = max(0.0, diff)
            denom = abs(d) if abs(d) > EPS else float("nan")
            pct_deg = (deg / denom) if denom == denom else float("nan")

            summary[k + "_default"] = d
            summary[k + "_custom"] = c
            summary[k + "_diff"] = diff
            summary[k + "_degradation"] = deg
            summary[k + "_pct_degradation"] = pct_deg

    # Derived: inferred min period and Fmax from WNS at 10ns target.
    if "overall_wns_default" in summary and "overall_wns_custom" in summary:
        d_wns = summary["overall_wns_default"]
        c_wns = summary["overall_wns_custom"]
        # Pmin_est(ns) = 10 - WNS; Fmax(GHz) = 1 / Pmin(ns)
        d_pmin = REF_PERIOD_NS - d_wns
        c_pmin = REF_PERIOD_NS - c_wns
        d_fmax = (1.0 / d_pmin) if d_pmin > EPS else float("inf")
        c_fmax = (1.0 / c_pmin) if c_pmin > EPS else float("inf")
        summary["pmin_default_ns"] = d_pmin
        summary["pmin_custom_ns"] = c_pmin
        summary["pmin_diff_ns"] = c_pmin - d_pmin  # + means worse (longer period)
        summary["fmax_default_GHz"] = d_fmax
        summary["fmax_custom_GHz"] = c_fmax
        summary["fmax_diff_GHz"] = c_fmax - d_fmax  # + means better

        # Percent deltas relative to default
        summary["pmin_pct_change"] = (summary["pmin_diff_ns"] / d_pmin) if d_pmin > EPS else float("nan")
        summary["fmax_pct_change"] = (summary["fmax_diff_GHz"] / d_fmax) if d_fmax > EPS else float("nan")

    return rows, summary

def main():
    ap = argparse.ArgumentParser(description="Compare 'golden' timing metrics from physcmp logs between default and custom phys_opt runs.")
    ap.add_argument("--default", default="../build_default_vtr_new", help="Path to default phys_opt root")
    ap.add_argument("--custom", default="../build_custom_vtr_new", help="Path to custom phys_opt root")
    ap.add_argument("--outdir", default="physopt_compare_out", help="Directory to write output CSV/JSON files")
    ap.add_argument("--verbose", action="store_true", help="Verbose logging to stderr")
    ap.add_argument("--print-all", action="store_true", help="Print every discovered physcmp log mapping")
    ap.add_argument("--topn", type=int, default=10, help="How many items per table")
    args = ap.parse_args()

    default_root = Path(args.default).resolve()
    custom_root  = Path(args.custom).resolve()
    outdir = Path(args.outdir).resolve()
    outdir.mkdir(parents=True, exist_ok=True)

    default_logs = find_physcmp_logs(default_root, verbose=args.verbose, print_all=args.print_all)
    custom_logs  = find_physcmp_logs(custom_root,  verbose=args.verbose, print_all=args.print_all)

    common_keys = sorted(set(default_logs.keys()) & set(custom_logs.keys()))

    all_rows: List[Dict] = []
    per_design: Dict[str, Dict[str, float]] = {}

    for key in common_keys:
        rows, summary = compare_design(key, default_logs[key], custom_logs[key], verbose=args.verbose)
        all_rows.extend(rows)
        per_design[key] = summary

    # Write detailed
    detailed_csv = outdir / "physopt_timing_diffs_detailed.csv"
    with detailed_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["key","collection","design","metric","default_golden","custom_golden","diff_custom_minus_default","abs_diff"],
        )
        writer.writeheader()
        writer.writerows(all_rows)

    # Determine columns for overall table
    all_cols = set()
    for s in per_design.values():
        all_cols.update(s.keys())
    overall_cols = ["key","collection","design"] + sorted(all_cols)

    # Write overall per-design table
    overall_csv = outdir / "physopt_timing_diffs_overall.csv"
    with overall_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=overall_cols)
        writer.writeheader()
        for key in sorted(per_design.keys()):
            row = {
                "key": key,
                "collection": key.split("/", 1)[0] if "/" in key else "",
                "design": key.split("/", 1)[1] if "/" in key else key,
            }
            row.update(per_design[key])
            writer.writerow(row)

    # JSON
    with (outdir / "physopt_timing_diffs_overall.json").open("w", encoding="utf-8") as f:
        json.dump(per_design, f, indent=2)

    # Build rankings for BOTH degradations and improvements (WNS, Pmin, Fmax)
    rankings: Dict[str, List[Dict]] = {
        "wns_worst": [], "wns_best": [],
        "pmin_worst": [], "pmin_best": [],
        "fmax_worst": [], "fmax_best": [],
    }

    for key, s in per_design.items():
        coll = key.split("/", 1)[0] if "/" in key else ""
        dsgn = key.split("/", 1)[1] if "/" in key else key

        # WNS diff
        if "overall_wns_diff" in s and "overall_wns_default" in s and "overall_wns_custom" in s:
            rankings["wns_worst"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["overall_wns_default"], "custom": s["overall_wns_custom"],
                "diff": s["overall_wns_diff"],  # negative is worse
            })
            rankings["wns_best"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["overall_wns_default"], "custom": s["overall_wns_custom"],
                "diff": s["overall_wns_diff"],
            })

        # Pmin diff: + means worse
        if "pmin_diff_ns" in s:
            rankings["pmin_worst"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["pmin_default_ns"], "custom": s["pmin_custom_ns"],
                "diff": s["pmin_diff_ns"],
            })
            rankings["pmin_best"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["pmin_default_ns"], "custom": s["pmin_custom_ns"],
                "diff": s["pmin_diff_ns"],
            })

        # Fmax diff: - means worse
        if "fmax_diff_GHz" in s:
            rankings["fmax_worst"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["fmax_default_GHz"], "custom": s["fmax_custom_GHz"],
                "diff": s["fmax_diff_GHz"],
            })
            rankings["fmax_best"].append({
                "key": key, "collection": coll, "design": dsgn,
                "default": s["fmax_default_GHz"], "custom": s["fmax_custom_GHz"],
                "diff": s["fmax_diff_GHz"],
            })

    # Sort
    rankings["wns_worst"].sort(key=lambda r: r["diff"])               # most negative first
    rankings["wns_best"].sort(key=lambda r: r["diff"], reverse=True)  # most positive first
    rankings["pmin_worst"].sort(key=lambda r: r["diff"], reverse=True) # largest + increase is worst
    rankings["pmin_best"].sort(key=lambda r: r["diff"])                # most negative (decrease) is best
    rankings["fmax_worst"].sort(key=lambda r: r["diff"])               # most negative drop in Fmax is worst
    rankings["fmax_best"].sort(key=lambda r: r["diff"], reverse=True)  # largest + increase in Fmax is best

    # Emit CSVs
    for name, rows in rankings.items():
        with (outdir / f"{name}.csv").open("w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=["key","collection","design","default","custom","diff"])
            writer.writeheader()
            writer.writerows(rows[:args.topn])

    # Summary stats across all designs
    wns_diffs = [s["overall_wns_diff"] for s in per_design.values() if "overall_wns_diff" in s]
    pmin_diffs = [s["pmin_diff_ns"] for s in per_design.values() if "pmin_diff_ns" in s]
    fmax_diffs = [s["fmax_diff_GHz"] for s in per_design.values() if "fmax_diff_GHz" in s]

    def safe_mean(x): return mean(x) if x else float("nan")
    def safe_median(x): return median(x) if x else float("nan")

    stats = {
        "count_designs": len(per_design),
        "wns_diff_mean_ns": safe_mean(wns_diffs),
        "wns_diff_median_ns": safe_median(wns_diffs),
        "pmin_diff_mean_ns": safe_mean(pmin_diffs),
        "pmin_diff_median_ns": safe_median(pmin_diffs),
        "fmax_diff_mean_GHz": safe_mean(fmax_diffs),
        "fmax_diff_median_GHz": safe_median(fmax_diffs),
        "num_improved_wns": sum(1 for v in wns_diffs if v > 0),
        "num_degraded_wns": sum(1 for v in wns_diffs if v < 0),
        "num_equal_wns":    sum(1 for v in wns_diffs if abs(v) <= 1e-12),
    }

    with (outdir / "summary_stats.json").open("w", encoding="utf-8") as f:
        json.dump(stats, f, indent=2)

    with (outdir / "summary_stats.md").open("w", encoding="utf-8") as f:
        f.write("# Timing Summary (Custom vs Default)")
        f.write(f"- Designs compared: **{stats['count_designs']}**")
        f.write(f"- WNS Δ (custom−default): mean **{stats['wns_diff_mean_ns']:.3f} ns**, median **{stats['wns_diff_median_ns']:.3f} ns**")
        f.write(f"- Inferred Pmin Δ (ns): mean **{stats['pmin_diff_mean_ns']:.3f}**, median **{stats['pmin_diff_median_ns']:.3f}** (positive = worse)")
        f.write(f"- Inferred Fmax Δ (GHz): mean **{stats['fmax_diff_mean_GHz']:.4f}**, median **{stats['fmax_diff_median_GHz']:.4f}** (negative = worse)")
        f.write(f"- Count improved WNS: **{stats['num_improved_wns']}**, degraded: **{stats['num_degraded_wns']}**, equal: **{stats['num_equal_wns']}**")

    
    # === Concise per-design table (paper-ready) ===
    concise_rows = []
    for key, s in per_design.items():
        row = {
            "key": key,
            "collection": key.split("/", 1)[0] if "/" in key else "",
            "design": key.split("/", 1)[1] if "/" in key else key,
            "overall_wns_diff_ns": s.get("overall_wns_diff"),
            "overall_tns_diff_ns": s.get("overall_tns_diff"),
            "overall_tns_endpoints_diff": s.get("overall_tns_endpoints_diff"),
            "overall_tns_fail_diff": s.get("overall_tns_fail_diff"),
        }
        concise_rows.append(row)

    concise_cols = ["key","collection","design","overall_wns_diff_ns","overall_tns_diff_ns","overall_tns_endpoints_diff","overall_tns_fail_diff"]
    concise_csv = outdir / "per_design_timing_changes.csv"
    with concise_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=concise_cols)
        w.writeheader()
        w.writerows(concise_rows)

    # Overall averages across all designs (concise)
    def _vals(name):
        return [r[name] for r in concise_rows if r[name] is not None]

    avg_wns = sum(_vals("overall_wns_diff_ns"))/len(_vals("overall_wns_diff_ns")) if _vals("overall_wns_diff_ns") else float("nan")
    avg_tns = sum(_vals("overall_tns_diff_ns"))/len(_vals("overall_tns_diff_ns")) if _vals("overall_tns_diff_ns") else float("nan")
    avg_eps = sum(_vals("overall_tns_endpoints_diff"))/len(_vals("overall_tns_endpoints_diff")) if _vals("overall_tns_endpoints_diff") else float("nan")
    avg_fail = sum(_vals("overall_tns_fail_diff"))/len(_vals("overall_tns_fail_diff")) if _vals("overall_tns_fail_diff") else float("nan")

    overall_avg_csv = outdir / "overall_averages.csv"
    with overall_avg_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["metric", "mean_change"])
        w.writerow(["overall_wns_diff_ns", avg_wns])
        w.writerow(["overall_tns_diff_ns", avg_tns])
        w.writerow(["overall_tns_endpoints_diff", avg_eps])
        w.writerow(["overall_tns_fail_diff", avg_fail])

    print(f"[OK] Wrote rankings CSVs, concise tables, and summary stats to {outdir}")

if __name__ == "__main__":
    main()

