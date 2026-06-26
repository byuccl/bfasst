#!/usr/bin/env python3
"""Assemble RandSoC datasets from several build machines into one dataset.

Each remote build machine has a bfasst ``build/rand_soc`` directory containing
``design_<seed>`` directories. This script copies the *complete* designs (those
with ``vivado_impl/impl.dcp``) from every configured source into a single output
directory, renumbering them contiguously as ``design_0000``, ``design_0001``, ...

It also writes a ``dataset.yaml`` manifest in the output directory recording:
  * the bfasst and rand_soc git hashes (hard-coded near the top of this file), and
  * for every assembled design: the originating machine, the source path, the
    RandSoC config used, and the seed.

The seed is read from the source directory name (``design_<seed>``). The RandSoC
config is hard-coded per source directory in ``MACHINES`` below -- update it if a
source directory was built with a different config.
"""

# =============================================================================
# USAGE
# =============================================================================
# Configure the dataset in the DATASET CONFIGURATION block below (output dir,
# git hashes, and source machines), then run:
#
#   python scripts/assemble_randsoc_dataset.py
#       Assemble the complete designs into the hard-coded OUTPUT_DIR.
#
#   --max-designs N    Cap the assembled dataset at N designs total.
#   --dry-run          Show the plan and run rsync in --dry-run mode; do not
#                      write the manifest.
#   --manifest-only    (Re)write dataset.yaml only; do not copy design dirs.
# =============================================================================

import argparse
import subprocess
import sys
from pathlib import Path

try:
    from tqdm import tqdm
except ImportError:  # tqdm is optional; fall back to plain numbered output.
    tqdm = None

# A design is "complete" when this file exists under its directory.
COMPLETE_MARKER = "vivado_impl/impl.dcp"

# =============================================================================
# DATASET CONFIGURATION -- FPT 2026
# =============================================================================
# Where to assemble the dataset. The design_NNNN directories and dataset.yaml
# are written here.
OUTPUT_DIR = Path("/data/jgoeders/fpt2026_dataset")

# Git hashes the dataset was generated with (recorded in dataset.yaml).
# Obtain with:
#   bfasst:   git rev-parse HEAD
#   rand_soc: git -C third_party/rand_soc rev-parse HEAD
BFASST_GIT_HASH = "fe284fa5c703dedc2bed0780c6740af70644312c"
RAND_SOC_GIT_HASH = "fe645ed66fdda032d5020ee592fbc8117b776978"

# Source build directories to pull designs from.
#   (ssh_host, build_dir, randsoc_config)
# `randsoc_config` is the RandSoC creator config used to generate that build
# (repo-relative). VERIFY these -- they are inferred from the source paths.
MACHINES = [
    ("CCL1", "/data/jgoeders/fpt2026/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026.yaml"),
    ("serenity", "/data/jgoeders/fpt2026/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026.yaml"),
    ("CCL1", "/data/jgoeders/fpt2026_1/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026_all.yaml"),
    ("serenity", "/data/jgoeders/fpt2026_1/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026_big.yaml"),
    ("CCL1", "/data/jgoeders/fpt2026_2/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026_all.yaml"),
    ("serenity", "/data/jgoeders/fpt2026_2/build/rand_soc",
     "resources/randsoc/randsoc_configs/fpt_2026_all.yaml"),
]
# =============================================================================


# =============================================================================
# DATASET CONFIGURATION -- <your dataset>
# =============================================================================
# To assemble a different dataset, comment out the FPT 2026 block above and
# fill in your own values here:
#
# OUTPUT_DIR = Path("")
# BFASST_GIT_HASH = ""
# RAND_SOC_GIT_HASH = ""
# MACHINES = [
#     ("host", "/path/to/build/rand_soc", "resources/randsoc/..."),
# ]
# =============================================================================


def list_complete_designs(host: str, build_dir: str) -> list[tuple[int, str]]:
    """Return [(seed, source_path), ...] for complete designs on one machine.

    Sorted by seed ascending. Seed is parsed from the ``design_<seed>`` name.
    """
    # List the completion markers, then strip back to the design directory.
    remote_cmd = (
        f"cd {build_dir} 2>/dev/null || exit 0; "
        f"ls -d design_*/{COMPLETE_MARKER} 2>/dev/null"
    )
    try:
        result = subprocess.run(
            ["ssh", host, remote_cmd],
            capture_output=True, text=True, timeout=120,
        )
    except subprocess.TimeoutExpired:
        print(f"  ! {host}: timed out listing {build_dir}", file=sys.stderr)
        return []

    designs = []
    suffix = "/" + COMPLETE_MARKER
    for line in result.stdout.splitlines():
        line = line.strip()
        if not line.endswith(suffix):
            continue
        name = line[: -len(suffix)]  # e.g. "design_0"
        if not name.startswith("design_"):
            continue
        try:
            seed = int(name.split("_", 1)[1])
        except ValueError:
            print(f"  ! {host}: cannot parse seed from {name!r}", file=sys.stderr)
            continue
        designs.append((seed, f"{build_dir.rstrip('/')}/{name}"))

    designs.sort(key=lambda d: d[0])
    return designs


