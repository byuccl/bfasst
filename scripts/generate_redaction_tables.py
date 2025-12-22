"""
All-in-one timing + obfuscation artifact generator.

Point this at two build directories ("default" and "custom") and it will:
  1) Find and parse *physcmp/physcmp.log* files in each tree.
     - Join on collection/design
     - Read ONLY golden values from the default tree and ONLY golden values from the custom tree
       (interpreting them as two different flows to compare)
     - Compute per-metric diffs (custom - default)
     - Derive Pmin/Fmax deltas from overall_wns at a reference period if available
     - Emit:
         - physopt_timing_diffs_detailed.csv
         - physopt_timing_diffs_overall.csv / .json
         - rankings CSVs (best/worst by WNS, Pmin, Fmax)
         - summary_stats.json + summary_stats.md
         - per_design_timing_changes.csv
         - overall_averages.csv
         - fmax_summary.csv (like the old fmax_from_physcmp.py)

  2) Parse obfuscation-related logs in the *custom* tree (or a user-provided --obf-root):
     - netlist_obfuscate/netlist_obfuscate.log and netlist_deobfuscate/netlist_deobfuscate.log
     - Extract runtimes, total cells, LUT/FF inventory when present
     - Summarize obfuscated cell types and modified properties from
       netlist_obfuscate/original_cell_props.json when available
     - Emit:
         - obf_deobf_timings.csv
         - obf_cell_types_summary.csv
         - obf_properties_by_cell_type.csv
         - obf_summary_for_paper.md

Optional plotting: if matplotlib and pandas/numpy are available, WNS/TNS degradation bar charts
(written under outdir/timing_outputs). If not installed, CSVs are still produced.

Usage:
  python timing_artifacts_all_in_one.py \
    --default ../build_default_vtr_new \
    --custom  ../build_custom_vtr_new \
    --outdir  physopt_compare_out \
    --constraint-ns 10.0

Requires: Python 3.8+; stdlib. (Optional) numpy, pandas, matplotlib for plots.
"""

import math
from datetime import datetime
import json
import re
import csv
import argparse
from dataclasses import dataclass
from collections import defaultdict
from statistics import mean, median
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

_HAS_PLOTS = True

# -------------------------------
# Regexes and constants
# -------------------------------
TIMESTAMPED_METRIC_RE = re.compile(
    r"""^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+
        (?P<metric>[A-Za-z0-9_.]+)
        \s+golden=\s*(?P<golden>[+-]?\d+(?:\.\d+)?)
        \s+test=\s*(?P<test>[+-]?\d+(?:\.\d+)?)
        \s+delta=\s*(?P<delta>[+-]?\d+(?:\.\d+)?)
        """,
    re.VERBOSE,
)

GOLDEN_ONLY_METRIC_RE = re.compile(
    r"""^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+
        (?P<metric>[A-Za-z0-9_.]+)
        \s+golden=\s*(?P<golden>[+-]?\d+(?:\.\d+)?)
        \s+test=\s*(?P<test>[+-]?\d+(?:\.\d+)?)
        \s+delta=\s*(?P<delta>[+-]?\d+(?:\.\d+)?)
        """,
    re.VERBOSE,
)

WNS_LINE_RE = re.compile(r"^.*overall_wns\s+golden=\s*([+-]?\d+(?:\.\d+)?)", re.IGNORECASE)

# Obfuscation block parsing
OBF_START_RE = re.compile(r"\bObfuscated\s+\d+\s+cells:")
INV_LINE_RE = re.compile(r"INFO[:\s]+([A-Z0-9_]+)[,:]\s+(\d+)")
TOTAL_CELLS_OBF_RE = re.compile(r"Total cells in design:\s+(\d+)")
TOTAL_CELLS_DEOBF_RE = re.compile(r"Loaded properties for\s+(\d+)\s+cells")
TS_RE = re.compile(r"^(?P<ts>\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}(?:\.\d{3})?)")

METRICS_CONFIG = {
    "overall_wns": {"better": "higher"},
    "overall_tns": {"better": "higher"},
    "overall_tns_endpoints": {"better": "lower"},
    "overall_tns_fail": {"better": "lower"},
    "overall_tpws": {"better": "higher"},
    "overall_wpws": {"better": "higher"},
}

EPS = 1e-12
DEFAULT_REF_PERIOD_NS = 10.0


