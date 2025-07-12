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

from bfasst.utils.netlist_obfuscate_helpers import TAG_PROP, SENTINEL_VALUES
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


def invert_init_literal(lit: str) -> str:
    """
    Bitwise invert an arbitrary INIT literal string "64'h0123AB…" of the proper width.
    """
    width_str, hexstr = lit.split("'h")
    width = int(width_str)
    mask = (1 << width) - 1
    val = int(hexstr, 16)
    inv = (~val) & mask
    inv_str = f"{width}'h{inv:0{width//4}X}"
    # logging.debug("new string for lit %s: %s", lit, inv_str)
    return inv_str


def toggle_token(token: str) -> str:
    """Toggle a token by adding or removing a leading !"""
    return token[1:] if token.startswith("!") else f"!{token}"


def toggle_input_in_equation(eq, logical_pin: str) -> str:
    """
    Changes a boolean equation to have one of its inputs toggled.
    """
    pattern = rf"(!?{re.escape(logical_pin)})"
    py_eq = str(eq.toString())
    return re.sub(pattern, lambda m: toggle_token(m.group(1)), py_eq)


_HEX_RE = re.compile(r"^(\d+)'h([0-9a-fA-F]+)$")


def parse_init(lit: str) -> tuple[int, int]:
    """
    Parse \"<W>'h<HEX>\"  →  (width, value)
    Return **None** if the string is not a hex literal.
    """
    m = _HEX_RE.fullmatch(lit.strip())
    if not m:
        return None
    width = int(m.group(1))
    value = int(m.group(2), 16)
    return width, value


def is_bitwise_invert(a: str, b: str) -> bool:
    """
    True iff INIT string *b* is exactly the bitwise-NOT of *a*.
    Safely returns False if either literal is not hex form.
    """
    pa = parse_init(a)
    pb = parse_init(b)
    if pa is None or pb is None:
        return False

    w_a, v_a = pa
    w_b, v_b = pb
    if w_a != w_b:
        return False

    mask = (1 << w_a) - 1
    return v_b == (~v_a & mask)


def resolve_logical_pin(cell, bel_pin_name: str, wire: str) -> str:
    lp = cell.getLogicalPinMapping(bel_pin_name)
    if lp is not None:
        return lp

    for e in cell.getPinMappingsL2P().entrySet():
        if wire in e.getValue():
            return e.getKey()
    return None


def process_lut(site, bel_pin, wire, visited: set) -> tuple[bool, str, str]:
    """
    Helper function to propagate signal inversions through a LUT
    """
    cell = site.getCell(bel_pin.getBEL().getName())
    if cell is None or not LUTTools.isCellALUT(cell) or cell in visited:
        return False, None, None
    visited.add(cell)

    if not cell_is_obfuscated(cell):
        return False, None, None

    lp = resolve_logical_pin(cell, bel_pin.getName(), wire)
    if lp is None:
        return False, None, None

    eq = LUTTools.getLUTEquation(cell)
    new_eq = toggle_input_in_equation(eq, lp)
    if new_eq != eq:
        LUTTools.configureLUT(cell, new_eq)
        return True, cell, site
    return False, None, None


def cell_is_obfuscated(cell) -> bool:
    """
    Returns true if a cell was obfuscated before implementation
    """
    props = cell.getEDIFCellInst().getPropertiesMap()
    return props is not None and props.containsKey(TAG_PROP)


def process_site_wire(site, wire, visited: set) -> tuple[list["Net"], int]:
    """
    Process all bel_pins for a given site+wire and return new nets to enqueue + count of flips.
    """
    new_nets = []
    flips = 0

    for bel_pin in site.getSiteWirePins(wire):
        updated, cell, site_inst = process_lut(site, bel_pin, wire, visited)
        if not updated or cell is None:
            continue

        bel_o = LUTTools.getLUTOutputPin(cell.getBEL())
        spi_o = site_inst.getSitePinInst(bel_o.getName())
        if spi_o is not None and spi_o.getNet() is not None:
            new_nets.append(spi_o.getNet())
            flips += 1

    return new_nets, flips


