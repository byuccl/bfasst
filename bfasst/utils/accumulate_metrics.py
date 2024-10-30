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
    parser = argparse.ArgumentParser(description="Compute metrics on a graph.")
    parser.add_argument(
        "analysis_dir", help="The path to the folder containing all analysis files for all graphs."
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable debug logging.")
    parser.add_argument("-o", help="The name of the output file to create")
    args = parser.parse_args()

    # Logging (for debug, don't use in parallel)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )

    # Initialize the master dictionary
    master_metrics = {}

    # Iterate through the files in the analysis directory
    for file in Path(args.analysis_dir).iterdir():
        if file.is_dir():
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

    # sort the values for each metric after merging
    for ip in master_metrics:
        for metric in master_metrics[ip]:
            master_metrics[ip][metric] = sorted(master_metrics[ip][metric])

    # Compute the stats for each metric
    stats_summary = {}
    for ip, metrics in master_metrics.items():
        for metric, values in metrics.items():
            # Calculate statistics
            if values:  # Check if the list is not empty
                min_val, Q1, median, Q3, max_val = five_number_summary(values)
                mean = sum(values) / len(values)
                stddev = statistics.stdev(values) if len(values) > 1 else 0.0

                # Prepare the summary dictionary
                if ip not in stats_summary:
                    stats_summary[ip] = {}

                stats_summary[ip][metric] = {
                    "min": min_val,
                    "Q1": Q1,
                    "median": median,
                    "Q3": Q3,
                    "max": max_val,
                    "mean": mean,
                    "stddev": stddev,
                }

    for k, v in master_metrics.items():
        logger.debug(k + ": " + str(v))

    for k, v in stats_summary.items():
        logger.debug(k + ": " + str(v))


def five_number_summary(data):
    n = len(data)
    min_val = data[0]
    max_val = data[-1]
    Q1 = data[n // 4]
    median = data[n // 2]
    Q3 = data[(3 * n) // 4]
    return min_val, Q1, median, Q3, max_val


if __name__ == "__main__":
    main()
