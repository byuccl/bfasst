#!/usr/bin/env python3
"""
Aggregate timing deltas from all physcmp.log files in a BFASST batch run.

* Reads the batch YAML to know which designs were run.
* For each design, opens build/<design>/physcmp/physcmp.log.
* Extracts every line that looks like
        <metric> ... delta=<number>
  (this is exactly what the timing‑diff code prints).
* Writes a single CSV‑ish summary:
        design,metric,delta, golden, test
  One row per metric per design.

If a physcmp.log file is missing, prints a warning but continues.
"""

from __future__ import annotations
import csv
import re
import sys
from pathlib import Path
from collections import defaultdict
from typing import Dict, List
from bfasst.yaml_parser import RunParser

BATCH_YAML      = Path("../tests/weekly/impl_obfuscate.yaml")
BUILD_ROOT      = Path("../build")
OUTPUT_CSV      = Path("timing_delta_summary.csv")

TIMING_LINE_RE = re.compile(
    r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} +(?P<metric>[A-Za-z0-9_.]+)\s+"
    r"golden=\s*(?P<golden>[+-]?\d+\.\d+)\s+"
    r"test=\s*(?P<test>[+-]?\d+\.\d+)\s+"
    r"delta=\s*(?P<delta>[+-]?\d+\.\d+)"
)

parser = RunParser(BATCH_YAML)
designs: List[str] = parser.design_paths
print(f"Found {len(designs)} designs in {BATCH_YAML}")

rows: List[Dict[str, str]] = []
missing = 0
no_data = 0

for design in designs:
    log_path = BUILD_ROOT / design / "physcmp" / "physcmp.log"
    if not log_path.is_file():
        print(f"\033[33mWARNING: no physcmp.log for {design}\033[0m", file=sys.stderr)
        missing += 1
        continue

    found_metric = False
    for line in log_path.read_text(errors="ignore").splitlines():
        m = TIMING_LINE_RE.match(line.strip())
        if m:
            found_metric = True
            rows.append(
                {
                    "design": design,
                    "metric": m.group("metric"),
                    "delta": float(m.group("delta")),
                    "golden": float(m.group("golden")),
                    "test": float(m.group("test")),
                }
            )
    if not found_metric:
        print(f"INFO: no timing‑delta lines in {log_path}", file=sys.stderr)
        no_data += 1

if rows:
    OUTPUT_CSV.parent.mkdir(parents=True, exist_ok=True)
    with OUTPUT_CSV.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["design", "metric", "delta", "golden", "test"])
        writer.writeheader()
        # sort by absolute worst delta first
        for r in sorted(rows, key=lambda d: (d["metric"], d["delta"])):
            writer.writerow(r)
    print(f"\nWrote {len(rows)} rows → {OUTPUT_CSV}")
else:
    print("\nERROR: No timing deltas found — nothing written")
    sys.exit(1)

print(f"Missing logs: {missing}, logs without timing data: {no_data}")

