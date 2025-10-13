#!/usr/bin/env python3
import argparse
import csv
import json
import re
from pathlib import Path
from collections import defaultdict

# Regex to detect lines like: "2025-09-27 ... INFO Obfuscated 3016 cells:"
OBF_START_RE = re.compile(r"\bObfuscated\s+\d+\s+cells:")
# Inventory lines often look like: "INFO    LUT6: 972" or "INFO:    LUT6, 972"
INV_LINE_RE = re.compile(r"INFO[:\s]+([A-Z0-9_]+)[,:]\s+(\d+)")

def parse_obf_log(log_path: Path):
    """
    Returns:
      obf_counts: dict[cell_type] -> count  (from the 'Obfuscated ... cells:' block)
    """
    obf_counts = defaultdict(int)
    if not log_path.exists():
        return obf_counts

    in_obf_block = False
    with log_path.open("r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            if not in_obf_block:
                if OBF_START_RE.search(line):
                    in_obf_block = True
                continue

            # We're inside obf block; collect until we hit a separator or non-matching section
            m = INV_LINE_RE.search(line)
            if m:
                cell = m.group(1).strip()
                count = int(m.group(2))
                obf_counts[cell] += count
            else:
                # Heuristic: end of block when we hit a non-inventory line after starting.
                if line.strip() == "" or line.startswith("=") or "Writing out new DCPs" in line:
                    break

    return obf_counts

def parse_original_cell_props(json_path: Path):
    """
    Returns:
      props_by_cell: dict[cell_type] -> dict[property_name] -> count
      insts_by_cell: dict[cell_type] -> count  (number of instances with any modified properties)
    """
    props_by_cell = defaultdict(lambda: defaultdict(int))
    insts_by_cell = defaultdict(int)

    if not json_path.exists():
        return props_by_cell, insts_by_cell

    try:
        with json_path.open("r", encoding="utf-8", errors="ignore") as f:
            data = json.load(f)
    except Exception as e:
        # If the JSON is newline-delimited fragments, try to recover by wrapping in braces
        try:
            text = json_path.read_text(encoding="utf-8", errors="ignore")
            text = text.strip()
            if not text.startswith("{"):
                text = "{\n" + text
            if not text.endswith("}"):
                text = text + "\n}"
            data = json.loads(text)
        except Exception:
            return props_by_cell, insts_by_cell

    if not isinstance(data, dict):
        return props_by_cell, insts_by_cell

    for inst_name, entry in data.items():
        if not isinstance(entry, dict):
            continue
        cell_type = entry.get("type")
        mods = entry.get("modified_properties") or []
        if not cell_type or not isinstance(mods, list) or len(mods) == 0:
            continue

        # Count this instance as modified for its cell type
        insts_by_cell[cell_type] += 1

        for mp in mods:
            prop = mp.get("identifier")
            if prop:
                props_by_cell[cell_type][prop] += 1

    return props_by_cell, insts_by_cell

def walk_designs(root: Path):
    """
    Yields (collection, design, obf_log_path, json_path) for each design that has at least the obfuscate dir.
    """
    for obf_log in root.rglob("netlist_obfuscate/netlist_obfuscate.log"):
        design_dir = obf_log.parent.parent
        collection_dir = design_dir.parent
        json_path = design_dir / "netlist_obfuscate" / "original_cell_props.json"
        yield (collection_dir.name, design_dir.name, obf_log, json_path)

def main():
    ap = argparse.ArgumentParser(description="Summarize obfuscated cell types and modified properties across designs.")
    ap.add_argument("--root", default="../build_custom_vtr_new", help="Root directory containing designs")
    ap.add_argument("--out_dir", default="physopt_compare_out", help="Directory to write outputs")
    args = ap.parse_args()

    root = Path(args.root).resolve()
    out_dir = Path(args.out_dir).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    # Aggregates across all designs
    total_obf_counts = defaultdict(int)          # from logs: cell_type -> total count obfuscated
    json_insts_by_cell = defaultdict(int)        # from JSON: cell_type -> number of instances with modified props
    props_by_cell_agg = defaultdict(lambda: defaultdict(int))  # cell_type -> prop -> total count
    designs_with_type = defaultdict(set)         # cell_type -> set of (collection/design)

    # Walk designs
    design_seen = 0
    for collection, design, obf_log, json_path in walk_designs(root):
        design_seen += 1
        key = f"{collection}/{design}"

        # Parse log
        obf_counts = parse_obf_log(obf_log)
        for cell_type, cnt in obf_counts.items():
            total_obf_counts[cell_type] += cnt
            designs_with_type[cell_type].add(key)

        # Parse JSON
        props_by_cell, insts_by_cell = parse_original_cell_props(json_path)
        for cell_type, inst_cnt in insts_by_cell.items():
            json_insts_by_cell[cell_type] += inst_cnt
            designs_with_type[cell_type].add(key)
        for cell_type, prop_map in props_by_cell.items():
            for prop, cnt in prop_map.items():
                props_by_cell_agg[cell_type][prop] += cnt

    # Write CSV: summary of cell types obfuscated
    summary_csv = out_dir / "obf_cell_types_summary.csv"
    with summary_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["cell_type", "obfuscated_instances_from_logs", "json_modified_instances", "designs_seen"])
        all_cell_types = set(total_obf_counts.keys()) | set(json_insts_by_cell.keys())
        for ctype in sorted(all_cell_types):
            w.writerow([
                ctype,
                total_obf_counts.get(ctype, 0),
                json_insts_by_cell.get(ctype, 0),
                len(designs_with_type.get(ctype, set())),
            ])

    # Write CSV: properties per cell type
    props_csv = out_dir / "obf_properties_by_cell_type.csv"
    with props_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["cell_type", "property_identifier", "count_instances_modified"])
        for ctype in sorted(props_by_cell_agg.keys()):
            for prop, cnt in sorted(props_by_cell_agg[ctype].items(), key=lambda x: (-x[1], x[0])):
                w.writerow([ctype, prop, cnt])

    # Also write a concise Markdown for the paper
    md_path = out_dir / "obf_summary_for_paper.md"
    with md_path.open("w", encoding="utf-8") as f:
        f.write("# Obfuscation Capability Summary\n\n")
        f.write(f"- Designs scanned under `{root}`: {design_seen}\n")
        f.write("- The following cell types were obfuscated and their commonly modified properties:\n\n")
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

    print(f"Wrote:\n  - {summary_csv}\n  - {props_csv}\n  - {md_path}")

if __name__ == "__main__":
    main()