def yaml_escape(value: str) -> str:
    """Quote a scalar for YAML output if it could be misinterpreted."""
    if value == "" or any(c in value for c in ":#") or value != value.strip():
        return '"' + value.replace('"', '\\"') + '"'
    return value


def write_manifest(path: Path, bfasst_hash: str, rand_soc_hash: str,
                   plan: list[dict], width: int) -> None:
    """Write the dataset.yaml manifest."""
    lines = [
        "# Generated by scripts/assemble_randsoc_dataset.py",
        f"bfasst_git_hash: {bfasst_hash}",
        f"rand_soc_git_hash: {rand_soc_hash}",
        f"num_designs: {len(plan)}",
        "designs:",
    ]
    for entry in plan:
        name = f"design_{entry['index']:0{width}d}"
        lines.append(f"  - name: {name}")
        lines.append(f"    host: {yaml_escape(entry['host'])}")
        lines.append(f"    source: {yaml_escape(entry['source'])}")
        lines.append(f"    randsoc_config: {yaml_escape(entry['config'])}")
        lines.append(f"    seed: {entry['seed']}")
    path.write_text("\n".join(lines) + "\n")


def rsync_design(host: str, source: str, dest: Path, dry_run: bool) -> bool:
    """Copy a remote design directory into dest. Return True on success."""
    cmd = ["rsync", "-a", "--delete"]
    if dry_run:
        cmd.append("--dry-run")
    # Trailing slash on source so contents land directly in dest.
    cmd += [f"{host}:{source}/", f"{dest}/"]
    result = subprocess.run(cmd)
    return result.returncode == 0


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--max-designs", type=int, default=None, metavar="N",
                        help="Cap the assembled dataset at N designs total")
    parser.add_argument("--manifest-only", action="store_true",
                        help="Write dataset.yaml only; do not copy design dirs")
    parser.add_argument("--dry-run", action="store_true",
                        help="Show the plan and run rsync in --dry-run mode; "
                             "do not write the manifest")
    args = parser.parse_args()

    print(f"bfasst   {BFASST_GIT_HASH}")
    print(f"rand_soc {RAND_SOC_GIT_HASH}")

    # Gather complete designs from every source, in MACHINES order then by seed.
    plan: list[dict] = []
    for host, build_dir, config in MACHINES:
        designs = list_complete_designs(host, build_dir)
        print(f"{host:<10} {build_dir:<40} {len(designs):>5} complete")
        for seed, source in designs:
            plan.append({"host": host, "source": source,
                         "config": config, "seed": seed})

    if args.max_designs is not None and len(plan) > args.max_designs:
        print(f"Capping {len(plan)} designs at --max-designs={args.max_designs}")
        plan = plan[: args.max_designs]

    if not plan:
        print("No complete designs found.", file=sys.stderr)
        sys.exit(1)

    # Contiguous numbering; pad width grows with the dataset size (min 4).
    for new_index, entry in enumerate(plan):
        entry["index"] = new_index
    width = max(4, len(str(len(plan) - 1)))

    print(f"\nAssembling {len(plan)} designs into {OUTPUT_DIR} "
          f"(design_{0:0{width}d} .. design_{len(plan) - 1:0{width}d})")

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    if not args.manifest_only:
        failures = 0
        progress = tqdm(total=len(plan), unit="design") if tqdm else None
        for entry in plan:
            name = f"design_{entry['index']:0{width}d}"
            dest = OUTPUT_DIR / name
            dest.mkdir(parents=True, exist_ok=True)
            if tqdm:
                progress.set_description(name)
            else:
                print(f"[{entry['index'] + 1}/{len(plan)}] {name} "
                      f"<- {entry['host']}:{entry['source']}")
            if not rsync_design(entry["host"], entry["source"], dest, args.dry_run):
                # tqdm.write avoids clobbering the active bar.
                msg = f"  ! rsync failed for {name}"
                tqdm.write(msg, file=sys.stderr) if tqdm else print(msg, file=sys.stderr)
                failures += 1
            if tqdm:
                progress.update(1)
        if tqdm:
            progress.close()
        if failures:
            print(f"\n{failures} design(s) failed to copy.", file=sys.stderr)

    if args.dry_run:
        print("\nDry run: manifest not written.")
        return

    manifest_path = OUTPUT_DIR / "dataset.yaml"
    write_manifest(manifest_path, BFASST_GIT_HASH, RAND_SOC_GIT_HASH, plan, width)
    print(f"\nWrote {manifest_path}")


if __name__ == "__main__":
    main()
