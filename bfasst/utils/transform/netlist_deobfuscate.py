"""
Netlist De-obfuscation (paper-aligned, minimal)

- Reads obfuscated DCP/EDIF and restores properties by exact full
  hierarchical instance name lookup from JSON (no transforms/heuristics).
- Reads UNMODIFIED DCP/EDIF and writes them back out unchanged (paper artifact).
- Writes de-obfuscated DCP/EDIF and the unmodified DCP/EDIF.

This intentionally omits transform inference, INIT reshaping, tag/suffix
fallbacks, etc., to match the paper’s methodology.
"""

import argparse
import json
import logging
import pathlib
import time

from bfasst import jpype_jvm

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.edif import EDIFTools, EDIFValueType
from java.lang import System
from java.io import PrintStream, FileOutputStream


def setup_logging(log_path: pathlib.Path, level_str: str) -> None:
    """Route stdout to a file and configure Python logging."""
    fos = FileOutputStream(str(log_path), True)
    ps = PrintStream(fos, True)
    System.setOut(ps)

    level = getattr(logging, level_str.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        level=level,
        format="%(asctime)s.%(msecs)03d %(levelname)s: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    logging.info("Logging at %s", level_str)


def _safe_value_type(type_str):
    """Map json type string to EDIFValueType, defaulting to STRING on error/None."""
    edif_value_names = {e.name() for e in EDIFValueType.values()}
    if not isinstance(type_str, str) or not type_str:
        return EDIFValueType.STRING
    if type_str in edif_value_names:
        return EDIFValueType.valueOf(type_str)
    logging.warning("Unknown EDIFValueType '%s'; defaulting to STRING", type_str)
    return EDIFValueType.STRING


def restore_properties_for_cell(cell, entry: dict, hname: str) -> int:
    """
    Reapply properties exactly as stored in JSON for a given cell.
    Returns number of properties restored.
    """
    props = entry.get("modified_properties", [])
    count = 0
    for item in props:
        key = item.get("identifier")
        val = item.get("value")
        typ = _safe_value_type(item.get("type"))
        if key is None or val is None:
            logging.warning("Skipping malformed property on %s: %s", hname, item)
            continue
        # Keep value as-is; no INIT reformatting or transform logic.
        cell.addProperty(key, val, typ)
        count += 1
    return count


def restore_all_properties(design: Design, json_db: dict[str, dict]) -> None:
    """
    Iterate hierarchical instances and restore properties by exact full
    hierarchical instance name match (paper methodology).
    """
    netlist = design.getNetlist()
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    total_instances = 0
    restored_instances = 0
    restored_props = 0
    missing = 0

    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                total_instances += 1
                hname = h_inst.getFullHierarchicalInstName()
                entry = json_db.get(hname)
                if not entry:
                    missing += 1
                    continue
                added = restore_properties_for_cell(h_inst.getInst(), entry, hname)
                if added:
                    restored_instances += 1
                    restored_props += added

    logging.info(
        "Instances scanned: %d | instances restored: %d | props restored: %d | no-match: %d",
        total_instances,
        restored_instances,
        restored_props,
        missing,
    )


def main():
    """Netlist Restoration Runner"""
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--build_path", required=True, type=pathlib.Path, help="Dir for logs/outputs")

    # Obfuscated design (apply properties here)
    p.add_argument("--dcp_in", required=True, type=pathlib.Path, help="Input checkpoint (.dcp)")
    p.add_argument("--edf_in", required=True, type=pathlib.Path, help="Input EDIF (.edf)")
    p.add_argument(
        "--props_json",
        required=True,
        type=pathlib.Path,
        help="JSON mapping: full hier inst name -> properties",
    )
    p.add_argument("--out_dcp", required=True, type=pathlib.Path, help="Output de-obfuscated DCP")
    p.add_argument("--out_edf", required=True, type=pathlib.Path, help="Output de-obfuscated EDIF")

    # Unmodified design (pass-through; artifact includes this)
    p.add_argument(
        "--unmodified_dcp_in",
        required=True,
        type=pathlib.Path,
        help="Input unmodified checkpoint (.dcp)",
    )
    p.add_argument(
        "--unmodified_edf_in", required=True, type=pathlib.Path, help="Input unmodified EDIF (.edf)"
    )
    p.add_argument(
        "--unmodified_out_dcp", required=True, type=pathlib.Path, help="Output unmodified DCP path"
    )
    p.add_argument(
        "--unmodified_out_edf", required=True, type=pathlib.Path, help="Output unmodified EDIF path"
    )

    p.add_argument(
        "--log", default="netlist_deobfuscate.log", help="Log filename (inside build_path)"
    )
    p.add_argument(
        "--logging_level",
        default="INFO",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        help="Verbosity level",
    )

    args = p.parse_args()

    args.build_path.mkdir(parents=True, exist_ok=True)
    log_path = args.build_path / args.log
    if log_path.exists():
        log_path.unlink()
    setup_logging(log_path, args.logging_level)

    # Load JSON properties db
    logging.info("Reading JSON properties from %s", args.props_json)
    with open(args.props_json, "r", encoding="utf-8") as f:
        props_db = json.load(f)
    logging.info("Loaded properties for %d entries", len(props_db))

    # Load obfuscated design
    t0 = time.perf_counter()
    design_obf = Design.readCheckpoint(args.dcp_in, args.edf_in)
    logging.info("Obfuscated design loaded in %.2f s", time.perf_counter() - t0)

    # Restore properties (exact match only)
    logging.info("Restoring properties on obfuscated design (exact name match)")
    t1 = time.perf_counter()
    restore_all_properties(design_obf, props_db)
    logging.info("Restoration complete in %.2f s", time.perf_counter() - t1)

    # Write de-obfuscated outputs
    t2 = time.perf_counter()
    design_obf.writeCheckpoint(args.out_dcp)
    logging.info("Wrote de-obfuscated DCP in %.2f s", time.perf_counter() - t2)

    t3 = time.perf_counter()
    design_obf.getNetlist().exportEDIF(args.out_edf)
    logging.info("Wrote de-obfuscated EDIF in %.2f s", time.perf_counter() - t3)

    # Load unmodified design and write through (no changes)
    logging.info("Loading unmodified design (pass-through)")
    t4 = time.perf_counter()
    design_unmod = Design.readCheckpoint(args.unmodified_dcp_in, args.unmodified_edf_in)
    logging.info("Unmodified design loaded in %.2f s", time.perf_counter() - t4)

    t5 = time.perf_counter()
    design_unmod.writeCheckpoint(args.unmodified_out_dcp)
    logging.info("Wrote unmodified DCP in %.2f s", time.perf_counter() - t5)

    t6 = time.perf_counter()
    design_unmod.getNetlist().exportEDIF(args.unmodified_out_edf)
    logging.info("Wrote unmodified EDIF in %.2f s", time.perf_counter() - t6)

    logging.info("NetlistDeobfuscate (paper-aligned) complete")


if __name__ == "__main__":
    main()
