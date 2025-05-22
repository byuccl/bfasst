"""
RapidWright physical‐comparison runner.

Runs a cell-by-cell and net-by-net comparison to ensure
placement and routing between two designs are identical.

Also runs a text-based diff on timing and utilization reports.
"""

import re
import logging
from argparse import ArgumentParser
from pathlib import Path
from typing import Optional

from bfasst import jpype_jvm
from bfasst.utils.physcmp_data_types import ImplReports

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design


def setup_logging(log_path: str, level_str: str):
    """Setup logging related functionality"""

    level = getattr(logging, level_str.upper(), logging.INFO)
    root = logging.getLogger()
    root.handlers.clear()
    root.setLevel(level)

    fmt = logging.Formatter("%(asctime)s %(message)s", "%Y%m%d%H%M%S")
    fh = logging.FileHandler(log_path, mode="w")
    fh.setFormatter(fmt)
    root.addHandler(fh)

    ch = logging.StreamHandler()
    ch.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
    root.addHandler(ch)

    root.info("Logging at %s", level_str)


def load_and_trim(path: Path) -> list[str]:
    with open(path, "r") as f:
        return f.readlines()[11:]


def compare_reports(golden_path: Path, test_path: Path, label: Optional[str] = None):
    """Run a text-based comparison between two implementation reports."""

    def is_rise_fall_swap(gs: str, ts: str) -> bool:
        pat = r"(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+([rf])\s+(.+)"
        mg, mt = re.search(pat, gs), re.search(pat, ts)
        if mg and mt:
            same_delay = mg.group(1) == mt.group(1)
            same_slack = mg.group(2) == mt.group(2)
            same_rest = mg.group(4) == mt.group(4)
            different_edge = mg.group(3) != mt.group(3)

            if same_delay and same_slack and same_rest and different_edge:
                logging.debug("[rise/fall swap]")
                logging.debug("  G: %s", gs)
                logging.debug("  T: %s", ts)
                return True
        return False

    diffs = []
    swaps = []

    g_lines = load_and_trim(golden_path)
    t_lines = load_and_trim(test_path)

    for idx, (g, t) in enumerate(zip(g_lines, t_lines), start=12):
        gs, ts = g.strip(), t.strip()
        if gs == ts:
            continue

        if label and "timing" in label.lower() and is_rise_fall_swap(gs, ts):
            swaps.append((idx, gs, ts))
            continue

        diffs.append((idx, gs, ts))

    extra_g = g_lines[len(t_lines) :]
    extra_t = t_lines[len(g_lines) :]
    return diffs, extra_g, extra_t, swaps


def log_report_diff(label: str, golden_path: Path, test_path: Path) -> bool:
    """Helper function to report report file differences"""

    diffs, extra_g, extra_t, swaps = compare_reports(golden_path, test_path, label)
    saw = False

    if diffs:
        saw = True
        logging.debug("[%s] Differences found in %d lines:", label, len(diffs))
        for ln, g, t in diffs:
            logging.debug("[%s] Line %d:\n\tGOLD: %s\n\tTEST: %s", label, ln, g, t)
    else:
        msg = "[%s] No significant differences found"
        if "timing" in label.lower():
            msg += " (excluding rise/fall changes)"
        logging.debug(msg, label)

    if swaps:
        saw = True
        logging.info("[%s] Ignored %d rise/fall-only swaps.", label, len(swaps))
    if extra_g:
        saw = True
        logging.debug("[%s] Golden has %d extra lines.", label, len(extra_g))
    if extra_t:
        saw = True
        logging.debug("[%s] Test has %d extra lines.", label, len(extra_t))

    return saw


def compare_cells(d1: Design, d2: Design) -> int:
    """Compare physical placement of all cells in a design"""

    by_name2 = {c.getName(): c for c in d2.getCells()}
    by_site2 = {(str(c.getSite()), str(c.getBEL())): c for c in d2.getCells()}
    diffs = 0

    for c1 in d1.getCells():
        c2 = by_name2.get(c1.getName()) or by_site2.get((str(c1.getSite()), str(c1.getBEL())))
        if not c2:
            diffs += 1
            logging.debug("[CELL] %s missing in second design", c1.getName())
        elif c1.getSite() != c2.getSite() or c1.getBEL() != c2.getBEL():
            diffs += 1
            logging.debug(
                "[CELL] %s placed differently: %s/%s vs %s/%s",
                c1.getName(),
                c1.getSite(),
                c1.getBEL(),
                c2.getSite(),
                c2.getBEL(),
            )

    by_name1 = {c.getName(): c for c in d1.getCells()}
    by_site1 = {(str(c.getSite()), str(c.getBEL())): c for c in d1.getCells()}
    for c2 in d2.getCells():
        if not (by_name1.get(c2.getName()) or by_site1.get((str(c2.getSite()), str(c2.getBEL())))):
            diffs += 1
            logging.debug("[CELL] %s missing in first design", c2.getName())

    logging.info("[CELL] Done comparing cells. Differences: %d", diffs)
    logging.info("[CELL] Design 1 total cells: %d", d1.getCells().size())
    logging.info("[CELL] Design 2 total cells: %d", d2.getCells().size())
    return diffs


