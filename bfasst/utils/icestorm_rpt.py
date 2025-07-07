"""Stand-alone script to take an icestorm reversed netlist and count
LUTS, FFs, Carries, and RAM40Ks"""

import argparse
import pathlib


def write_report(netlist, report):
    """Write a report of netlist primitive counts to report file"""
    # read the netlist
    with open(netlist, "r") as f:
        netlist_lines = f.read()

    # count the primitives
    num_luts = netlist_lines.count("/* LUT")
    num_carries = netlist_lines.count("/* CARRY")
    num_ffs = netlist_lines.count("/* FF")
    num_always_ffs = netlist_lines.count("always @")
    num_assign_ffs = num_ffs - num_always_ffs
    num_ram40s = netlist_lines.count("SB_RAM40_4K")

    # get the mod time
    mod_time = pathlib.Path(netlist).stat().st_mtime

    # write the report
    with open(report, "w") as f:
        f.write(f"Results from icestorm netlist ({mod_time}):\n")
        f.write("  Number of LUTs: " + str(num_luts) + "\n")
        f.write("  Number of carry cells: " + str(num_carries) + "\n")
        f.write("  Number of flip flops: " + str(num_ffs) + "\n")
        f.write("    Flops w/ assign statements: " + str(num_assign_ffs) + "\n")
        f.write("    Flops w/ always statements: " + str(num_always_ffs) + "\n")
        f.write("  Number of RAM40Ks: " + str(num_ram40s) + "\n")
        f.write("\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Count primitives in an icestorm netlist")
    parser.add_argument("--netlist", "-n", type=pathlib.Path, help="Path to the netlist file")
    parser.add_argument("--report", "-r", type=pathlib.Path, help="Path to the report file")
    args = parser.parse_args()

    write_report(args.netlist, args.report)
