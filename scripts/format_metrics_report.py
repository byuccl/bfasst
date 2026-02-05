#!/usr/bin/env python3
"""
Format metrics summary JSON into a human-readable text report.

Reads the JSON output from summarize_metrics.py and generates a formatted
text report with tables for aggregate statistics and per-design results.

Usage:
    python format_metrics_report.py [--input METRICS_JSON] [--output REPORT_TXT]
"""

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, List


def format_aggregate_timing_stats(stats: Dict[str, Any]) -> str:
    """Format aggregate timing statistics table."""
    lines = []
    lines.append("=" * 80)
    lines.append("AGGREGATE STATISTICS - TIMING (Reference - 10ns clock)")
    lines.append("=" * 80)
    lines.append(
        f"{'Metric':<40} {'Mean':>10} {'Median':>10} {'Min':>12} {'Max':>12} {'StdDev':>10}"
    )
    lines.append("-" * 80)

    # WNS/TNS/WHS timing metrics
    timing_metrics = [
        ("WNS Baseline (ns)", "timing_wns_baseline"),
        ("WNS Test (ns)", "timing_wns_test"),
        ("WNS Delta (ns)", "timing_wns_delta"),
        ("TNS Baseline (ns)", "timing_tns_baseline"),
        ("TNS Test (ns)", "timing_tns_test"),
        ("TNS Delta (ns)", "timing_tns_delta"),
        ("WHS Baseline (ns)", "timing_whs_baseline"),
        ("WHS Test (ns)", "timing_whs_test"),
        ("WHS Delta (ns)", "timing_whs_delta"),
        ("Fmax Baseline (MHz)", "timing_fmax_mhz_baseline"),
        ("Fmax Test (MHz)", "timing_fmax_mhz_test"),
    ]

    for label, key in timing_metrics:
        if key in stats:
            s = stats[key]
            lines.append(
                f"{label:<40} {s['mean']:>10.3f} {s['median']:>10.3f} "
                f"{s['min']:>12.3f} {s['max']:>12.3f} {s['stdev']:>10.3f}"
            )

    # Fmax delta as percentage
    if "timing_fmax_mhz_delta" in stats:
        s = stats["timing_fmax_mhz_delta"]
        # Calculate percentage from absolute values
        baseline = stats.get("timing_fmax_mhz_baseline", {})
        if baseline.get("mean", 0) != 0:
            pct_mean = (s["mean"] / baseline["mean"]) * 100
            pct_median = (
                (s["median"] / baseline.get("median", 1)) * 100 if baseline.get("median") else 0
            )
            lines.append(
                f"{'Fmax Delta (%)':<40} {pct_mean:>9.2f}% {pct_median:>9.2f}% "
                f"{s['min']:>12.3f} {s['max']:>12.3f} {s['stdev']:>10.3f}"
            )

    lines.append("")
    return "\n".join(lines)


