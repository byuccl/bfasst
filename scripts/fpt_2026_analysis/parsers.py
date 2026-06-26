"""Stdlib-only parsers for RandSoC Vivado outputs.

This module deliberately depends on nothing outside the Python standard library
(``re``, ``csv``, ``pathlib``) so it can be copied to and run on the remote build
machines, which have no numpy/matplotlib installed. The plotting scripts
(``utilization.py``, ``timing.py``, ``congestion.py``, ``runtime.py``) import the
``parse_*`` functions and shared constants from here; ``dataset.py`` imports
``collect_all`` / ``COLUMNS`` / ``write_csv`` to build the per-machine CSV.
"""

import csv
import re
from pathlib import Path

# --------------------------------------------------------------------------- #
# Utilization
# --------------------------------------------------------------------------- #

# Maps short name -> (table row label, section header for zero-usage fallback)
# SLICE is the slice/CLB occupancy row ("Slice" on 7-series, would be "CLB" on
# UltraScale+) — a packing-density metric distinct from raw LUT/FF counts. It is
# only present post-implementation, so it is excluded from the post-synth subset.
RESOURCES = {
    "LUT": ("Slice LUTs", None),
    "FF": ("Slice Registers", None),
    "SLICE": ("Slice", None),
    "BRAM": ("Block RAM Tile", "3. Memory"),
    "DSP": ("DSPs", "4. DSP"),
    "IO": ("Bonded IOB", None),
}

# Resources reported post-synthesis (no placement yet -> no SLICE/IO occupancy).
SYNTH_RESOURCES = ("LUT", "FF", "BRAM", "DSP")


def parse_utilization(path: Path, keys=None) -> dict[str, float] | None:
    """Parse a Vivado utilization report; returns util% per resource, or None on parse failure.

    `keys` selects which RESOURCES to require (default: all). Pass a subset for
    reports that don't contain every row (e.g. SYNTH_RESOURCES for post-synth).
    """
    text = path.read_text()
    result = {}
    for key in (keys if keys is not None else RESOURCES):
        label, zero_section = RESOURCES[key]
        pattern = (
            rf"\|\s*{re.escape(label)}\s*\|\s*[\d,]+\s*\|[^|]*\|[^|]*\|[^|]*\|\s*([\d.]+)\s*\|"
        )
        m = re.search(pattern, text)
        if m:
            result[key] = float(m.group(1))
        elif zero_section and zero_section in text:
            # Section exists but table is empty — resource count is zero
            result[key] = 0.0
        else:
            return None
    return result


# Columns in `report_utilization -hierarchical` (utilization_hier.txt), in order
# after the Instance and Module name columns.
HIER_RESOURCE_COLUMNS = [
    "total_luts", "logic_luts", "lutrams", "srls", "ffs", "ramb36", "ramb18", "dsp",
]

# A top-level RandSoC IP wrapper instance: the design.tcl wraps each generated IP
# in a `ip_<index>_<type>` hierarchy (e.g. ip_0_axi_quad_spi), so these rows give
# per-IP resource usage. Children (deeper in the hierarchy) are ignored.
_HIER_IP_RE = re.compile(r"^ip_(\d+)_([a-zA-Z0-9_]+)$")


def parse_utilization_hier(path: Path) -> list[dict]:
    """Parse `report_utilization -hierarchical`; one dict per top-level IP wrapper.

    Returns a list of {ip_index, ip_type, total_luts, logic_luts, lutrams, srls,
    ffs, ramb36, ramb18, dsp} for each ``ip_<n>_<type>`` instance in the design.
    Only the IP-wrapper rows are kept (not their sub-instances), so summing a type
    across designs gives that IP's size distribution. Empty list if none found.
    """
    ips = []
    for line in path.read_text().splitlines():
        if not line.lstrip().startswith("|"):
            continue
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if len(cells) < 2 + len(HIER_RESOURCE_COLUMNS):
            continue
        m = _HIER_IP_RE.match(cells[0])
        if not m:
            continue
        try:
            vals = [int(c) for c in cells[2:2 + len(HIER_RESOURCE_COLUMNS)]]
        except ValueError:
            continue
        ip = {"ip_index": int(m.group(1)), "ip_type": m.group(2)}
        ip.update(dict(zip(HIER_RESOURCE_COLUMNS, vals)))
        ips.append(ip)
    return ips


# --------------------------------------------------------------------------- #
# Timing
# --------------------------------------------------------------------------- #


