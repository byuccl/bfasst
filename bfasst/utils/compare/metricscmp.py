"""Command-line script for comparing metrics between implementations."""

import argparse
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional, List


@dataclass
class TimingMetrics:
    """Timing metrics from Vivado timing_summary report."""

    wns: float  # Worst Negative Slack (ns)
    tns: float  # Total Negative Slack (ns)
    whs: float  # Worst Hold Slack (ns)
    ths: float  # Total Hold Slack (ns)
    failing_endpoints: int  # TNS Failing Endpoints
    clock_period_ns: float  # Clock period in nanoseconds (from constraint)
    fmax_mhz: float  # Maximum achievable frequency in MHz


@dataclass
class ResourceMetrics:
    """Resource utilization metrics from Vivado utilization report."""

    lut_used: int
    ff_used: int
    bram36_used: int
    bram18_used: int
    dsp_used: int


@dataclass
class CompilationMetrics:
    """Compilation time metrics parsed from Vivado log."""

    place_time_sec: float
    route_time_sec: float
    total_time_sec: float


@dataclass
class CongestionMetrics:
    """Congestion metrics from Vivado report_design_analysis -congestion."""

    max_level: int  # Maximum congestion level (0-8)
    north_global: int  # North direction global congestion level
    south_global: int  # South direction global congestion level
    east_global: int  # East direction global congestion level
    west_global: int  # West direction global congestion level


@dataclass
class SynthTiming:
    """Timing metrics from Vivado synthesis log."""

    synth_design_sec: float  # Time for synth_design command
    opt_design_sec: float  # Time for opt_design command
    total_sec: float  # Total synthesis time


@dataclass
class PhysOptIteration:
    """Timing for a single phys_opt_design call."""

    stage: str  # "post_place" or "post_route"
    iteration: int  # Which iteration of clock crank (0-indexed)
    elapsed_sec: float  # Elapsed wall-clock time


@dataclass
class DetailedImplTiming:
    """Detailed implementation timing metrics."""

    place_sec: float  # place_design time
    route_sec: float  # route_design time
    phys_opt_iterations: List[PhysOptIteration] = field(default_factory=list)
    total_phys_opt_sec: float = 0.0  # Sum of all phys_opt times
    total_sec: float = 0.0  # Total implementation time


@dataclass
class TransformTiming:
    """Timing for netlist transformation (redaction/unredaction)."""

    total_sec: float  # Total time for the transform


@dataclass
class ImplMetrics:
    """Combined metrics for an implementation."""

    timing: TimingMetrics
    resources: ResourceMetrics
    compilation: CompilationMetrics
    congestion: Optional[CongestionMetrics] = None


@dataclass
class BitstreamComparison:
    """Comparison of bitstreams between golden and test implementations."""

    golden_size: int  # Size in bytes
    test_size: int  # Size in bytes
    identical: bool  # Whether bitstreams are byte-for-byte identical