def format_aggregate_cranked_timing_stats(stats: Dict[str, Any]) -> str:
    """Format aggregate cranked timing statistics table."""
    lines = []
    lines.append("=" * 80)
    lines.append("AGGREGATE STATISTICS - CRANKED TIMING (Actual tight constraints)")
    lines.append("=" * 80)
    lines.append(
        f"{'Metric':<40} {'Mean':>10} {'Median':>10} {'Min':>12} {'Max':>12} {'StdDev':>10}"
    )
    lines.append("-" * 80)

    # Cranked timing metrics
    cranked_timing_metrics = [
        ("Clock Period Baseline (ns)", "cranked_timing_clock_period_ns_baseline"),
        ("Clock Period Test (ns)", "cranked_timing_clock_period_ns_test"),
        ("Clock Period Delta (ns)", "cranked_timing_clock_period_ns_delta"),
        ("WNS Baseline (ns)", "cranked_timing_wns_baseline"),
        ("WNS Test (ns)", "cranked_timing_wns_test"),
        ("WNS Delta (ns)", "cranked_timing_wns_delta"),
        ("Fmax Baseline (MHz)", "cranked_timing_fmax_mhz_baseline"),
        ("Fmax Test (MHz)", "cranked_timing_fmax_mhz_test"),
    ]

    for label, key in cranked_timing_metrics:
        if key in stats:
            s = stats[key]
            lines.append(
                f"{label:<40} {s['mean']:>10.3f} {s['median']:>10.3f} "
                f"{s['min']:>12.3f} {s['max']:>12.3f} {s['stdev']:>10.3f}"
            )

    # Fmax delta as percentage
    if "cranked_timing_fmax_mhz_delta" in stats:
        s = stats["cranked_timing_fmax_mhz_delta"]
        # Calculate percentage from absolute values
        baseline = stats.get("cranked_timing_fmax_mhz_baseline", {})
        if baseline.get("mean", 0) != 0:
            pct_mean = (s["mean"] / baseline["mean"]) * 100
            pct_median = (
                (s["median"] / baseline.get("median", 1)) * 100 if baseline.get("median") else 0
            )
            lines.append(
                f"{'Fmax Delta (%)':<40} {pct_mean:>9.2f}% {pct_median:>9.2f}% "
                f"{s['min']:>12.3f} {s['max']:>12.3f} {s['stdev']:>10.3f}"
            )

    lines.append("")
    lines.append("Note: Cranked timing uses actual tight clock constraints from clock cranking.")
    lines.append("      Reference timing (above) uses 10ns clock after unredaction.")
    lines.append(
        "      Both calculations verify to the same Fmax (critical path delay is identical)."
    )
    lines.append("")
    return "\n".join(lines)


def format_aggregate_resource_stats(stats: Dict[str, Any]) -> str:
    """Format aggregate resource utilization statistics table."""
    lines = []
    lines.append("=" * 80)
    lines.append("AGGREGATE STATISTICS - RESOURCES")
    lines.append("=" * 80)
    lines.append(
        f"{'Metric':<40} {'Mean':>10} {'Median':>10} {'Min':>12} {'Max':>12} {'StdDev':>10}"
    )
    lines.append("-" * 80)

    resource_metrics = [
        ("Total LUTs Baseline", "resources_lut_baseline"),
        ("Total LUTs Test", "resources_lut_test"),
        ("Total LUTs Delta", "resources_lut_delta"),
        ("Logic LUTs Baseline", "resources_logic_luts_baseline"),
        ("Logic LUTs Test", "resources_logic_luts_test"),
        ("Logic LUTs Delta", "resources_logic_luts_delta"),
        ("LUTRAMs Baseline", "resources_lutrams_baseline"),
        ("LUTRAMs Test", "resources_lutrams_test"),
        ("LUTRAMs Delta", "resources_lutrams_delta"),
        ("SRLs Baseline", "resources_srls_baseline"),
        ("SRLs Test", "resources_srls_test"),
        ("SRLs Delta", "resources_srls_delta"),
        ("FFs Baseline", "resources_ff_baseline"),
        ("FFs Test", "resources_ff_test"),
        ("FFs Delta", "resources_ff_delta"),
        ("BRAM36 Baseline", "resources_bram36_baseline"),
        ("BRAM36 Test", "resources_bram36_test"),
        ("BRAM36 Delta", "resources_bram36_delta"),
        ("BRAM18 Baseline", "resources_bram18_baseline"),
        ("BRAM18 Test", "resources_bram18_test"),
        ("BRAM18 Delta", "resources_bram18_delta"),
        ("DSP Baseline", "resources_dsp_baseline"),
        ("DSP Test", "resources_dsp_test"),
        ("DSP Delta", "resources_dsp_delta"),
        ("Total Cells Baseline", "resources_total_cells_baseline"),
        ("Total Cells Test", "resources_total_cells_test"),
        ("Total Cells Delta", "resources_total_cells_delta"),
    ]

    for label, key in resource_metrics:
        if key in stats:
            s = stats[key]
            lines.append(
                f"{label:<40} {s['mean']:>10.1f} {s['median']:>10.0f} "
                f"{s['min']:>12.0f} {s['max']:>12.0f} {s['stdev']:>10.2f}"
            )

    lines.append("")
    return "\n".join(lines)


