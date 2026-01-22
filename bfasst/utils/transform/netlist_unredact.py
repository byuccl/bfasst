"""
Netlist Unredaction (paper-aligned, minimal with name fallbacks)

- Reads redacted DCP/EDIF and restores properties by looking up entries
  in JSON.
- Lookup order: exact full hierarchical name -> ORIG_CELL_NAME -> tag (TAG_PROP)
  -> suffix stripping.
- Reads UNMODIFIED DCP/EDIF and writes them back out unchanged (paper artifact).
- Writes unredacted DCP/EDIF and the unmodified DCP/EDIF.
"""

import argparse
import json
import logging
import pathlib
import re
import time
from typing import Dict, Optional, Tuple

from bfasst import jpype_jvm
from bfasst.utils.transform.netlist_redact_helpers import TAG_PROP  # tag property key

jpype_jvm.start()

from java.io import FileOutputStream, PrintStream
from java.lang import System

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.edif import EDIFTools, EDIFValueType


# ----------------- Logging -----------------
def setup_logging(log_path: pathlib.Path, level_str: str) -> None:
    """Route stdout to a file and configure Python logging."""
    fos = FileOutputStream(str(log_path), True)
    ps = PrintStream(fos, True)
    System.setOut(ps)
    System.setErr(ps)

    level = getattr(logging, level_str.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        level=level,
        format="%(asctime)s.%(msecs)03d %(levelname)s: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    logging.info("Logging at %s", level_str)


# ----------------- Helpers -----------------
def _safe_value_type(type_str) -> EDIFValueType:
    """Map JSON type string to EDIFValueType, defaulting to STRING on error/None."""
    try:
        if isinstance(type_str, str) and type_str:
            return EDIFValueType.valueOf(type_str)
    except (ValueError, AttributeError, TypeError):
        pass
    return EDIFValueType.STRING


# Common uniquification/replication suffix patterns to strip iteratively.
_SUFFIX_PATTERNS = [
    r"\[\d+\]$",  # array-like indices: [5]
    r"_replica\d*$",  # _replica, _replica3
    r"_inst\d*$",  # _inst, _inst12
    r"_rewire\d*$",  # _rewire, _rewire2
    r"_comp\d*$",  # _comp, _comp7
    r"_rep\d*$",  # _rep, _rep4
    r"_[0-9]+$",  # _1, _2, ...
]
_SUFFIX_PATTERN = "|".join(_SUFFIX_PATTERNS)
_SUFFIX_RE = re.compile(f"(?:{_SUFFIX_PATTERN})")


def _strip_suffixes_lookup(name: str, json_db: Dict[str, dict]) -> Optional[Tuple[str, dict]]:
    """
    Iteratively strip common replication/uniquification suffixes from `name`
    and try to find an entry in json_db. Returns (matched_key, entry) or None.
    """
    cur = str(name)
    seen = set()
    for _ in range(64):  # guard against pathological loops
        if cur in json_db:
            return cur, json_db[cur]
        if cur in seen:
            break
        seen.add(cur)
        new = _SUFFIX_RE.sub("", cur)
        if new == cur or not new:
            break
        cur = new
    return None


def _get_prop_value(obj_map, key: str):
    """
    RapidWright property map can return either a value object with getValue()
    or the raw string; normalize to plain string if present.
    """
    try:
        prop = obj_map.get(key)
        if prop is None:
            return None
        # Try to call getValue() if available.
        try:
            return prop.getValue()
        except AttributeError:
            return str(prop)
    except (AttributeError, TypeError):
        return None


def _find_entry_for_instance(h_inst, hname: str, json_db: Dict[str, dict]) -> Optional[dict]:
    """
    Lookup order:
      1) exact full hierarchical name
      2) ORIG_CELL_NAME property (if present)
      3) tag match via TAG_PROP (if present in both)
      4) suffix-stripping fallback
    Returns the JSON entry dict or None.
    """
    # 1) Exact match on full hierarchical instance name
    entry = json_db.get(hname)
    if entry:
        return entry

    # 2) ORIG_CELL_NAME (if present)
    ocn = _get_prop_value(h_inst.getInst().getPropertiesMap(), "ORIG_CELL_NAME")
    if ocn and ocn in json_db:
        return json_db[ocn]

    # 3) Tag match via TAG_PROP
    tag_val = _get_prop_value(h_inst.getInst().getPropertiesMap(), TAG_PROP)
    if tag_val is not None:
        # Linear scan; avoids building extra indices and keeps file minimal.
        for v in json_db.values():
            if v.get("tag") == tag_val:
                return v

    # 4) Suffix-stripping fallback on hierarchical name
    stripped = _strip_suffixes_lookup(hname, json_db)
    if stripped:
        _, entry = stripped
        return entry

    return None


# ----------------- Core Restore -----------------
def restore_properties_for_cell(cell, entry: dict, hname: str) -> int:
    """
    Reapply properties exactly as stored in JSON for a given cell.
    Returns number of properties restored (>=1 => treated as restored).
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
        # Keep value as-is (no INIT transform or reshaping).
        cell.addProperty(key, val, typ)
        count += 1
    return count


def restore_all_properties(design: Design, json_db: Dict[str, dict]) -> None:
    """
    Iterate hierarchical instances and restore properties using the
    fallback chain (exact -> ORIG_CELL_NAME -> TAG_PROP -> suffix-strip).
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

                entry = _find_entry_for_instance(h_inst, hname, json_db)
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


# ----------------- CLI Runner -----------------
def main():
    """Netlist Unredaction Runner (paper-aligned with name fallbacks)."""
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--build_path", required=True, type=pathlib.Path, help="Dir for logs/outputs")

    # Redacted design (apply properties here)
    p.add_argument("--dcp_in", required=True, type=pathlib.Path, help="Input checkpoint (.dcp)")
    p.add_argument("--edf_in", required=True, type=pathlib.Path, help="Input EDIF (.edf)")
    p.add_argument(
        "--props_json",
        required=True,
        type=pathlib.Path,
        help="JSON mapping: full hier inst name -> properties",
    )
    p.add_argument("--out_dcp", required=True, type=pathlib.Path, help="Output unredacted DCP")
    p.add_argument("--out_edf", required=True, type=pathlib.Path, help="Output unredacted EDIF")

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

    p.add_argument("--log", default="netlist_unredact.log", help="Log filename (inside build_path)")
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

    # Load redacted design
    t0 = time.perf_counter()
    design_redacted = Design.readCheckpoint(args.dcp_in, args.edf_in)
    logging.info("Redacted design loaded in %.2f s", time.perf_counter() - t0)

    # Restore properties (with fallback matching)
    logging.info("Restoring properties on redacted design (with name fallbacks)")
    t1 = time.perf_counter()
    restore_all_properties(design_redacted, props_db)
    logging.info("Restoration complete in %.2f s", time.perf_counter() - t1)

    # Write unredacted outputs
    t2 = time.perf_counter()
    design_redacted.writeCheckpoint(args.out_dcp)
    logging.info("Wrote unredacted DCP in %.2f s", time.perf_counter() - t2)

    t3 = time.perf_counter()
    design_redacted.getNetlist().exportEDIF(args.out_edf)
    logging.info("Wrote unredacted EDIF in %.2f s", time.perf_counter() - t3)

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

    logging.info("NetlistUnredact (paper-aligned with fallbacks) complete")


if __name__ == "__main__":
    main()