def propagate_inversions(design: Design, roots: list[str]) -> int:
    """
    After fixing LUT inversions post-implementation, propagate inversion
    downstream by flipping inputs to connected LUTs marked as obfuscated.
    """
    flips = 0
    empty = ArrayList()

    for hier_name in roots:
        root = design.getCell(hier_name)
        if root is None:
            continue

        out_spi = root.getSitePinFromLogicalPin("O", empty)
        if out_spi is None or out_spi.getNet() is None:
            continue

        queue = [out_spi.getNet()]
        visited = set()

        while queue:
            net = queue.pop()
            for sink in net.getSinkPins():
                site = sink.getSiteInst()
                wire = sink.getSiteWireName()

                new_nets, new_flips = process_site_wire(site, wire, visited)
                queue.extend(new_nets)
                flips += new_flips

    return flips


def find_inversion_roots(netlist, json_db) -> list[str]:
    """
    Return hierarchical names of LUTs whose INIT was complemented
    during obfuscation (i.e. current INIT is bitwise-inverted sentinel).
    """
    hier_map = EDIFTools.createCellInstanceMap(netlist)
    roots = []

    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                hname = h_inst.getFullHierarchicalInstName()
                entry = json_db.get(hname)
                if entry is None:
                    continue
                cell = h_inst.getInst()
                lut_size = LUTTools.getLUTSize(cell)
                props = cell.getPropertiesMap()
                init_prop = props.get("INIT")
                if init_prop is None:
                    continue

                cur_init = str(init_prop.getValue())

                if "tag" in entry:
                    if lut_size in SENTINEL_VALUES and is_bitwise_invert(
                        SENTINEL_VALUES[lut_size], cur_init
                    ):
                        roots.append(hname)
<<<<<<< HEAD
                        logging.debug("Found inversion root")
=======
>>>>>>> origin/retime
                else:
                    base_init = next(
                        (
                            p["value"]
                            for p in entry["baseline_properties"]
                            if p["identifier"] == "INIT"
                        ),
                        None,
                    )
                    if base_init and is_bitwise_invert(base_init, cur_init):
                        logging.debug("Found nonobfuscated cell that was inverted")
                        roots.append(hname)

    return roots


def restore_properties_for_cell(cell, entry: dict, hname: str, inversion_roots: set):
    for item in entry.get("modified_properties", []):
        key = item["identifier"]
        val = item["value"]
        typ = EDIFValueType.valueOf(item.get("type"))

<<<<<<< HEAD
        if key == "INIT":
            if hname in inversion_roots:
                val = invert_init_literal(val)
            val = re.sub(r"(h)([0-9a-fA-F]+)", lambda m: m.group(1) + m.group(2).upper(), val)
=======
        if key == "INIT" and hname in inversion_roots:
            val = invert_init_literal(val)
>>>>>>> origin/retime

        cell.addProperty(key, val, typ)


<<<<<<< HEAD
def init_literal_to_bits(init_literal: str, width_bits: int) -> list[int]:
    """Return a list of bit-values (LSB first) for the given INIT literal."""
    bits = int(str(init_literal).split("'h")[1], 16)
    return [(bits >> i) & 1 for i in range(1 << width_bits)]


def pack_bits_to_init(bits: list[int]) -> str:
    """Pack LSB-first bit list into canonical hex INIT literal."""
    value = 0
    for i, b in enumerate(bits):
        value |= (b & 1) << i
    hex_chars = (len(bits) + 3) // 4  # 4 bits per hex digit
    return f"{len(bits)}'h{value:0{hex_chars}X}"


def eval_parent_subset(parent_bits, parent_width, subset, perm, sigma):
    """Evaluate parent LUT on a restricted, permuted, possibly inverted subset."""
    m = len(subset)
    tbl = []
    for x in range(1 << m):
        addr = 0
        for i, pin in enumerate(subset):
            bit = (x >> perm[i]) & 1
            if sigma[i]:
                bit ^= 1  # input inversion
            addr |= bit << pin
        tbl.append(parent_bits[addr])
    return tbl


