"""Step 1 of the aggregation pipeline: generate per-machine CSVs on the remote
build machines and copy them back locally.

The raw RandSoC build output is too large to copy off the remote machines, so we
run the stdlib-only generators (``dataset.py`` + ``ip_sizes_dataset.py``, both
importing ``parsers.py``) *on each machine* and only copy back the small CSVs.
The remotes have no numpy/matplotlib and may not have a bfasst checkout, so the
generator files are copied into a temporary directory on the remote for each run.

Two CSVs are produced per machine, both stamped with the originating machine:
  * the per-design dataset  -> ``<out-dir>/raw/<label>.csv``    (merge with
    ``join_csv.py`` / ``make join`` into ``<out-dir>/dataset.csv``)
  * per-IP sizes            -> ``<out-dir>/raw_ip/<label>.csv``  (read directly
    by ``ip_sizes.py`` / ``make ip-sizes``; no join needed)

The per-IP CSV is best-effort: machines without ``utilization_hier.txt`` reports
yet simply contribute no ip_sizes file, without failing the dataset fetch.
"""

import argparse
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

# (label, ssh_host, build_dir, python_interpreter)
DEFAULT_MACHINES = [
    ("CCL1", "CCL1", "/data/jgoeders/fpt2026/build/rand_soc", "python"),
    ("serenity", "serenity", "/data/jgoeders/fpt2026/build/rand_soc", "python3"),
    ("CCL1_all", "CCL1", "/data/jgoeders/fpt2026_1/build/rand_soc", "python"),
    ("serenity_big", "serenity", "/data/jgoeders/fpt2026_1/build/rand_soc", "python3"),
    ("CCL1_2", "CCL1", "/data/jgoeders/fpt2026_2/build/rand_soc", "python"),
    ("serenity_2", "serenity", "/data/jgoeders/fpt2026_2/build/rand_soc", "python3"),
    # ("aws",          "aws",      "/home/ubuntu/bfasst/build/rand_soc",      "python3"),
    # ("aws2",         "aws2",     "/home/ubuntu/bfasst/build/rand_soc",      "python3"),
    # ("aws3",         "aws3",     "/home/ubuntu/bfasst/build/rand_soc",      "python3"),
]

# Files the remote generators need (all stdlib-only).
GENERATOR_FILES = ["parsers.py", "dataset.py", "ip_sizes_dataset.py"]


def fetch_machine(label: str, host: str, build_dir: str, python: str, out_dir: Path) -> bool:
    """Generate the CSVs on one machine and copy them back. Returns True on success.

    Returns True when the per-design dataset CSV was fetched; the per-IP ip_sizes
    CSV is best-effort (a machine with no hierarchical reports just contributes no
    ip_sizes file). Runs in a worker thread, so all output is buffered into a
    single block and flushed at the end rather than printed inline -- otherwise
    parallel machines' logs would interleave unreadably.
    """
    here = Path(__file__).parent
    out = [f"==> {label} ({host})"]
    err = []

    def flush():
        print("\n".join(out))
        if err:
            print("\n".join(err), file=sys.stderr)

    # Create a temporary working dir on the remote.
    r = subprocess.run(["ssh", host, "mktemp -d"], capture_output=True, text=True, timeout=60)
    if r.returncode != 0 or not r.stdout.strip():
        err.append(f"  ! {label}: failed to create remote temp dir: {r.stderr.strip()}")
        flush()
        return False
    remote_tmp = r.stdout.strip().splitlines()[-1]

    try:
        # Copy the stdlib-only generators over.
        scp_src = [str(here / f) for f in GENERATOR_FILES]
        r = subprocess.run(
            ["scp", "-q", *scp_src, f"{host}:{remote_tmp}/"],
            capture_output=True,
            text=True,
            timeout=120,
        )
        if r.returncode != 0:
            err.append(f"  ! {label}: failed to copy generators: {r.stderr.strip()}")
            flush()
            return False

        # --- Per-design dataset (required) ---
        gen_cmd = (
            f"{python} {remote_tmp}/dataset.py {build_dir} "
            f"--out-dir {remote_tmp} --machine {label}"
        )
        r = subprocess.run(["ssh", host, gen_cmd], capture_output=True, text=True, timeout=1800)
        if r.returncode != 0:
            err.append(
                f"  ! {label}: dataset generation failed: {r.stderr.strip() or r.stdout.strip()}"
            )
            flush()
            return False
        for line in r.stdout.splitlines():
            out.append(f"    {line}")

        raw_dir = out_dir / "raw"
        raw_dir.mkdir(parents=True, exist_ok=True)
        local_csv = raw_dir / f"{label}.csv"
        r = subprocess.run(
            ["scp", "-q", f"{host}:{remote_tmp}/dataset.csv", str(local_csv)],
            capture_output=True,
            text=True,
            timeout=120,
        )
        if r.returncode != 0:
            err.append(f"  ! {label}: failed to copy dataset CSV back: {r.stderr.strip()}")
            flush()
            return False
        out.append(f"    fetched -> {local_csv}")

        # --- Per-IP sizes (best-effort: needs utilization_hier.txt reports) ---
        ip_cmd = (
            f"{python} {remote_tmp}/ip_sizes_dataset.py {build_dir} "
            f"--out-dir {remote_tmp} --machine {label}"
        )
        r = subprocess.run(["ssh", host, ip_cmd], capture_output=True, text=True, timeout=1800)
        if r.returncode != 0:
            out.append(
                f"    (no ip_sizes: {r.stderr.strip() or r.stdout.strip() or 'no hierarchical reports'})"
            )
        else:
            for line in r.stdout.splitlines():
                out.append(f"    {line}")
            raw_ip_dir = out_dir / "raw_ip"
            raw_ip_dir.mkdir(parents=True, exist_ok=True)
            local_ip_csv = raw_ip_dir / f"{label}.csv"
            r = subprocess.run(
                ["scp", "-q", f"{host}:{remote_tmp}/ip_sizes.csv", str(local_ip_csv)],
                capture_output=True,
                text=True,
                timeout=120,
            )
            if r.returncode != 0:
                err.append(f"  ! {label}: failed to copy ip_sizes CSV back: {r.stderr.strip()}")
            else:
                out.append(f"    fetched -> {local_ip_csv}")

        flush()
        return True
    finally:
        # Best-effort cleanup of the remote temp dir.
        subprocess.run(
            ["ssh", host, f"rm -rf {remote_tmp}"],
            capture_output=True,
            text=True,
            timeout=60,
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
        "--out-dir",
        type=Path,
        default=Path("output"),
        help="Local output dir; dataset CSVs land in <out-dir>/raw/ and per-IP "
        "CSVs in <out-dir>/raw_ip/ (default: output)",
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

    # Each machine is independent (its own remote temp dir and local CSVs), so fetch
    # them concurrently -- one slow/large build no longer blocks the others.
    with ThreadPoolExecutor(max_workers=len(machines)) as pool:
        results = pool.map(lambda m: fetch_machine(m[0], m[1], m[2], m[3], args.out_dir), machines)
        failures = sum(1 for ok in results if not ok)

    print()
    ok = len(machines) - failures
    print(
        f"Fetched {ok}/{len(machines)} machines into {args.out_dir}/raw "
        f"(+ {args.out_dir}/raw_ip where available)"
    )
    if failures:
        print("Run 'make join' once all machines succeed.", file=sys.stderr)
        sys.exit(1)
    print("Next: 'make join' to merge into a single dataset.csv")


if __name__ == "__main__":
    main()