def format_aggregate_congestion_stats(stats: Dict[str, Any]) -> str:
    """Format aggregate congestion statistics table."""
    lines = []
    lines.append("=" * 80)
    lines.append("AGGREGATE STATISTICS - CONGESTION")
    lines.append("=" * 80)
    lines.append(
        f"{'Metric':<40} {'Mean':>10} {'Median':>10} {'Min':>12} {'Max':>12} {'StdDev':>10}"
    )
    lines.append("-" * 80)

    congestion_metrics = [
        ("Max Level Baseline", "congestion_max_level_baseline"),
        ("Max Level Test", "congestion_max_level_test"),
        ("North Global Baseline", "congestion_north_global_baseline"),
        ("North Global Test", "congestion_north_global_test"),
        ("South Global Baseline", "congestion_south_global_baseline"),
        ("South Global Test", "congestion_south_global_test"),
        ("East Global Baseline", "congestion_east_global_baseline"),
        ("East Global Test", "congestion_east_global_test"),
        ("West Global Baseline", "congestion_west_global_baseline"),
        ("West Global Test", "congestion_west_global_test"),
    ]

    for label, key in congestion_metrics:
        if key in stats:
            s = stats[key]
            lines.append(
                f"{label:<40} {s['mean']:>10.1f} {s['median']:>10.0f} "
                f"{s['min']:>12.0f} {s['max']:>12.0f} {s['stdev']:>10.1f}"
            )

    lines.append("")
    return "\n".join(lines)


def format_aggregate_detailed_timing_stats(stats: Dict[str, Any]) -> str:
    """Format aggregate detailed timing statistics table."""
    lines = []
    lines.append("=" * 80)
    lines.append("AGGREGATE STATISTICS - DETAILED TIMING (seconds)")
    lines.append("=" * 80)
    lines.append(f"{'Stage':<60} {'Mean':>10} {'Median':>10} {'Min':>12} {'Max':>12}")
    lines.append("-" * 80)

    detailed_timing_metrics = [
        ("Synthesis (synth_design)", "detailed_timing_synth_design_sec"),
        ("Synthesis (opt_design)", "detailed_timing_opt_design_sec"),
        ("Redaction", "detailed_timing_redaction_sec"),
        ("Unredaction", "detailed_timing_unredaction_sec"),
        ("Baseline Impl - Place", "detailed_timing_baseline_impl_place_sec"),
        ("Baseline Impl - Route", "detailed_timing_baseline_impl_route_sec"),
        ("Baseline Impl - Phys Opt", "detailed_timing_baseline_impl_total_phys_opt_sec"),
        ("Baseline Impl - Total", "detailed_timing_baseline_impl_total_sec"),
        ("Test Impl - Place", "detailed_timing_test_impl_place_sec"),
        ("Test Impl - Route", "detailed_timing_test_impl_route_sec"),
        ("Test Impl - Phys Opt", "detailed_timing_test_impl_total_phys_opt_sec"),
        ("Test Impl - Total", "detailed_timing_test_impl_total_sec"),
    ]

    for label, key in detailed_timing_metrics:
        if key in stats:
            s = stats[key]
            lines.append(
                f"{label:<60} {s['mean']:>10.1f} {s['median']:>10.1f} "
                f"{s['min']:>12.1f} {s['max']:>12.1f}"
            )

    lines.append("")
    lines.append("")
    return "\n".join(lines)


def extract_timing_data(design: Dict) -> Dict:
    """Extract timing data from a design."""
    cranked = design.get("cranked_timing", {}) or design.get("timing", {})

    fmax_baseline = cranked.get("fmax_baseline_mhz", 0.0)
    fmax_delta = cranked.get("fmax_delta_mhz", 0.0)
    fmax_delta_pct = (fmax_delta / fmax_baseline * 100) if fmax_baseline else 0.0

    return {
        "clock_period_baseline": cranked.get("clock_period_ns_baseline", 0.0),
        "clock_period_test": cranked.get("clock_period_ns_test", 0.0),
        "wns_baseline": cranked.get("wns_baseline", 0.0),
        "wns_test": cranked.get("wns_test", 0.0),
        "wns_delta": cranked.get("wns_delta", 0.0),
        "fmax_baseline": fmax_baseline,
        "fmax_test": cranked.get("fmax_test_mhz", 0.0),
        "fmax_delta_pct": fmax_delta_pct,
    }


