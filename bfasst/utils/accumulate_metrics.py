"""Accumulate metrics from graphs in a dataset after computing them for all graphs"""

import argparse
import logging
import json
from pathlib import Path
import statistics

logger = logging.getLogger(__name__)


def main():
    """Load the graph, convert to adj_list, and compute metrics."""
    # ArgParse
    args = get_args()

    # Logging (for debug, don't use in parallel)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )

    # Initialize the master dictionary
    master_metrics_output = args.m if args.m else "master_metrics.log"
    stats_summary_output = args.s if args.s else "summary_statistics.log"

    # Iterate through the files in the analysis directory
    master_metrics = compute_master_metrics(
        args.analysis_dir, master_metrics_output, stats_summary_output
    )

    # sort the values for each metric after merging
    master_metrics = sort_metrics(master_metrics)

    # Compute the stats for each metric
    stats_summary = get_stats_summary(master_metrics)

    # write master_metrics to a file
    with open(master_metrics_output, "w") as f:
        f.write(json.dumps(master_metrics, indent=4))

    with open(stats_summary_output, "w") as f:
        f.write(json.dumps(stats_summary, indent=4))


def get_args():
    """Get the command line arguments."""
    parser = argparse.ArgumentParser(description="Compute metrics on a graph.")
    parser.add_argument(
        "analysis_dir", help="The path to the folder containing all analysis files for all graphs."
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable debug logging.")
    parser.add_argument("-m", help="The name of the metrics file to create")
    parser.add_argument(
        "-s", help="The name of the stats (5-num summary, mean, stddev) file to create"
    )
    return parser.parse_args()


def compute_master_metrics(analysis_dir, master_metrics_output, stats_summary_output):
    """Compute the master metrics from the analysis directory."""
    master_metrics = {}
    for file in Path(analysis_dir).iterdir():
        if file.is_dir():
            continue

        if file.name in (
            master_metrics_output,
            stats_summary_output,
            # Skip the master_metrics and stats_summary files
            # Even if the user has specified different names
            # for this run
            "master_metrics.log",
            "summary_statistics.log",
        ):
            continue

        with open(file, "r") as f:
            graph_metrics = json.loads(f.readline())

        for ip, metrics in graph_metrics.items():
            # Initialize the IP entry in the master dictionary if it doesn't exist
            if ip not in master_metrics:
                master_metrics[ip] = {}

            for metric, values in metrics.items():
                # Initialize the metric entry if it doesn't exist
                if metric not in master_metrics[ip]:
                    master_metrics[ip][metric] = []

                # Concatenate the lists
                master_metrics[ip][metric].extend(values)

    return master_metrics


def sort_metrics(metrics):
    """Sort the values for each metric in the dictionary."""
    for ip, _ in metrics.items():
        for metric in metrics[ip]:
            metrics[ip][metric] = sorted(metrics[ip][metric])
    return metrics


def get_stats_summary(master_metrics):
    """Compute the 5-number summary, mean, and standard deviation for each metric."""
    summary = {}
    for ip, metrics in master_metrics.items():
        for metric, values in metrics.items():
            # Calculate statistics
            if values:  # Check if the list is not empty
                min_val, first_quartile, median, third_quartile, max_val = five_number_summary(
                    values
                )
                mean = sum(values) / len(values)
                stddev = statistics.stdev(values) if len(values) > 1 else 0.0

                # Prepare the summary dictionary
                if ip not in summary:
                    summary[ip] = {}

                summary[ip][metric] = {
                    "min": min_val,
                    "Q1": first_quartile,
                    "median": median,
                    "Q3": third_quartile,
                    "max": max_val,
                    "mean": mean,
                    "stddev": stddev,
                }
    return summary


def five_number_summary(data):
    """Compute the 5-number summary for the given data."""
    n = len(data)
    min_val = data[0]
    max_val = data[-1]
    first_quartile = data[n // 4]
    median = data[n // 2]
    third_quartile = data[(3 * n) // 4]
    return min_val, first_quartile, median, third_quartile, max_val


if __name__ == "__main__":
    main()
