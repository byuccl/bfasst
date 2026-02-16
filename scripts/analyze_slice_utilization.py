#!/usr/bin/env python3
"""
Analyze slice utilization from Vivado utilization reports.

Creates a detailed table showing slice resource usage for all designs.
"""

import argparse
import re
import sys
from pathlib import Path
from typing import Dict, Optional


def parse_slice_utilization(util_file: Path) -> Optional[Dict]:
    """Parse slice utilization from a Vivado utilization.txt file."""
    try:
        content = util_file.read_text()
    except (OSError, IOError) as e:
        print(f"Error reading {util_file}: {e}", file=sys.stderr)
        return None

    # Extract device
    device_match = re.search(r"Device\s*:\s*(xc7[ak]\d+[a-z]+)", content)
    device = device_match.group(1) if device_match else "unknown"
    fpga_type = "Kintex-7" if device.startswith("xc7k") else "Artix-7"

    # Parse "2. Slice Logic Distribution" section
    slice_section = re.search(
        r"2\. Slice Logic Distribution\s*-+\s*\n(.+?)(?=\n\n|\n\d+\.)", content, re.DOTALL
    )

    if not slice_section:
        return None

    section_text = slice_section.group(1)

    # Extract slice counts
    data = {
        "device": device,
        "fpga_type": fpga_type,
        "total_slices": 0,
        "slicel": 0,
        "slicem": 0,
        "slice_luts": 0,
        "lut_as_logic": 0,
        "lut_as_memory": 0,
        "slice_registers": 0,
        "available_slices": 0,
        "slice_util_pct": 0.0,
    }

    # Parse Slice count
    slice_match = re.search(
        r"\|\s*Slice\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*(\d+\.\d+)",
        section_text,
    )
    if slice_match:
        data["total_slices"] = int(slice_match.group(1))
        data["available_slices"] = int(slice_match.group(2))
        data["slice_util_pct"] = float(slice_match.group(3))

    # Parse SLICEL count
    slicel_match = re.search(r"\|\s*SLICEL\s*\|\s*(\d+)\s*\|", section_text)
    if slicel_match:
        data["slicel"] = int(slicel_match.group(1))

    # Parse SLICEM count
    slicem_match = re.search(r"\|\s*SLICEM\s*\|\s*(\d+)\s*\|", section_text)
    if slicem_match:
        data["slicem"] = int(slicem_match.group(1))

    # Parse LUT as Logic
    lut_logic_match = re.search(r"\|\s*LUT as Logic\s*\|\s*(\d+)\s*\|", section_text)
    if lut_logic_match:
        data["lut_as_logic"] = int(lut_logic_match.group(1))

    # Parse LUT as Memory
    lut_mem_match = re.search(r"\|\s*LUT as Memory\s*\|\s*(\d+)\s*\|", section_text)
    if lut_mem_match:
        data["lut_as_memory"] = int(lut_mem_match.group(1))

    # Parse Slice Registers
    slice_reg_match = re.search(r"\|\s*Slice Registers\s*\|\s*(\d+)\s*\|", section_text)
    if slice_reg_match:
        data["slice_registers"] = int(slice_reg_match.group(1))

    # Total Slice LUTs
    data["slice_luts"] = data["lut_as_logic"] + data["lut_as_memory"]

    return data


def find_utilization_files(build_dir: Path):
    """Find all utilization files in the build directory."""
    util_files = []
    for util_file in build_dir.rglob("vivado_reimpl/utilization.txt"):
        design_dir = util_file.parent.parent
        collection = design_dir.parent.name
        design = design_dir.name
        util_files.append((collection, design, util_file))
    return sorted(util_files, key=lambda x: (x[0], x[1]))


def parse_all_designs(util_files):
    """Parse utilization data for all designs."""
    results = []
    for collection, design, util_file in util_files:
        data = parse_slice_utilization(util_file)
        if data:
            data["collection"] = collection
            data["design"] = design
            results.append(data)
    return results


