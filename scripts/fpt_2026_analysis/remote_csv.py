"""Step 1 of the aggregation pipeline: generate per-machine CSVs on the remote
build machines and copy them back locally.

The raw RandSoC build output is too large to copy off the remote machines, so we
run the stdlib-only generator (``dataset.py`` + ``parsers.py``) *on each machine*
and only copy back the small resulting CSV. The remotes have no numpy/matplotlib
and may not have a bfasst checkout, so the two generator files are copied into a
temporary directory on the remote for each run.

Each fetched CSV lands at ``<out-dir>/raw/<label>.csv`` with the originating
machine stamped in its ``machine`` column. Run ``join_csv.py`` afterwards
(``make join``) to merge them into ``<out-dir>/dataset.csv``.
"""

import argparse
import subprocess
import sys
from pathlib import Path

# (label, ssh_host, build_dir, python_interpreter)
DEFAULT_MACHINES = [
    ("CCL1",     "CCL1",     "/data/jgoeders/fpt2026/build/rand_soc", "python"),
    ("serenity", "serenity", "/data/jgoeders/fpt2026/build/rand_soc", "python3"),
]

# Files the remote generator needs (all stdlib-only).
GENERATOR_FILES = ["parsers.py", "dataset.py"]


def fetch_machine(label: str, host: str, build_dir: str, python: str, raw_dir: Path) -> bool:
    """Generate the CSV on one machine and copy it back. Returns True on success."""
    here = Path(__file__).parent
    print(f"==> {label} ({host})")

    # Create a temporary working dir on the remote.
    r = subprocess.run(
        ["ssh", host, "mktemp -d"], capture_output=True, text=True, timeout=60
    )
    if r.returncode != 0 or not r.stdout.strip():
        print(f"  ! failed to create remote temp dir: {r.stderr.strip()}", file=sys.stderr)
        return False
    remote_tmp = r.stdout.strip().splitlines()[-1]

    try:
        # Copy the stdlib-only generator over.
        scp_src = [str(here / f) for f in GENERATOR_FILES]
        r = subprocess.run(
            ["scp", "-q", *scp_src, f"{host}:{remote_tmp}/"],
            capture_output=True, text=True, timeout=120,
        )
        if r.returncode != 0:
            print(f"  ! failed to copy generator: {r.stderr.strip()}", file=sys.stderr)
            return False

        # Run it remotely, writing the CSV into the same temp dir.
        gen_cmd = (
            f"{python} {remote_tmp}/dataset.py {build_dir} "
            f"--out-dir {remote_tmp} --machine {label}"
        )
        r = subprocess.run(
            ["ssh", host, gen_cmd], capture_output=True, text=True, timeout=1800
        )
        if r.returncode != 0:
            print(f"  ! generation failed: {r.stderr.strip() or r.stdout.strip()}", file=sys.stderr)
            return False
        for line in r.stdout.splitlines():
            print(f"    {line}")

        # Copy the CSV back.
        raw_dir.mkdir(parents=True, exist_ok=True)
        local_csv = raw_dir / f"{label}.csv"
        r = subprocess.run(
            ["scp", "-q", f"{host}:{remote_tmp}/dataset.csv", str(local_csv)],
            capture_output=True, text=True, timeout=120,
        )
        if r.returncode != 0:
            print(f"  ! failed to copy CSV back: {r.stderr.strip()}", file=sys.stderr)
            return False
        print(f"    fetched -> {local_csv}")
        return True
    finally:
        # Best-effort cleanup of the remote temp dir.
        subprocess.run(
            ["ssh", host, f"rm -rf {remote_tmp}"],
            capture_output=True, text=True, timeout=60,
        )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--machine",
        action="append",
        metavar="LABEL:HOST:BUILD_DIR[:INTERP]",
        help="Override machines to query (repeatable). INTERP defaults to python3. "
             "Default: CCL1 and serenity.",
    )
    parser.add_argument(
        "--out-dir", type=Path, default=Path("output"),
        help="Local output dir; CSVs land in <out-dir>/raw/ (default: output)",
    )
    args = parser.parse_args()

    if args.machine:
        machines = []
        for spec in args.machine:
            parts = spec.split(":")
            if len(parts) == 3:
                label, host, build_dir = parts
                python = "python3"
            elif len(parts) == 4:
                label, host, build_dir, python = parts
            else:
                parser.error(f"--machine must be LABEL:HOST:BUILD_DIR[:INTERP], got {spec!r}")
            machines.append((label, host, build_dir, python))
    else:
        machines = DEFAULT_MACHINES

    raw_dir = args.out_dir / "raw"
    failures = 0
    for label, host, build_dir, python in machines:
        if not fetch_machine(label, host, build_dir, python, raw_dir):
            failures += 1

    print()
    ok = len(machines) - failures
    print(f"Fetched {ok}/{len(machines)} machines into {raw_dir}")
    if failures:
        print("Run 'make join' once all machines succeed.", file=sys.stderr)
        sys.exit(1)
    print("Next: 'make join' to merge into a single dataset.csv")


if __name__ == "__main__":
    main()