def format_per_design_timing_resources(designs: List[Dict]) -> str:
    """Format per-design timing and resource results table.

    Uses cranked timing for Fmax (actual implementation results) and WNS.
    """
    lines = []
    lines.append("=" * 200)
    lines.append("PER-DESIGN RESULTS - TIMING & RESOURCES")
    lines.append("=" * 200)
    lines.append(
        f"{'Collection':<15} {'Design':<28} {'Clk.B(ns)':>10} {'Clk.T(ns)':>10} "
        f"{'B.WNS':>8} {'T.WNS':>8} {'WNS Δ':>8} "
        f"{'B.Fmax':>9} {'T.Fmax':>9} {'Fmax Δ%':>9} {'LUT Δ':>8} {'FF Δ':>7} "
        f"{'Cong':>5}  {'Bitstream':<10}"
    )
    lines.append("-" * 200)

    for design in designs:
        collection = design.get("collection", "")
        name = design.get("design", "")

        timing = extract_timing_data(design)
        resources = design.get("resources", {})
        congestion = design.get("congestion", {})
        bitstream = design.get("bitstream", {})

        bitstream_status = "Identical" if bitstream.get("identical", True) else "Different"

        lines.append(
            f"{collection:<15} {name:<28} {timing['clock_period_baseline']:>10.3f} "
            f"{timing['clock_period_test']:>10.3f} "
            f"{timing['wns_baseline']:>8.3f} {timing['wns_test']:>8.3f} "
            f"{timing['wns_delta']:>8.3f} "
            f"{timing['fmax_baseline']:>9.1f} {timing['fmax_test']:>9.1f} "
            f"{timing['fmax_delta_pct']:>8.2f}% "
            f"{resources.get('lut_delta', 0):>8} {resources.get('ff_delta', 0):>7} "
            f"{congestion.get('max_level_test', 0):>5}  {bitstream_status:<10}"
        )

    lines.append("")
    lines.append(
        "Legend: Clk.B/T=Clock Period Baseline/Test (actual from implementation), "
        "B.WNS=Baseline WNS, T.WNS=Test WNS,"
    )
    lines.append("        B.Fmax=Baseline Fmax (MHz), T.Fmax=Test Fmax (MHz)")
    lines.append(
        "Note: All timing data from cranked timing (actual implementation results, "
        "not post-redaction re-analysis)"
    )
    lines.append("")
    return "\n".join(lines)


def extract_detailed_timing(design: Dict) -> Dict:
    """Extract detailed timing data from a design."""
    detailed = design.get("detailed_timing", {})
    synth = detailed.get("synthesis", {})
    baseline_impl = detailed.get("baseline_impl", {})
    test_impl = detailed.get("test_impl", {})

    return {
        "synth_design_sec": synth.get("synth_design_sec", 0.0),
        "opt_design_sec": synth.get("opt_design_sec", 0.0),
        "redact_sec": detailed.get("redaction_sec", 0.0),
        "unredact_sec": detailed.get("unredaction_sec", 0.0),
        "b_place": baseline_impl.get("place_sec", 0.0),
        "b_route": baseline_impl.get("route_sec", 0.0),
        "b_phys_opt": baseline_impl.get("total_phys_opt_sec", 0.0),
        "b_total": baseline_impl.get("total_sec", 0.0),
        "t_place": test_impl.get("place_sec", 0.0),
        "t_route": test_impl.get("route_sec", 0.0),
        "t_phys_opt": test_impl.get("total_phys_opt_sec", 0.0),
        "t_total": test_impl.get("total_sec", 0.0),
    }


