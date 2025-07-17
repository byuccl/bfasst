"""
Netlist De-obfuscation runner using RapidWright.

Loads a Vivado checkpoint (.dcp) and EDIF (.edf), reapplies
the original cell properties stored in JSON, and writes out
de-obfuscated checkpoint and EDIF for downstream reporting.
"""

import argparse
import math
import logging
import pathlib
import json
import time
import re
from itertools import combinations, permutations, product

from bfasst.utils.netlist_obfuscate_helpers import TAG_PROP, SENTINEL_VALUES, parse_init, format_init
from bfasst import jpype_jvm

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.edif import EDIFTools, EDIFValueType
from com.xilinx.rapidwright.design.tools import LUTTools
from java.util import ArrayList
from java.lang import System
from java.io import PrintStream, FileOutputStream


def setup_logging(log_path: pathlib.Path, level_str: str):
    """Setup logging for this util"""
    fos = FileOutputStream(str(log_path), True)
    ps = PrintStream(fos, True)
    System.setOut(ps)

    level = getattr(logging, level_str.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        level=level,
        format="%(asctime)s %(levelname)s: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    logging.info("Logging at %s", level_str)


def restore_properties_for_cell(cell, entry: dict, hname: str, inversion_roots: set):
    count = 0
    for item in entry.get("modified_properties", []):
        key = item["identifier"]
        val = item["value"]
        typ = EDIFValueType.valueOf(item.get("type"))

        if key == "INIT":
            if hname in inversion_roots:
                val = invert_init_literal(val)
            val = re.sub(r"(h)([0-9a-fA-F]+)", lambda m: m.group(1) + m.group(2).upper(), val)

        count += 1
        cell.addProperty(key, val, typ)

    if count:
        return 1
    else:
        return 0

def derive_comp_init(parent_entry: dict, comp_cell) -> str | None:
    """
    Resize parent's INIT to match the logical LUT width of comp_cell.
    Uses only the LUT type size (no pin counting).
    """
    parent_init = next(
        (
            it["value"]
            for it in parent_entry.get("modified_properties", [])
            if it["identifier"] == "INIT"
        ),
        None,
    )
    if parent_init is None:
        return None

    parsed = parse_init(parent_init)
    if parsed is None:
        logging.warning("derive_comp_init: can't parse parent INIT '%s'; returning unchanged.",
                        parent_init)
        return parent_init
    parent_bits, parent_val = parsed

    child_w = LUTTools.getLUTSize(comp_cell)
    if child_w is None:
        logging.warning("derive_comp_init: can't infer LUT width for %s; returning parent INIT.",
                        comp_cell.getName())
        return parent_init

    bits_needed = 1 << child_w

    if parent_bits == bits_needed:
        new_lit = format_init(bits_needed, parent_val)
        logging.info("derive_comp_init: %s widths match %d bits.", comp_cell.getName(), bits_needed)
        return new_lit

    if parent_bits > bits_needed:
        # Keep LSBs (Vivado bit0 aligns with lowest address)
        new_val = parent_val & ((1 << bits_needed) - 1)
        logging.info("derive_comp_init: %s truncated %d->%d bits.", comp_cell.getName(),
                     parent_bits, bits_needed)
    else:
        tile = (bits_needed + parent_bits - 1) // parent_bits
        mask = (1 << parent_bits) - 1
        new_val = 0
        shift = 0
        for _ in range(tile):
            new_val |= (parent_val & mask) << shift
            shift += parent_bits
        new_val &= (1 << bits_needed) - 1
        logging.info("derive_comp_init: %s tiled %d->%d bits.", comp_cell.getName(),
                     parent_bits, bits_needed)

    return format_init(bits_needed, new_val)


def restore_all_properties(design: Design, json_db: dict[str, dict], inversion_roots: set):
    """
    Restores all properties to the cells in a design based on json_db.
    Added logic: if hname ends with "_comp", derive its INIT from the
    non-_comp twin's INIT using derive_comp_init().
    """
    netlist = design.getNetlist()
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    count = 0
    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                hname = h_inst.getFullHierarchicalInstName()
                entry = json_db.get(hname)
                if entry:
                    logging.debug("Successfully found entry for %s", hname)
                else:
                    logging.info("No entry found for %s", hname)

                    orig_cell_name = h_inst.getInst().getPropertiesMap().get("ORIG_CELL_NAME")
                    logging.info("Using original cell name %s", orig_cell_name)
                    entry = json_db.get(orig_cell_name)
                    if entry:
                        logging.info("Successfully found entry for %s", orig_cell_name)
                    else:
                        logging.info("Failed to find entry for %s", orig_cell_name)
                        logging.info("Falling back to tag matching")
                        cell = h_inst.getInst()
                        tag_prop = cell.getPropertiesMap().get(TAG_PROP)
                        if tag_prop:
                            tag = tag_prop.getValue()
                            entry = next((e for e in json_db.values() if e.get("tag") == tag), None)
                            
                            if entry:
                                logging.info("Successfully matched tag for %s", hname)
                            else:
                                logging.warning("No tag or modified twin for %s; skipping", hname)
                                continue
                        else:
                            logging.warning("No tag found for %s", hname)
                            continue
                
                new_init = derive_comp_init(entry, h_inst.getInst())
                if new_init:
                    found = False
                    for prop in entry.get("modified_properties", []):
                        if prop.get("identifier") == "INIT":
                            prop["value"] = new_init
                            found = True
                            break
                    if not found:
                        entry.setdefault("modified_properties", []).append({
                            "identifier": "INIT",
                            "value": new_init,
                            "type": "STRING"
                        })

                count += restore_properties_for_cell(h_inst.getInst(), entry, hname, inversion_roots)

    logging.info("Restored %d cells", count)


def apply_properties(design: Design, json_db: dict[str, dict]):
    """
    Reapplies obfuscated properties from a saved JSON db. Handles:
    1. Restoring INIT values (including inversion correction)
    2. Propagating inversion corrections through connected LUTs
    """
    logging.info("Building tag->properties map from JSON...")
    inversion_roots = [] # set(find_inversion_roots(design.getNetlist(), json_db))

    restore_all_properties(design, json_db, inversion_roots)


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
        "--unmodified_dcp_in", required=True, type=pathlib.Path, help="Input unobfuscated dcp"
    )
    p.add_argument(
        "--unmodified_edf_in", required=True, type=pathlib.Path, help="Input unobfuscated edf"
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
        "--unmodified_out_dcp", required=True, type=pathlib.Path, help="Output original DCP path"
    )
    p.add_argument(
        "--unmodified_out_edf", required=True, type=pathlib.Path, help="Output original EDF path"
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

    logging.info("Loading design checkpoints and netlists")
    t0 = time.perf_counter()
    design1 = Design.readCheckpoint(args.dcp_in, args.edf_in)
    design2 = Design.readCheckpoint(args.unmodified_dcp_in, args.unmodified_edf_in)
    # design1.flattenDesign()
    # design2.flattenDesign()
    logging.info("Designs loaded in %.2f s", time.perf_counter() - t0)

    logging.info("Applying saved properties to design")
    t1 = time.perf_counter()
    apply_properties(design1, props)
    logging.info("Applied properties in %.2f s", time.perf_counter() - t1)

    logging.info("Writing out new checkpoints")
    t2 = time.perf_counter()
    design1.writeCheckpoint(args.out_dcp)
    design2.writeCheckpoint(args.unmodified_out_dcp)
    logging.info("Wrote DCPs in %.2f s", time.perf_counter() - t2)

    logging.info("Writing out new EDIFs")
    t3 = time.perf_counter()
    design1.getNetlist().exportEDIF(args.out_edf)
    design2.getNetlist().exportEDIF(args.unmodified_out_edf)
    logging.info("Wrote EDIFs in %.2f s", time.perf_counter() - t3)

    logging.info("NetlistDeobfuscate complete")


if __name__ == "__main__":
    main()
