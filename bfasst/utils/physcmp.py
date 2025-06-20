"""
RapidWright physical‐comparison runner.

Runs physical and logical comparisons on two post-implementation netlists
Then compares the bitstreams to verify full equivalence
"""

import logging
from argparse import ArgumentParser
from pathlib import Path

from bfasst import jpype_jvm
from bfasst.utils.physcmp_data_types import ImplReports, PhyscmpException

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.design.compare import DesignComparator
from com.xilinx.rapidwright.edif.compare import EDIFNetlistComparator
from java.io import ByteArrayOutputStream, PrintStream, FileOutputStream
from java.lang import System


def setup_logging(log_path: str, level_str: str):
    """Setup logging related functionality"""
    fos = FileOutputStream(str(log_path), True)
    ps = PrintStream(fos, True)
    System.setOut(ps)

    level = getattr(logging, level_str.upper(), logging.INFO)
    root = logging.getLogger()
    root.handlers.clear()
    root.setLevel(level)

    fmt = logging.Formatter("%(asctime)s %(message)s", "%Y-%m-%d %H:%M:%S")
    fh = logging.FileHandler(log_path, mode="w")
    fh.setFormatter(fmt)
    root.addHandler(fh)

    root.info("Logging at %s", level_str)


def compare_bitstreams(golden_path: Path, test_path: Path, ignore_bytes: int = 200) -> bool:
    """Compare two bitstreams, ignoring the first `ignore_bytes` bytes."""
    with open(golden_path, "rb") as f1, open(test_path, "rb") as f2:
        golden_data = f1.read()
        test_data = f2.read()

    if len(golden_data) != len(test_data):
        logging.warning(
            "Bitstreams have different sizes: golden=%d, test=%d", len(golden_data), len(test_data)
        )
        return True

    differences = 0
    # We skip the first bytes because that's just a header and timestamps mess up the comparison
    for i in range(ignore_bytes, len(golden_data)):
        if golden_data[i] != test_data[i]:
            logging.debug(
                "Bitstream difference at byte %d: golden=0x%02X, test=0x%02X",
                i,
                golden_data[i],
                test_data[i],
            )
            differences += 1
            if differences > 10:
                logging.debug("Stopping after 10 differences")
                break

    if differences > 0:
        logging.warning("Bitstreams differ after ignoring first %d bytes", ignore_bytes)
        return True

    logging.info("Bitstreams match (ignoring first %d bytes)", ignore_bytes)
    return False


def compare_cells(d1: Design, d2: Design) -> int:
    """
    Compare all cells between two designs
    Really just to help see where INIT values differ
    """
    diffs = 0

    cells_a = {cell.getName(): cell for cell in d1.getCells()}
    cells_b = {cell.getName(): cell for cell in d2.getCells()}

    common_names = set(cells_a.keys()) & set(cells_b.keys())
    for name in common_names:
        cell_a = cells_a[name]
        cell_b = cells_b[name]

        if cell_a.getProperty("INIT") != cell_b.getProperty("INIT"):
            if diffs < 10:
                logging.debug("INIT values differ for %s", name)
            diffs += 1

    logging.info("[CELL] Done comparing cells. Differences: %d", diffs)
    logging.info("[CELL] Design 1 total cells: %d", d1.getCells().size())
    logging.info("[CELL] Design 2 total cells: %d", d2.getCells().size())
    return diffs


def log_diff_summary(layout_comparator, netlist_comparator, layout_lines=30, netlist_lines=50):
    """
    Function to log all the differences found by the RW design and netlist comparators
    """
    # Layout comparator output
    layout_baos = ByteArrayOutputStream()
    layout_ps = PrintStream(layout_baos)
    layout_comparator.printDiffReport(layout_ps)
    layout_ps.flush()
    layout_report_str = str(layout_baos.toString())
    layout_report_lines = layout_report_str.splitlines()
    truncated_layout = "\n".join(layout_report_lines[:layout_lines])
    if len(layout_report_lines) > layout_lines:
        truncated_layout += f"\n... (truncated, total {len(layout_report_lines)} lines)"

    # Netlist comparator output
    netlist_baos = ByteArrayOutputStream()
    netlist_ps = PrintStream(netlist_baos)
    netlist_comparator.printDiffReport(netlist_ps)
    netlist_ps.flush()
    netlist_report_str = str(netlist_baos.toString())
    netlist_report_lines = netlist_report_str.splitlines()
    truncated_netlist = "\n".join(netlist_report_lines[:netlist_lines])
    if len(netlist_report_lines) > netlist_lines:
        truncated_netlist += f"\n... (truncated, total {len(netlist_report_lines)} lines)"

    # Combine and log
    logging.info("Layout diff report (first %d lines):\n%s", layout_lines, truncated_layout)
    logging.info("Netlist diff report (first %d lines):\n%s", netlist_lines, truncated_netlist)


def compare_all(
    golden: ImplReports,
    test: ImplReports,
    log_path: str,
    log_level: str,
):
    """
    1) setup logging
    2) read checkpoints
    3) design comparison
    4) netlist comparison
    5) bitstream comparison
    """
    setup_logging(log_path, log_level)
    logging.info("Reading design checkpoints")
    d1 = Design.readCheckpoint(golden.dcp, golden.edf)
    d2 = Design.readCheckpoint(test.dcp, test.edf)

    layout_comparator = DesignComparator()
    layout_comparator.setComparePlacement(True)
    layout_comparator.setComparePIPs(True)
    layout_comparator.setComparePIPFlags(True)
    num_diffs = layout_comparator.compareDesigns(d1, d2)

    netlist_comparator = EDIFNetlistComparator()
    netlist1 = d1.getNetlist()
    netlist2 = d2.getNetlist()
    num_diffs += netlist_comparator.compareNetlists(netlist1, netlist2)

    num_diffs += compare_cells(d1, d2)

    logging.info("Total layout/logic differences between designs: %d", num_diffs)
    log_diff_summary(layout_comparator, netlist_comparator)

    logging.info("Comparing bitstreams...")
    bitstream_diff = compare_bitstreams(golden.bitstream, test.bitstream)
    if bitstream_diff:
        logging.error("\033[31mFound differences in bitstream comparison.\033[0m")
        raise PhyscmpException

    logging.info("\033[32mNo differences found in bitstream comparison.\033[0m")


if __name__ == "__main__":
    p = ArgumentParser(description="BFASST physcmp runner")
    p.add_argument("--golden_dcp", required=True)
    p.add_argument("--golden_edf", required=True)
    p.add_argument("--golden_setup_timing", required=True)
    p.add_argument("--golden_hold_timing", required=True)
    p.add_argument("--golden_timing_summary_full", required=True)
    p.add_argument("--golden_utilization", required=True)
    p.add_argument("--golden_power", required=True)
    p.add_argument("--golden_bitstream", required=True)

    p.add_argument("--test_dcp", required=True)
    p.add_argument("--test_edf", required=True)
    p.add_argument("--test_setup_timing", required=True)
    p.add_argument("--test_hold_timing", required=True)
    p.add_argument("--test_timing_summary_full", required=True)
    p.add_argument("--test_utilization", required=True)
    p.add_argument("--test_power", required=True)
    p.add_argument("--test_bitstream", required=True)

    p.add_argument("--log_path", required=True)
    p.add_argument("--logging_level", default="INFO")

    args = p.parse_args()
    golden_design_reports = ImplReports.from_args(args, "golden")
    test_design_reports = ImplReports.from_args(args, "test")

    compare_all(golden_design_reports, test_design_reports, args.log_path, args.logging_level)