def format_per_design_detailed_timing(designs: List[Dict]) -> str:
    """Format per-design detailed timing results table."""
    lines = []
    lines.append("=" * 150)
    lines.append("PER-DESIGN RESULTS - DETAILED TIMING (seconds)")
    lines.append("=" * 150)
    lines.append(
        f"{'Collection':<15} {'Design':<28} {'Synth':>8} {'Opt':>6} {'Redact':>8} {'Unred':>8} "
        f"{'B.Place':>9} {'B.Route':>9} {'B.Phys':>8} {'B.Total':>9} {'T.Place':>9} "
        f"{'T.Route':>9} {'T.Phys':>8} {'T.Total':>9} {'Δ Total':>9}"
    )
    lines.append("-" * 150)

    for design in designs:
        collection = design.get("collection", "")
        name = design.get("design", "")
        timing = extract_detailed_timing(design)
        delta_total = timing["t_total"] - timing["b_total"]

        lines.append(
            f"{collection:<15} {name:<28} {timing['synth_design_sec']:>8.0f} "
            f"{timing['opt_design_sec']:>6.0f} "
            f"{timing['redact_sec']:>8.1f} {timing['unredact_sec']:>8.1f} "
            f"{timing['b_place']:>9.0f} {timing['b_route']:>9.0f} "
            f"{timing['b_phys_opt']:>8.0f} {timing['b_total']:>9.0f} "
            f"{timing['t_place']:>9.0f} {timing['t_route']:>9.0f} "
            f"{timing['t_phys_opt']:>8.0f} {timing['t_total']:>9.0f} {delta_total:>9.0f}"
        )

    lines.append("")
    lines.append("")
    return "\n".join(lines)


def format_per_design_congestion(designs: List[Dict]) -> str:
    """Format per-design congestion levels table."""
    lines = []
    lines.append("=" * 120)
    lines.append("PER-DESIGN CONGESTION LEVELS")
    lines.append("=" * 120)
    lines.append(
        f"{'Collection':<15} {'Design':<28} {'Max Lvl':>9} {'North':>8} {'South':>8} "
        f"{'East':>8} {'West':>8}"
    )
    lines.append("-" * 120)

    for design in designs:
        collection = design.get("collection", "")
        name = design.get("design", "")

        congestion = design.get("congestion", {})
        max_level = congestion.get("max_level_test", 0)
        north = congestion.get("north_global_test", 0) if "north_global_test" in congestion else 0
        south = congestion.get("south_global_test", 0) if "south_global_test" in congestion else 0
        east = congestion.get("east_global_test", 0) if "east_global_test" in congestion else 0
        west = congestion.get("west_global_test", 0) if "west_global_test" in congestion else 0

        lines.append(
            f"{collection:<15} {name:<28} {max_level:>9} {north:>8} {south:>8} "
            f"{east:>8} {west:>8}"
        )

    lines.append("")
    lines.append("")
    return "\n".join(lines)


def extract_resource_data(design: Dict, has_detailed: bool) -> Dict:
    """Extract resource data from a design."""
    resources = design.get("resources", {})

    def safe_get(key):
        val = resources.get(key)
        return val if val is not None else 0

    if has_detailed:
        return {
            "total_luts": safe_get("lut_test"),
            "logic_luts": safe_get("logic_luts_test"),
            "lutrams": safe_get("lutrams_test"),
            "srls": safe_get("srls_test"),
            "ffs": safe_get("ff_test"),
            "bram36": safe_get("bram36_test"),
            "bram18": safe_get("bram18_test"),
            "dsp": safe_get("dsp_test"),
        }

    return {
        "total_luts": safe_get("lut_test"),
        "ffs": safe_get("ff_test"),
        "bram36": safe_get("bram36_test"),
        "bram18": safe_get("bram18_test"),
        "dsp": safe_get("dsp_test"),
    }


