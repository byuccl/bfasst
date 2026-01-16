#!/usr/bin/env python3
"""
Summarize metrics from all designs in the build directory.

Reads metrics_comparison.json files and creates a comprehensive summary
with per-design metrics and aggregate statistics.

Usage:
    python summarize_metrics.py [--build-dir BUILD_PATH] [--output OUTPUT_PATH]
"""

import argparse
import json
import math
import sys
from dataclasses import dataclass, field
from pathlib import Path
from statistics import mean, median, stdev
from typing import Any, Dict, List, Optional


@dataclass
class DesignSummary:
    """Summary of metrics for a single design."""

    collection: str
    design: str
    metrics: Dict[str, Any] = field(default_factory=dict)


def find_metrics_files(build_dir: Path) -> List[tuple]:
    """Find all metrics_comparison.json files in build directory.

    Returns list of (collection, design, path) tuples.
    """
    results = []
    for metrics_file in build_dir.rglob("metricscmp/metrics_comparison.json"):
        design_dir = metrics_file.parent.parent
        collection_dir = design_dir.parent

        if collection_dir.parent == build_dir:
            results.append((collection_dir.name, design_dir.name, metrics_file))

    return sorted(results)


def load_design_metrics(collection: str, design: str, metrics_path: Path) -> DesignSummary:
    """Load metrics from a single design's metrics_comparison.json."""
    summary = DesignSummary(collection=collection, design=design)

    try:
        with open(metrics_path, encoding="utf-8") as f:
            data = json.load(f)
        summary.metrics = data
    except (json.JSONDecodeError, OSError) as e:
        print(f"Warning: Could not load {metrics_path}: {e}")

    return summary


def safe_stats(values: List[float]) -> Dict[str, float]:
    """Compute statistics safely handling empty/small lists."""
    filtered = [v for v in values if v is not None and not math.isinf(v) and not math.isnan(v)]
    if not filtered:
        return {"mean": 0.0, "median": 0.0, "min": 0.0, "max": 0.0, "stdev": 0.0, "count": 0}

    result = {
        "mean": round(mean(filtered), 4),
        "median": round(median(filtered), 4),
        "min": round(min(filtered), 4),
        "max": round(max(filtered), 4),
        "count": len(filtered),
    }
    result["stdev"] = round(stdev(filtered), 4) if len(filtered) > 1 else 0.0
    return result


def extract_nested_value(data: Dict, *keys) -> Optional[float]:
    """Safely extract a nested value from a dictionary."""
    current = data
    for key in keys:
        if not isinstance(current, dict) or key not in current:
            return None
        current = current[key]
    return current if isinstance(current, (int, float)) else None


def _compute_metric_stats(
    summaries: List[DesignSummary], category: str, metrics: List[str], include_delta: bool = True
) -> Dict[str, Any]:
    """Compute stats for a list of metrics in a category."""
    stats = {}
    for metric in metrics:
        baseline_vals = [
            extract_nested_value(s.metrics, category, metric, "baseline") for s in summaries
        ]
        test_vals = [extract_nested_value(s.metrics, category, metric, "test") for s in summaries]

        if any(v is not None for v in baseline_vals):
            stats[f"{category}_{metric}_baseline"] = safe_stats(baseline_vals)
            stats[f"{category}_{metric}_test"] = safe_stats(test_vals)
            if include_delta:
                delta_vals = [
                    extract_nested_value(s.metrics, category, metric, "delta") for s in summaries
                ]
                stats[f"{category}_{metric}_delta"] = safe_stats(delta_vals)
    return stats


def _compute_detailed_timing_stats(summaries: List[DesignSummary]) -> Dict[str, Any]:
    """Compute detailed timing statistics."""
    stats = {}

    # Synthesis timing
    synth_design_vals = [
        extract_nested_value(s.metrics, "detailed_timing", "synthesis", "synth_design_sec")
        for s in summaries
    ]
    if any(v is not None for v in synth_design_vals):
        opt_design_vals = [
            extract_nested_value(s.metrics, "detailed_timing", "synthesis", "opt_design_sec")
            for s in summaries
        ]
        stats["detailed_timing_synth_design_sec"] = safe_stats(synth_design_vals)
        stats["detailed_timing_opt_design_sec"] = safe_stats(opt_design_vals)

    # Redaction/unredaction timing
    redact_vals = [
        extract_nested_value(s.metrics, "detailed_timing", "redaction", "total_sec")
        for s in summaries
    ]
    if any(v is not None for v in redact_vals):
        unredact_vals = [
            extract_nested_value(s.metrics, "detailed_timing", "unredaction", "total_sec")
            for s in summaries
        ]
        stats["detailed_timing_redaction_sec"] = safe_stats(redact_vals)
        stats["detailed_timing_unredaction_sec"] = safe_stats(unredact_vals)

    # Implementation timing
    for impl_type in ["baseline_impl", "test_impl"]:
        place_vals = [
            extract_nested_value(s.metrics, "detailed_timing", impl_type, "place_sec")
            for s in summaries
        ]
        if any(v is not None for v in place_vals):
            for field_name in ["place_sec", "route_sec", "total_phys_opt_sec", "total_sec"]:
                field_vals = [
                    extract_nested_value(s.metrics, "detailed_timing", impl_type, field_name)
                    for s in summaries
                ]
                stats[f"detailed_timing_{impl_type}_{field_name}"] = safe_stats(field_vals)

    return stats


