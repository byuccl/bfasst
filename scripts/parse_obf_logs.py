#!/usr/bin/env python3
import argparse
import csv
import datetime as dt
import re
from pathlib import Path
from typing import Dict, Optional, Tuple

TS_RE = re.compile(r"^(?P<ts>\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}(?:\.\d{3})?)")
TOTAL_CELLS_OBF_RE = re.compile(r"Total cells in design:\s+(\d+)")
TOTAL_CELLS_DEOBF_RE = re.compile(r"Loaded properties for\s+(\d+)\s+cells")
CELL_INVENTORY_RE = re.compile(r"INFO[: ]+\s*([A-Z0-9_]+)[,:]\s+(\d+)")
OBF_DONE_RE = re.compile(r"NetlistObfuscate done")
DEOBF_DONE_RE = re.compile(r"NetlistDeobfuscate complete")

def parse_ts(line: str) -> Optional[dt.datetime]:
    m = TS_RE.match(line)
    if not m:
        return None
    s = m.group("ts")
    for fmt in ("%Y-%m-%d %H:%M:%S.%f", "%Y-%m-%d %H:%M:%S"):
        try:
            return dt.datetime.strptime(s, fmt)
        except ValueError:
            pass
    return None

def scan_log(log_path: Path, mode: str) -> Tuple[Optional[float], Optional[int], Optional[int], Optional[int], bool]:
    """
    mode: 'obf' or 'deobf'
    Returns:
      runtime_ms,
      total_cells,
      lut_count,
      ff_count,
      saw_inventory
    """
    if not log_path.exists():
        return None, None, None, None, False

    with log_path.open("r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()

    first_ts: Optional[dt.datetime] = None
    end_ts: Optional[dt.datetime] = None
    total_cells_obf: Optional[int] = None
    total_cells_deobf: Optional[int] = None
    lut_sum = 0
    ff_sum = 0
    saw_inventory = False

    # first timestamp
    for ln in lines:
        t = parse_ts(ln)
        if t:
            first_ts = t
            break

    # parse lines
    for ln in lines:
        # detect done marker and capture its timestamp
        t = parse_ts(ln)
        if mode == "obf" and OBF_DONE_RE.search(ln) and t:
            end_ts = t
        elif mode == "deobf" and DEOBF_DONE_RE.search(ln) and t:
            end_ts = t

        # total cells lines
        if total_cells_obf is None:
            m = TOTAL_CELLS_OBF_RE.search(ln)
            if m:
                total_cells_obf = int(m.group(1))
        if total_cells_deobf is None:
            m = TOTAL_CELLS_DEOBF_RE.search(ln)
            if m:
                total_cells_deobf = int(m.group(1))

        # inventory
        m = CELL_INVENTORY_RE.search(ln)
        if m:
            prim = m.group(1)
            cnt = int(m.group(2))
            saw_inventory = True
            if prim.startswith("LUT"):
                lut_sum += cnt
            if prim.startswith("FD"):
                ff_sum += cnt

    # fallback for end timestamp: last timestamp in file
    if end_ts is None:
        for ln in reversed(lines):
            t = parse_ts(ln)
            if t:
                end_ts = t
                break

    runtime_ms: Optional[float] = None
    if first_ts and end_ts:
        runtime_ms = (end_ts - first_ts).total_seconds() * 1000.0

    # choose total cells
    total_cells = total_cells_obf if total_cells_obf is not None else total_cells_deobf
    lut_count = lut_sum if saw_inventory else None
    ff_count = ff_sum if saw_inventory else None
    return runtime_ms, total_cells, lut_count, ff_count, saw_inventory

def collect(root: Path) -> Dict[str, Dict]:
    """
    Walks <root>/**/netlist_obfuscate|netlist_deobfuscate and collects per-design stats.
    Returns dict: key -> row
    """
    rows: Dict[str, Dict] = {}

    # Discover obfuscate logs
    for obf in root.rglob("netlist_obfuscate/netlist_obfuscate.log"):
        design_dir = obf.parent.parent
        coll_dir = design_dir.parent
        if not design_dir.is_dir() or not coll_dir.is_dir():
            continue
        key = f"{coll_dir.name}/{design_dir.name}"
        row = rows.setdefault(key, {
            "key": key,
            "collection": coll_dir.name,
            "design": design_dir.name,
            "obf_runtime_ms": None,
            "deobf_runtime_ms": None,
            "total_cells": None,
            "lut_count": None,
            "ff_count": None,
        })
        rt, tc, lut, ff, inv = scan_log(obf, mode="obf")
        if rt is not None:
            row["obf_runtime_ms"] = rt
        if tc is not None:
            row["total_cells"] = tc
        if inv:
            row["lut_count"] = lut
            row["ff_count"] = ff

    # Discover deobfuscate logs
    for deobf in root.rglob("netlist_deobfuscate/netlist_deobfuscate.log"):
        design_dir = deobf.parent.parent
        coll_dir = design_dir.parent
        if not design_dir.is_dir() or not coll_dir.is_dir():
            continue
        key = f"{coll_dir.name}/{design_dir.name}"
        row = rows.setdefault(key, {
            "key": key,
            "collection": coll_dir.name,
            "design": design_dir.name,
            "obf_runtime_ms": None,
            "deobf_runtime_ms": None,
            "total_cells": None,
            "lut_count": None,
            "ff_count": None,
        })
        rt, tc, lut, ff, inv = scan_log(deobf, mode="deobf")
        if rt is not None:
            row["deobf_runtime_ms"] = rt
        if row["total_cells"] is None and tc is not None:
            row["total_cells"] = tc
        if (row["lut_count"] is None or row["ff_count"] is None) and inv:
            row["lut_count"] = lut
            row["ff_count"] = ff

    return rows

def main():
    ap = argparse.ArgumentParser(description="Parse obfuscation/deobfuscation runtimes and cell counts from logs.")
    ap.add_argument("--root", default="../build_default_vtr_new", help="Root directory to scan (e.g., build_custom_phys_opt)")
    ap.add_argument("--out", default="physopt_compare_out/obf_deobf_timings.csv", help="Output CSV path")
    args = ap.parse_args()

    root = Path(args.root).resolve()
    out = Path(args.out).resolve()
    out.parent.mkdir(parents=True, exist_ok=True)

    rows = collect(root)

    with out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "key","collection","design",
                "obf_runtime_ms","deobf_runtime_ms",
                "total_cells","lut_count","ff_count",
            ],
        )
        writer.writeheader()
        for key in sorted(rows.keys()):
            writer.writerow(rows[key])

    print(f"Wrote {len(rows)} rows to {out}")

if __name__ == "__main__":
    main()