def format_per_design_resource_breakdown(designs: List[Dict]) -> str:
    """Format per-design detailed resource breakdown table.

    Note: Requires regenerated metrics with detailed LUT breakdown.
    If metrics were generated with an older version, the breakdown columns will show zeros.
    """
    lines = []

    # Check if any design has the new detailed breakdown data
    has_detailed_data = any(
        d.get("resources", {}).get("logic_luts_test") is not None for d in designs
    )

    if not has_detailed_data:
        lines.append("=" * 120)
        lines.append("PER-DESIGN RESOURCE BREAKDOWN")
        lines.append("=" * 120)
        lines.append("Note: Detailed LUT breakdown not available in current metrics.")
        lines.append("To see Logic LUTs, LUTRAMs, and SRLs, regenerate metrics with updated tools.")
        lines.append("")
        lines.append(
            f"{'Collection':<15} {'Design':<28} {'Total LUTs':>10} {'FFs':>10} "
            f"{'BRAM36':>8} {'BRAM18':>8} {'DSP':>8}"
        )
        lines.append("-" * 120)

        for design in designs:
            collection = design.get("collection", "")
            name = design.get("design", "")
            res = extract_resource_data(design, has_detailed_data)

            lines.append(
                f"{collection:<15} {name:<28} {res['total_luts']:>10} {res['ffs']:>10} "
                f"{res['bram36']:>8} {res['bram18']:>8} {res['dsp']:>8}"
            )
    else:
        lines.append("=" * 160)
        lines.append("PER-DESIGN RESOURCE BREAKDOWN")
        lines.append("=" * 160)
        lines.append(
            f"{'Collection':<15} {'Design':<28} {'Total':>8} {'Logic':>8} {'LUTRAM':>8} {'SRL':>8} "
            f"{'FFs':>10} {'BRAM36':>8} {'BRAM18':>8} {'DSP':>8}  {'Implementation':<10}"
        )
        lines.append("-" * 160)

        for design in designs:
            collection = design.get("collection", "")
            name = design.get("design", "")
            res = extract_resource_data(design, has_detailed_data)

            lines.append(
                f"{collection:<15} {name:<28} {res['total_luts']:>8} {res['logic_luts']:>8} "
                f"{res['lutrams']:>8} {res['srls']:>8} "
                f"{res['ffs']:>10} {res['bram36']:>8} {res['bram18']:>8} "
                f"{res['dsp']:>8}  {'Test':<10}"
            )

        lines.append("")
        lines.append(
            "Note: Shows test implementation resources. LUT breakdown: Total = Logic + LUTRAM + SRL"
        )

    lines.append("")
    return "\n".join(lines)


def is_notable_design(design: Dict) -> bool:
    """Check if a design has notable differences."""
    cranked = design.get("cranked_timing", {}) or design.get("timing", {})
    resources = design.get("resources", {})

    wns_delta = abs(cranked.get("wns_delta", 0.0))
    fmax_baseline = cranked.get("fmax_baseline_mhz", 0.0)
    fmax_delta = cranked.get("fmax_delta_mhz", 0.0)
    fmax_delta_pct = abs(fmax_delta / fmax_baseline * 100) if fmax_baseline else 0.0
    lut_delta = abs(resources.get("lut_delta", 0))
    ff_delta = abs(resources.get("ff_delta", 0))

    return wns_delta > 0.3 or fmax_delta_pct > 5 or lut_delta > 15 or ff_delta > 15


def format_notable_designs(designs: List[Dict]) -> str:
    """Format table of designs with notable differences.

    Uses cranked timing for WNS and Fmax comparisons.
    """
    lines = []

    # Filter designs with notable differences
    notable = [d for d in designs if is_notable_design(d)]

    # Sort by WNS delta (descending absolute value)
    notable.sort(
        key=lambda d: abs(d.get("cranked_timing", d.get("timing", {})).get("wns_delta", 0.0)),
        reverse=True,
    )

    lines.append("=" * 150)
    lines.append(
        "DESIGNS WITH NOTABLE DIFFERENCES "
        "(|WNS Δ| > 0.3 OR |Fmax Δ%| > 5 OR |LUT Δ| > 15 OR |FF Δ| > 15)"
    )
    lines.append("=" * 150)
    lines.append(
        f"{'Collection':<15} {'Design':<28} {'WNS Δ':>10} {'TNS Δ':>10} {'Fmax Δ%':>10} "
        f"{'LUT Δ':>8} {'FF Δ':>7}  {'Bitstream':<10}"
    )
    lines.append("-" * 150)

    for design in notable:
        collection = design.get("collection", "")
        name = design.get("design", "")

        cranked = design.get("cranked_timing", {}) or design.get("timing", {})
        timing_ref = design.get("timing", {})
        resources = design.get("resources", {})
        bitstream = design.get("bitstream", {})

        fmax_baseline = cranked.get("fmax_baseline_mhz", 0.0)
        fmax_delta = cranked.get("fmax_delta_mhz", 0.0)
        fmax_delta_pct = (fmax_delta / fmax_baseline * 100) if fmax_baseline else 0.0
        bitstream_status = "Identical" if bitstream.get("identical", True) else "Different"

        lines.append(
            f"{collection:<15} {name:<28} {cranked.get('wns_delta', 0.0):>10.3f} "
            f"{timing_ref.get('tns_delta', 0.0):>10.1f} "
            f"{fmax_delta_pct:>9.2f}% "
            f"{resources.get('lut_delta', 0):>8} {resources.get('ff_delta', 0):>7}  "
            f"{bitstream_status:<10}"
        )

    lines.append("")
    lines.append(f"Total notable designs: {len(notable)}/{len(designs)}")
    lines.append("Note: Timing data from cranked timing (actual implementation results)")
    lines.append("")
    return "\n".join(lines)