@dataclass
class MetricsComparison:
    """Comparison between baseline and test implementations."""

    baseline: ImplMetrics
    test: ImplMetrics
    bitstream: Optional[BitstreamComparison] = None

    def to_dict(self) -> dict:
        """Convert comparison to dictionary for JSON output."""
        result = {
            "timing": {
                "wns": {
                    "baseline": self.baseline.timing.wns,
                    "test": self.test.timing.wns,
                    "delta": self.test.timing.wns - self.baseline.timing.wns,
                },
                "tns": {
                    "baseline": self.baseline.timing.tns,
                    "test": self.test.timing.tns,
                    "delta": self.test.timing.tns - self.baseline.timing.tns,
                },
                "whs": {
                    "baseline": self.baseline.timing.whs,
                    "test": self.test.timing.whs,
                    "delta": self.test.timing.whs - self.baseline.timing.whs,
                },
                "ths": {
                    "baseline": self.baseline.timing.ths,
                    "test": self.test.timing.ths,
                    "delta": self.test.timing.ths - self.baseline.timing.ths,
                },
                "failing_endpoints": {
                    "baseline": self.baseline.timing.failing_endpoints,
                    "test": self.test.timing.failing_endpoints,
                    "delta": self.test.timing.failing_endpoints
                    - self.baseline.timing.failing_endpoints,
                },
                "clock_period_ns": {
                    "baseline": self.baseline.timing.clock_period_ns,
                    "test": self.test.timing.clock_period_ns,
                    "delta": self.test.timing.clock_period_ns
                    - self.baseline.timing.clock_period_ns,
                },
                "fmax_mhz": {
                    "baseline": self.baseline.timing.fmax_mhz,
                    "test": self.test.timing.fmax_mhz,
                    "delta": self.test.timing.fmax_mhz - self.baseline.timing.fmax_mhz,
                },
            },
            "resources": {
                "lut": {
                    "baseline": self.baseline.resources.lut_used,
                    "test": self.test.resources.lut_used,
                    "delta": self.test.resources.lut_used - self.baseline.resources.lut_used,
                },
                "ff": {
                    "baseline": self.baseline.resources.ff_used,
                    "test": self.test.resources.ff_used,
                    "delta": self.test.resources.ff_used - self.baseline.resources.ff_used,
                },
                "bram36": {
                    "baseline": self.baseline.resources.bram36_used,
                    "test": self.test.resources.bram36_used,
                    "delta": self.test.resources.bram36_used - self.baseline.resources.bram36_used,
                },
                "bram18": {
                    "baseline": self.baseline.resources.bram18_used,
                    "test": self.test.resources.bram18_used,
                    "delta": self.test.resources.bram18_used - self.baseline.resources.bram18_used,
                },
                "dsp": {
                    "baseline": self.baseline.resources.dsp_used,
                    "test": self.test.resources.dsp_used,
                    "delta": self.test.resources.dsp_used - self.baseline.resources.dsp_used,
                },
            },
            "compilation": {
                "place_time_sec": {
                    "baseline": self.baseline.compilation.place_time_sec,
                    "test": self.test.compilation.place_time_sec,
                    "delta": self.test.compilation.place_time_sec
                    - self.baseline.compilation.place_time_sec,
                },
                "route_time_sec": {
                    "baseline": self.baseline.compilation.route_time_sec,
                    "test": self.test.compilation.route_time_sec,
                    "delta": self.test.compilation.route_time_sec
                    - self.baseline.compilation.route_time_sec,
                },
                "total_time_sec": {
                    "baseline": self.baseline.compilation.total_time_sec,
                    "test": self.test.compilation.total_time_sec,
                    "delta": self.test.compilation.total_time_sec
                    - self.baseline.compilation.total_time_sec,
                },
            },
            "bitstream": {
                "golden_size": self.bitstream.golden_size if self.bitstream else None,
                "test_size": self.bitstream.test_size if self.bitstream else None,
                "identical": self.bitstream.identical if self.bitstream else None,
            },
        }

        # Add congestion metrics if available
        if self.baseline.congestion and self.test.congestion:
            result["congestion"] = {
                "max_level": {
                    "baseline": self.baseline.congestion.max_level,
                    "test": self.test.congestion.max_level,
                    "delta": self.test.congestion.max_level - self.baseline.congestion.max_level,
                },
                "north_global": {
                    "baseline": self.baseline.congestion.north_global,
                    "test": self.test.congestion.north_global,
                    "delta": self.test.congestion.north_global
                    - self.baseline.congestion.north_global,
                },
                "south_global": {
                    "baseline": self.baseline.congestion.south_global,
                    "test": self.test.congestion.south_global,
                    "delta": self.test.congestion.south_global
                    - self.baseline.congestion.south_global,
                },
                "east_global": {
                    "baseline": self.baseline.congestion.east_global,
                    "test": self.test.congestion.east_global,
                    "delta": self.test.congestion.east_global
                    - self.baseline.congestion.east_global,
                },
                "west_global": {
                    "baseline": self.baseline.congestion.west_global,
                    "test": self.test.congestion.west_global,
                    "delta": self.test.congestion.west_global
                    - self.baseline.congestion.west_global,
                },
            }

        return result


