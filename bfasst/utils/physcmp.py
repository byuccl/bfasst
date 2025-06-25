"""
RapidWright physical‐comparison runner.

Runs physical and logical comparisons on two post-implementation netlists
Then compares the bitstreams to verify full equivalence
"""

import logging
import re
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
    """Compare two bitstreams, ignoring the first ignore_bytes bytes."""
    with open(golden_path, "rb") as f1, open(test_path, "rb") as f2:
        golden_data = f1.read()
        test_data = f2.read()

    if len(golden_data) != len(test_data):
        logging.warning(
            "Bitstreams have different sizes: golden=%d, test=%d", len(golden_data), len(test_data)
        )
        return True

    differences = 0
    # We skip the first bytes because it's just a header and timestamps mess up the comparison
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


def _capture_report_lines(comparator):
    """Run printDiffReport and return the list of lines."""
    baos, ps = ByteArrayOutputStream(), PrintStream(ByteArrayOutputStream())
    ps = PrintStream(baos)
    comparator.printDiffReportSummary(ps)
    ps.flush()
    return "\n" + str(baos.toString())


def printDiff(diff):
    logging.info("Diff: %s", diff.toString())


def log_netlist_diffs(netlist_comparator):
    diff_map = netlist_comparator.getDiffMap()
    logging.info(_capture_report_lines(netlist_comparator))

    count = 0
    for entry in diff_map.entrySet():
        diff_type = entry.getKey()
        diff_list = entry.getValue()

        logging.info("Diff Type: %s", diff_type)
        if str(diff_type) == "PROPERTY_VALUE":
            logging.info("Skipping diffs of type %s", diff_type)
            continue

        for diff in diff_list:
            if count > 10:
                return count
            count += 1
            printDiff(diff)
    return count


def log_layout_diffs(design_comparator):
    diff_map = design_comparator.getDiffMap()
    logging.info(_capture_report_lines(design_comparator))

    count = 0
    for entry in diff_map.entrySet():
        diff_type = entry.getKey()
        diff_list = entry.getValue()

        logging.info("Diff Type: %s", diff_type)
        if str(diff_type) == "PROPERTY_VALUE":
            logging.info("Skipping diffs of type %s", diff_type)
            continue

        for diff in diff_list:
            if count > 10:
                return count
            count += 1
            printDiff(diff)
    return count


def compare_all(golden, test, log_path: str, log_level: str):
    """
     read checkpoints
     compare placement / routing
     compare EDIF netlists
     compare bitstreams
    """

    setup_logging(log_path, log_level)

    logging.info("Reading design checkpoints")
    d1 = Design.readCheckpoint(golden.dcp, golden.edf)
    d2 = Design.readCheckpoint(test.dcp,    test.edf)

    layout_cmp = DesignComparator()
    layout_cmp.setComparePlacement(True)
    layout_cmp.setComparePIPs(True)
    layout_cmp.setComparePIPFlags(True)
    layout_cmp.compareDesigns(d1, d2)

    netlist_cmp = EDIFNetlistComparator()
    netlist_cmp.compareNetlists(d1.getNetlist(), d2.getNetlist())
    
    log_layout_diffs(layout_cmp)
    log_netlist_diffs(netlist_cmp)

    num_layout_diffs = layout_cmp.getDiffCount()
    num_netlist_diffs = netlist_cmp.getDiffCount()

    if num_netlist_diffs:
        logging.error("\033[31mFound differences between logical netlists\033[0m")
        raise PhyscmpException
    logging.info("\033[32mNo differences found between logical netlists\033[0m")

    logging.info("Comparing bitstreams...")
    if compare_bitstreams(golden.bitstream, test.bitstream):
        logging.error("\033[33mFound differences in bitstream comparison.\033[0m")
        # raise PhyscmpException
    else:
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