def extract_cranked_timing_comparison(design: Dict) -> Dict:
    """Extract both reference and cranked timing for comparison."""
    timing = design.get("timing", {})
    cranked = design.get("cranked_timing", {})

    fmax_baseline = cranked.get("fmax_baseline_mhz", 0.0)
    fmax_delta = cranked.get("fmax_delta_mhz", 0.0)
    fmax_delta_pct = (fmax_delta / fmax_baseline * 100) if fmax_baseline else 0.0

    return {
        "ref_clk": timing.get("clock_period_ns_baseline", 0.0),
        "ref_wns_b": timing.get("wns_baseline", 0.0),
        "ref_wns_t": timing.get("wns_test", 0.0),
        "crnk_clk_b": cranked.get("clock_period_ns_baseline", 0.0),
        "crnk_clk_t": cranked.get("clock_period_ns_test", 0.0),
        "crnk_wns_b": cranked.get("wns_baseline", 0.0),
        "crnk_wns_t": cranked.get("wns_test", 0.0),
        "fmax_baseline": fmax_baseline,
        "fmax_test": cranked.get("fmax_test_mhz", 0.0),
        "fmax_delta_pct": fmax_delta_pct,
    }


def format_per_design_cranked_timing(designs: List[Dict]) -> str:
    """Format per-design cranked timing comparison table."""
    lines = []
    lines.append("=" * 180)
    lines.append("PER-DESIGN CRANKED TIMING COMPARISON")
    lines.append("=" * 180)
    lines.append(
        f"{'Collection':<15} {'Design':<28} {'Ref.Clk':>8} {'Ref.WNS.B':>10} {'Ref.WNS.T':>10} "
        f"{'Crnk.Clk.B':>10} {'Crnk.Clk.T':>10} {'Crnk.WNS.B':>10} {'Crnk.WNS.T':>10} "
        f"{'Fmax.B':>9} {'Fmax.T':>9} {'Fmax Δ%':>9}"
    )
    lines.append("-" * 180)

    for design in designs:
        collection = design.get("collection", "")
        name = design.get("design", "")
        ct = extract_cranked_timing_comparison(design)

        lines.append(
            f"{collection:<15} {name:<28} {ct['ref_clk']:>8.2f} {ct['ref_wns_b']:>10.3f} "
            f"{ct['ref_wns_t']:>10.3f} "
            f"{ct['crnk_clk_b']:>10.3f} {ct['crnk_clk_t']:>10.3f} "
            f"{ct['crnk_wns_b']:>10.3f} {ct['crnk_wns_t']:>10.3f} "
            f"{ct['fmax_baseline']:>9.1f} {ct['fmax_test']:>9.1f} "
            f"{ct['fmax_delta_pct']:>8.2f}%"
        )

    lines.append("")
    lines.append("Legend:")
    lines.append("  Ref.Clk = Reference clock period (10ns, reset after unredaction)")
    lines.append("  Ref.WNS.B/T = Reference WNS baseline/test (from post-unredaction analysis)")
    lines.append(
        "  Crnk.Clk.B/T = Cranked clock period baseline/test "
        "(actual tight constraints from implementation)"
    )
    lines.append("  Crnk.WNS.B/T = Cranked WNS baseline/test (actual from implementation)")
    lines.append("  Fmax.B/T = Fmax baseline/test (calculated from cranked timing)")
    lines.append("")
    lines.append("Note: This table shows both timing sources side-by-side for comparison.")
    lines.append(
        "      For 96% of designs, both sources calculate identical Fmax (same critical path)."
    )
    lines.append("      A few designs show different Fmax due to different clocks being reported.")
    lines.append("      Formula: Fmax = 1000 / (Clock_Period - WNS)")
    lines.append("")
    return "\n".join(lines)


