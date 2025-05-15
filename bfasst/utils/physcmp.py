"""
RapidWright physical‐comparison runner.

Uses the RwPhysNetlist transformer and RW helpers to generate
physical EDIF netlists from two DCP+EDF inputs, then runs
a basic cell‐by‐cell equivalence check.
"""

import sys
import logging
from argparse import ArgumentParser
from pathlib import Path

from bfasst import jpype_jvm
jpype_jvm.start()

import bfasst.utils.rw_helpers as rw
from bfasst.utils.rw_phys_netlist import RwPhysNetlist

from com.xilinx.rapidwright.design import Design

def setup_logging(log_path, level_str):
    level = getattr(logging, level_str.upper(), logging.INFO)

    logger = logging.getLogger()
    logger.handlers.clear()
    logger.setLevel(level)

    file_handler = logging.FileHandler(log_path, mode="w")
    file_handler.setFormatter(logging.Formatter("%(asctime)s %(message)s", "%Y%m%d%H%M%S"))
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


def compare_phys(golden_dcp, golden_edf, test_dcp, test_edf, log_path, logging_level):
    setup_logging(log_path, logging_level)

    logging.info("Generating physical netlists")
    design1 = Design.readCheckpoint(golden_dcp)
    design2 = Design.readCheckpoint(test_dcp)

    # Build lookup tables for design2
    name_to_cell2 = {c.getName(): c for c in design2.getCells()}
    site_bel_to_cell2 = {
        (str(c.getSite()), str(c.getBEL())): c for c in design2.getCells()
    }

    num_cell_differences = 0

    # 1) Cells in design1 not matched in design2
    for cell1 in design1.getCells():
        cell2 = name_to_cell2.get(cell1.getName())
        if cell2 is None:
            key = (str(cell1.getSite()), str(cell1.getBEL()))
            cell2 = site_bel_to_cell2.get(key)
        if cell2 is None:
            num_cell_differences += 1
            logging.warning(f"[CELL] {cell1.getName()} missing in second design")
            continue

        # If we found it, check if it actually moved
        if cell1.getSite() != cell2.getSite() or cell1.getBEL() != cell2.getBEL():
            num_cell_differences += 1
            logging.warning(
                f"[CELL] {cell1.getName()} placed differently: "
                f"{cell1.getSite()}/{cell1.getBEL()} vs {cell2.getSite()}/{cell2.getBEL()}"
            )

    # 2) Cells in design2 not matched in design1
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
            logging.warning(f"[CELL] {cell2.getName()} missing in first design")

    logging.info(f"[CELL] Done comparing cells. Differences: {num_cell_differences}")

    # ——— Improved Net Comparison (physical‐pin signature) ———
    def net_signature(net):
        # Driver pin: getSource() → SitePinInst → unique site.pin string
        src = net.getSource()
        drv_sig = src.getSitePinName() if src else "<NONE>"
    
        # Sink pins: getSinkPins() → list of SitePinInst
        sink_sigs = frozenset(pin.getSitePinName() for pin in net.getSinkPins())
    
        return (drv_sig, sink_sigs)
    
    # Build maps from signature → Net object
    sigs1 = { net_signature(n): n for n in design1.getNets() }
    sigs2 = { net_signature(n): n for n in design2.getNets() }
    
    num_net_differences = 0
    
    # Nets in design1 not found in design2
    for sig, net1 in sigs1.items():
        if sig not in sigs2:
            drv, sinks = sig
            num_net_differences += 1
            logging.warning(f"[NET] {drv} → {len(sinks)} sinks missing in second design")
    
    # Nets in design2 not found in design1
    for sig, net2 in sigs2.items():
        if sig not in sigs1:
            drv, sinks = sig
            num_net_differences += 1
            logging.warning(f"[NET] {drv} → {len(sinks)} sinks missing in first design")
    
    logging.info(f"[NET] Done comparing nets. Differences: {num_net_differences}")

    total = num_cell_differences + num_net_differences
    logging.info("Done comparing physical placement and routing.")
    logging.info(f"Design 1 total cells: {design1.getCells().size()}")
    logging.info(f"Design 2 total cells: {design2.getCells().size()}")
    logging.info(f"Design 1 total nets: {design1.getNets().size()}")
    logging.info(f"Design 2 total nets: {design2.getNets().size()}")
    logging.info(f"Differences found: {total}")

if __name__ == "__main__":
    p = ArgumentParser(description="BFASST physcmp runner")
    p.add_argument("--golden_dcp",     required=True, help="First implementation .dcp")
    p.add_argument("--golden_edf",     required=True, help="First implementation .edf")
    p.add_argument("--test_dcp",       required=True, help="Second implementation .dcp")
    p.add_argument("--test_edf",       required=True, help="Second implementation .edf")
    p.add_argument("--log_path",       required=True, help="Output log file")
    p.add_argument("--logging_level",  default="INFO", help="DEBUG|INFO|...")

    args = p.parse_args()
    compare_phys(
        args.golden_dcp, args.golden_edf,
        args.test_dcp,   args.test_edf,
        args.log_path,   args.logging_level,
    )
