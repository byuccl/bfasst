"""
Tool to perform obfuscation on a post-synthesis netlist.
Go through a bunch of different cell types and wipe their properties
"""

import argparse
import re
import logging
import pathlib
import time
import shutil
import json
import copy
from collections import defaultdict
import spydrnet as sdn


def get_masking_init(lut_size):
    bits = 2**lut_size
    # This INIT string works to obfuscate the LUTs and doesn't seem to change implementation
    return f"0x{'0'*(bits//4 - 1)}1"


def obfuscate_lut(inst):
    """
    Overwrite INIT in LUT if present and not size 1.
    Returns True if changed.
    """
    ref_name = inst.reference.name
    match = re.match(r"LUT(\d)", ref_name)
    if not match:
        logging.warning("LUT not matched when blanking INIT string: %s", ref_name)
        return False

    lut_size = int(match.group(1))
    if lut_size == 1:
        return False

    changed = False
    for prop in inst.data.get("EDIF.properties", []):
        if prop.get("identifier") == "INIT":
            prop["value"] = get_masking_init(lut_size)
            changed = True
    return changed


def obfuscate_bram(inst):
    """
    Obfuscate BRAM properties while preserving critical ones.
    """
    # Preserve key BRAM parameters like width, depth, write mode, etc.
    skip_props = [
        "READ_WIDTH_A",
        "WRITE_WIDTH_A",
        "READ_WIDTH_B",
        "WRITE_WIDTH_B",
        "WRITE_MODE_A",
        "WRITE_MODE_B",
        "RAM_MODE",
    ]
    return obfuscate_all(inst, skip_props=skip_props)


def obfuscate_all(inst, skip_props=None):
    """
    Zero out all properties except those in skip_props.
    Returns True if any property was changed.
    """
    if skip_props is None:
        skip_props = set()
    else:
        skip_props = set(skip_props)

    changed = False
    for prop in inst.data.get("EDIF.properties", []):
        name = prop["identifier"]
        if name in skip_props:
            continue

        old = prop["value"]
        if isinstance(old, bool):
            new = False
        elif isinstance(old, int):
            new = 0
        elif isinstance(old, str) and old.startswith("48'h"):
            new = "48'h000000000000"
        else:
            new = "NONE"

        if prop["value"] != new:
            prop["value"] = new
            changed = True

    return changed


def get_modified_props(before: list[dict], after: list[dict]) -> list[dict]:
    """
    Returns a list of properties that were changed between `before` and `after`.
    Comparison is based on 'identifier' and 'value'.
    """
    before_map = {p["identifier"]: p["value"] for p in before}
    after_map = {p["identifier"]: p["value"] for p in after}

    modified = []
    for key, after_val in after_map.items():
        before_val = before_map.get(key, None)
        if before_val != after_val:
            modified.append({"identifier": key, "value": before_val})

    return modified


def obfuscate_cell_properties(top, out_path):
    """
    Obfuscate LUTs and DSPs in a design, saving all original properties to a JSON log.
    """
    modified_cells = {}
    type_counts = defaultdict(int)
    count = 0

    logging.debug("Beginning iteration through all instances")
    for inst in top.get_instances():
        if inst.reference is None:
            continue

        ref_name = inst.reference.name
        # logging.debug("Working with reference: %s", ref_name)

        original_props = copy.deepcopy(inst.data.get("EDIF.properties", []))  # copy

        if ref_name.startswith("LUT"):
            modified = obfuscate_lut(inst)
        elif ref_name.startswith("DSP"):
            modified = obfuscate_all(inst)
        elif ref_name.startswith("BRAM"):
            modified = obfuscate_bram(inst)
        else:
            continue

        if modified:
            # logging.debug("Obfuscated properties from: %s", ref_name)
            new_props = inst.data.get("EDIF.properties", [])
            modified_props = get_modified_props(original_props, new_props)
            if modified_props:
                modified_cells[inst["EDIF.identifier"]] = {
                    "name": inst.get(".NAME", ""),
                    "type": ref_name,
                    "original_properties": modified_props,
                }
                type_counts[ref_name] += 1
                count += 1

    with open(out_path, "w") as f:
        json.dump(modified_cells, f, indent=2)

    logging.info("Obfuscated %d cells. Original properties written to %s", count, out_path)
    logging.debug("Summary of obfuscated cell types:")
    for cell_type, type_count in sorted(type_counts.items()):
        logging.debug("  %s: %d", cell_type, type_count)

    return count


def main():
    """
    Tool to perform obfuscation on a post-synthesis netlist.
    Currently its only function is to purge INIT values for
    all LUTs in a synthesized design and replace them with dummy values
    """
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "build_path",
        type=pathlib.Path,
        help="Directory where logs (and any intermediates) go",
    )
    parser.add_argument(
        "--dcp",
        required=True,
        type=pathlib.Path,
        help="Input Vivado checkpoint (.dcp)",
    )
    parser.add_argument(
        "--edf",
        required=True,
        type=pathlib.Path,
        help="Input synthesized EDIF netlist (.edf)",
    )
    parser.add_argument(
        "--out_dcp",
        required=True,
        type=pathlib.Path,
        help="Where to write the transformed checkpoint",
    )
    parser.add_argument(
        "--out_edf",
        required=True,
        type=pathlib.Path,
        help="Where to write the transformed EDIF",
    )
    parser.add_argument(
        "--original_cell_props",
        default="original_cell_props.json",
        help="Location of original cell properties before obfuscation",
    )
    parser.add_argument(
        "--log",
        default="netlist_transform.log",
        help="Log filename (inside build_path)",
    )
    parser.add_argument(
        "--logging_level",
        default="INFO",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        help="Verbosity level",
    )
    args = parser.parse_args()

    args.build_path.mkdir(parents=True, exist_ok=True)

    log_path = args.build_path / args.log
    log_path.unlink(missing_ok=True)
    numeric_level = getattr(logging, args.logging_level.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        format="%(asctime)s %(levelname)s %(message)s",
        level=numeric_level,
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    logging.info("NetlistObfuscate start")

    t0 = time.perf_counter()
    shutil.copyfile(args.dcp, args.out_dcp)
    logging.info(
        "Copied DCP %s -> %s in %.3f s",
        args.dcp,
        args.out_dcp,
        time.perf_counter() - t0,
    )

    t1 = time.perf_counter()
    logging.debug("Parsing EDF...")
    netlist_ir = sdn.parse(str(args.edf))
    logging.debug("Finished parsing EDF in %.3f s", time.perf_counter() - t1)

    t2 = time.perf_counter()
    logging.debug("Starting cell property obfuscation...")
    top = netlist_ir.top_instance
    orig_cell_props = args.build_path / args.original_cell_props
    count = obfuscate_cell_properties(top, orig_cell_props)
    logging.debug("Finished cell property obfuscation in %.3f s", time.perf_counter() - t2)
    logging.debug("%d properties changed", count)

    t3 = time.perf_counter()
    logging.debug("Starting EDF write...")
    sdn.compose(netlist_ir, str(args.out_edf), write_blackbox=False)
    logging.info(
        "Wrote EDF %s in %.3f s",
        args.out_edf,
        time.perf_counter() - t3,
    )
    logging.info("NetlistObfuscate done in %.3f s", time.perf_counter() - t0)


if __name__ == "__main__":
    main()