# -------------------------------
# Helpers
# -------------------------------
@dataclass
class DesignKey:
    """Helper class to find designs in the file structure"""

    collection: str
    design: str

    @property
    def key(self) -> str:
        return f"{self.collection}/{self.design}"

    @staticmethod
    def from_physcmp_path(log_path: Path) -> Optional["DesignKey"]:
        # <root>/<collection>/<design>/physcmp/physcmp.log
        physcmp_dir = log_path.parent
        design_dir = physcmp_dir.parent if physcmp_dir else None
        coll_dir = design_dir.parent if design_dir else None
        if coll_dir and design_dir and coll_dir.is_dir() and design_dir.is_dir():
            return DesignKey(coll_dir.name, design_dir.name)
        return None


def find_physcmp_logs(root: Path) -> Dict[str, Path]:
    """Helper function to find physcmp logs"""
    mapping: Dict[str, Path] = {}
    if not root.exists():
        return mapping
    for log_path in root.rglob("physcmp/physcmp.log"):
        dk = DesignKey.from_physcmp_path(log_path)
        if not dk:
            continue
        key = dk.key
        # Prefer the shorter path if duplicates appear
        if key not in mapping or len(str(log_path)) < len(str(mapping[key])):
            mapping[key] = log_path
    return mapping


def parse_physcmp_golden_metrics(log_path: Path) -> Dict[str, float]:
    """Helper function to parse the timing metrics from physcmp"""
    metrics: Dict[str, float] = {}
    try:
        with log_path.open("r", encoding="utf-8", errors="ignore") as f:
            for raw in f:
                m = TIMESTAMPED_METRIC_RE.match(raw.strip())
                if not m:
                    continue
                metric = m.group("metric")
                try:
                    metrics[metric] = float(m.group("golden"))
                except ValueError:
                    pass
    except FileNotFoundError:
        pass
    return metrics


def safe_float(x: object, default: Optional[float] = None) -> Optional[float]:
    try:
        return float(x)  # type: ignore[arg-type]
    except (ValueError, KeyError, TypeError):
        return default


# -------------------------------
# Phase 1: Timing comparison & summaries
# -------------------------------


# pylint: disable=too-many-locals
def compare_design_metrics(
    key: str,
    default_log: Path,
    custom_log: Path,
    ref_period_ns: float,
) -> Tuple[List[Dict], Dict[str, float]]:
    """Compare metrics between a golden and test design"""
    default_metrics = parse_physcmp_golden_metrics(default_log)
    custom_metrics = parse_physcmp_golden_metrics(custom_log)
    common = sorted(set(default_metrics) & set(custom_metrics))

    rows: List[Dict] = []
    for metric in common:
        d_val = default_metrics.get(metric)
        c_val = custom_metrics.get(metric)
        diff = (c_val - d_val) if (d_val is not None and c_val is not None) else math.nan
        collection, design = key.split("/", 1) if "/" in key else ("", key)
        rows.append(
            {
                "key": key,
                "collection": collection,
                "design": design,
                "metric": metric,
                "default_golden": d_val,
                "custom_golden": c_val,
                "diff_custom_minus_default": diff,
                "abs_diff": abs(diff) if not math.isnan(diff) else math.nan,
            }
        )

    # Summary row used for overall tables
    summary: Dict[str, float] = {}
    for mname, cfg in METRICS_CONFIG.items():
        if mname in default_metrics and mname in custom_metrics:
            d = default_metrics[mname]
            c = custom_metrics[mname]
            diff = c - d
            better = cfg["better"]
            degradation = max(0.0, -diff) if better == "higher" else max(0.0, diff)
            denom = abs(d) if abs(d) > EPS else float("nan")
            pct_deg = (degradation / denom) if not math.isnan(denom) else float("nan")
            summary[mname + "_default"] = d
            summary[mname + "_custom"] = c
            summary[mname + "_diff"] = diff
            summary[mname + "_degradation"] = degradation
            summary[mname + "_pct_degradation"] = pct_deg

    # Derived Pmin/Fmax from WNS and ref period
    if "overall_wns_default" in summary and "overall_wns_custom" in summary:
        d_wns = summary["overall_wns_default"]
        c_wns = summary["overall_wns_custom"]
        d_pmin = ref_period_ns - d_wns
        c_pmin = ref_period_ns - c_wns
        d_fmax = (1.0 / d_pmin) if d_pmin > EPS else float("inf")  # GHz if period in ns
        c_fmax = (1.0 / c_pmin) if c_pmin > EPS else float("inf")
        summary.update(
            {
                "pmin_default_ns": d_pmin,
                "pmin_custom_ns": c_pmin,
                "pmin_diff_ns": c_pmin - d_pmin,
                "fmax_default_GHz": d_fmax,
                "fmax_custom_GHz": c_fmax,
                "fmax_diff_GHz": c_fmax - d_fmax,
                "pmin_pct_change": ((c_pmin - d_pmin) / d_pmin) if d_pmin > EPS else float("nan"),
                "fmax_pct_change": ((c_fmax - d_fmax) / d_fmax) if d_fmax > EPS else float("nan"),
            }
        )

    return rows, summary


