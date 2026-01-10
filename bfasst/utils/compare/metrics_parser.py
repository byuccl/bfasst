"""Parsers for Vivado output files to extract metrics."""

import re
from pathlib import Path

from bfasst.utils.compare.metrics_data_types import (
    TimingMetrics,
    ResourceMetrics,
    CompilationMetrics,
    ImplMetrics,
)


def parse_timing_summary(path: Path) -> TimingMetrics:
    """Parse timing metrics from Vivado timing_summary.txt.

    Looks for the Design Timing Summary table and extracts WNS, TNS, WHS, THS values.
    """
    content = path.read_text()

    # Find the Design Timing Summary section with the data row
    # Format:     WNS(ns)      TNS(ns)  TNS Failing Endpoints  ...
    #             -------      -------  ---------------------  ...
    #               6.390        0.000                      0  ...

    # Look for the data line after "Design Timing Summary"
    pattern = (
        r"Design Timing Summary.*?-{5,}.*?-{5,}.*?\n\s+"
        r"([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+\d+\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)"
    )
    match = re.search(pattern, content, re.DOTALL)

    if match:
        wns = float(match.group(1))
        tns = float(match.group(2))
        tns_failing = int(match.group(3))
        whs = float(match.group(4))
        ths = float(match.group(5))
        return TimingMetrics(
            wns=wns,
            tns=tns,
            whs=whs,
            ths=ths,
            failing_endpoints=tns_failing,
        )

    # Default values if parsing fails
    return TimingMetrics(wns=0.0, tns=0.0, whs=0.0, ths=0.0, failing_endpoints=0)


def parse_utilization(path: Path) -> ResourceMetrics:
    """Parse resource utilization from Vivado utilization.txt.

    Parses the hierarchical utilization table to extract LUT, FF, BRAM, DSP counts.
    """
    content = path.read_text()

    # Look for the table header and data row
    # Format: | Instance | Module | Total LUTs | Logic LUTs | LUTRAMs | SRLs |
    #         | FFs | RAMB36 | RAMB18 | DSP Blocks |
    # Table rows are separated by | and values are in columns

    lut_used = 0
    ff_used = 0
    bram36_used = 0
    bram18_used = 0
    dsp_used = 0

    # Find the (top) row which has the total values
    # Format: | counters | (top) | 9 | 9 | 0 | 0 | 16 | 0 | 0 | 0 |
    pattern = (
        r"\|\s*\S+\s*\|\s*\(top\)\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*\d+\s*\|"
        r"\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|"
    )
    match = re.search(pattern, content)

    if match:
        lut_used = int(match.group(1))  # Total LUTs
        ff_used = int(match.group(2))  # FFs
        bram36_used = int(match.group(3))  # RAMB36
        bram18_used = int(match.group(4))  # RAMB18
        dsp_used = int(match.group(5))  # DSP Blocks

    return ResourceMetrics(
        lut_used=lut_used,
        ff_used=ff_used,
        bram36_used=bram36_used,
        bram18_used=bram18_used,
        dsp_used=dsp_used,
    )


def _parse_time_to_seconds(time_str: str) -> float:
    """Parse Vivado time string to seconds.

    Handles formats like:
    - "00:00:44"
    - "00:01:26"
    """
    parts = time_str.split(":")
    if len(parts) == 3:
        hours = int(parts[0])
        minutes = int(parts[1])
        seconds = float(parts[2])
        return hours * 3600 + minutes * 60 + seconds
    return 0.0


def parse_vivado_log(path: Path) -> CompilationMetrics:
    """Parse compilation times from vivado.log.

    Extracts place_design and route_design elapsed times.
    """
    content = path.read_text()

    place_time = 0.0
    route_time = 0.0

    # Look for place_design time
    # Format: place_design: Time (s): cpu = 00:00:44 ; elapsed = 00:00:47
    place_match = re.search(r"place_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if place_match:
        place_time = _parse_time_to_seconds(place_match.group(1))

    # Look for route_design time
    # Format: route_design: Time (s): cpu = 00:00:59 ; elapsed = 00:01:26
    route_match = re.search(r"route_design: Time \(s\):.*?elapsed = ([\d:]+)", content)
    if route_match:
        route_time = _parse_time_to_seconds(route_match.group(1))

    total_time = place_time + route_time

    return CompilationMetrics(
        place_time_sec=place_time,
        route_time_sec=route_time,
        total_time_sec=total_time,
    )


def parse_impl_metrics(
    timing_path: Path,
    utilization_path: Path,
    log_path: Path,
) -> ImplMetrics:
    """Parse all metrics for an implementation from its output files."""
    return ImplMetrics(
        timing=parse_timing_summary(timing_path),
        resources=parse_utilization(utilization_path),
        compilation=parse_vivado_log(log_path),
    )
