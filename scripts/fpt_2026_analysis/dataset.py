"""Collect all per-design metrics into a single CSV.

Stdlib-only (imports only ``parsers``), so this script can be copied to and run
on the remote build machines, which have no numpy/matplotlib. Use ``--machine``
to stamp the originating machine on every row so per-machine CSVs can later be
joined (see ``join_csv.py``) without seed collisions.
"""

import argparse
import sys
from pathlib import Path

# Import parsers from sibling module (pure stdlib — safe on remote machines)
sys.path.insert(0, str(Path(__file__).parent))
from parsers import COLUMNS, collect_all, write_csv


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Collect all RandSoC per-design metrics into a CSV."
    )
    parser.add_argument(
        "build_dir", type=Path, help="Root rand_soc build directory (e.g. build/rand_soc)"
    )
    parser.add_argument(
        "--out-dir", type=Path, default=Path("output"), help="Directory for output CSV"
    )
    parser.add_argument(
        "--machine", default="", help="Label stamped in the 'machine' column (e.g. CCL1)"
    )
    args = parser.parse_args()

    rows = collect_all(args.build_dir, machine=args.machine)
    if not rows:
        print(f"No design directories found under {args.build_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Collected data for {len(rows)} designs\n")
    args.out_dir.mkdir(parents=True, exist_ok=True)
    write_csv(rows, args.out_dir / "dataset.csv")
    print(f"({len(COLUMNS)} columns)")


if __name__ == "__main__":
    main()