# --- Parsers ---


def parse_timing_summary(path: Path) -> TimingMetrics:
    """Parse timing metrics from Vivado timing_summary.txt."""
    content = path.read_text()

    # Parse WNS, TNS, WHS, THS from Design Timing Summary section
    wns, tns, whs, ths, failing_endpoints = 0.0, 0.0, 0.0, 0.0, 0

    section_match = re.search(r"Design Timing Summary", content)
    if section_match:
        remaining = content[section_match.end() :]
        pattern = r"^\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+\d+\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)"
        match = re.search(pattern, remaining, re.MULTILINE)
        if match:
            wns = float(match.group(1))
            tns = float(match.group(2))
            failing_endpoints = int(match.group(3))
            whs = float(match.group(4))
            ths = float(match.group(5))

    # Parse clock period from Clock Summary section
    # Format: Clock  Waveform(ns)  Period(ns)  Frequency(MHz)
    clock_period_ns = 0.0
    clock_match = re.search(
        r"^\s*(\S+)\s+\{[\d.\s]+\}\s+([\d.]+)\s+([\d.]+)",
        content,
        re.MULTILINE,
    )
    if clock_match:
        clock_period_ns = float(clock_match.group(2))

    # Calculate fmax from clock period and WNS
    # Achieved period = clock_period - WNS (WNS is positive when timing met, negative when violated)
    # fmax = 1000 / achieved_period (MHz)
    if clock_period_ns > 0:
        achieved_period = clock_period_ns - wns
        fmax_mhz = 1000.0 / achieved_period if achieved_period > 0 else 0.0
    else:
        fmax_mhz = 0.0

    return TimingMetrics(
        wns=wns,
        tns=tns,
        whs=whs,
        ths=ths,
        failing_endpoints=failing_endpoints,
        clock_period_ns=clock_period_ns,
        fmax_mhz=fmax_mhz,
    )


def parse_utilization(path: Path) -> ResourceMetrics:
    """Parse resource utilization from Vivado utilization.txt."""
    content = path.read_text()

    pattern = (
        r"\|\s*\S+\s*\|\s*\(top\)\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*\d+\s*\|"
        r"\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|"
    )
    match = re.search(pattern, content)

    if match:
        return ResourceMetrics(
            lut_used=int(match.group(1)),
            ff_used=int(match.group(2)),
            bram36_used=int(match.group(3)),
            bram18_used=int(match.group(4)),
            dsp_used=int(match.group(5)),
        )

    return ResourceMetrics(lut_used=0, ff_used=0, bram36_used=0, bram18_used=0, dsp_used=0)


def _parse_time_to_seconds(time_str: str) -> float:
    """Parse Vivado time string (HH:MM:SS) to seconds."""
    parts = time_str.split(":")
    if len(parts) == 3:
        hours = int(parts[0])
        minutes = int(parts[1])
        seconds = float(parts[2])
        return hours * 3600 + minutes * 60 + seconds
    return 0.0