def emit_timing_artifacts(
    outdir: Path,
    per_design_rows: List[Dict],
    per_design_summary: Dict[str, Dict[str, float]],
    ref_period_ns: float,
) -> None:
    """Helper to output timing related tables"""
    # pylint: disable=too-many-statements
    detailed_csv = outdir / "physopt_timing_diffs_detailed.csv"
    with detailed_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "key",
                "collection",
                "design",
                "metric",
                "default_golden",
                "custom_golden",
                "diff_custom_minus_default",
                "abs_diff",
            ],
        )
        writer.writeheader()
        writer.writerows(per_design_rows)

    # Overall per-design table (summary fields may vary across designs)
    all_cols = set()
    for s in per_design_summary.values():
        all_cols.update(s.keys())
    overall_cols = ["key", "collection", "design"] + sorted(all_cols)

    overall_csv = outdir / "physopt_timing_diffs_overall.csv"
    with overall_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=overall_cols)
        writer.writeheader()
        for key in sorted(per_design_summary.keys()):
            collection, design = key.split("/", 1) if "/" in key else ("", key)
            row = {"key": key, "collection": collection, "design": design}
            row.update(per_design_summary[key])
            writer.writerow(row)

    with (outdir / "physopt_timing_diffs_overall.json").open("w", encoding="utf-8") as f:
        json.dump(per_design_summary, f, indent=2)

    # Rankings
    rankings: Dict[str, List[Dict]] = {
        k: []
        for k in ["wns_worst", "wns_best", "pmin_worst", "pmin_best", "fmax_worst", "fmax_best"]
    }
    for key, s in per_design_summary.items():
        coll, dsgn = key.split("/", 1) if "/" in key else ("", key)
        if all(k in s for k in ["overall_wns_diff", "overall_wns_default", "overall_wns_custom"]):
            rec = {
                "key": key,
                "collection": coll,
                "design": dsgn,
                "default": s["overall_wns_default"],
                "custom": s["overall_wns_custom"],
                "diff": s["overall_wns_diff"],
            }
            rankings["wns_worst"].append(rec)
            rankings["wns_best"].append(rec)
        if "pmin_diff_ns" in s:
            rec = {
                "key": key,
                "collection": coll,
                "design": dsgn,
                "default": s.get("pmin_default_ns"),
                "custom": s.get("pmin_custom_ns"),
                "diff": s["pmin_diff_ns"],
            }
            rankings["pmin_worst"].append(rec)
            rankings["pmin_best"].append(rec)
        if "fmax_diff_GHz" in s:
            rec = {
                "key": key,
                "collection": coll,
                "design": dsgn,
                "default": s.get("fmax_default_GHz"),
                "custom": s.get("fmax_custom_GHz"),
                "diff": s["fmax_diff_GHz"],
            }
            rankings["fmax_worst"].append(rec)
            rankings["fmax_best"].append(rec)

    rankings["wns_worst"].sort(key=lambda r: r["diff"])  # negative first
    rankings["wns_best"].sort(key=lambda r: r["diff"], reverse=True)
    rankings["pmin_worst"].sort(key=lambda r: r["diff"], reverse=True)  # larger + is worse
    rankings["pmin_best"].sort(key=lambda r: r["diff"])  # more negative is better
    rankings["fmax_worst"].sort(key=lambda r: r["diff"])  # more negative is worse
    rankings["fmax_best"].sort(key=lambda r: r["diff"], reverse=True)

    for name, rows in rankings.items():
        with (outdir / f"{name}.csv").open("w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(
                f, fieldnames=["key", "collection", "design", "default", "custom", "diff"]
            )
            writer.writeheader()
            writer.writerows(rows)

    # Summary stats
    wns_diffs = [
        s["overall_wns_diff"] for s in per_design_summary.values() if "overall_wns_diff" in s
    ]
    pmin_diffs = [s["pmin_diff_ns"] for s in per_design_summary.values() if "pmin_diff_ns" in s]
    fmax_diffs = [s["fmax_diff_GHz"] for s in per_design_summary.values() if "fmax_diff_GHz" in s]

    def safe_mean(x: List[float]) -> float:
        return mean(x) if x else float("nan")

    def safe_median(x: List[float]) -> float:
        return median(x) if x else float("nan")

    stats = {
        "count_designs": len(per_design_summary),
        "ref_period_ns": ref_period_ns,
        "wns_diff_mean_ns": safe_mean(wns_diffs),
        "wns_diff_median_ns": safe_median(wns_diffs),
        "pmin_diff_mean_ns": safe_mean(pmin_diffs),
        "pmin_diff_median_ns": safe_median(pmin_diffs),
        "fmax_diff_mean_GHz": safe_mean(fmax_diffs),
        "fmax_diff_median_GHz": safe_median(fmax_diffs),
        "num_improved_wns": sum(1 for v in wns_diffs if v > 0),
        "num_degraded_wns": sum(1 for v in wns_diffs if v < 0),
        "num_equal_wns": sum(1 for v in wns_diffs if abs(v) <= 1e-12),
    }

    with (outdir / "summary_stats.json").open("w", encoding="utf-8") as f:
        json.dump(stats, f, indent=2)

    with (outdir / "summary_stats.md").open("w", encoding="utf-8") as f:
        f.write("# Timing Summary (Custom vs Default)\n\n")
        f.write(f"- Reference constraint period: **{ref_period_ns:.3f} ns**\n")
        f.write(f"- Designs compared: **{stats['count_designs']}**\n")
        f.write(
            f"- WNS Δ (custom−default): mean **{stats['wns_diff_mean_ns']:.3f} ns**, "
            f"median **{stats['wns_diff_median_ns']:.3f} ns**\n"
        )
        f.write(
            f"- Inferred Pmin Δ (ns): mean **{stats['pmin_diff_mean_ns']:.3f}**, "
            f"median **{stats['pmin_diff_median_ns']:.3f}** (positive = worse)\n"
        )
        f.write(
            f"- Inferred Fmax Δ (GHz): mean **{stats['fmax_diff_mean_GHz']:.4f}**, "
            f"median **{stats['fmax_diff_median_GHz']:.4f}** (negative = worse)\n"
        )
        f.write(
            f"- Count improved WNS: **{stats['num_improved_wns']}**, "
            f"degraded: **{stats['num_degraded_wns']}**, equal: **{stats['num_equal_wns']}**\n"
        )

    # Concise per-design table for paper
    concise_rows = []
    for key, s in per_design_summary.items():
        collection, design = key.split("/", 1) if "/" in key else ("", key)
        concise_rows.append(
            {
                "key": key,
                "collection": collection,
                "design": design,
                "overall_wns_diff_ns": s.get("overall_wns_diff"),
                "overall_tns_diff_ns": s.get("overall_tns_diff"),
                "overall_tns_endpoints_diff": s.get("overall_tns_endpoints_diff"),
                "overall_tns_fail_diff": s.get("overall_tns_fail_diff"),
            }
        )

    concise_cols = [
        "key",
        "collection",
        "design",
        "overall_wns_diff_ns",
        "overall_tns_diff_ns",
        "overall_tns_endpoints_diff",
        "overall_tns_fail_diff",
    ]
    concise_csv = outdir / "per_design_timing_changes.csv"
    with concise_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=concise_cols)
        w.writeheader()
        w.writerows(concise_rows)

    # Overall averages across designs (concise)
    def _vals(name: str) -> List[float]:
        return [r[name] for r in concise_rows if r.get(name) is not None]

    avg_rows = [
        ("overall_wns_diff_ns", _vals("overall_wns_diff_ns")),
        ("overall_tns_diff_ns", _vals("overall_tns_diff_ns")),
        ("overall_tns_endpoints_diff", _vals("overall_tns_endpoints_diff")),
        ("overall_tns_fail_diff", _vals("overall_tns_fail_diff")),
    ]
    with (outdir / "overall_averages.csv").open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["metric", "mean_change"])
        for name, vals in avg_rows:
            w.writerow([name, mean(vals) if vals else float("nan")])

    # Fmax summary (MHz) like the original script
    fmax_rows = []
    for key, s in per_design_summary.items():
        coll, des = key.split("/", 1) if "/" in key else ("", key)
        wns_def = s.get("overall_wns_default")
        wns_cus = s.get("overall_wns_custom")
        period_def = ref_period_ns - wns_def if wns_def is not None else None
        period_cus = ref_period_ns - wns_cus if wns_cus is not None else None
        f_def = (
            (1000.0 / period_def)
            if (period_def is not None and period_def > 0)
            else (float("inf") if period_def is not None else None)
        )
        f_cus = (
            (1000.0 / period_cus)
            if (period_cus is not None and period_cus > 0)
            else (float("inf") if period_cus is not None else None)
        )
        delta = (
            (f_cus - f_def)
            if (f_def is not None and f_cus is not None and math.isfinite(f_def))
            else None
        )
        pct = ((delta / abs(f_def)) * 100.0) if (delta is not None and abs(f_def) > EPS) else None
        fmax_rows.append(
            {
                "key": key,
                "collection": coll,
                "design": des,
                "wns_default": wns_def,
                "wns_custom": wns_cus,
                "period_default_ns": period_def,
                "period_custom_ns": period_cus,
                "fmax_default_mhz": f_def,
                "fmax_custom_mhz": f_cus,
                "delta_fmax_mhz": delta,
                "pct_diff_fmax_vs_default": pct,
            }
        )

    with (outdir / "fmax_summary.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "key",
                "collection",
                "design",
                "wns_default",
                "wns_custom",
                "period_default_ns",
                "period_custom_ns",
                "fmax_default_mhz",
                "fmax_custom_mhz",
                "delta_fmax_mhz",
                "pct_diff_fmax_vs_default",
            ],
        )
        writer.writeheader()
        writer.writerows(fmax_rows)