def parse_timing(path: Path) -> dict | None:
    """Parse a Vivado timing_summary.txt; returns timing metrics or None if unconstrained."""
    text = path.read_text()

    if "There are no user specified timing constraints" in text:
        return None

    # WNS, TNS, failing endpoints, total endpoints from the Intra Clock Table row for clk_out1
    # Row format:  clk_out1_<name>  WNS  TNS  TNS_fail  TNS_total  WPWS  TPWS  ...
    clock_row = re.search(
        r"^\s+clk_out1_\S+\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+(\d+)",
        text,
        re.MULTILINE,
    )
    if not clock_row:
        return None

    wns = float(clock_row.group(1))
    tns = float(clock_row.group(2))
    failing_endpoints = int(clock_row.group(3))
    total_endpoints = int(clock_row.group(4))

    # Target clock period (ns) from the Clock Summary row, e.g.:
    #   clk_out1_<name>   {0.000 4.167}   8.333   120.005
    # The {waveform} braces distinguish it from the Intra Clock Table rows.
    period_row = re.search(
        r"^\s+clk_out1_\S+\s+\{[^}]*\}\s+([\d.]+)\s+([\d.]+)",
        text,
        re.MULTILINE,
    )
    clk_period = float(period_row.group(1)) if period_row else None

    # Logic levels and data path delay from the first constrained Max Delay Paths section.
    # Find the first path that is clocked (VIOLATED or MET, not inf).
    # The constrained paths appear before unconstrained (inf) ones.
    logic_levels = None
    data_path_delay = None

    # Locate the first Slack line that is not "inf"
    for m in re.finditer(r"Slack\s*(?:\(VIOLATED\)|\(MET\))\s*:\s*([-\d.]+)ns", text):
        # From this position, grab the next Logic Levels and Data Path Delay lines
        tail = text[m.start() :]
        ll_m = re.search(r"Logic Levels:\s+(\d+)", tail)
        dp_m = re.search(r"Data Path Delay:\s+([\d.]+)ns", tail)
        if ll_m and dp_m:
            logic_levels = int(ll_m.group(1))
            data_path_delay = float(dp_m.group(1))
        break

    return {
        "wns": wns,
        "tns": tns,
        "failing_endpoints": failing_endpoints,
        "total_endpoints": total_endpoints,
        "logic_levels": logic_levels,
        "data_path_delay": data_path_delay,
        "clk_period": clk_period,
    }


# --------------------------------------------------------------------------- #
# Logic levels (max combinational depth)
# --------------------------------------------------------------------------- #


def parse_logic_levels(path: Path) -> int | None:
    """Parse a report_design_analysis logic-level distribution report.

    Returns the maximum combinational logic depth across the design -- the
    highest logic-level column with a non-zero path count, over all end-point
    clocks -- or None if the report contains no distribution data. This is the
    deepest path regardless of slack, unlike the worst-path ``logic_levels`` from
    ``parse_timing``. The report table looks like:

        |     End Point Clock     | Requirement |  0  |  1  |  2  | ... |
        | clk_out1_...            | 8.333ns     | 690 | 203 |  11 | ... |
    """
    levels = None
    max_level = None
    for line in path.read_text().splitlines():
        stripped = line.strip()
        if not stripped.startswith("|"):
            continue
        cells = [c.strip() for c in stripped.strip("|").split("|")]
        if not cells:
            continue
        if cells[0] == "End Point Clock":
            # Remaining header cells are the logic-level numbers (0, 1, 2, ...).
            levels = [int(c) for c in cells[2:] if c.isdigit()]
            continue
        if not levels:
            continue
        # Data row: per-level path counts follow the clock name and requirement.
        try:
            counts = [int(c) for c in cells[2:2 + len(levels)]]
        except ValueError:
            continue
        for lvl, cnt in zip(levels, counts):
            if cnt > 0 and (max_level is None or lvl > max_level):
                max_level = lvl
    return max_level


# --------------------------------------------------------------------------- #
# Congestion
# --------------------------------------------------------------------------- #

DIRECTIONS = ["North", "South", "East", "West"]


