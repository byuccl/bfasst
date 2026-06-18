"""Collect all per-design metrics into a single CSV."""

import argparse
import csv
import sys
from pathlib import Path

# Import parsers from sibling scripts
sys.path.insert(0, str(Path(__file__).parent))
from utilization import parse_utilization
from timing import parse_timing
from congestion import parse_congestion
from runtime import parse_runtime


def collect_all(build_dir: Path) -> list[dict]:
    rows = []
    for design_dir in sorted(build_dir.glob("design_*")):
        seed = int(design_dir.name.split("_")[1])
        row = {"seed": seed}

        # --- Post-implementation utilization ---
        impl_util_path = design_dir / "vivado_impl" / "utilization.txt"
        util = parse_utilization(impl_util_path) if impl_util_path.exists() else None
        if util:
            row["lut_util_pct"]  = util.get("LUT")
            row["ff_util_pct"]   = util.get("FF")
            row["bram_util_pct"] = util.get("BRAM")
            row["dsp_util_pct"]  = util.get("DSP")
            row["io_util_pct"]   = util.get("IO")
        else:
            for k in ("lut_util_pct", "ff_util_pct", "bram_util_pct", "dsp_util_pct", "io_util_pct"):
                row[k] = None

        # --- Post-synthesis utilization ---
        synth_util_path = design_dir / "vivado_synth" / "synth_utilization.txt"
        synth_util = parse_utilization(synth_util_path) if synth_util_path.exists() else None
        if synth_util:
            row["synth_lut_util_pct"]  = synth_util.get("LUT")
            row["synth_ff_util_pct"]   = synth_util.get("FF")
            row["synth_bram_util_pct"] = synth_util.get("BRAM")
            row["synth_dsp_util_pct"]  = synth_util.get("DSP")
        else:
            for k in ("synth_lut_util_pct", "synth_ff_util_pct", "synth_bram_util_pct", "synth_dsp_util_pct"):
                row[k] = None

        # --- Timing ---
        timing_path = design_dir / "vivado_impl" / "timing_summary.txt"
        timing = parse_timing(timing_path) if timing_path.exists() else None
        if timing:
            row["wns_ns"]              = timing.get("wns")
            row["tns_ns"]              = timing.get("tns")
            row["failing_endpoints"]   = timing.get("failing_endpoints")
            row["total_endpoints"]     = timing.get("total_endpoints")
            row["logic_levels"]        = timing.get("logic_levels")
            row["data_path_delay_ns"]  = timing.get("data_path_delay")
        else:
            for k in ("wns_ns", "tns_ns", "failing_endpoints", "total_endpoints",
                      "logic_levels", "data_path_delay_ns"):
                row[k] = None

        # --- Congestion ---
        impl_log = design_dir / "vivado_impl" / "vivado.log"
        congestion = parse_congestion(impl_log) if impl_log.exists() else None
        if congestion:
            row["congestion_north_pct"]   = congestion.get("North")
            row["congestion_south_pct"]   = congestion.get("South")
            row["congestion_east_pct"]    = congestion.get("East")
            row["congestion_west_pct"]    = congestion.get("West")
            row["congestion_max_pct"]     = congestion.get("max")
            row["has_congestion_hotspot"] = congestion.get("has_congested_region")
        else:
            for k in ("congestion_north_pct", "congestion_south_pct", "congestion_east_pct",
                      "congestion_west_pct", "congestion_max_pct", "has_congestion_hotspot"):
                row[k] = None

        # --- Runtime ---
        runtime = parse_runtime(
            design_dir / "vivado_synth" / "vivado.log",
            design_dir / "vivado_impl" / "vivado.log",
        )
        if runtime:
            row["synth_elapsed_s"] = runtime.get("synth")
            row["opt_elapsed_s"]   = runtime.get("opt")
            row["place_elapsed_s"] = runtime.get("place")
            row["route_elapsed_s"] = runtime.get("route")
            row["impl_elapsed_s"]  = runtime.get("impl")
            row["total_elapsed_s"] = runtime.get("total")
        else:
            for k in ("synth_elapsed_s", "opt_elapsed_s", "place_elapsed_s",
                      "route_elapsed_s", "impl_elapsed_s", "total_elapsed_s"):
                row[k] = None

        rows.append(row)
    return rows


COLUMNS = [
    "seed",
    "lut_util_pct", "ff_util_pct", "bram_util_pct", "dsp_util_pct", "io_util_pct",
    "synth_lut_util_pct", "synth_ff_util_pct", "synth_bram_util_pct", "synth_dsp_util_pct",
    "wns_ns", "tns_ns", "failing_endpoints", "total_endpoints",
    "logic_levels", "data_path_delay_ns",
    "congestion_north_pct", "congestion_south_pct", "congestion_east_pct",
    "congestion_west_pct", "congestion_max_pct", "has_congestion_hotspot",
    "synth_elapsed_s", "opt_elapsed_s", "place_elapsed_s",
    "route_elapsed_s", "impl_elapsed_s", "total_elapsed_s",
]


def write_csv(rows: list[dict], out_path: Path) -> None:
    with open(out_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=COLUMNS)
        writer.writeheader()
        writer.writerows(rows)
    print(f"Saved {out_path}  ({len(rows)} designs, {len(COLUMNS)} columns)")


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
    args = parser.parse_args()

    rows = collect_all(args.build_dir)
    if not rows:
        print(f"No design directories found under {args.build_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Collected data for {len(rows)} designs\n")
    args.out_dir.mkdir(parents=True, exist_ok=True)
    write_csv(rows, args.out_dir / "dataset.csv")


if __name__ == "__main__":
    main()