# -------------------------------
# Phase 2: Obfuscation runtimes & inventory (from a single root, typically custom)
# -------------------------------


def _parse_ts(line: str) -> Optional[float]:
    m = TS_RE.match(line)
    if not m:
        return None
    s = m.group("ts")

    for fmt in ("%Y-%m-%d %H:%M:%S.%f", "%Y-%m-%d %H:%M:%S"):
        try:
            return datetime.strptime(s, fmt).timestamp()
        except ValueError:
            pass
    return None


def scan_obf_deobf_log(
    log_path: Path, mode: str
) -> Tuple[Optional[float], Optional[int], Optional[int], Optional[int], bool]:
    """
    mode in {"obf", "deobf"}
    Returns: (runtime_ms, total_cells, lut_count, ff_count, saw_inventory)
    """
    # pylint: disable=too-many-branches
    if not log_path.exists():
        return None, None, None, None, False

    lines = log_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    first_ts: Optional[float] = None
    end_ts: Optional[float] = None
    total_cells_obf: Optional[int] = None
    total_cells_deobf: Optional[int] = None
    lut_sum = 0
    ff_sum = 0
    saw_inventory = False

    # first timestamp
    for ln in lines:
        t = _parse_ts(ln)
        if t is not None:
            first_ts = t
            break

    for ln in lines:
        t = _parse_ts(ln)
        if mode == "obf" and "NetlistObfuscate done" in ln and t is not None:
            end_ts = t
        elif mode == "deobf" and "NetlistDeobfuscate complete" in ln and t is not None:
            end_ts = t

        if total_cells_obf is None:
            m = TOTAL_CELLS_OBF_RE.search(ln)
            if m:
                total_cells_obf = int(m.group(1))
        if total_cells_deobf is None:
            m = TOTAL_CELLS_DEOBF_RE.search(ln)
            if m:
                total_cells_deobf = int(m.group(1))

        m = INV_LINE_RE.search(ln)
        if m:
            prim, cnt = m.group(1), int(m.group(2))
            saw_inventory = True
            if prim.startswith("LUT"):
                lut_sum += cnt
            if prim.startswith("FD"):
                ff_sum += cnt

    if end_ts is None:
        for ln in reversed(lines):
            t = _parse_ts(ln)
            if t is not None:
                end_ts = t
                break

    runtime_ms: Optional[float] = None
    if first_ts is not None and end_ts is not None:
        runtime_ms = (end_ts - first_ts) * 1000.0

    total_cells = total_cells_obf if total_cells_obf is not None else total_cells_deobf
    lut_count = lut_sum if saw_inventory else None
    ff_count = ff_sum if saw_inventory else None
    return runtime_ms, total_cells, lut_count, ff_count, saw_inventory


