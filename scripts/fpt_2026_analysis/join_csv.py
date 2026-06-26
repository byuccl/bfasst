"""Step 2 of the aggregation pipeline: join per-machine CSVs into one dataset.

Reads every ``<raw-dir>/*.csv`` produced by ``remote_csv.py``, verifies each has
the expected header, concatenates their rows, and writes a single
``<out>`` (default ``output/dataset.csv``). Design identity is the
``(machine, seed)`` pair, so non-overlapping or even colliding seed ranges across
machines are handled cleanly. The merged CSV is what the plotting scripts consume
via their ``--csv`` option.
"""

import argparse
import csv
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from parsers import COLUMNS


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--raw-dir", type=Path, default=Path("output/raw"),
        help="Directory of per-machine CSVs to join (default: output/raw)",
    )
    parser.add_argument(
        "--out", type=Path, default=Path("output/dataset.csv"),
        help="Path for the merged CSV (default: output/dataset.csv)",
    )
    args = parser.parse_args()

    csv_paths = sorted(args.raw_dir.glob("*.csv"))
    if not csv_paths:
        print(f"No CSVs found in {args.raw_dir}", file=sys.stderr)
        sys.exit(1)

    all_rows = []
    seen_keys = set()
    for path in csv_paths:
        with open(path, newline="") as f:
            reader = csv.DictReader(f)
            if reader.fieldnames != COLUMNS:
                print(
                    f"  ! {path.name}: header mismatch\n"
                    f"      expected {COLUMNS}\n      got      {reader.fieldnames}",
                    file=sys.stderr,
                )
                sys.exit(1)
            rows = list(reader)
        for row in rows:
            key = (row["machine"], row["seed"])
            if key in seen_keys:
                print(f"  ! duplicate (machine, seed) {key} in {path.name}", file=sys.stderr)
            seen_keys.add(key)
        all_rows.extend(rows)
        print(f"  {path.name:<20} {len(rows):>6} designs")

    args.out.parent.mkdir(parents=True, exist_ok=True)
    with open(args.out, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=COLUMNS)
        writer.writeheader()
        writer.writerows(all_rows)

    print("-" * 30)
    print(f"  {'TOTAL':<20} {len(all_rows):>6} designs -> {args.out}")


if __name__ == "__main__":
    main()