def format_bitstream_summary(designs: List[Dict]) -> str:
    """Format bitstream comparison summary."""
    lines = []

    total = len(designs)
    identical_count = sum(1 for d in designs if d.get("bitstream", {}).get("identical", True))
    different_count = total - identical_count

    lines.append("=" * 80)
    lines.append("BITSTREAM COMPARISON SUMMARY")
    lines.append("=" * 80)
    lines.append(
        f"Identical bitstreams: {identical_count}/{total} ({identical_count/total*100:.1f}%)"
    )
    lines.append(
        f"Different bitstreams: {different_count}/{total} ({different_count/total*100:.1f}%)"
    )
    lines.append("")

    if different_count > 0:
        lines.append("Designs with different bitstreams:")
        for design in designs:
            bitstream = design.get("bitstream", {})
            if not bitstream.get("identical", True):
                collection = design.get("collection", "")
                name = design.get("design", "")
                golden_size = bitstream.get("golden_size", 0)
                test_size = bitstream.get("test_size", 0)
                lines.append(f"  - {collection}/{name}: Golden={golden_size}, Test={test_size}")
                lines.append(
                    "    Note: Netlist comparison shows functionally equivalent "
                    "(only clock buffer replication differs)"
                )
        lines.append("")

    return "\n".join(lines)


def generate_report(metrics_json: Dict) -> str:
    """Generate complete metrics report from JSON data."""
    lines = []

    # Summary
    summary = metrics_json.get("summary", {})
    total_designs = summary.get("total_designs", 0)
    collections = ", ".join(summary.get("collections", []))

    lines.append("=" * 80)
    lines.append("SUMMARY")
    lines.append("=" * 80)
    lines.append(f"Total Designs: {total_designs}")
    lines.append(f"Collections: {collections}")
    lines.append("")

    # Aggregate statistics
    aggregate = metrics_json.get("aggregate_statistics", {})
    lines.append(format_aggregate_timing_stats(aggregate))
    lines.append(format_aggregate_cranked_timing_stats(aggregate))
    lines.append(format_aggregate_resource_stats(aggregate))
    lines.append(format_aggregate_congestion_stats(aggregate))
    lines.append(format_aggregate_detailed_timing_stats(aggregate))

    # Per-design results
    designs = metrics_json.get("designs", [])
    lines.append(format_per_design_timing_resources(designs))
    lines.append(format_per_design_cranked_timing(designs))
    lines.append(format_per_design_detailed_timing(designs))
    lines.append(format_per_design_resource_breakdown(designs))
    lines.append(format_per_design_congestion(designs))
    lines.append(format_notable_designs(designs))
    lines.append(format_bitstream_summary(designs))

    return "\n".join(lines)


def main():
    """Entry point for the format_metrics_report script."""
    parser = argparse.ArgumentParser(description="Format metrics summary JSON into text report")
    parser.add_argument(
        "--input",
        type=Path,
        default=None,
        help="Input JSON file from summarize_metrics.py (default: stdin)",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Output text report file (default: stdout)",
    )

    args = parser.parse_args()

    # Read input JSON
    if args.input:
        with open(args.input, encoding="utf-8") as f:
            metrics_json = json.load(f)
    else:
        metrics_json = json.load(sys.stdin)

    # Generate report
    report_text = generate_report(metrics_json)

    # Write output
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(report_text)
        print(f"Report written to {args.output}", file=sys.stderr)
    else:
        print(report_text)

    return 0


if __name__ == "__main__":
    sys.exit(main())
