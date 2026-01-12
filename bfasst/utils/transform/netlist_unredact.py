"""
Netlist Unredaction (paper-aligned, minimal with name fallbacks)

- Reads redacted DCP/EDIF and restores properties by looking up entries
  in JSON.
- Lookup order: exact full hierarchical name -> ORIG_CELL_NAME -> tag (TAG_PROP)
  -> suffix stripping.
- Reads UNMODIFIED DCP/EDIF and writes them back out unchanged (paper artifact).
- Writes unredacted DCP/EDIF and the unmodified DCP/EDIF.

Optional: Handle RESTRUCT_OPT transformations by computing correct INITs using
Ashenhurst-Curtis Decomposition (ACD) when pre-phys_opt checkpoints are provided.
"""

import argparse
import json
import logging
import pathlib
import re
import time
from typing import Dict, Tuple, Optional, List

from bfasst import jpype_jvm
from bfasst.utils.transform.netlist_redact_helpers import TAG_PROP  # tag property key

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.edif import EDIFTools, EDIFValueType
from java.lang import System
from java.io import PrintStream, FileOutputStream


# ----------------- Logging -----------------
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


# ----------------- RESTRUCT_OPT Handling -----------------
# pylint: disable=too-many-locals
def handle_restruct_opt(
    design: Design,
    json_db: Dict[str, dict],
    pre_phys_opt_dcp: pathlib.Path,
    pre_phys_opt_edf: pathlib.Path,
    post_phys_opt_dcps: List[pathlib.Path],
) -> int:
    """
    Handle RESTRUCT_OPT transformations by computing correct INITs.

    Uses the restruct_transform module to:
    1. Track transformations across phys_opt passes
    2. Identify restructured cell groups
    3. Compute correct INITs using ACD factorization
    4. Apply the computed INITs to the design

    Returns number of cells updated.
    """
    # Import here to avoid circular imports and keep import optional
    # pylint: disable=import-outside-toplevel
    from bfasst.utils.transform.restruct_transform import (
        track_restruct_transforms,
        build_composite_function,
        compute_restruct_inits,
        parse_edif_cells_rapidwright,
    )

    logging.info("Handling RESTRUCT_OPT transformations...")
    logging.info("  Pre-phys_opt: %s", pre_phys_opt_dcp)
    logging.info("  Post-phys_opt checkpoints: %d", len(post_phys_opt_dcps))

    # Track transformations
    _, _, groups, final_netlist = track_restruct_transforms(
        pre_phys_opt_dcp, pre_phys_opt_edf, post_phys_opt_dcps
    )

    if not groups:
        logging.info("No RESTRUCT_OPT groups found")
        return 0

    logging.info("Found %d RESTRUCT_OPT groups", len(groups))

    # Parse pre-netlist for composite function building
    pre_netlist = parse_edif_cells_rapidwright(pre_phys_opt_dcp, pre_phys_opt_edf)

    # Get cell instance map for the design
    netlist = design.getNetlist()
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    # Build name -> cell instance mapping
    cell_by_name = {}
    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                name = str(h_inst.getInst().getName())
                cell_by_name[name] = h_inst.getInst()

    cells_updated = 0

    for group in groups:
        logging.info(
            "Processing group: output=%s, intermediates=%s",
            group.output_cell,
            group.intermediate_cells,
        )

        # Build composite function
        composite_func = build_composite_function(group, json_db, pre_netlist)
        if composite_func is None:
            logging.warning("Could not build composite function for group %s", group.output_cell)
            continue

        # Compute correct INITs
        computed_inits = compute_restruct_inits(group, final_netlist, composite_func)

        # Apply computed INITs to the design
        all_cells = [group.output_cell] + group.intermediate_cells
        for cell_name in all_cells:
            if cell_name not in cell_by_name:
                logging.warning("Cell %s not found in design", cell_name)
                continue

            cell = cell_by_name[cell_name]
            new_init = computed_inits.get(cell_name)
            if new_init is None:
                continue

            # Format INIT value
            cell_info = final_netlist[cell_name]
            init_width = cell_info.init_width
            init_str = f"{init_width}'h{new_init:X}"

            logging.info("  Setting %s INIT = %s", cell_name, init_str)
            cell.addProperty("INIT", init_str, EDIFValueType.STRING)
            cells_updated += 1

    logging.info("RESTRUCT_OPT handling complete: %d cells updated", cells_updated)
    return cells_updated


# ----------------- CLI Runner -----------------
# pylint: disable=too-many-locals,too-many-statements
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

    # Optional: RESTRUCT_OPT handling
    p.add_argument(
        "--pre_phys_opt_dcp",
        type=pathlib.Path,
        help="Pre-phys_opt checkpoint (for RESTRUCT_OPT handling)",
    )
    p.add_argument(
        "--pre_phys_opt_edf",
        type=pathlib.Path,
        help="Pre-phys_opt EDIF (for RESTRUCT_OPT handling)",
    )
    p.add_argument(
        "--post_place_dir",
        type=pathlib.Path,
        help="Directory containing post-place phys_opt checkpoints (*.dcp files)",
    )
    p.add_argument(
        "--post_route_dir",
        type=pathlib.Path,
        help="Directory containing post-route phys_opt checkpoints (*.dcp files)",
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

    # Handle RESTRUCT_OPT transformations if checkpoints provided
    if args.pre_phys_opt_dcp and args.pre_phys_opt_edf and args.post_place_dir:
        # Collect checkpoints from both post_place and post_route directories
        # Exclude pre_phys_opt.dcp since it's the starting point, not a phys_opt output
        post_phys_opt_dcps = []

        if args.post_place_dir.exists():
            for dcp in sorted(args.post_place_dir.glob("*.dcp")):
                if dcp.name != "pre_phys_opt.dcp":
                    post_phys_opt_dcps.append(dcp)

        if args.post_route_dir and args.post_route_dir.exists():
            for dcp in sorted(args.post_route_dir.glob("*.dcp")):
                post_phys_opt_dcps.append(dcp)

        if post_phys_opt_dcps:
            logging.info("Found %d phys_opt checkpoints", len(post_phys_opt_dcps))
            t_restruct = time.perf_counter()
            handle_restruct_opt(
                design_redacted,
                props_db,
                args.pre_phys_opt_dcp,
                args.pre_phys_opt_edf,
                post_phys_opt_dcps,
            )
            logging.info("RESTRUCT_OPT handling took %.2f s", time.perf_counter() - t_restruct)
        else:
            logging.warning(
                "No phys_opt DCP files found in %s or %s", args.post_place_dir, args.post_route_dir
            )
    elif args.pre_phys_opt_dcp or args.pre_phys_opt_edf or args.post_place_dir:
        logging.warning(
            "RESTRUCT_OPT handling requires: --pre_phys_opt_dcp, "
            "--pre_phys_opt_edf, and --post_place_dir"
        )

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