def parse_obf_block_counts(obf_log: Path) -> Dict[str, int]:
    """Helper to parse redaction logs"""
    counts = defaultdict(int)
    if not obf_log.exists():
        return counts
    in_block = False
    for line in obf_log.read_text(encoding="utf-8", errors="ignore").splitlines():
        if not in_block:
            if OBF_START_RE.search(line):
                in_block = True
            continue
        m = INV_LINE_RE.search(line)
        if m:
            counts[m.group(1).strip()] += int(m.group(2))
        else:
            if line.strip() == "" or line.startswith("=") or "Writing out new DCPs" in line:
                break
    return counts


def parse_original_cell_props(json_path: Path) -> Tuple[Dict[str, Dict[str, int]], Dict[str, int]]:
    """Helper to parse the original cell properties in a json file"""
    props_by_cell = defaultdict(lambda: defaultdict(int))
    insts_by_cell = defaultdict(int)
    if not json_path.exists():
        return props_by_cell, insts_by_cell

    try:
        data = json.loads(json_path.read_text(encoding="utf-8", errors="ignore"))
    except Exception:  # pylint: disable=broad-exception-caught
        # Attempt to recover newline-delimited fragments by bracing
        try:
            text = json_path.read_text(encoding="utf-8", errors="ignore").strip()
            if not text.startswith("{"):
                text = "{\n" + text
            if not text.endswith("}"):
                text = text + "\n}"
            data = json.loads(text)
        except Exception:  # pylint: disable=broad-exception-caught
            return props_by_cell, insts_by_cell

    if not isinstance(data, dict):
        return props_by_cell, insts_by_cell

    for _, entry in data.items():
        if not isinstance(entry, dict):
            continue
        cell_type = entry.get("type")
        mods = entry.get("modified_properties") or []
        if not cell_type or not isinstance(mods, list) or len(mods) == 0:
            continue
        insts_by_cell[cell_type] += 1
        for mp in mods:
            prop = mp.get("identifier")
            if prop:
                props_by_cell[cell_type][prop] += 1

    return props_by_cell, insts_by_cell


