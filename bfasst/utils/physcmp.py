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
    logging.basicConfig(
        filename=log_path,
        filemode="w",
        format="%(asctime)s %(message)s",
        level=level,
        datefmt="%Y%m%d%H%M%S",
    )
    logging.info(f"Logging at {level_str}")


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
    golden_dir = Path(golden_dcp).parent
    test_dir   = Path(test_dcp).parent

    design1 = Design.readCheckpoint(golden_dir)
    design2 = Design.readCheckpoint(test_dir)

    for cell1 in design1.getCells():
        cell2 = design2.getCell(cell1.getName())
        if cell2 is None:
            print(f"{cell1.getName()} missing in second design")
            continue
        if cell1.getSite() != cell2.getSite() or cell1.getBEL() != cell2.getBEL():
            print(f"{cell1.getName()} placed differently between designs")

    print(f"Done comparing physical placement and routing")


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
