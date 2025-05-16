"""
Purge INIT values for all LUTs in a synthesized design using RapidWright
and replace them with dummy values, logging the original and new INITs.
"""
import sys
import logging
from argparse import ArgumentParser
from pathlib import Path
from bfasst import jpype_jvm
jpype_jvm.start()

import time
import shutil
import json
import math

from com.xilinx.rapidwright.design import Design
from com.xilinx.rapidwright.edif import EDIFPropertyValue, EDIFValueType
from jpype import JClass

def get_masking_init(lut_size):
    width = 2 ** lut_size
    val = 1 << (width - 1)
    return f"{width}'h{val:0{width // 4}X}"


def purge_lut_init_and_log(design: Design, log_path: Path):
    init_map = {}
    count = 0

    for inst in design.getNetlist().getTopCell().getCellInsts():
        props = inst.getPropertiesMap()
        if props is None or not props.containsKey("INIT"):
            continue

        prop = props.get("INIT")
        original = prop.getValue()

        hex_digits = original[2:]
        bits = len(hex_digits) * 4
        lut_size = int(math.log2(bits))

        if lut_size <= 1:
            continue

        new_init = get_masking_init(lut_size)
        props.put("INIT", EDIFPropertyValue(new_init, EDIFValueType.STRING))

        init_map[str(inst.getName())] = {
            "original_init": str(original),
            "new_init": str(new_init),
            "lut_size": str(lut_size),
        }

        count += 1

    with open(log_path, "w") as f:
        json.dump(init_map, f, indent=2)

    logging.info(f"Purged INIT on {count} LUTs; log → {log_path}")
    return count


def main():
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("build_path", type=Path, help="Directory for logs/intermediates")
    parser.add_argument("--dcp", required=True, type=Path, help="Input checkpoint (.dcp)")
    parser.add_argument("--edf", required=True, type=Path, help="Input EDIF (.edf)")
    parser.add_argument("--out_dcp", required=True, type=Path, help="Output checkpoint path")
    parser.add_argument("--out_edf", required=True, type=Path, help="Output EDIF path")
    parser.add_argument("--log", default="netlist_transform_rw.log", help="Log filename")
    parser.add_argument(
        "--logging_level",
        default="INFO",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        help="Verbosity",
    )
    args = parser.parse_args()

    args.build_path.mkdir(parents=True, exist_ok=True)
    log_file = args.build_path / args.log
    log_file.unlink(missing_ok=True)
    logging.basicConfig(
        filename=str(log_file),
        level=getattr(logging, args.logging_level),
        format="%(asctime)s %(levelname)s %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    logging.info("=== NetlistTransformRW start ===")

    # Copy and load the checkpoint
    t0 = time.perf_counter()
    shutil.copyfile(args.dcp, args.out_dcp)
    logging.info(f"Copied DCP {args.dcp} → {args.out_dcp} ({time.perf_counter()-t0:.3f}s)")

    t1 = time.perf_counter()
    design = Design.readCheckpoint(str(args.out_dcp))

    # Modify INITs
    init_log = args.build_path / "init_backup.json"
    purge_lut_init_and_log(design, init_log)

    # Save back the new DCP
    design.writeCheckpoint(str(args.out_dcp))
    logging.info(f"Wrote transformed DCP ({time.perf_counter()-t1:.3f}s)")

    # Save back the new EDF
    EDIFTools = JClass("com.xilinx.rapidwright.edif.EDIFTools")
    
    netlist     = design.getNetlist()
    top_name    = netlist.getTopCell().getName()
    out_edf_str = str(args.out_edf)
    
    EDIFTools.writeEDIFFile(out_edf_str, netlist, top_name)
    logging.info(f"Wrote obfuscated EDIF → {out_edf_str}")

    logging.info("=== NetlistTransformRW done ===")


if __name__ == "__main__":
    main()

