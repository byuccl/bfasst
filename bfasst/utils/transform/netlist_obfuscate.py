"""
Tool to perform obfuscation on a post-synthesis netlist.
Go through a bunch of different cell types and wipe their properties
Then store the original properties in a JSON file for restoration later
"""

import argparse
import logging
import pathlib
import time
import json
import uuid
from collections import defaultdict
from bfasst.config import PART
from bfasst.utils.general import json_write_if_changed
from bfasst.utils.transform.netlist_obfuscate_helpers import TAG_PROP, get_masking_init

from bfasst import jpype_jvm

jpype_jvm.start()

# pylint: disable=wrong-import-position, wrong-import-order
from java.lang import System
from java.util import ArrayList
from java.io import PrintStream, FileOutputStream
from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.design.tools import LUTTools
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.edif import EDIFTools, EDIFNetlist, EDIFHierCellInst, EDIFValueType, EDIFDirection, EDIFCell, EDIFCellInst
from com.xilinx.rapidwright.eco import ECOTools

def _json_entry(prop_name: str, prop_val: "EDIFPropertyValue") -> dict[str, str]:
    """
    Returns a json entry with the correct type based on a property's name and value
    """
    return {
        "identifier": str(prop_name),
        "value": str(prop_val.getValue()),
        "type": str(prop_val.getType().name()),
    }


def add_tag(inst):
    tag = uuid.uuid4().hex
    inst.getInst().addProperty(TAG_PROP, tag)
    return tag


def obfuscate_lut(inst, counts) -> tuple[bool, list[dict[str, str]]]:
    """
    Obfuscate a single LUT instance.
     Replaces INIT with a masking literal.
     Adds a unique TAG_PROP so we can reverse later.
     Bumps the per-type counter in `counts`.

    Returns
    -------
    changed : bool                   – True if INIT modified
    tag     : str  | None            – Random tag added (None if unchanged)
    mods    : list[{"identifier","value"}] – Original properties we overwrote
    """
    props_map = inst.getInst().getPropertiesMap()
    lut_size = LUTTools.getLUTSize(inst.getInst())

    if lut_size <= 1:
        return False, []

    old_init = str(props_map.get("INIT").getValue())
    new_init = get_masking_init(str(old_init), lut_size)

    inst.getInst().addProperty("INIT", new_init)

    counts[inst.getCellType().getName()] += 1
    return True, [{"identifier": "INIT", "value": old_init, "type": "STRING"}]


def obfuscate_bram(inst, counts):
    """
    Obfuscate BRAM properties while preserving critical ones.
    """
    skip_props = [
        "RAM_MODE",
        "BRAM_SIZE",
        "READ_WIDTH_A",
        "READ_WIDTH_B",
        "WRITE_WIDTH_A",
        "WRITE_WIDTH_B",
        "WRITE_MODE_A",
        "WRITE_MODE_B",
        "DOA_REG",
        "DOB_REG",
        "RSTREG_PRIORITY_A",
        "RSTREG_PRIORITY_B",
        "SRVAL_A",
        "SRVAL_B",
    ]

    return obfuscate_all(inst, skip_props, counts)


def obfuscate_dsp(inst, counts):
    """
    Obfuscate DSP48E1 parameters as much as possible while preserving implementation behavior.
    """
    skip_props = [
        "AREG",
        "ACASCREG",
        "BREG",
        "BCASCREG",
        "ADREG",
        "ALUMODEREG",
        "CARRYINREG",
        "CARRYINSELREG",
        "CREG",
        "DREG",
        "INMODEREG",
        "MREG",
        "OPMODEREG",
        "PREG",
        "USE_DPORT",
        "USE_MULT",
        "USE_PATTERN_DETECT",
        "USE_SIMD",
    ]
    return obfuscate_all(inst, skip_props, counts)


def obfuscate_all(
    inst: EDIFHierCellInst, skip_props: set[str] = None, counts=None
) -> tuple[bool, list[dict[str, str]]]:
    """
    Obfuscates all properties in a cell, excluding the ones in skip_props
    """
    skip_props = skip_props or set()
    changed = False
    mods = []

    props_map = inst.getInst().getPropertiesMap()
    for entry in list(props_map.entrySet()):
        name = str(entry.getKey())
        prop_val = entry.getValue()
        if name in skip_props:
            continue

        orig_type = prop_val.getType()
        orig_text = prop_val.getValue()
        mods.append(_json_entry(name, prop_val))

        if orig_type == EDIFValueType.INTEGER:
            new_text = "0"
        elif orig_type == EDIFValueType.BOOLEAN:
            new_text = "false"
        else:
            new_text = "NONE"

        if orig_text != new_text:
            inst.getInst().addProperty(name, new_text, orig_type)
            changed = True

    if changed and counts is not None:
        counts[inst.getCellType().getName()] += 1

    return changed, mods


def classify_and_obfuscate(inst, ref_type, counts) -> tuple[bool, dict, str]:
    """Apply the appropriate obfuscation based on cell type."""
    changed, mods, tag = False, None, None

    match True:
        case _ if LUTTools.isCellALUT(inst.getInst()):
            changed, mods = obfuscate_lut(inst, counts)
        case _ if "RAMB" in ref_type:
            changed, mods = obfuscate_bram(inst, counts)
        case _ if "DSP" in ref_type:
            changed, mods = obfuscate_dsp(inst, counts)
        case _ if any(
            sub in ref_type
            for sub in [
                "RAMD",
                "RAM32M",
                "RAM32X1D",
                "SRL16E",
                "RAMS",
                # "DSP",
                "IBUF",
                "OBUF",
                "FDRE",
                "FDSE",
                "FDCE",
                "FDPE",
            ]
        ):
            changed, mods = obfuscate_all(inst, None, counts)

    if changed:
        tag = add_tag(inst)
    return changed, mods, tag


