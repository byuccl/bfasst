#!/usr/bin/env python3
import argparse
import csv
import re
from pathlib import Path
from collections import defaultdict

PHYS_LOG_REL = Path('physcmp/physcmp.log')
WNS_LINE_RE = re.compile(r'^.*overall_wns\s+golden=\s*([+-]?\d+(?:\.\d+)?)', re.IGNORECASE)

def find_design_logs(root: Path):
    for phys in root.rglob('physcmp/physcmp.log'):
        design_dir = phys.parent.parent
        collection = design_dir.parent.name
        design = design_dir.name
        yield (collection, design, phys)

def parse_wns_from_physcmp(log_path: Path):
    try:
        with log_path.open('r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                m = WNS_LINE_RE.match(line)
                if m:
                    try:
                        return float(m.group(1))
                    except ValueError:
                        pass
    except FileNotFoundError:
        pass
    return None

def main():
    ap = argparse.ArgumentParser(description='Compute per-design fmax from physcmp logs (golden overall_wns).')
    ap.add_argument('--default_root', default='../build_default_vtr_new', help='Root of default phys_opt results')
    ap.add_argument('--custom_root', default='../build_custom_vtr_new', help='Root of custom phys_opt results')
    ap.add_argument('--constraint_ns', type=float, default=10.0, help='Constraint period used for reports (ns)')
    ap.add_argument('--out_csv', default='physopt_compare_out/fmax_summary.csv', help='Output CSV path')
    args = ap.parse_args()

    default_root = Path(args.default_root).resolve()
    custom_root = Path(args.custom_root).resolve()
    out_csv = Path(args.out_csv).resolve()
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    default_map = {}
    for coll, des, logp in find_design_logs(default_root):
        key = f'{coll}/{des}'
        default_map[key] = logp

    custom_map = {}
    for coll, des, logp in find_design_logs(custom_root):
        key = f'{coll}/{des}'
        custom_map[key] = logp

    keys = sorted(set(default_map.keys()) & set(custom_map.keys()))

    rows = []
    EPS = 1e-9

    for key in keys:
        coll, des = key.split('/', 1)
        default_log = default_map[key]
        custom_log = custom_map[key]

        wns_def = parse_wns_from_physcmp(default_log)
        wns_cus = parse_wns_from_physcmp(custom_log)

        period_def = None
        period_cus = None
        f_def = None
        f_cus = None
        delta = None
        pct = None

        if wns_def is not None:
            period_def = args.constraint_ns - wns_def
            f_def = float('inf') if period_def <= 0 else 1000.0 / period_def

        if wns_cus is not None:
            period_cus = args.constraint_ns - wns_cus
            f_cus = float('inf') if period_cus <= 0 else 1000.0 / period_cus

        if f_def is not None and f_cus is not None and f_def not in (float('inf'), float('-inf')):
            delta = f_cus - f_def
            denom = abs(f_def) if abs(f_def) > EPS else EPS
            pct = (delta / denom) * 100.0

        rows.append({
            'key': key,
            'collection': coll,
            'design': des,
            'wns_default': wns_def,
            'wns_custom': wns_cus,
            'period_default_ns': period_def,
            'period_custom_ns': period_cus,
            'fmax_default_mhz': f_def,
            'fmax_custom_mhz': f_cus,
            'delta_fmax_mhz': delta,
            'pct_diff_fmax_vs_default': pct,
            'default_log': str(default_log),
            'custom_log': str(custom_log),
        })

    with out_csv.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=[
            'key','collection','design',
            'wns_default','wns_custom',
            'period_default_ns','period_custom_ns',
            'fmax_default_mhz','fmax_custom_mhz',
            'delta_fmax_mhz','pct_diff_fmax_vs_default',
            'default_log','custom_log'
        ])
        writer.writeheader()
        for r in rows:
            writer.writerow(r)

    print(f'Wrote {out_csv} with {len(rows)} rows.')
    if not rows:
        print('Note: No overlapping designs with physcmp logs were found. Check your root paths.')

if __name__ == '__main__':
    main()

