"""
Netlist De-obfuscation runner using RapidWright.

Loads a Vivado checkpoint (.dcp) and EDIF (.edf), reapplies
the original cell properties stored in JSON, and writes out
de-obfuscated checkpoint and EDIF for downstream reporting.
"""

import argparse
import logging
import pathlib
from pathlib import Path
import json
import time
import re

from bfasst import jpype_jvm

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design


def setup_logging(log_path: pathlib.Path, level_str: str):
    """Setup logging for this util"""

    level = getattr(logging, level_str.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        level=level,
        format="%(asctime)s %(levelname)s: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    console = logging.StreamHandler()
    console.setLevel(level)
    console.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
    logging.getLogger().addHandler(console)
    logging.info("Logging at %s", level_str)


def canonicalize(name: str) -> str:
    """
    Normalize ANY cell name to a pure “words and underscores” form:
      - turn every non-alphanumeric into “_”
      - collapse runs of “_”
      - strip leading/trailing “_”
      - lowercase
    """
    s = str(name)
    s = re.sub(r"[^0-9A-Za-z]+", "_", s)
    s = re.sub(r"_+", "_", s)
    s = s.strip("_")
    return s.lower()


def apply_properties(design: Design, props: dict[str, dict]):
    """
    For each cell_id in props, apply only the changed EDIF properties
    to the matching RapidWright cell, using canonical name matching.
    """

    # with open("canonical_netlist_cells.txt", "w") as f_netlist:
    #     for c in design.getCells():
    #         f_netlist.write(f"{c.getName()} → {canonicalize(c.getName())}\n")

    # with open("canonical_props_cells.txt", "w") as f_props:
    #     for cell_id_raw in props:
    #         f_props.write(f"{cell_id_raw} → {canonicalize(cell_id_raw)}\n")

    logging.info("Building canonical cell map...")
    canonical_cell_map = {canonicalize(c.getName()): c for c in design.getCells()}

    missing = 0
    updated = 0

    for cell_id_raw, info in props.items():
        canon_id = canonicalize(cell_id_raw)
        cell = canonical_cell_map.get(canon_id)

        if cell is None:
            logging.debug("[missing] cell not found: %s -> %s", cell_id_raw, canon_id)
            missing += 1
            continue

        for p in info.get("original_properties", []):
            key = p["identifier"]
            val = p["value"]

            if isinstance(val, bool):
                cell.addProperty(key, True)
            else:
                # everything else as string
                cell.addProperty(key, str(val))
                # logging.debug("Added property '%s' = %s to %s", key, val, cell.getName())
            updated += 1

    logging.info("Re-applied %d properties across %d cells", updated, len(props) - missing)

    if missing > 0:
        logging.warning("Skipped %d missing cells", missing)


def main():
    """
    Netlist De-obfuscation runner using RapidWright.

    Loads a Vivado checkpoint (.dcp) and EDIF (.edf), reapplies
    the original cell properties stored in JSON, and writes out
    de-obfuscated checkpoint and EDIF for downstream reporting.
    """

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--build_path", required=True, type=pathlib.Path, help="Directory for logs/intermediates"
    )
    p.add_argument(
        "--dcp_in", required=True, type=pathlib.Path, help="Input implementation checkpoint (.dcp)"
    )
    p.add_argument(
        "--edf_in", required=True, type=pathlib.Path, help="Input synthesized EDIF netlist (.edf)"
    )
    p.add_argument(
        "--props_json",
        required=True,
        type=pathlib.Path,
        help="JSON file with saved original_properties per cell",
    )
    p.add_argument(
        "--out_dcp", required=True, type=pathlib.Path, help="Output de-obfuscated DCP path"
    )
    p.add_argument(
        "--out_edf", required=True, type=pathlib.Path, help="Output de-obfuscated EDIF path"
    )
    p.add_argument(
        "--log", default="netlist_deobfuscate.log", help="Log filename (inside build_path)"
    )
    p.add_argument(
        "--logging_level",
        default="DEBUG",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        help="Verbosity level",
    )

    args = p.parse_args()

    args.build_path.mkdir(parents=True, exist_ok=True)
    log_path = args.build_path / args.log
    if log_path.exists():
        log_path.unlink()
    setup_logging(log_path, args.logging_level)

    logging.info("Reading JSON properties from %s", args.props_json)
    props = json.load(open(args.props_json))
    logging.info("Loaded properties for %d cells", len(props))

    logging.info("Loading design checkpoint and netlist")
    t0 = time.perf_counter()
    design = Design.readCheckpoint(str(args.dcp_in), str(args.edf_in))
    logging.info("Design loaded in %.2f s", time.perf_counter() - t0)

    logging.info("Applying saved properties to design")
    t1 = time.perf_counter()
    apply_properties(design, props)
    logging.info("Applied properties in %.2f s", time.perf_counter() - t1)

    logging.info("Writing out new checkpoint to %s", args.out_dcp)
    t2 = time.perf_counter()
    design.writeCheckpoint(str(args.out_dcp))
    logging.info("Wrote DCP in %.2f s", time.perf_counter() - t2)

    #    logging.info("Writing out new EDIF to %s", args.out_edf)
    #    t3 = time.perf_counter()
    #    design.writeEdif(str(args.out_edf))
    #    logging.info("Wrote EDIF in %.2f s", time.perf_counter() - t3)

    # placeholder for now as we don't actually use the EDIF
    edf_path = Path(args.out_edf)
    edf_path.parent.mkdir(parents=True, exist_ok=True)

    if not edf_path.exists():
        edf_path.write_text("placeholder edif")

    logging.info("NetlistDeobfuscate complete")


if __name__ == "__main__":
    main()
