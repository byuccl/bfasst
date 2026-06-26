"""Collect per-IP resource sizes into a CSV (one row per IP instance).

Stdlib-only (imports only ``parsers``), so it can be copied to and run on the
remote build machines, which have no numpy/matplotlib. Mirrors ``dataset.py`` but
reads the hierarchical utilization reports (``vivado_impl/utilization_hier.txt``)
and emits one row per ``ip_<n>_<type>`` instance rather than one row per design.

Use ``--machine`` to stamp the originating machine so per-machine CSVs can be
concatenated without seed collisions.
"""

import argparse
import sys
from pathlib import Path

# Import parsers from sibling module (pure stdlib — safe on remote machines)
sys.path.insert(0, str(Path(__file__).parent))
from parsers import collect_ip_sizes, write_ip_sizes_csv


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Collect per-IP resource sizes from hierarchical utilization reports."
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

    rows = collect_ip_sizes(args.build_dir, machine=args.machine)
    if not rows:
        print(f"No IP-size data found under {args.build_dir} "
              "(no utilization_hier.txt reports yet?)", file=sys.stderr)
        sys.exit(1)

    args.out_dir.mkdir(parents=True, exist_ok=True)
    write_ip_sizes_csv(rows, args.out_dir / "ip_sizes.csv")


if __name__ == "__main__":
    main()