def parse_congestion(log_path: Path) -> dict | None:
    """Parse peak routing segment utilization (%) per direction from vivado.log."""
    text = log_path.read_text()

    # Lines look like:
    #   North Dir 2x2 Area, Max Cong = 87.6126%, Congestion bounded by ...
    #   East Dir 1x1 Area, Max Cong = 83.8235%, No Congested Regions.
    result = {}
    for direction in DIRECTIONS:
        m = re.search(
            rf"{direction} Dir \S+ Area, Max Cong = ([\d.]+)%",
            text,
        )
        if m:
            result[direction] = float(m.group(1))

    if len(result) != len(DIRECTIONS):
        return None

    result["max"] = max(result[d] for d in DIRECTIONS)
    result["has_congested_region"] = "Congestion bounded by tiles" in text
    return result


# --------------------------------------------------------------------------- #
# Runtime
# --------------------------------------------------------------------------- #


def _parse_elapsed(hms: str) -> float:
    """Convert HH:MM:SS or HH:MM:SS.ss to seconds."""
    parts = hms.split(":")
    return sum(float(p) * 60 ** (len(parts) - 1 - i) for i, p in enumerate(parts))


def _phase_elapsed(text: str, phase: str) -> float | None:
    """Elapsed seconds for a Vivado phase command (e.g. 'place_design').

    Normally the phase summary is a prefixed line ('place_design: Time (s): ...
    elapsed = ...'). For some fast phases Vivado instead emits a *bare*
    'Time (s): ... elapsed = ...' line, so fall back to the last such line before
    '<phase> completed successfully' (the command's own summary).
    """
    m = re.search(rf"^{phase}: Time.*?elapsed = ([\d:]+)", text, re.MULTILINE)
    if m:
        return _parse_elapsed(m.group(1))
    end = text.find(f"{phase} completed successfully")
    if end == -1:
        return None
    times = re.findall(r"Time \(s\):[^\n]*elapsed = ([\d:]+)", text[:end])
    return _parse_elapsed(times[-1]) if times else None


def parse_runtime(synth_log: Path, impl_log: Path) -> dict | None:
    """Parse elapsed wall-clock time for each Vivado phase."""
    result = {}

    if synth_log.exists():
        elapsed = _phase_elapsed(synth_log.read_text(), "synth_design")
        if elapsed is not None:
            result["synth"] = elapsed

    if impl_log.exists():
        text = impl_log.read_text()
        for phase in ["opt_design", "place_design", "route_design"]:
            elapsed = _phase_elapsed(text, phase)
            if elapsed is not None:
                result[phase.replace("_design", "")] = elapsed

    if not result:
        return None

    result["impl"] = sum(result.get(p, 0) for p in ["opt", "place", "route"])
    result["total"] = result.get("synth", 0) + result["impl"]
    return result


# --------------------------------------------------------------------------- #
# Combined dataset
# --------------------------------------------------------------------------- #

COLUMNS = [
    "machine", "seed",
    "lut_util_pct", "ff_util_pct", "slice_util_pct", "bram_util_pct", "dsp_util_pct", "io_util_pct",
    "synth_lut_util_pct", "synth_ff_util_pct", "synth_bram_util_pct", "synth_dsp_util_pct",
    "wns_ns", "tns_ns", "failing_endpoints", "total_endpoints",
    "logic_levels", "max_logic_levels", "data_path_delay_ns", "clk_period_ns",
    "congestion_north_pct", "congestion_south_pct", "congestion_east_pct",
    "congestion_west_pct", "congestion_max_pct", "has_congestion_hotspot",
    "synth_elapsed_s", "opt_elapsed_s", "place_elapsed_s",
    "route_elapsed_s", "impl_elapsed_s", "total_elapsed_s",
]

# Per-column type converters used by read_dataset_csv to turn CSV strings back
# into typed values (empty string -> None).
_INT_COLUMNS = {"seed", "failing_endpoints", "total_endpoints", "logic_levels",
                "max_logic_levels"}
_BOOL_COLUMNS = {"has_congestion_hotspot"}
_STR_COLUMNS = {"machine"}


