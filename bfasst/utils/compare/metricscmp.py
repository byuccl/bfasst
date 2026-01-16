#!/usr/bin/env python3
"""Command-line script for comparing metrics between implementations."""

from __future__ import annotations

import argparse
import filecmp
import json
import re
from dataclasses import dataclass
from pathlib import Path


# --- Data Types ---


@dataclass
class TimingMetrics:
    """Timing metrics from Vivado timing_summary report."""

    wns: float  # Worst Negative Slack (ns)
    tns: float  # Total Negative Slack (ns)
    whs: float  # Worst Hold Slack (ns)
    ths: float  # Total Hold Slack (ns)
    failing_endpoints: int  # TNS Failing Endpoints


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
class ImplMetrics:
    """Combined metrics for an implementation."""

    timing: TimingMetrics
    resources: ResourceMetrics
    compilation: CompilationMetrics


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
    bitstream: BitstreamComparison | None = None

    def to_dict(self) -> dict:
        """Convert comparison to dictionary for JSON output."""
        return {
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


# --- Parsers ---


def parse_timing_summary(path: Path) -> TimingMetrics:
    """Parse timing metrics from Vivado timing_summary.txt."""
    content = path.read_text()

    section_match = re.search(r"Design Timing Summary", content)
    if not section_match:
        return TimingMetrics(wns=0.0, tns=0.0, whs=0.0, ths=0.0, failing_endpoints=0)

    remaining = content[section_match.end() :]
    pattern = r"^\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+\d+\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)"
    match = re.search(pattern, remaining, re.MULTILINE)

    if match:
        return TimingMetrics(
            wns=float(match.group(1)),
            tns=float(match.group(2)),
            whs=float(match.group(4)),
            ths=float(match.group(5)),
            failing_endpoints=int(match.group(3)),
        )

    return TimingMetrics(wns=0.0, tns=0.0, whs=0.0, ths=0.0, failing_endpoints=0)


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


def parse_impl_metrics(timing_path: Path, utilization_path: Path, log_path: Path) -> ImplMetrics:
    """Parse all metrics for an implementation from its output files."""
    return ImplMetrics(
        timing=parse_timing_summary(timing_path),
        resources=parse_utilization(utilization_path),
        compilation=parse_vivado_log(log_path),
    )


def compare_bitstreams(
    golden_path: Path, test_path: Path, skip_bytes: int = 50
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
    parser.add_argument("--test_timing", required=True, help="Path to test timing_summary.txt")
    parser.add_argument("--test_utilization", required=True, help="Path to test utilization.txt")
    parser.add_argument("--test_log", required=True, help="Path to test vivado.log")
    parser.add_argument("--output", required=True, help="Path to output JSON file")

    args = parser.parse_args()

    baseline_metrics = parse_impl_metrics(
        Path(args.baseline_timing),
        Path(args.baseline_utilization),
        Path(args.baseline_log),
    )
    test_metrics = parse_impl_metrics(
        Path(args.test_timing),
        Path(args.test_utilization),
        Path(args.test_log),
    )

    bitstream_cmp = compare_bitstreams(
        Path(args.golden_bitstream),
        Path(args.test_bitstream),
    )

    comparison = MetricsComparison(
        baseline=baseline_metrics, test=test_metrics, bitstream=bitstream_cmp
    )

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, "w") as f:
        json.dump(comparison.to_dict(), f, indent=2)

    if not bitstream_cmp.identical:
        raise RuntimeError(
            f"Bitstreams do not match: {args.golden_bitstream} vs {args.test_bitstream}"
        )


if __name__ == "__main__":
    main()
