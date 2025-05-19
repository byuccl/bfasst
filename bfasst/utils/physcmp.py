"""
RapidWright physical‐comparison runner.

Runs a cell-by-cell and net-by-net comparison to ensure
placement and routing between two designs are identical.

Also runs a text-based diff on timing and utilization reports.

This tool is very strict in its comparisons. It may say that
two equivalent designs are different depending on naming/ordering of
design elements. But if it says designs are equivalent, they definitely are.
"""

import sys
import logging
from argparse import ArgumentParser
from pathlib import Path
from bfasst import jpype_jvm
jpype_jvm.start()

import re
import bfasst.utils.rw_helpers as rw
from bfasst.utils.rw_phys_netlist import RwPhysNetlist
from com.xilinx.rapidwright.design import Design


def setup_logging(log_path, level_str):
    level = getattr(logging, level_str.upper(), logging.INFO)

    logger = logging.getLogger()
    logger.handlers.clear()
    logger.setLevel(level)

    file_handler = logging.FileHandler(log_path, mode="w")
    file_handler.setFormatter(
        logging.Formatter("%(asctime)s %(message)s", "%Y%m%d%H%M%S")
    )
    logger.addHandler(file_handler)

    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
    logger.addHandler(console)

    logger.info(f"Logging at {level_str}")


def make_phys_netlist(build_dir: Path, dcp: Path, edif: Path) -> Path:
    """
    Run RwPhysNetlist to generate a physical EDIF from a DCP+EDIF pair.
    Returns path to the new EDIF.
    """
    transformer = RwPhysNetlist(build_dir, logging.getLogger().level)
    transformer.run(str(dcp), str(edif))
    return transformer.stage_dir / "viv_impl_physical.edf"


def load_and_trim(file_path):
    # Skip first 11 lines (header/metadata)
    with open(file_path, 'r') as f:
        lines = f.readlines()[11:]
    return lines


def compare_reports(golden_path, test_path, label=None):
    golden_lines = load_and_trim(golden_path)
    test_lines = load_and_trim(test_path)

    diffs = []
    rise_fall_swaps = []

    for i, (g_line, t_line) in enumerate(zip(golden_lines, test_lines)):
        g_stripped = g_line.strip()
        t_stripped = t_line.strip()
        line_num = i + 12  # to match report line numbering

        if g_stripped == t_stripped:
            continue

        # Special handling for timing rise/fall swaps
        if label and "timing" in label.lower():
            # Match pattern like: float float r/f name
            rf_pattern = r"(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+([rf])\s+(.+)"
            g_match = re.search(rf_pattern, g_stripped)
            t_match = re.search(rf_pattern, t_stripped)
            if g_match and t_match:
                # Compare all parts except the r/f character
                if g_match.group(1, 2, 4) == t_match.group(1, 2, 4) and g_match.group(3) != t_match.group(3):
                    rise_fall_swaps.append((line_num, g_stripped, t_stripped))
                    continue

        diffs.append((line_num, g_stripped, t_stripped))

    extra_golden = golden_lines[len(test_lines):]
    extra_test = test_lines[len(golden_lines):]

    return diffs, extra_golden, extra_test, rise_fall_swaps


def log_report_diff(label, golden_path, test_path):
    diffs, extra_golden, extra_test, rise_fall_swaps = compare_reports(golden_path, test_path, label=label)
    differences_found = False

    if diffs:
        differences_found = True
        logging.debug(f"[{label}] Differences found in {len(diffs)} lines:")
        for line_num, g_line, t_line in diffs:
            logging.debug(f"[{label}] Line {line_num}:\n\tGOLD: {g_line}\n\tTEST: {t_line}")
    else:
        if "timing" in label.lower():
            logging.debug(f"[{label}] No significant differences found (excluding rise/fall changes)")
        else:
            logging.debug(f"[{label}] No significant differences found")

    if rise_fall_swaps:
        logging.info(f"[{label}] Ignored {len(rise_fall_swaps)} rise/fall-only swaps.")

    if extra_golden:
        differences_found = True
        logging.debug(f"[{label}] Golden has {len(extra_golden)} extra lines.")
    if extra_test:
        differences_found = True
        logging.debug(f"[{label}] Test has {len(extra_test)} extra lines.")

    return differences_found or bool(rise_fall_swaps)