def derive_comp_init(parent_entry: dict, comp_cell) -> str | None:
    """
    Returns a canonical INIT literal for comp_cell derived only from its
    parent's INIT. Does NOT look at the (obfuscated) child INIT.
    """
    logging.debug("derive_comp_init")
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

    bit_len = int(parent_init.split("'h")[0])
    parent_width = int(math.log2(bit_len)) 
    parent_bits = init_literal_to_bits(parent_init, parent_width)
    child_width = LUTTools.getLUTSize(comp_cell)
    if child_width == 0:  # not a LUT
        return None

    pins = list(range(parent_width))
    best_bits = None

    # Enumerate all subset/perm/sigma combos
    if parent_width > 4:
        logging.warning("Parent width is too wide. Skipping")
        return None 

    for subset in combinations(pins, child_width):
        for perm in permutations(range(child_width)):
            for sigma in product([0, 1], repeat=child_width):
                tbl = eval_parent_subset(parent_bits, parent_width, subset, perm, sigma)
                tbl_inv = [1 - b for b in tbl]
                # Choose lexicographically-smallest truth table (canonical)
                for candidate in (tbl, tbl_inv):
                    if (best_bits is None) or (candidate < best_bits):
                        best_bits = candidate

    if best_bits is None:
        return None
    return pack_bits_to_init(best_bits)


def restore_all_properties(design: Design, json_db: dict[str, dict], inversion_roots: set):
    """
    Restores all properties to the cells in a design based on json_db.
    Added logic: if hname ends with "_comp", derive its INIT from the
    non-_comp twin's INIT using derive_comp_init().
=======
def restore_all_properties(design: Design, json_db: dict[str, dict], inversion_roots: set):
    """
    Restores all properties to the cells in a design based on json_db
>>>>>>> origin/retime
    """
    netlist = design.getNetlist()
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                hname = h_inst.getFullHierarchicalInstName()
                entry = json_db.get(hname)
<<<<<<< HEAD

                # Fallback #1 – tag matching
                if entry is None:
                    cell = h_inst.getInst()
                    tag_prop = cell.getPropertiesMap().get(TAG_PROP)
                    if tag_prop:
                        tag = tag_prop.getValue()
                        entry = next((e for e in json_db.values() if e.get("tag") == tag), None)

                # Fallback #2 – handle "_comp" twin
                if entry is None and hname.endsWith("_comp"):
                    base_hname = hname[:-5]                       # strip "_comp"
                    base_entry = json_db.get(base_hname)
                    if base_entry is not None:
                        logging.info("[_comp] matched %s -> %s", hname, base_hname)
                        new_init = derive_comp_init(base_entry, h_inst.getInst())
                        logging.info("made it past derive_comp_init")
                        if new_init:
                            logging.info("[_comp] derived INIT %s", new_init)
                            entry = {"modified_properties": [{
                                         "identifier": "INIT",
                                         "value":      new_init,
                                         "type":       "STRING"}]}
                        else:
                            logging.warning("[_comp] could not derive INIT for %s", hname)

                # No match – skip
                if entry is None:
                    logging.warning("No tag or _comp twin for %s; skipping", hname)
                    continue
                
=======
                if entry is None:
                    logging.warning("Hierarchical name %s not found in JSON file", hname)
                    continue
>>>>>>> origin/retime
                restore_properties_for_cell(h_inst.getInst(), entry, hname, inversion_roots)


def apply_properties(design: Design, json_db: dict[str, dict]):
    """
    Reapplies obfuscated properties from a saved JSON db. Handles:
    1. Restoring INIT values (including inversion correction)
    2. Propagating inversion corrections through connected LUTs
    """
    logging.info("Building tag->properties map from JSON...")
    inversion_roots = set(find_inversion_roots(design.getNetlist(), json_db))

    restore_all_properties(design, json_db, inversion_roots)

<<<<<<< HEAD
    # flips = propagate_inversions(design, inversion_roots)
    # logging.info("Propagated inversions across %d tagged LUTs", flips)
=======
    flips = propagate_inversions(design, inversion_roots)
    logging.info("Propagated inversions across %d tagged LUTs", flips)
>>>>>>> origin/retime


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