def gather_obf_summaries(obf_root: Path, outdir: Path) -> None:
    """Helper to get summaries for redacted designs"""
    # pylint: disable=too-many-statements, too-many-branches
    rows: Dict[str, Dict[str, Optional[float]]] = {}

    for log in obf_root.rglob("netlist_obfuscate/netlist_obfuscate.log"):
        design_dir = log.parent.parent
        coll_dir = design_dir.parent
        key = f"{coll_dir.name}/{design_dir.name}"
        rt, tc, lut, ff, inv = scan_obf_deobf_log(log, mode="obf")
        row = rows.setdefault(
            key,
            {
                "key": key,
                "collection": coll_dir.name,
                "design": design_dir.name,
                "obf_runtime_ms": None,
                "deobf_runtime_ms": None,
                "total_cells": None,
                "lut_count": None,
                "ff_count": None,
            },
        )
        if rt is not None:
            row["obf_runtime_ms"] = rt
        if tc is not None:
            row["total_cells"] = tc
        if inv:
            row["lut_count"] = lut
            row["ff_count"] = ff

    for log in obf_root.rglob("netlist_deobfuscate/netlist_deobfuscate.log"):
        design_dir = log.parent.parent
        coll_dir = design_dir.parent
        key = f"{coll_dir.name}/{design_dir.name}"
        rt, tc, lut, ff, inv = scan_obf_deobf_log(log, mode="deobf")
        row = rows.setdefault(
            key,
            {
                "key": key,
                "collection": coll_dir.name,
                "design": design_dir.name,
                "obf_runtime_ms": None,
                "deobf_runtime_ms": None,
                "total_cells": None,
                "lut_count": None,
                "ff_count": None,
            },
        )
        if rt is not None:
            row["deobf_runtime_ms"] = rt
        if row.get("total_cells") is None and tc is not None:
            row["total_cells"] = tc
        if (row.get("lut_count") is None or row.get("ff_count") is None) and inv:
            row["lut_count"] = lut
            row["ff_count"] = ff

    timings_csv = outdir / "obf_deobf_timings.csv"
    with timings_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "key",
                "collection",
                "design",
                "obf_runtime_ms",
                "deobf_runtime_ms",
                "total_cells",
                "lut_count",
                "ff_count",
            ],
        )
        writer.writeheader()
        for key in sorted(rows.keys()):
            writer.writerow(rows[key])

    # 2b) Cell-type and property summaries from logs + JSON
    total_obf_counts = defaultdict(int)
    json_insts_by_cell = defaultdict(int)
    props_by_cell_agg = defaultdict(lambda: defaultdict(int))
    designs_with_type = defaultdict(set)
    design_seen = 0

    for obf_log in obf_root.rglob("netlist_obfuscate/netlist_obfuscate.log"):
        design_seen += 1
        design_dir = obf_log.parent.parent
        collection_dir = design_dir.parent
        key = f"{collection_dir.name}/{design_dir.name}"

        # From log block
        obf_counts = parse_obf_block_counts(obf_log)
        for cell_type, cnt in obf_counts.items():
            total_obf_counts[cell_type] += cnt
            designs_with_type[cell_type].add(key)

        # From JSON
        json_path = design_dir / "netlist_obfuscate" / "original_cell_props.json"
        props_by_cell, insts_by_cell = parse_original_cell_props(json_path)
        for cell_type, inst_cnt in insts_by_cell.items():
            json_insts_by_cell[cell_type] += inst_cnt
            designs_with_type[cell_type].add(key)
        for cell_type, prop_map in props_by_cell.items():
            for prop, cnt in prop_map.items():
                props_by_cell_agg[cell_type][prop] += cnt

    summary_csv = outdir / "obf_cell_types_summary.csv"
    with summary_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(
            [
                "cell_type",
                "obfuscated_instances_from_logs",
                "json_modified_instances",
                "designs_seen",
            ]
        )
        all_cell_types = set(total_obf_counts.keys()) | set(json_insts_by_cell.keys())
        for ctype in sorted(all_cell_types):
            w.writerow(
                [
                    ctype,
                    total_obf_counts.get(ctype, 0),
                    json_insts_by_cell.get(ctype, 0),
                    len(designs_with_type.get(ctype, set())),
                ]
            )

    props_csv = outdir / "obf_properties_by_cell_type.csv"
    with props_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["cell_type", "property_identifier", "count_instances_modified"])
        for ctype in sorted(props_by_cell_agg.keys()):
            for prop, cnt in sorted(props_by_cell_agg[ctype].items(), key=lambda x: (-x[1], x[0])):
                w.writerow([ctype, prop, cnt])

    md_path = outdir / "obf_summary_for_paper.md"
    with md_path.open("w", encoding="utf-8") as f:
        f.write("# Obfuscation Capability Summary\n\n")
        f.write(f"- Designs scanned under `{obf_root}`: {design_seen}\n")
        f.write(
            "- The following cell types were obfuscated and their commonly modified properties:\n\n"
        )
        all_cell_types = set(total_obf_counts.keys()) | set(json_insts_by_cell.keys())
        for ctype in sorted(all_cell_types):
            log_cnt = total_obf_counts.get(ctype, 0)
            json_cnt = json_insts_by_cell.get(ctype, 0)
            f.write(f"## {ctype}\n")
            f.write(f"- Instances obfuscated (logs): **{log_cnt}**\n")
            f.write(f"- Instances with modified properties (JSON): **{json_cnt}**\n")
            props = props_by_cell_agg.get(ctype, {})
            if props:
                f.write("- Modified properties:\n")
                for prop, cnt in sorted(props.items(), key=lambda x: (-x[1], x[0])):
                    f.write(f"  - `{prop}`: {cnt}\n")
            else:
                f.write("- Modified properties: *(none observed in JSON or not available)*\n")
            f.write("\n")