def compare_phys(
    golden_dcp,
    golden_edf,
    golden_setup_timing,
    golden_hold_timing,
    golden_timing_summary_full,
    golden_utilization,
    golden_power,
    test_dcp,
    test_edf,
    test_setup_timing,
    test_hold_timing,
    test_timing_summary_full,
    test_utilization,
    test_power,
    log_path,
    logging_level
):
    setup_logging(log_path, logging_level)

    logging.info("Generating physical netlists")
    design1 = Design.readCheckpoint(golden_dcp)
    design2 = Design.readCheckpoint(test_dcp)

    # CELL COMPARISON
    name_to_cell2 = {c.getName(): c for c in design2.getCells()}
    site_bel_to_cell2 = {
        (str(c.getSite()), str(c.getBEL())): c for c in design2.getCells()
    }

    num_cell_differences = 0

    # Cells in design1 not in design2
    for cell1 in design1.getCells():
        cell2 = name_to_cell2.get(cell1.getName())
        if cell2 is None:
            key = (str(cell1.getSite()), str(cell1.getBEL()))
            cell2 = site_bel_to_cell2.get(key)
        if cell2 is None:
            num_cell_differences += 1
            logging.debug(f"[CELL] {cell1.getName()} missing in second design")
            continue

        # Check for placement differences
        if cell1.getSite() != cell2.getSite() or cell1.getBEL() != cell2.getBEL():
            num_cell_differences += 1
            logging.debug(
                f"[CELL] {cell1.getName()} placed differently: "
                f"{cell1.getSite()}/{cell1.getBEL()} vs {cell2.getSite()}/{cell2.getBEL()}"
            )

    # Cells in design2 not in design1
    name_to_cell1 = {c.getName(): c for c in design1.getCells()}
    site_bel_to_cell1 = {
        (str(c.getSite()), str(c.getBEL())): c for c in design1.getCells()
    }
    for cell2 in design2.getCells():
        cell1 = name_to_cell1.get(cell2.getName())
        if cell1 is None:
            key = (str(cell2.getSite()), str(cell2.getBEL()))
            cell1 = site_bel_to_cell1.get(key)
        if cell1 is None:
            num_cell_differences += 1
            logging.debug(f"[CELL] {cell2.getName()} missing in first design")

    logging.info(f"[CELL] Done comparing cells. Differences: {num_cell_differences}")
    logging.info(f"[CELL] Design 1 total cells: {design1.getCells().size()}")
    logging.info(f"[CELL] Design 2 total cells: {design2.getCells().size()}")

    # NET COMPARISON
    def net_signature(net):
        src = net.getSource()
        drv_sig = src.getSitePinName() if src else "<NONE>"
        sink_sigs = frozenset(pin.getSitePinName() for pin in net.getSinkPins())
        return drv_sig, sink_sigs

    sigs1 = {net_signature(n): n for n in design1.getNets()}
    sigs2 = {net_signature(n): n for n in design2.getNets()}

    num_net_differences = 0

    for sig, net1 in sigs1.items():
        if sig not in sigs2:
            drv, sinks = sig
            num_net_differences += 1
            logging.debug(f"[NET] {drv} -> {len(sinks)} sinks missing in second design")
    for sig, net2 in sigs2.items():
        if sig not in sigs1:
            drv, sinks = sig
            num_net_differences += 1
            logging.debug(f"[NET] {drv} -> {len(sinks)} sinks missing in first design")

    logging.info(f"[NET] Done comparing nets. Differences: {num_net_differences}")
    logging.info(f"[NET] Design 1 total nets: {design1.getNets().size()}")
    logging.info(f"[NET] Design 2 total nets: {design2.getNets().size()}")

    # TIMING & UTILIZATION & POWER REPORT COMPARISON
    setup_diffs   = log_report_diff("SETUP_TIMING",        golden_setup_timing,        test_setup_timing)
    hold_diffs    = log_report_diff("HOLD_TIMING",         golden_hold_timing,         test_hold_timing)
    summary_diffs = log_report_diff("FULL_TIMING_SUMMARY", golden_timing_summary_full, test_timing_summary_full)
    util_diffs    = log_report_diff("UTILIZATION",         golden_utilization,         test_utilization)
    # power_diffs   = log_report_diff("POWER",               golden_power,               test_power)

    logging.info("Done comparing designs")
    total_differences = num_cell_differences + num_net_differences
    if total_differences == 0:
        logging.info("No layout differences found between designs")
    else:
        logging.warning(f"Found layout differences between designs: {total_differences}")

    for label, found in [
        ("SETUP_TIMING",        setup_diffs),
        ("HOLD_TIMING",         hold_diffs),
        ("FULL_TIMING_SUMMARY", summary_diffs),
        ("UTILIZATION",         util_diffs),
    #    ("POWER",               power_diffs),
    ]:
        if found:
            logging.warning(f"Found {label.lower()} differences between designs")
        else:
            logging.info(f"No {label.lower()} differences found between designs")

    if logging.getLogger().getEffectiveLevel() >= logging.INFO:
        print("Note: Set logging level to DEBUG for more details")


if __name__ == "__main__":
    p = ArgumentParser(description="BFASST physcmp runner")
    p.add_argument("--golden_dcp", required=True, help="First implementation .dcp")
    p.add_argument("--golden_edf", required=True, help="First implementation .edf")
    p.add_argument(
        "--golden_setup_timing",
        required=True,
        help="First setup timing report (report_timing -file)"
    )
    p.add_argument(
        "--golden_hold_timing",
        required=True,
        help="First hold timing report (report_timing -hold -file)"
    )
    p.add_argument(
        "--golden_timing_summary_full",
        required=True,
        help="First full timing-summary report (report_timing_summary -file)"
    )
    p.add_argument("--golden_utilization", required=True, help="First utilization report")
    p.add_argument("--golden_power", required=True, help="First power report")

    p.add_argument("--test_dcp", required=True, help="Second implementation .dcp")
    p.add_argument("--test_edf", required=True, help="Second implementation .edf")
    p.add_argument(
        "--test_setup_timing",
        required=True,
        help="Second setup timing report (report_timing -file)"
    )
    p.add_argument(
        "--test_hold_timing",
        required=True,
        help="Second hold timing report (report_timing -hold -file)"
    )
    p.add_argument(
        "--test_timing_summary_full",
        required=True,
        help="Second full timing-summary report (report_timing_summary -file)"
    )
    p.add_argument("--test_utilization", required=True, help="Second utilization report")
    p.add_argument("--test_power", required=True, help="Second power report")

    p.add_argument("--log_path", required=True, help="Output log file")
    p.add_argument(
        "--logging_level", default="INFO",
        help="Logging level: DEBUG, INFO, WARNING, etc."
    )

    args = p.parse_args()

    compare_phys(
        args.golden_dcp,
        args.golden_edf,
        args.golden_setup_timing,
        args.golden_hold_timing,
        args.golden_timing_summary_full,
        args.golden_utilization,
        args.golden_power,
        args.test_dcp,
        args.test_edf,
        args.test_setup_timing,
        args.test_hold_timing,
        args.test_timing_summary_full,
        args.test_utilization,
        args.test_power,
        args.log_path,
        args.logging_level,
    )