def compare_nets(d1: Design, d2: Design) -> int:
    """Compare physical nets in a design"""

    def sig(n):
        src = n.getSource()
        drv = src.getSitePinName() if src else "<NONE>"
        sinks = frozenset(p.getSitePinName() for p in n.getSinkPins())
        return (drv, sinks)

    s1 = {sig(n) for n in d1.getNets()}
    s2 = {sig(n) for n in d2.getNets()}
    diffs = 0

    for drv, sinks in s1 - s2:
        diffs += 1
        logging.debug("[NET] %s -> %d sinks missing in second design", drv, len(sinks))
    for drv, sinks in s2 - s1:
        diffs += 1
        logging.debug("[NET] %s -> %d sinks missing in first design", drv, len(sinks))

    logging.info("[NET] Done comparing nets. Differences: %d", diffs)
    logging.info("[NET] Design 1 total nets: %d", d1.getNets().size())
    logging.info("[NET] Design 2 total nets: %d", d2.getNets().size())
    return diffs


def log_layout_summary(total: int):
    if total == 0:
        logging.info("No layout differences found between designs")
    else:
        logging.warning("Found layout differences between designs: %d", total)


def log_report_summary(flags: dict[str, bool]):
    for label, saw in flags.items():
        if saw:
            logging.warning("Found %s differences between designs", label.lower())
        else:
            logging.info("No %s differences found between designs", label.lower())
    if logging.getLogger().getEffectiveLevel() >= logging.INFO:
        print("Note: Set logging level to DEBUG for more details")


def compare_all(
    golden: ImplReports,
    test: ImplReports,
    log_path: str,
    log_level: str,
):
    """
    Orchestrate:
      1) setup logging
      2) read checkpoints
      3) cell & net compares
      4) text-diff compares
      5) final summaries
    """
    setup_logging(log_path, log_level)
    logging.info("Reading design checkpoints")
    d1 = Design.readCheckpoint(golden.dcp, golden.edf)
    d2 = Design.readCheckpoint(test.dcp, golden.edf)

    cell_diffs = compare_cells(d1, d2)
    net_diffs = compare_nets(d1, d2)

    report_flags = {
        "SETUP_TIMING": log_report_diff("SETUP_TIMING", golden.setup_timing, test.setup_timing),
        "HOLD_TIMING": log_report_diff("HOLD_TIMING", golden.hold_timing, test.hold_timing),
        "FULL_SUMMARY": log_report_diff(
            "FULL_TIMING_SUMMARY", golden.timing_summary_full, test.timing_summary_full
        ),
        "UTILIZATION": log_report_diff("UTILIZATION", golden.utilization, test.utilization),
        # "POWER":         log_report_diff("POWER",         golden.power,       test.power),
    }

    log_layout_summary(cell_diffs + net_diffs)
    log_report_summary(report_flags)


if __name__ == "__main__":
    p = ArgumentParser(description="BFASST physcmp runner")
    p.add_argument("--golden_dcp", required=True)
    p.add_argument("--golden_edf", required=True)
    p.add_argument("--golden_setup_timing", required=True)
    p.add_argument("--golden_hold_timing", required=True)
    p.add_argument("--golden_timing_summary_full", required=True)
    p.add_argument("--golden_utilization", required=True)
    p.add_argument("--golden_power", required=True)

    p.add_argument("--test_dcp", required=True)
    p.add_argument("--test_edf", required=True)
    p.add_argument("--test_setup_timing", required=True)
    p.add_argument("--test_hold_timing", required=True)
    p.add_argument("--test_timing_summary_full", required=True)
    p.add_argument("--test_utilization", required=True)
    p.add_argument("--test_power", required=True)

    p.add_argument("--log_path", required=True)
    p.add_argument("--logging_level", default="INFO")

    args = p.parse_args()
    golden_design_reports = ImplReports.from_args(args, "golden")
    test_design_reports = ImplReports.from_args(args, "test")

    compare_all(golden_design_reports, test_design_reports, args.log_path, args.logging_level)