# -------------------------------
# Optional: WNS/TNS degradation CSVs and plots (like create_timing_summary)
# -------------------------------


def optional_degradation_outputs(outdir: Path) -> None:
    """Create csv files of timing degradations"""

    csv_path = outdir / "physopt_timing_diffs_detailed.csv"
    if not csv_path.exists():
        return

    df = pd.read_csv(csv_path)
    for c in ("default_golden", "custom_golden"):
        df[c] = pd.to_numeric(df[c], errors="coerce")

    # Pick one row per design for WNS/TNS
    def pick_rows(exact_metric: str, fallback_suffix: str) -> pd.DataFrame:
        exact = df[df["metric"] == exact_metric].copy()
        if len(exact):
            return exact.sort_values(["design", "metric"]).groupby("design", as_index=False).first()
        fb = df[df["metric"].str.endswith(fallback_suffix, na=False)].copy()
        if len(fb):
            return fb.sort_values(["design", "metric"]).groupby("design", as_index=False).first()
        return exact

    wns = pick_rows("overall_wns", ".wns")
    tns = pick_rows("overall_tns", ".tns")

    def percent_change_wns(golden: pd.Series, custom: pd.Series) -> pd.Series:
        denom = np.maximum(np.abs(golden), 1e-12)
        return (custom - golden) / denom * 100.0

    def percent_change_tns(golden: pd.Series, custom: pd.Series) -> pd.Series:
        out = pd.Series(np.zeros(len(golden)), index=golden.index, dtype=float)
        both_zero = (golden == 0) & (custom == 0)
        pos_reg = (golden == 0) & (custom > 0)
        normal = ~(both_zero | pos_reg)
        out[both_zero] = 0.0
        out[pos_reg] = np.inf
        out[normal] = (
            (custom[normal] - golden[normal]) / np.maximum(np.abs(golden[normal]), 1e-12) * 100.0
        )
        return out

    out_timing = outdir / "timing_outputs"
    out_timing.mkdir(parents=True, exist_ok=True)

    if len(wns):
        wns["percent_change"] = percent_change_wns(wns["default_golden"], wns["custom_golden"])
        wns_sorted = wns.loc[
            :, ["design", "metric", "default_golden", "custom_golden", "percent_change"]
        ].sort_values("percent_change", ascending=True)
        wns_sorted.to_csv(out_timing / "wns_degradation_summary.csv", index=False)
        plt.figure(figsize=(10, max(4, 0.3 * len(wns_sorted))))
        plt.barh(wns_sorted["design"], wns_sorted["percent_change"])  # no explicit colors/styles
        plt.xlabel("% Change in WNS (negative = worse)")
        plt.title("Timing Degradation by Design (WNS)")
        plt.tight_layout()
        plt.savefig(out_timing / "wns_degradation.png")
        plt.close()

    if len(tns):
        tns["percent_change"] = percent_change_tns(tns["default_golden"], tns["custom_golden"])
        tns_sorted = tns.loc[
            :, ["design", "metric", "default_golden", "custom_golden", "percent_change"]
        ].sort_values("percent_change", ascending=False, key=lambda s: s.replace(np.inf, 1e12))
        tns_sorted.to_csv(out_timing / "tns_degradation_summary.csv", index=False)
        plot_df = tns_sorted.copy()
        plot_df["plot_percent_change"] = plot_df["percent_change"].replace(np.inf, 1000.0)
        plt.figure(figsize=(10, max(4, 0.3 * len(plot_df))))
        plt.barh(plot_df["design"], plot_df["plot_percent_change"])  # no explicit colors/styles
        plt.xlabel("% Change in TNS (positive = worse; ∞ shown as 1000%)")
        plt.title("Timing Degradation by Design (TNS)")
        plt.tight_layout()
        plt.savefig(out_timing / "tns_degradation.png")
        plt.close()