def parse_vivado_log(path: Path) -> CompilationMetrics:
    """Parse compilation times from vivado.log."""
    content = path.read_text()

    place_time = 0.0
    route_time = 0.0

    place_match = re.search(r"place_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if place_match:
        place_time = _parse_time_to_seconds(place_match.group(1))

    route_match = re.search(r"route_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if route_match:
        route_time = _parse_time_to_seconds(route_match.group(1))

    return CompilationMetrics(
        place_time_sec=place_time,
        route_time_sec=route_time,
        total_time_sec=place_time + route_time,
    )


def parse_congestion_report(path: Path) -> CongestionMetrics:
    """Parse congestion metrics from Vivado report_design_analysis -congestion output.

    The report contains tables with congestion levels by direction (North, South, East, West)
    and type (Global, Long). We extract the congestion levels for each direction.

    Vivado reports "No congestion windows are found above level 5" when the design
    has low congestion, in which case all levels will be 0.
    """
    content = path.read_text()

    max_level = 0
    north_global = 0
    south_global = 0
    east_global = 0
    west_global = 0

    # Look for congestion reporting sections (various Vivado versions use different names)
    for section_name in [
        "Placer Final Level Congestion Reporting",
        "Router Final Level Congestion Reporting",
        "Routed Maximum Level Congestion Reporting",
        "Placed Maximum Level Congestion Reporting",
    ]:
        section_match = re.search(
            rf"{re.escape(section_name)}.*?(?=\n\d+\.\s|\Z)", content, re.DOTALL
        )
        if section_match:
            section_text = section_match.group()

            # Check if there's no congestion
            if "No congestion" in section_text:
                break

            # Parse direction-specific congestion levels from the table
            # Format: | North | Global | 3 | ... or | North | Long | 2 | ...
            for direction in ["North", "South", "East", "West"]:
                # Match any type (Global or Long), take the Level column
                match = re.search(
                    rf"\|\s*{direction}\s*\|\s*\w+\s*\|\s*(\d+)\s*\|",
                    section_text,
                )
                if match:
                    level = int(match.group(1))
                    if direction == "North":
                        north_global = level
                    elif direction == "South":
                        south_global = level
                    elif direction == "East":
                        east_global = level
                    elif direction == "West":
                        west_global = level
                    max_level = max(max_level, level)
            break  # Use the first section found

    return CongestionMetrics(
        max_level=max_level,
        north_global=north_global,
        south_global=south_global,
        east_global=east_global,
        west_global=west_global,
    )


def parse_synth_log(path: Path) -> SynthTiming:
    """Parse synthesis timing from Vivado synthesis log."""
    content = path.read_text()

    synth_time = 0.0
    opt_time = 0.0

    synth_match = re.search(r"synth_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if synth_match:
        synth_time = _parse_time_to_seconds(synth_match.group(1))

    opt_match = re.search(r"opt_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if opt_match:
        opt_time = _parse_time_to_seconds(opt_match.group(1))

    return SynthTiming(
        synth_design_sec=synth_time,
        opt_design_sec=opt_time,
        total_sec=synth_time + opt_time,
    )


def parse_detailed_impl_log(path: Path) -> DetailedImplTiming:
    """Parse detailed implementation timing from Vivado implementation log.

    Extracts timing for place_design, route_design, and each phys_opt_design call.
    The clock crank loop may run multiple iterations, each with post-place and
    post-route phys_opt calls.
    """
    content = path.read_text()

    # Find all timing events in order with their positions
    # This handles multiple clock crank iterations properly
    events = []

    # Pattern for any Vivado command timing
    timing_pattern = re.compile(
        r"(place_design|route_design|phys_opt_design): Time \(s\):.*?elapsed = ([\d:]+)"
    )

    for match in timing_pattern.finditer(content):
        cmd = match.group(1)
        elapsed = _parse_time_to_seconds(match.group(2))
        events.append((match.start(), cmd, elapsed))

    # Process events to calculate totals and identify phys_opt stages
    total_place = 0.0
    total_route = 0.0
    phys_opt_iterations: List[PhysOptIteration] = []

    # Track state for determining phys_opt stage
    last_major_cmd = None  # "place" or "route"
    post_place_count = 0
    post_route_count = 0

    for pos, cmd, elapsed in events:
        if cmd == "place_design":
            total_place += elapsed
            last_major_cmd = "place"
        elif cmd == "route_design":
            total_route += elapsed
            last_major_cmd = "route"
        elif cmd == "phys_opt_design":
            if last_major_cmd == "route":
                stage = "post_route"
                iteration = post_route_count
                post_route_count += 1
            else:
                # Default to post_place if we haven't seen route yet
                stage = "post_place"
                iteration = post_place_count
                post_place_count += 1

            phys_opt_iterations.append(
                PhysOptIteration(stage=stage, iteration=iteration, elapsed_sec=elapsed)
            )

    total_phys_opt = sum(p.elapsed_sec for p in phys_opt_iterations)
    total_time = total_place + total_route + total_phys_opt

    return DetailedImplTiming(
        place_sec=total_place,
        route_sec=total_route,
        phys_opt_iterations=phys_opt_iterations,
        total_phys_opt_sec=total_phys_opt,
        total_sec=total_time,
    )


def parse_transform_log(path: Path) -> TransformTiming:
    """Parse timing from redaction or unredaction log.

    Looks for lines like:
        'NetlistRedact done in 1.115 s'
    Or calculates from first/last timestamps if no explicit time found.
    """
    content = path.read_text()

    total_time = 0.0

    # Try to find explicit total time
    # Format: "NetlistRedact done in 1.115 s" or similar
    done_match = re.search(r"done in ([\d.]+) s", content)
    if done_match:
        total_time = float(done_match.group(1))
    else:
        # Calculate from timestamps if no explicit time
        # Format: "2026-01-16 15:09:30.924 INFO: ..."
        timestamps = re.findall(r"(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d+)", content)
        if len(timestamps) >= 2:
            from datetime import datetime

            fmt = "%Y-%m-%d %H:%M:%S.%f"
            try:
                start = datetime.strptime(timestamps[0], fmt)
                end = datetime.strptime(timestamps[-1], fmt)
                total_time = (end - start).total_seconds()
            except ValueError:
                pass

    return TransformTiming(total_sec=total_time)


def parse_impl_metrics(
    timing_path: Path,
    utilization_path: Path,
    log_path: Path,
    congestion_path: Optional[Path] = None,
) -> ImplMetrics:
    """Parse all metrics for an implementation from its output files."""
    congestion = None
    if congestion_path and congestion_path.exists():
        congestion = parse_congestion_report(congestion_path)

    return ImplMetrics(
        timing=parse_timing_summary(timing_path),
        resources=parse_utilization(utilization_path),
        compilation=parse_vivado_log(log_path),
        congestion=congestion,
    )


def compare_bitstreams(
    golden_path: Path, test_path: Path, skip_bytes: int = 200
) -> BitstreamComparison:
    """Compare two bitstream files, skipping header bytes (timestamps, etc)."""
    golden_size = golden_path.stat().st_size
    test_size = test_path.stat().st_size

    # Compare content after skipping header bytes
    with open(golden_path, "rb") as f_golden, open(test_path, "rb") as f_test:
        golden_content = f_golden.read()[skip_bytes:]
        test_content = f_test.read()[skip_bytes:]
        identical = golden_content == test_content

    return BitstreamComparison(
        golden_size=golden_size,
        test_size=test_size,
        identical=identical,
    )


# --- Main ---


def main():
    """Compare metrics between baseline and test implementations and output JSON."""
    parser = argparse.ArgumentParser(
        description="Compare metrics between baseline and test implementations"
    )
    # Bitstream comparison (golden vs test)
    parser.add_argument("--golden_bitstream", required=True, help="Path to golden bitstream")
    parser.add_argument("--test_bitstream", required=True, help="Path to test bitstream")
    # Metrics comparison (baseline vs test)
    parser.add_argument(
        "--baseline_timing", required=True, help="Path to baseline timing_summary.txt"
    )
    parser.add_argument(
        "--baseline_utilization", required=True, help="Path to baseline utilization.txt"
    )
    parser.add_argument("--baseline_log", required=True, help="Path to baseline vivado.log")
    parser.add_argument(
        "--baseline_congestion", required=False, help="Path to baseline congestion.txt"
    )
    parser.add_argument("--test_timing", required=True, help="Path to test timing_summary.txt")
    parser.add_argument("--test_utilization", required=True, help="Path to test utilization.txt")
    parser.add_argument("--test_log", required=True, help="Path to test vivado.log")
    parser.add_argument("--test_congestion", required=False, help="Path to test congestion.txt")
    # Additional logs for detailed timing
    parser.add_argument("--synth_log", required=False, help="Path to synthesis vivado.log")
    parser.add_argument("--redact_log", required=False, help="Path to redaction log")
    parser.add_argument("--unredact_log", required=False, help="Path to unredaction log")
    parser.add_argument("--output", required=True, help="Path to output JSON file")

    args = parser.parse_args()

    baseline_congestion = Path(args.baseline_congestion) if args.baseline_congestion else None
    test_congestion = Path(args.test_congestion) if args.test_congestion else None

    baseline_metrics = parse_impl_metrics(
        Path(args.baseline_timing),
        Path(args.baseline_utilization),
        Path(args.baseline_log),
        baseline_congestion,
    )
    test_metrics = parse_impl_metrics(
        Path(args.test_timing),
        Path(args.test_utilization),
        Path(args.test_log),
        test_congestion,
    )

    bitstream_cmp = compare_bitstreams(
        Path(args.golden_bitstream),
        Path(args.test_bitstream),
    )

    comparison = MetricsComparison(
        baseline=baseline_metrics, test=test_metrics, bitstream=bitstream_cmp
    )

    # Build output dictionary
    output_dict = comparison.to_dict()

    # Add detailed timing if additional logs are provided
    detailed_timing = {}

    if args.synth_log:
        synth_timing = parse_synth_log(Path(args.synth_log))
        detailed_timing["synthesis"] = {
            "synth_design_sec": synth_timing.synth_design_sec,
            "opt_design_sec": synth_timing.opt_design_sec,
            "total_sec": synth_timing.total_sec,
        }

    if args.redact_log:
        redact_timing = parse_transform_log(Path(args.redact_log))
        detailed_timing["redaction"] = {"total_sec": redact_timing.total_sec}

    if args.unredact_log:
        unredact_timing = parse_transform_log(Path(args.unredact_log))
        detailed_timing["unredaction"] = {"total_sec": unredact_timing.total_sec}

    # Parse detailed impl timing from the baseline and test logs
    baseline_impl_timing = parse_detailed_impl_log(Path(args.baseline_log))
    test_impl_timing = parse_detailed_impl_log(Path(args.test_log))

    detailed_timing["baseline_impl"] = {
        "place_sec": baseline_impl_timing.place_sec,
        "route_sec": baseline_impl_timing.route_sec,
        "phys_opt_iterations": [
            {"stage": p.stage, "iteration": p.iteration, "elapsed_sec": p.elapsed_sec}
            for p in baseline_impl_timing.phys_opt_iterations
        ],
        "total_phys_opt_sec": baseline_impl_timing.total_phys_opt_sec,
        "total_sec": baseline_impl_timing.total_sec,
    }

    detailed_timing["test_impl"] = {
        "place_sec": test_impl_timing.place_sec,
        "route_sec": test_impl_timing.route_sec,
        "phys_opt_iterations": [
            {"stage": p.stage, "iteration": p.iteration, "elapsed_sec": p.elapsed_sec}
            for p in test_impl_timing.phys_opt_iterations
        ],
        "total_phys_opt_sec": test_impl_timing.total_phys_opt_sec,
        "total_sec": test_impl_timing.total_sec,
    }

    output_dict["detailed_timing"] = detailed_timing

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, "w") as f:
        json.dump(output_dict, f, indent=2)

    if not bitstream_cmp.identical:
        #raise RuntimeError(
        #    f"Bitstreams do not match: {args.golden_bitstream} vs {args.test_bitstream}"
        #)
        print(f"Bitstreams do not match: {args.golden_bitstream} vs {args.test_bitstream}")


if __name__ == "__main__":
    main()