def snapshot_properties(inst) -> list[dict[str, str]]:
    props_map = inst.getInst().getPropertiesMap()
    return [{"identifier": str(k), "value": str(v.getValue())} for k, v in props_map.entrySet()]


def log_summary(counts_all, counts, no_changeable_parameters):
    for k, v in counts_all.items():
        if k in counts:
            color = "\033[32m" if counts[k] == v else "\033[33m"
            logging.info("%s\t%s, %d\033[0m", color, k, v)
        elif k not in no_changeable_parameters:
            logging.info("\033[31m\t%s, %d\033[0m", k, v)
        else:
            logging.info("\t%s, %d", k, v)


def process_cell(inst, ref_type: str, counts) -> tuple[dict, bool]:
    """Process a single cell: snapshot, attempt obfuscation, return JSON entry."""
    entry = {
        "type": ref_type,
        "baseline_properties": snapshot_properties(inst),
    }

    changed, mods, tag = classify_and_obfuscate(inst, ref_type, counts)
    if changed:
        entry["tag"] = str(tag)
        entry["modified_properties"] = mods

    return entry, changed


def print_obfuscation_summary(counts_all, counts, obf_count: int):
    logging.info("Total cells in design: %d", sum(counts_all.values()))
    log_summary(
        counts_all,
        counts,
        no_changeable_parameters=["GND", "VCC", "MUXF7", "MUXF8", "CARRY4", "BUFG"],
    )
    logging.info("Obfuscated %d cells:", obf_count)
    for k, v in counts.items():
        logging.info("\t%s: %d", k, v)


def obfuscate_cell_properties(netlist: EDIFNetlist, out_path: str) -> int:
    """
    Takes all cells in the netlist and wipes their properties
    Saves the original properties in a JSON file located at out_path
    """
    cells_json = {}
    counts = defaultdict(int)
    counts_all = defaultdict(int)
    obf_count = 0

    for lib_map in EDIFTools.createCellInstanceMap(netlist).values():
        for inst_list in lib_map.values():
            for inst in inst_list:
                ref_type = str(inst.getCellType().getName())
                full_name = str(inst.getFullHierarchicalInstName())

                counts_all[ref_type] += 1

                entry, changed = process_cell(inst, ref_type, counts)
                cells_json[full_name] = entry

                if changed:
                    obf_count += 1

    print_obfuscation_summary(counts_all, counts, obf_count)
    json_write_if_changed(out_path, json.dumps(cells_json, indent=2))
    return obf_count


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
        "--build_path",
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
        "--orig_dcp",
        required=True,
        type=pathlib.Path,
        help="Input DCP that will be run through RW without modification",
    )
    parser.add_argument(
        "--orig_edf",
        required=True,
        type=pathlib.Path,
        help="Input EDF that will be run through RW without modification",
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
        "--untransformed_out_dcp",
        required=True,
        type=pathlib.Path,
        help="Where to write the unmodified DCP",
    )
    parser.add_argument(
        "--untransformed_out_edf",
        required=True,
        type=pathlib.Path,
        help="Where to write the unmodified EDIF",
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
    if log_path.exists():
        log_path.unlink(missing_ok=True)
    numeric_level = getattr(logging, args.logging_level.upper(), logging.INFO)
    logging.basicConfig(
        filename=log_path,
        format="%(asctime)s.%(msecs)03d %(levelname)s %(message)s",
        level=numeric_level,
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    System.setOut(PrintStream(FileOutputStream(str(log_path), True), True))

    logging.info("NetlistObfuscate start")

    t0 = time.perf_counter()
    design1 = Design.readCheckpoint(args.dcp, args.edf)
    design2 = Design.readCheckpoint(args.orig_dcp, args.orig_edf)

    t1 = time.perf_counter()
    device = Device.getDevice(PART)
    # design1.flattenDesign()
    # design2.flattenDesign()
    netlist1 = design1.getNetlist()
    netlist2 = design2.getNetlist()
    netlist1.expandMacroUnisims(device.getSeries())
    netlist2.expandMacroUnisims(device.getSeries())

    orig_cell_props = args.build_path / args.original_cell_props
    count = obfuscate_cell_properties(netlist1, orig_cell_props)

    logging.debug("Finished cell property obfuscation in %.3f s", time.perf_counter() - t1)
    logging.debug("%d properties changed", count)

    t2 = time.perf_counter()
    logging.info("Writing out new DCPs")
    design1.writeCheckpoint(args.out_dcp)
    design2.writeCheckpoint(args.untransformed_out_dcp)
    logging.info("Wrote DCPs in %.3f s", time.perf_counter() - t2)

    t3 = time.perf_counter()
    logging.info("Writing out new EDFs")
    netlist1.exportEDIF(args.out_edf)
    netlist2.exportEDIF(args.untransformed_out_edf)
    logging.info("Wrote EDFs in %.3f s", time.perf_counter() - t3)

    logging.info("NetlistObfuscate done in %.3f s", time.perf_counter() - t0)


if __name__ == "__main__":
    main()
