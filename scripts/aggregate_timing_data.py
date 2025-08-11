#!/usr/bin/env python3
"""
Aggregate timing deltas across two build trees:
- Read ONLY golden values from the golden build's physcmp.log files.
- Read ONLY test values from the obfuscated build's physcmp.log files.
- Join by design + metric (occurrence order), compute delta = test - golden.
- Write CSV: design,metric,delta,golden,test

If a log is missing, warn and continue. If a metric appears on only one side,
warn for that design+metric occurrence and skip that row.
"""

from __future__ import annotations
import argparse
import csv
import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple

from bfasst.yaml_parser import RunParser

TIMING_LINE_RE = re.compile(
    r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\s+"
    r"(?P<metric>[A-Za-z0-9_.]+)\s+"
    r"golden=\s*(?P<golden>[+-]?\d+\.\d+)\s+"
    r"test=\s*(?P<test>[+-]?\d+\.\d+)\s+"
    r"delta=\s*(?P<delta>[+-]?\d+\.\d+)"
)

def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Aggregate timing deltas from golden vs obfuscated builds.")
    p.add_argument("--batch-yaml", default="../tests/weekly/impl_obfuscate.yaml", type=Path,
                   help="Path to BFASST batch YAML listing designs.")
    p.add_argument("--golden-build", default="../build", type=Path,
                   help="Root of the GOLDEN (non-obfuscated) build tree.")
    p.add_argument("--obf-build", "--obfuscated-build", default="../build_obfuscated", type=Path,
                   help="Root of the OBFUSCATED (test) build tree.")
    p.add_argument("--output", default="timing_delta_summary.csv", type=Path,
                   help="Output CSV path.")
    return p.parse_args()

def extract_field_from_log(
    log_path: Path,
    field: str,  # "golden" or "test"
) -> Dict[Tuple[str, int], float]:
    """
    Parse physcmp.log and return {(metric, occurrence_index): value}.
    occurrence_index is 1-based in order of appearance per metric.
    """
    values: Dict[Tuple[str, int], float] = {}
    counts: Dict[str, int] = {}
    try:
        text = log_path.read_text(errors="ignore")
    except FileNotFoundError:
        return values

    for raw_line in text.splitlines():
        line = raw_line.strip()
        m = TIMING_LINE_RE.match(line)
        if not m:
            continue
        metric = m.group("metric")
        counts[metric] = counts.get(metric, 0) + 1
        idx = counts[metric]
        val = float(m.group(field))
        values[(metric, idx)] = val
    return values

def metric_label(metric: str, idx: int) -> str:
    return metric if idx == 1 else f"{metric}#{idx}"

def main() -> None:
    args = parse_args()

    parser = RunParser(args.batch_yaml)
    designs: List[str] = parser.design_paths
    print(f"Found {len(designs)} designs in {args.batch_yaml}")

    rows: List[Dict[str, object]] = []
    missing_golden_logs = 0
    missing_obf_logs = 0
    no_golden_data = 0
    no_obf_data = 0
    unmatched_pairs = 0

    for design in designs:
        golden_log = args.golden_build / design / "physcmp" / "physcmp.log"
        obf_log    = args.obf_build    / design / "physcmp" / "physcmp.log"

        golden_map = extract_field_from_log(golden_log, "golden")
        obf_map    = extract_field_from_log(obf_log, "test")

        if not golden_log.is_file():
            print(f"\033[33mWARNING: no golden physcmp.log for {design}: {golden_log}\033[0m", file=sys.stderr)
            missing_golden_logs += 1
        if not obf_log.is_file():
            print(f"\033[33mWARNING: no obfuscated physcmp.log for {design}: {obf_log}\033[0m", file=sys.stderr)
            missing_obf_logs += 1

        if not golden_map:
            print(f"INFO: no golden timing lines in {golden_log}", file=sys.stderr)
            no_golden_data += 1
        if not obf_map:
            print(f"INFO: no obfuscated timing lines in {obf_log}", file=sys.stderr)
            no_obf_data += 1

        # Join by (metric, occurrence index). Only output rows when both sides exist.
        all_keys = set(golden_map.keys()) | set(obf_map.keys())
        for (metric, idx) in sorted(all_keys):
            if (metric, idx) not in golden_map or (metric, idx) not in obf_map:
                unmatched_pairs += 1
                # Be verbose to help debugging mismatches.
                if (metric, idx) in golden_map and (metric, idx) not in obf_map:
                    print(f"\033[33mWARNING: {design} {metric_label(metric, idx)}: "
                          f"golden present, obfuscated missing\033[0m", file=sys.stderr)
                elif (metric, idx) in obf_map and (metric, idx) not in golden_map:
                    print(f"\033[33mWARNING: {design} {metric_label(metric, idx)}: "
                          f"obfuscated present, golden missing\033[0m", file=sys.stderr)
                continue

            golden = golden_map[(metric, idx)]
            test   = obf_map[(metric, idx)]
            delta  = test - golden

            rows.append({
                "design": design,
                "metric": metric_label(metric, idx),
                "delta":  delta,
                "golden": golden,
                "test":   test,
            })

    if rows:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        # Sort by absolute worst delta first.
        rows_sorted = sorted(rows, key=lambda r: abs(float(r["delta"])), reverse=True)
        with args.output.open("w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=["design", "metric", "delta", "golden", "test"])
            writer.writeheader()
            writer.writerows(rows_sorted)
        print(f"\nWrote {len(rows)} rows → {args.output}")
    else:
        print("\nERROR: No joined timing data found — nothing written")
        sys.exit(1)

    print(
        f"Missing logs — golden: {missing_golden_logs}, obfuscated: {missing_obf_logs}. "
        f"Logs without timing data — golden: {no_golden_data}, obfuscated: {no_obf_data}. "
        f"Unmatched metric occurrences skipped: {unmatched_pairs}."
    )

if __name__ == "__main__":
    main()