def compute_aggregate_stats(summaries: List[DesignSummary]) -> Dict[str, Any]:
    """Compute aggregate statistics across all designs."""
    stats = {}

    # Timing metrics
    timing_metrics = ["wns", "tns", "whs", "ths", "clock_period_ns", "fmax_mhz"]
    stats.update(_compute_metric_stats(summaries, "timing", timing_metrics))

    # Resource metrics
    resource_metrics = ["lut", "ff", "bram36", "bram18", "dsp"]
    stats.update(_compute_metric_stats(summaries, "resources", resource_metrics))

    # Congestion metrics
    congestion_metrics = ["max_level", "north_global", "south_global", "east_global", "west_global"]
    congestion_stats = _compute_metric_stats(
        summaries, "congestion", congestion_metrics, include_delta=False
    )
    stats.update(congestion_stats)

    # Detailed timing
    stats.update(_compute_detailed_timing_stats(summaries))

    return stats


def create_summary_report(summaries: List[DesignSummary], aggregate: Dict[str, Any]) -> Dict:
    """Create the final summary report."""
    report = {
        "summary": {
            "total_designs": len(summaries),
            "collections": list(set(s.collection for s in summaries)),
        },
        "aggregate_statistics": aggregate,
        "designs": [],
    }

    for s in summaries:
        design_entry = {
            "collection": s.collection,
            "design": s.design,
        }

        # Extract key metrics for the per-design summary
        m = s.metrics

        # Timing
        if "timing" in m:
            design_entry["timing"] = {
                "wns_baseline": extract_nested_value(m, "timing", "wns", "baseline"),
                "wns_test": extract_nested_value(m, "timing", "wns", "test"),
                "wns_delta": extract_nested_value(m, "timing", "wns", "delta"),
                "fmax_baseline_mhz": extract_nested_value(m, "timing", "fmax_mhz", "baseline"),
                "fmax_test_mhz": extract_nested_value(m, "timing", "fmax_mhz", "test"),
                "fmax_delta_mhz": extract_nested_value(m, "timing", "fmax_mhz", "delta"),
            }

        # Resources
        if "resources" in m:
            design_entry["resources"] = {
                "lut_baseline": extract_nested_value(m, "resources", "lut", "baseline"),
                "lut_test": extract_nested_value(m, "resources", "lut", "test"),
                "lut_delta": extract_nested_value(m, "resources", "lut", "delta"),
                "ff_baseline": extract_nested_value(m, "resources", "ff", "baseline"),
                "ff_test": extract_nested_value(m, "resources", "ff", "test"),
                "ff_delta": extract_nested_value(m, "resources", "ff", "delta"),
            }

        # Congestion
        if "congestion" in m:
            design_entry["congestion"] = {
                "max_level_baseline": extract_nested_value(
                    m, "congestion", "max_level", "baseline"
                ),
                "max_level_test": extract_nested_value(m, "congestion", "max_level", "test"),
            }

        # Bitstream
        if "bitstream" in m:
            design_entry["bitstream"] = {
                "identical": extract_nested_value(m, "bitstream", "identical"),
                "golden_size": extract_nested_value(m, "bitstream", "golden_size"),
                "test_size": extract_nested_value(m, "bitstream", "test_size"),
            }

        # Detailed timing
        if "detailed_timing" in m:
            dt = m["detailed_timing"]
            design_entry["detailed_timing"] = {}

            if "synthesis" in dt:
                design_entry["detailed_timing"]["synthesis"] = dt["synthesis"]

            if "redaction" in dt:
                design_entry["detailed_timing"]["redaction_sec"] = dt["redaction"].get("total_sec")

            if "unredaction" in dt:
                design_entry["detailed_timing"]["unredaction_sec"] = dt["unredaction"].get(
                    "total_sec"
                )

            if "baseline_impl" in dt:
                bi = dt["baseline_impl"]
                design_entry["detailed_timing"]["baseline_impl"] = {
                    "place_sec": bi.get("place_sec"),
                    "route_sec": bi.get("route_sec"),
                    "total_phys_opt_sec": bi.get("total_phys_opt_sec"),
                    "total_sec": bi.get("total_sec"),
                    "phys_opt_count": len(bi.get("phys_opt_iterations", [])),
                }

            if "test_impl" in dt:
                ti = dt["test_impl"]
                design_entry["detailed_timing"]["test_impl"] = {
                    "place_sec": ti.get("place_sec"),
                    "route_sec": ti.get("route_sec"),
                    "total_phys_opt_sec": ti.get("total_phys_opt_sec"),
                    "total_sec": ti.get("total_sec"),
                    "phys_opt_count": len(ti.get("phys_opt_iterations", [])),
                }

        report["designs"].append(design_entry)

    return report


def main():
    """Entry point for the summarize_metrics script."""
    parser = argparse.ArgumentParser(description="Summarize metrics from all designs in build dir")
    parser.add_argument(
        "--build-dir",
        type=Path,
        default=Path("build"),
        help="Path to build directory (default: build)",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Output JSON file path (default: stdout)",
    )

    args = parser.parse_args()

    if not args.build_dir.exists():
        print(f"Error: Build directory {args.build_dir} does not exist")
        return 1

    # Find all metrics files
    metrics_files = find_metrics_files(args.build_dir)
    if not metrics_files:
        print(f"No metrics_comparison.json files found in {args.build_dir}")
        return 1

    print(f"Found {len(metrics_files)} design(s) with metrics", file=sys.stderr)

    # Load all metrics
    summaries = []
    for collection, design, path in metrics_files:
        summary = load_design_metrics(collection, design, path)
        summaries.append(summary)

    # Compute aggregate statistics
    aggregate = compute_aggregate_stats(summaries)

    # Create final report
    report = create_summary_report(summaries, aggregate)

    # Output
    output_json = json.dumps(report, indent=2)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(output_json)
        print(f"Summary written to {args.output}", file=sys.stderr)
    else:
        print(output_json)

    return 0


if __name__ == "__main__":
    sys.exit(main())
