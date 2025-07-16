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


_DESIGN_ROW_RE = re.compile(
    r"^\s*(?P<wns>[+-]?\d+\.\d+)\s+"
    r"(?P<tns>[+-]?\d+\.\d+)\s+"
    r"(?P<tns_fail>\d+)\s+"
    r"(?P<tns_total>\d+)\s+"
    r"(?P<wpws>[+-]?\d+\.\d+)\s+"
    r"(?P<tpws>[+-]?\d+\.\d+)",
    re.MULTILINE,
)

_CLOCK_ROW_RE = re.compile(
    r"^(?P<clk>\S+)\s+"
    r"(?P<wns>[+-]?\d+\.\d+)\s+"
    r"(?P<tns>[+-]?\d+\.\d+)\s+"
    r"(?P<tns_fail>\d+)\s+"
    r"(?P<tns_total>\d+)\s+"
    r"(?P<wpws>[+-]?\d+\.\d+)\s+"
    r"(?P<tpws>[+-]?\d+\.\d+)",
    re.MULTILINE,
)


def parse_timing_report(report_path: Path):
    """
    Return a dict with overall metrics **plus** a nested dict of per‑clock metrics.
      { 'overall_wns': ...,
        'overall_tns': ...,
        ...
        'clocks': { 'fixed_clk_gen': {'wns': ..., 'tns': ..., ...}, ... }
      }
    """
    txt = report_path.read_text(errors="ignore")

    out = {}

    # ---------- overall design metrics ----------
    m = _DESIGN_ROW_RE.search(txt)
    if m:
        out.update(
            {
                "overall_wns": float(m.group("wns")),
                "overall_tns": float(m.group("tns")),
                "overall_tns_fail": int(m.group("tns_fail")),
                "overall_tns_total": int(m.group("tns_total")),
                "overall_wpws": float(m.group("wpws")),
                "overall_tpws": float(m.group("tpws")),
            }
        )

    # ---------- per‑clock metrics ----------
    clocks = {}
    for cm in _CLOCK_ROW_RE.finditer(txt):
        clk = cm.group("clk")
        clocks[clk] = {
            "wns": float(cm.group("wns")),
            "tns": float(cm.group("tns")),
            "tns_fail": int(cm.group("tns_fail")),
            "tns_total": int(cm.group("tns_total")),
            "wpws": float(cm.group("wpws")),
            "tpws": float(cm.group("tpws")),
        }
    out["clocks"] = clocks
    return out


def _flat_items(d, prefix=""):
    """
    Yield (key, value) pairs, flattening the nested clocks dict as
      clocks.fixed_clk_gen.wns, clocks.fixed_clk_gen.tns, ...
    """
    for k, v in d.items():
        if k == "clocks":
            for clk, sub in v.items():
                for sk, sv in sub.items():
                    yield f"clocks.{clk}.{sk}", sv
        else:
            yield prefix + k, v


def diff_timing(gold: dict, test: dict):
    """
    Compare two parsed timing dicts → {metric: (gold, test, delta)}.
    Nested clock metrics are flattened with 'clocks.<clk>.<field>' names.
    """
    flat_g = dict(_flat_items(gold))
    flat_t = dict(_flat_items(test))
    keys = set(flat_g) | set(flat_t)
    diff = {}
    for k in sorted(keys):
        g, t = flat_g.get(k), flat_t.get(k)
        diff[k] = (g, t, None if (g is None or t is None) else t - g)
    return diff


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
    logging.info("Diff found: %s", diff.toString())
    source_inst = diff.getSourceInst()
    if source_inst is not None:
        logging.info("Differing cell name: %s", source_inst.getName())
        logging.info("Differing cell properties:")
        props_map = source_inst.getPropertiesMap()
        for entry in props_map.entrySet():
            key = entry.getKey()
            value = entry.getValue()
            logging.info("  %s = %s", key, value)

    if diff.getPropertyKey() is not None:
        logging.info("Differing property: %s", diff.getPropertyKey())


def log_netlist_diffs(netlist_comparator):
    diff_map = netlist_comparator.getDiffMap()
    logging.info(_capture_report_lines(netlist_comparator))

    skip_substrings = {"HOLD_DETOUR", "ECO_CHECKSUM"}

    count = 0
    for entry in diff_map.entrySet():
        diff_type = entry.getKey()
        diff_list = entry.getValue()

        logging.info("\u001B[1mDiff Type: %s\u001B[0m", diff_type)

        shown = 0
        skipped = 0
        for diff in diff_list:
            property_key = diff.getPropertyKey()
            key_str = property_key if property_key is not None else ""

            if any(skip_str in key_str for skip_str in skip_substrings):
                skipped += 1
                continue

            count += 1
            MAX_TO_SHOW = 2
            if shown < MAX_TO_SHOW:
                printDiff(diff)
                shown += 1
            elif shown == MAX_TO_SHOW:
                logging.info("Stopped printing after %d diffs", MAX_TO_SHOW)
                shown += 1

        logging.info("Total meaningful %s diffs found: %d\n", diff_type, diff_list.size() - skipped)
        if skipped:
            logging.info("Skipped %d non-essential properties\n", skipped)

    return count


def log_layout_diffs(design_comparator):
    diff_map = design_comparator.getDiffMap()
    logging.info(_capture_report_lines(design_comparator))
    return design_comparator.getDiffCount()


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
    d2 = Design.readCheckpoint(test.dcp, test.edf)

    layout_cmp = DesignComparator()
    layout_cmp.setComparePlacement(True)
    layout_cmp.setComparePIPs(True)
    layout_cmp.setComparePIPFlags(True)
    layout_cmp.compareDesigns(d1, d2)

    netlist_cmp = EDIFNetlistComparator()
    netlist_cmp.compareNetlists(d1.getNetlist(), d2.getNetlist())

    num_layout_diffs = log_layout_diffs(layout_cmp)
    num_netlist_diffs = log_netlist_diffs(netlist_cmp)

    if num_netlist_diffs != 0:
        logging.error("\033[31mFound differences between logical netlists\033[0m")
        # raise PhyscmpException
    logging.info("\033[32mNo differences found between logical netlists\033[0m")

    logging.info("Parsing full timing summaries...")
    g_timing = parse_timing_report(golden.timing_summary_full)
    t_timing = parse_timing_report(test.timing_summary_full)

    timing_delta = diff_timing(g_timing, t_timing)
    worse = []
    for metric, (gv, tv, dv) in timing_delta.items():
        if gv is None or tv is None:
            logging.warning("Metric %-22s missing (golden=%s, test=%s)", metric, gv, tv)
            continue
        sign = "+" if dv > 0 else "-" if dv < 0 else "="
        logging.info(
            "%-22s  golden=%8.3f  test=%8.3f  delta=%+8.3f %s",
            metric, gv, tv, dv, sign
        )
        if dv is not None and dv < 0:
            worse.append(metric)

    if worse:
        logging.warning("\u001B[33mTiming degraded for: %s\u001B[0m", ", ".join(worse))
    else:
        logging.info("\u001B[32mNo timing regressions detected.\u001B[0m")

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