# -------------------------------
# Main
# -------------------------------


def main() -> None:
    """Script to generate artifacts for the netlist redaction paper"""
    ap = argparse.ArgumentParser(
        description="Generate all timing/obfuscation artifacts from two builds."
    )
    ap.add_argument(
        "--default",
        type=Path,
        default=Path("../build_default_vtr_new"),
        help="Default/reference build root",
    )
    ap.add_argument(
        "--custom",
        type=Path,
        default=Path("../build_custom_vtr_new"),
        help="Custom/test build root",
    )
    ap.add_argument(
        "--obf-root",
        type=Path,
        default=None,
        help="Root to scan for obfuscation logs (defaults to --custom)",
    )
    ap.add_argument(
        "--outdir", type=Path, default=Path("physopt_compare_out"), help="Directory for outputs"
    )
    ap.add_argument(
        "--constraint-ns",
        type=float,
        default=DEFAULT_REF_PERIOD_NS,
        help="Reference constraint period (ns) for Pmin/Fmax derivation",
    )
    ap.add_argument(
        "--skip-plots",
        action="store_true",
        help="Skip optional degradation plots even if deps are installed",
    )
    args = ap.parse_args()

    args.outdir.mkdir(parents=True, exist_ok=True)

    # Phase 1: timing comparisons
    default_logs = find_physcmp_logs(args.default)
    custom_logs = find_physcmp_logs(args.custom)
    common_keys = sorted(set(default_logs.keys()) & set(custom_logs.keys()))

    per_design_rows: List[Dict] = []
    per_design_summary: Dict[str, Dict[str, float]] = {}

    if not common_keys:
        print(f"[WARN] No overlapping designs.\n default={args.default}\n  custom ={args.custom}")
    else:
        for key in common_keys:
            rows, summary = compare_design_metrics(
                key, default_logs[key], custom_logs[key], args.constraint_ns
            )
            per_design_rows.extend(rows)
            per_design_summary[key] = summary
        emit_timing_artifacts(args.outdir, per_design_rows, per_design_summary, args.constraint_ns)

    # Phase 2: obfuscation summaries (custom by default)
    obf_root = args.obf_root or args.custom
    gather_obf_summaries(obf_root, args.outdir)

    # Optional plots
    if not args.skip_plots:
        optional_degradation_outputs(args.outdir)

    print("[OK] Completed. Outputs in:", args.outdir.resolve())


if __name__ == "__main__":
    main()
