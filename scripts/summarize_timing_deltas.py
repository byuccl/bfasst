import pandas as pd
import re
import math

CSV_PATH = "timing_delta_summary.csv"

# canonical timing metrics
CANON_METRICS = {
    "tns": ("overall_tns", r"\.tns$"),
    "tns_endpoints": ("overall_tns_endpoints", r"\.tns_endpoints$"),
    "tns_fail": ("overall_tns_fail", r"\.tns_fail$"),
    "wns": ("overall_wns", r"\.wns$"),
    "tpws": ("overall_tpws", r"\.tpws$"),
    "wpws": ("overall_wpws", r"\.wpws$"),
}

def pct_change(g, t):
    if g == 0:
        return 0.0 if t == 0 else math.copysign(math.inf, t)
    return (t - g) / abs(g) * 100.0

def load_and_extract_avg(csv_path):
    df = pd.read_csv(csv_path)
    df["design"] = df["design"].str.strip()
    df["metric"] = df["metric"].str.strip()

    summary = {}
    for key, (exact_name, fallback_pattern) in CANON_METRICS.items():
        rows = df[df["metric"] == exact_name]
        if rows.empty:
            rows = df[df["metric"].str.contains(fallback_pattern)]

        if not rows.empty:
            pct_changes = []
            for _, row in rows.iterrows():
                g, t = row["golden"], row["test"]
                pct = pct_change(g, t)
                if math.isfinite(pct):
                    pct_changes.append(pct)
            if pct_changes:
                summary[key] = sum(pct_changes) / len(pct_changes)
            else:
                summary[key] = float("nan")
        else:
            summary[key] = float("nan")
    return summary

summary = load_and_extract_avg(CSV_PATH)

# print nicely
print("Average percent change by metric:\n")
for k, v in summary.items():
    print(f"{k.upper():<15}: {v:.2f}%")

import matplotlib.pyplot as plt

labels = list(summary.keys())
values = [summary[k] for k in labels]

plt.figure(figsize=(8, 4))
plt.bar(labels, values, color='steelblue')
plt.axhline(0, linestyle='--', color='gray')
plt.title("Average Percent Change in Timing Metrics")
plt.ylabel("Percent Change (%)")
plt.tight_layout()
plt.savefig("avg_percent_change.png")
plt.show()
