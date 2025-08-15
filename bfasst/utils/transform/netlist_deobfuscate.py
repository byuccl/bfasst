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
import copy
import re
from itertools import combinations, permutations, product

from bfasst.utils.transform.netlist_obfuscate_helpers import (
    TAG_PROP,
    SENTINEL_VALUES,
    parse_init,
    format_init,
    get_masking_init,
)
from bfasst.utils.transform.init_restoration_helpers import apply_transforms, derive_init_transform
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
            val = re.sub(r"(h)([0-9a-fA-F]+)", lambda m: m.group(1) + m.group(2).upper(), val)

        count += 1
        cell.addProperty(key, val, typ)

    if count:
        return 1
    else:
        return 0


transforms_not_found = 0


def derive_modified_init(json_entry: dict, obfuscated_cell):
    """
    Resize json db entry's INIT to match the logical LUT width of an optimized cell.
    Uses only the LUT type size (no pin counting).
    """
    global transforms_not_found
    json_init_str = next(
        (
            it["value"]
            for it in json_entry.get("modified_properties", [])
            if it["identifier"] == "INIT"
        ),
        None,
    )
    if json_init_str is None:
        return None

    json_bits, json_val = parse_init(json_init_str)

    child_w = LUTTools.getLUTSize(obfuscated_cell)
    bits_needed = 1 << child_w

    sentinel_init_str = get_masking_init(None, math.log2(json_bits))
    _, sentinel_init_val = parse_init(sentinel_init_str)
    obfuscated_init_str = str(obfuscated_cell.getPropertiesMap().get("INIT").getValue())
    _, obfuscated_init_val = parse_init(obfuscated_init_str)

    # return format_init(bits_needed, json_val, False)
    if sentinel_init_val != obfuscated_init_val:
        logging.info(
            "Found non equivalent init strings in cell %s. Deriving transformation %s -> %s",
            obfuscated_cell.getName(),
            sentinel_init_str,
            obfuscated_init_str,
        )
        transforms = derive_init_transform(sentinel_init_val, obfuscated_init_val)
        if transforms:
            logging.info("Found transforms...")
            for t in transforms:
                logging.info(t)
            new_val = apply_transforms(json_val, transforms, None)
            new_init = format_init(bits_needed, new_val, False)
            logging.info("json_init_str: %s, new_init: %s", json_init_str, new_init)
        else:
            transforms_not_found += 1
            logging.warning(
                "Not able to find transforms from %s to %s", sentinel_init_str, obfuscated_init_str
            )
            new_val = json_val
    else:
        new_val = json_val

    return format_init(bits_needed, new_val, False)


def strip_suffixes_lookup(name: str, json_db: dict[str, dict]):
    # Try the full name first
    if name in json_db:
        return name, json_db[name]

    _SUFFIX_TOKENS = [
        "_comp",
        "_rewire",
        "_replica",
        "_rep",
        "_1",
        "_2",
        "_3",
        "_4",
        "_5",
        "_6",
        "_7",
        "_8",
        "_9",
        "_0",
    ]

    tokens = sorted(_SUFFIX_TOKENS, key=len, reverse=True)
    cur = str(name)
    seen = set()

    for _ in range(50):
        if cur in json_db:
            return cur, json_db[cur]

        if cur in seen:
            break
        seen.add(cur)

        matched = False
        for tok in tokens:
            if cur.endswith(tok):
                cur = cur[: -len(tok)]
                matched = True
                break

        if not matched:
            break

        if not cur:
            break

    return None


def _find_entry_for_instance(h_inst, hname: str, json_db: dict[str, dict]):
    entry = json_db.get(hname)
    if entry:
        return entry

    # logging.info("No entry found for %s", hname)

    orig_cell_name_prop = h_inst.getInst().getPropertiesMap().get("ORIG_CELL_NAME")
    if orig_cell_name_prop:
        orig_cell_name = orig_cell_name_prop
        # logging.info("Using original cell name %s", orig_cell_name)
        entry = json_db.get(orig_cell_name)
        if entry:
            # logging.info("Successfully found entry for %s", orig_cell_name)
            return entry
        # logging.info("Failed to find entry for %s", orig_cell_name)
    else:
        pass
        # logging.info("No ORIG_CELL_NAME property for %s", hname)

    cell = h_inst.getInst()
    tag_prop = cell.getPropertiesMap().get(TAG_PROP)
    if tag_prop:
        tag = tag_prop.getValue()
        entry = next((e for e in json_db.values() if e.get("tag") == tag), None)
        if entry:
            # logging.info("Successfully matched tag for %s", hname)
            return entry
        # logging.info("Tag did not match any entry for %s", hname)
    else:
        pass
        # logging.info("No tag property for %s", hname)

    stripped = strip_suffixes_lookup(hname, json_db)
    if stripped:
        base_name, entry = stripped
        # logging.info("Recovered base name %s from %s", base_name, hname)
        return entry

    logging.warning("No match (name/orig/tag/suffix) for %s; skipping", hname)
    return None


def _maybe_patch_init(entry: dict, h_inst):
    # Derive new INIT (returns None if not applicable)
    if "LUT" in h_inst.getCellName():
        new_init = derive_modified_init(entry, h_inst.getInst())
    else:
        new_init = next(
            (
                it["value"]
                for it in entry.get("modified_properties", [])
                if it["identifier"] == "INIT"
            ),
            None,
        )

    if not new_init:
        return
    if "LUT" not in h_inst.getCellName():
        # logging.info(
        #     "Skipping INIT operations on non-LUT cell %s", h_inst.getCellName()
        # )
        return

    props = entry.setdefault("modified_properties", [])
    for prop in props:
        if prop.get("identifier") == "INIT":
            prop["value"] = new_init
            return

    props.append({"identifier": "INIT", "value": new_init, "type": "STRING"})


def restore_all_properties(
    design: Design,
    json_db: dict[str, dict],
    inversion_roots: set,
):
    netlist = design.getNetlist()
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    restored_count = 0
    counts = {}

    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                hname = h_inst.getFullHierarchicalInstName()
                type = h_inst.getCellName()
                counts[type] = counts.get(type, 0) + 1

                entry_in_db = _find_entry_for_instance(h_inst, hname, json_db)
                if not entry_in_db:
                    continue

                entry = copy.deepcopy(entry_in_db)
                _maybe_patch_init(entry, h_inst)

                restored_count += restore_properties_for_cell(
                    h_inst.getInst(), entry, hname, inversion_roots
                )

    logging.info("Restored %d cells", restored_count)
    for type, count in counts.items():
        logging.info("   %s: %d", type, count)

    if transforms_not_found:
        logging.warning("Failed to find %d INIT string mappings", transforms_not_found)


def apply_properties(design: Design, json_db: dict[str, dict]):
    """
    Reapplies obfuscated properties from a saved JSON db. Handles:
    1. Restoring INIT values (including inversion correction)
    2. Propagating inversion corrections through connected LUTs
    """
    logging.info("Building tag->properties map from JSON...")
    inversion_roots = []  # set(find_inversion_roots(design.getNetlist(), json_db))

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
