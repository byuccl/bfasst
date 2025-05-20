"""
Tool to perform obfuscation on a post-synthesis netlist.
Currently its only function is to purge INIT values for 
all LUTs in a synthesized design and replace them with dummy values
"""

import argparse
import logging
import pathlib
import time
import shutil
import json
import spydrnet as sdn


def get_masking_init(lut_size):
    bits = 2**lut_size
    # This INIT string works to obfuscate the LUTs and doesn't seem to change implementation
    return f"0x{'0'*(bits//4 - 1)}1"


def obfuscate_lut(inst):
    """
    Overwrite INIT in LUT if present.
    Returns True if changed.
    """
    ref_name = inst.reference.name
    try:
        lut_size = int(ref_name.replace("LUT", ""))
    except ValueError:
        return False

    if lut_size == 1:
        return False

    changed = False
    for prop in inst.data.get("EDIF.properties", []):
        if prop.get("identifier") == "INIT":
            prop["value"] = get_masking_init(lut_size)
            changed = True
    return changed


def obfuscate_dsp(inst):
    """
    Zero out DSP properties.
    Returns True if any property was changed.
    """
    changed = False
    for prop in inst.data.get("EDIF.properties", []):
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


def obfuscate_cell_properties(top, out_path):
    """
    Obfuscate LUTs and DSPs in a design, saving all original properties to a JSON log.
    """
    modified_cells = {}
    count = 0

    for inst in top.get_instances(recursive=True):
        ref = inst.reference
        if ref is None:
            continue

        ref_name = ref.name
        cell_id = inst["EDIF.identifier"]
        original_props = list(inst.data.get("EDIF.properties", []))  # copy

        if ref_name.startswith("LUT"):
            modified = obfuscate_lut(inst)
        elif ref_name == "DSP48E1":
            continue  # don't do this yet
            # modified = obfuscate_dsp(inst)
        else:
            continue

        if modified:
            new_props = list(inst.data.get("EDIF.properties", []))  # after modification
            modified_cells[cell_id] = {
                "name": inst.get(".NAME", ""),
                "type": ref_name,
                "original_properties": original_props,
                "new_properties": new_props,
            }
            count += 1

    with open(out_path, "w") as f:
        json.dump(modified_cells, f, indent=2)

    logging.info("Obfuscated %d cells. Original properties written to %s", count, out_path)

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
        "Copied DCP %s → %s  (%.3f s)",
        args.dcp,
        args.out_dcp,
        time.perf_counter() - t0,
    )
    t1 = time.perf_counter()
    netlist_ir = sdn.parse(str(args.edf))

    top = netlist_ir.top_instance
    orig_cell_props = args.build_path / args.original_cell_props

    count = obfuscate_cell_properties(top, orig_cell_props)

    sdn.compose(netlist_ir, str(args.out_edf), write_blackbox=False)
    logging.info(
        "Obfuscated %d cells; wrote EDIF %s  (%.3f s)",
        count,
        args.out_edf,
        time.perf_counter() - t1,
    )
    logging.info("NetlistObfuscate done")


if __name__ == "__main__":
    main()