def write_fpga_section(f, fpga_type: str, fpga_designs):
    """Write the utilization table for a specific FPGA type."""
    f.write(f"\n{fpga_type} Designs ({fpga_designs[0]['device']}):\n")
    f.write("-" * 150 + "\n")
    f.write(
        f"{'Design':<45} {'Slices':<10} {'SLICEL':<10} {'SLICEM':<10} "
        f"{'LUTs':<10} {'Regs':<10} {'LUT/Logic':<10} {'LUT/Mem':<10} {'Util%':<8}\n"
    )
    f.write("-" * 150 + "\n")

    for r in fpga_designs:
        name = f"{r['collection']}/{r['design']}"
        f.write(
            f"{name:<45} "
            f"{r['total_slices']:>9,} "
            f"{r['slicel']:>9,} "
            f"{r['slicem']:>9,} "
            f"{r['slice_luts']:>9,} "
            f"{r['slice_registers']:>9,} "
            f"{r['lut_as_logic']:>9,} "
            f"{r['lut_as_memory']:>9,} "
            f"{r['slice_util_pct']:>7.2f}\n"
        )

    # Print summary stats
    total_slices = sum(r["total_slices"] for r in fpga_designs)
    total_slicel = sum(r["slicel"] for r in fpga_designs)
    total_slicem = sum(r["slicem"] for r in fpga_designs)
    avg_util = sum(r["slice_util_pct"] for r in fpga_designs) / len(fpga_designs)
    max_util = max(r["slice_util_pct"] for r in fpga_designs)
    max_design = max(fpga_designs, key=lambda x: x["slice_util_pct"])

    f.write("-" * 150 + "\n")
    f.write(
        f"{'TOTALS:':<45} "
        f"{total_slices:>9,} "
        f"{total_slicel:>9,} "
        f"{total_slicem:>9,} "
        f"{'':>10} {'':>10} {'':>10} {'':>10} "
        f"Avg:{avg_util:>5.2f}%\n"
    )
    f.write(
        f"{'MAX UTILIZATION:':<45} "
        f"{max_design['collection']}/{max_design['design']:<30} {max_util:>6.2f}%\n"
    )


def write_report_footer(f):
    """Write the column descriptions footer."""
    f.write("\n")
    f.write("=" * 150 + "\n")
    f.write("\nColumn Descriptions:\n")
    f.write("  Slices:    Total slice primitives used\n")
    f.write("  SLICEL:    Logic-only slices (cannot be used as memory)\n")
    f.write("  SLICEM:    Multi-function slices (can be used as logic or memory)\n")
    f.write("  LUTs:      Total LUTs in slices (Logic + Memory)\n")
    f.write("  Regs:      Total registers (FFs) in slices\n")
    f.write("  LUT/Logic: LUTs used for combinational logic\n")
    f.write("  LUT/Mem:   LUTs used as distributed RAM or shift registers\n")
    f.write("  Util%:     Slice utilization percentage\n")
    f.write("\n")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Analyze slice utilization from Vivado reports")
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("slice_utilization_report.txt"),
        help="Output file path (default: slice_utilization_report.txt)",
    )
    args = parser.parse_args()

    build_dir = Path("build")
    if not build_dir.exists():
        print(f"Error: {build_dir} does not exist")
        return 1

    util_files = find_utilization_files(build_dir)
    if not util_files:
        print("No utilization files found")
        return 1

    print(f"Found {len(util_files)} designs")
    print(f"Writing report to {args.output}")
    print()

    results = parse_all_designs(util_files)

    # Write report
    with open(args.output, "w") as f:
        f.write("=" * 150 + "\n")
        f.write("SLICE UTILIZATION ANALYSIS\n")
        f.write("=" * 150 + "\n")
        f.write("\n")

        for fpga_type in ["Artix-7", "Kintex-7"]:
            fpga_designs = [r for r in results if r["fpga_type"] == fpga_type]
            if fpga_designs:
                write_fpga_section(f, fpga_type, fpga_designs)

        write_report_footer(f)

    print(f"Report written to {args.output}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
