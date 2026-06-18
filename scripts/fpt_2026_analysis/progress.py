"""Report RandSoC build progress across remote machines.

A design is considered "complete" when its implementation DCP
(`vivado_impl/impl.dcp`) exists. This script SSHes into each configured
machine, counts complete vs. total design directories, and prints a summary.
"""

import argparse
import subprocess
import sys

# (label, ssh_host, build_dir)
DEFAULT_MACHINES = [
    ("CCL1",     "CCL1",     "/data/jgoeders/fpt2026/build/rand_soc"),
    ("serenity", "serenity", "/data/jgoeders/fpt2026/build/rand_soc"),
]

# Remote shell snippet: prints "<done> <total>" for the given build dir.
REMOTE_CMD = (
    'cd {build_dir} 2>/dev/null || {{ echo "0 0"; exit 0; }}; '
    'total=$(ls -d design_* 2>/dev/null | wc -l); '
    'done=$(ls design_*/vivado_impl/impl.dcp 2>/dev/null | wc -l); '
    'echo "$done $total"'
)


def query_machine(host: str, build_dir: str) -> tuple[int, int]:
    """Return (done, total) for one machine, or (-1, -1) on error."""
    cmd = REMOTE_CMD.format(build_dir=build_dir)
    try:
        result = subprocess.run(
            ["ssh", host, cmd],
            capture_output=True,
            text=True,
            timeout=60,
        )
    except subprocess.TimeoutExpired:
        print(f"  ! {host}: timed out", file=sys.stderr)
        return (-1, -1)

    # Pull the "<done> <total>" line out of stdout (ignore X11/banner noise).
    for line in reversed(result.stdout.splitlines()):
        parts = line.split()
        if len(parts) == 2 and all(p.isdigit() for p in parts):
            return int(parts[0]), int(parts[1])

    print(f"  ! {host}: unexpected output", file=sys.stderr)
    if result.stderr.strip():
        print(f"    {result.stderr.strip().splitlines()[-1]}", file=sys.stderr)
    return (-1, -1)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--machine",
        action="append",
        metavar="LABEL:HOST:BUILD_DIR",
        help="Override machines to query (repeatable). "
             "Default: CCL1 and serenity.",
    )
    args = parser.parse_args()

    if args.machine:
        machines = []
        for spec in args.machine:
            try:
                label, host, build_dir = spec.split(":", 2)
            except ValueError:
                parser.error(f"--machine must be LABEL:HOST:BUILD_DIR, got {spec!r}")
            machines.append((label, host, build_dir))
    else:
        machines = DEFAULT_MACHINES

    print(f"{'Machine':<12} {'Complete':>10} {'Total':>8} {'Percent':>9}")
    print("-" * 42)

    grand_done = grand_total = 0
    for label, host, build_dir in machines:
        done, total = query_machine(host, build_dir)
        if done < 0:
            print(f"{label:<12} {'error':>10}")
            continue
        pct = f"{100 * done / total:.1f}%" if total else "-"
        print(f"{label:<12} {done:>10} {total:>8} {pct:>9}")
        grand_done += done
        grand_total += total

    print("-" * 42)
    pct = f"{100 * grand_done / grand_total:.1f}%" if grand_total else "-"
    print(f"{'TOTAL':<12} {grand_done:>10} {grand_total:>8} {pct:>9}")


if __name__ == "__main__":
    main()
