#!/usr/bin/env python3
"""Command-line script for comparing metrics between implementations."""

import argparse
import json
from pathlib import Path

from bfasst.utils.compare.metrics_parser import parse_impl_metrics
from bfasst.utils.compare.metrics_data_types import MetricsComparison


def main():
    """Compare metrics between golden and test implementations and output JSON."""
    parser = argparse.ArgumentParser(
        description="Compare metrics between golden and test implementations"
    )
    parser.add_argument("--golden_timing", required=True, help="Path to golden timing_summary.txt")
    parser.add_argument(
        "--golden_utilization", required=True, help="Path to golden utilization.txt"
    )
    parser.add_argument("--golden_log", required=True, help="Path to golden vivado.log")
    parser.add_argument("--test_timing", required=True, help="Path to test timing_summary.txt")
    parser.add_argument("--test_utilization", required=True, help="Path to test utilization.txt")
    parser.add_argument("--test_log", required=True, help="Path to test vivado.log")
    parser.add_argument("--output", required=True, help="Path to output JSON file")

    args = parser.parse_args()

    # Parse metrics for both implementations
    golden_metrics = parse_impl_metrics(
        Path(args.golden_timing),
        Path(args.golden_utilization),
        Path(args.golden_log),
    )
    test_metrics = parse_impl_metrics(
        Path(args.test_timing),
        Path(args.test_utilization),
        Path(args.test_log),
    )

    # Create comparison and output to JSON
    comparison = MetricsComparison(golden=golden_metrics, test=test_metrics)

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, "w") as f:
        json.dump(comparison.to_dict(), f, indent=2)

    print(f"Metrics comparison written to {output_path}")


if __name__ == "__main__":
    main()
