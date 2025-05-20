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


def obfuscate_dsp_blocks(top):
    """
    Change parameters of DSP blocks
    """
    for inst in top.get_instances(recursive=True):
        if inst.reference.name == "DSP48E1":
            logging.info("Found DSP: %s", inst.name)
            props = inst.data.get("EDIF.properties", [])
            for prop in props:
                logging.info("%s = %s", prop["name"], prop["value"])


def get_masking_init(lut_size):
    bits = 2**lut_size
    # This INIT string works to obfuscate the LUTs and doesn't change placement and routing
    return f"0x{'0'*(bits//4 - 1)}1"


def purge_lut_init_and_log(top, log_path):
    """
    Replace INIT values with dummy logic and record the original values.
    """
    init_map = {}
    count = 0

    for inst in top.get_instances():
        ref_name = inst.reference.name
        if not ref_name.startswith("LUT"):
            continue

        # Infer LUT width from name: LUT2, LUT3, ..., LUT6
        try:
            lut_size = int(ref_name.replace("LUT", ""))
        except ValueError:
            logging.debug("Skipping LUT with name: %s", ref_name)
            continue  # Skip weird cell names

        if lut_size == 1:
            continue

        prop_list = inst.get("EDIF.properties", None)
        if not prop_list:
            continue

        for prop in prop_list:
            if prop.get("identifier") == "INIT":
                original = prop["value"]
                new_init = get_masking_init(lut_size)
                prop["value"] = new_init
                init_map[inst["EDIF.identifier"]] = {
                    "original_init": original,
                    "new_init": new_init,
                    "lut_size": lut_size,
                }
                count += 1

    # Save the INIT map to JSON
    # TODO: Put the old INITs back into the post implementation netlist
    with open(log_path, "w") as f:
        json.dump(init_map, f, indent=2)

    logging.info("Scrubbed %d LUT INITs and saved to %s", count, log_path)
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

    logging.info("NetlistTransform start")

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
    init_log_path = args.build_path / "init_backup.json"
    count = purge_lut_init_and_log(top, init_log_path)
    sdn.compose(netlist_ir, str(args.out_edf), write_blackbox=False)
    logging.info(
        "Purged INIT on %d LUT instances; wrote EDIF %s  (%.3f s)",
        count,
        args.out_edf,
        time.perf_counter() - t1,
    )

    logging.info("NetlistTransform done")


if __name__ == "__main__":
    main()