def collect_all(build_dir: Path, machine: str = "") -> list[dict]:
    """Parse each fully-completed design_* directory into one row per design.

    A design counts as complete only when its implementation DCP
    (``vivado_impl/impl.dcp``) exists — the same marker ``progress.py`` uses.
    Designs that haven't finished implementation are skipped entirely so the CSV
    never contains partial rows.
    """
    rows = []
    skipped = 0
    for design_dir in sorted(build_dir.glob("design_*")):
        if not (design_dir / "vivado_impl" / "impl.dcp").exists():
            skipped += 1
            continue
        seed = int(design_dir.name.split("_")[1])
        row = {"machine": machine, "seed": seed}

        # --- Post-implementation utilization (the primary utilization source) ---
        impl_util_path = design_dir / "vivado_impl" / "utilization.txt"
        util = parse_utilization(impl_util_path) if impl_util_path.exists() else None
        if util:
            row["lut_util_pct"]   = util.get("LUT")
            row["ff_util_pct"]    = util.get("FF")
            row["slice_util_pct"] = util.get("SLICE")
            row["bram_util_pct"]  = util.get("BRAM")
            row["dsp_util_pct"]   = util.get("DSP")
            row["io_util_pct"]    = util.get("IO")
        else:
            for k in ("lut_util_pct", "ff_util_pct", "slice_util_pct",
                      "bram_util_pct", "dsp_util_pct", "io_util_pct"):
                row[k] = None

        # --- Post-synthesis utilization ---
        synth_util_path = design_dir / "vivado_synth" / "synth_utilization.txt"
        synth_util = (
            parse_utilization(synth_util_path, keys=SYNTH_RESOURCES)
            if synth_util_path.exists() else None
        )
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
            row["clk_period_ns"]       = timing.get("clk_period")
        else:
            for k in ("wns_ns", "tns_ns", "failing_endpoints", "total_endpoints",
                      "logic_levels", "data_path_delay_ns", "clk_period_ns"):
                row[k] = None

        # --- Max logic depth (separate logic-level distribution report) ---
        # Independent of timing_summary.txt and only present once
        # report_logic_levels has been run, so parsed on its own.
        ll_path = design_dir / "vivado_impl" / "logic_levels.txt"
        row["max_logic_levels"] = parse_logic_levels(ll_path) if ll_path.exists() else None

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
    if skipped:
        print(f"Skipped {skipped} incomplete designs (no vivado_impl/impl.dcp)")
    return rows


def write_csv(rows: list[dict], out_path: Path) -> None:
    with open(out_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=COLUMNS)
        writer.writeheader()
        writer.writerows(rows)
    print(f"Saved {out_path}  ({len(rows)} designs, {len(COLUMNS)} columns)")


# --------------------------------------------------------------------------- #
# Per-IP sizes (one row per IP instance, from utilization_hier.txt)
# --------------------------------------------------------------------------- #

# One row per IP *instance* (not per design), so this is a separate dataset from
# the per-design COLUMNS above.
IP_SIZE_COLUMNS = ["machine", "seed", "ip_index", "ip_type"] + HIER_RESOURCE_COLUMNS


def collect_ip_sizes(build_dir: Path, machine: str = "") -> list[dict]:
    """One row per top-level IP instance across all completed designs.

    Reads each design's ``vivado_impl/utilization_hier.txt`` (only present once
    report_logic_levels / the impl flow has generated it) and emits a row per
    ``ip_<n>_<type>`` wrapper with its resource counts, stamped with machine+seed.
    Designs without the hierarchical report are skipped.
    """
    rows = []
    designs = missing = 0
    for design_dir in sorted(build_dir.glob("design_*")):
        hier_path = design_dir / "vivado_impl" / "utilization_hier.txt"
        if not hier_path.exists():
            missing += 1
            continue
        seed = int(design_dir.name.split("_")[1])
        ips = parse_utilization_hier(hier_path)
        if ips:
            designs += 1
        for ip in ips:
            rows.append({"machine": machine, "seed": seed, **ip})
    print(f"Collected {len(rows)} IP instances from {designs} designs "
          f"({missing} without a hierarchical report)")
    return rows


def write_ip_sizes_csv(rows: list[dict], out_path: Path) -> None:
    with open(out_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=IP_SIZE_COLUMNS)
        writer.writeheader()
        writer.writerows(rows)
    print(f"Saved {out_path}  ({len(rows)} IP instances)")


def _convert(column: str, value: str):
    """Convert one CSV cell back to its typed value (empty -> None)."""
    if column in _STR_COLUMNS:
        return value
    if value == "":
        return None
    if column in _BOOL_COLUMNS:
        return value == "True"
    if column in _INT_COLUMNS:
        return int(value)
    return float(value)


def read_dataset_csv(path: Path) -> list[dict]:
    """Read a joined dataset CSV back into typed rows for plotting."""
    with open(path, newline="") as f:
        reader = csv.DictReader(f)
        return [{col: _convert(col, row.get(col, "")) for col in COLUMNS} for row in reader]
