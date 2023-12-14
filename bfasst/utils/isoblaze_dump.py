"""Dump a single file with isoblaze. This will create two files:
One that lists all the bels, properties, and connections in a design,
and one that lists which BEL belongs to which IP in a design."""
import subprocess
import pathlib
import argparse

from bfasst.paths import (
    ISOBLAZE_DUMP_DCP_PATH,
    ISOBLAZE_DUMP_PATH,
    ISOBLAZE_GOLDEN_PATH,
    ROOT_PATH,
    DUMP_TOOL_BUILD_PATH,
    COLLECT_IP_TCL_PATH,
)


def dump_design(design_checkpoint):
    """Dump the design's impl.dcp to isoblaze dumpfile format,
    and return the path to the dumpfile"""
    command = [
        "vivado",
        "-mode",
        "batch",
        "-source",
        f"{ISOBLAZE_DUMP_PATH}",
        "-source",
        f"{ISOBLAZE_DUMP_DCP_PATH}",
        "-tclargs",
        f"{design_checkpoint}",
    ]

    proc = subprocess.Popen(command, cwd=ROOT_PATH)
    proc.communicate()
    return_code = proc.wait()

    if return_code != 0:
        raise RuntimeError(f"Failed to dump design {design_checkpoint}")

    return pathlib.Path(design_checkpoint).with_suffix(".dump")


def write_ip_file(design_checkpoint, ip_file):
    """Generate a file that lists all ip in a given design"""
    command = [
        "vivado",
        f"{design_checkpoint}",
        "-mode",
        "batch",
        "-source",
        f"{COLLECT_IP_TCL_PATH}",
        "-tclargs",
        f"{ip_file}",
    ]

    proc = subprocess.Popen(command, cwd=ROOT_PATH)
    proc.communicate()
    return_code = proc.wait()

    if return_code != 0:
        raise RuntimeError(f"Failed to collect IPs from design {design_checkpoint}")


def write_bels_to_ip_file(ip, golden_output):
    """Write the bels from the golden.{ip} file to the golden_output"""
    with open(f"golden.{ip}", "r") as f:
        bels = f.readlines()

    with open(golden_output, "a") as f:
        f.write(f"{ip}: \n")
        # indent the bels, and write one per line
        f.write("\n".join([f"\t{bel}" for bel in bels]))
        # add a newline at the end of each ip
        f.write("\n")

    # remove the golden.{ip} file since it is unnecessary
    pathlib.Path(f"golden.{ip}").unlink()


def bels_to_isoblaze_golden(ip, design_checkpoint):
    """Get the bels from the design checkpoint and write them to the golden_output"""
    command = [
        "vivado",
        f"{design_checkpoint}",
        "-mode",
        "batch",
        "-source",
        f"{ISOBLAZE_GOLDEN_PATH}",
        "-tclargs",
        f"{ip}",
    ]

    proc = subprocess.Popen(command, cwd=ROOT_PATH)
    proc.communicate()
    return_code = proc.wait()

    if return_code != 0:
        raise RuntimeError(f"Failed to dump design {design_checkpoint}")


def label_bels(design_checkpoint, golden_output, ip_file):
    """Label the bels with the IP they belong to"""
    write_ip_file(design_checkpoint, ip_file)

    # read the ip file, and save all the ip from the design into a list
    with open(ip_file, "r") as f:
        ip_list = f.readlines()
    ip_list = [ip.strip() for ip in ip_list]

    # create a file for the golden_output
    with open(golden_output, "w") as f:
        pass

    # iterate through the ip list and label the bels in the golden_output
    for ip in ip_list:
        bels_to_isoblaze_golden(ip, design_checkpoint)

        # bels that belong to ip now written to golden.{ip}
        # append them to the golden_output
        write_bels_to_ip_file(ip, golden_output)


if __name__ == "__main__":
    # Create an argparser that takes in the design name:
    parser = argparse.ArgumentParser()
    parser.add_argument("design", type=str, help="Name of the design checkpoint to dump")
    parser.add_argument(
        "output_dump",
        type=str,
        help="Name of the output dump file that uniquely identifies the design",
    )
    args = parser.parse_args()

    # Dump the design
    dumpfile = dump_design(args.design)

    # rename the dump file (and move it to the correct build subdir)
    dumpfile.rename(DUMP_TOOL_BUILD_PATH / args.output_dump)

    # iteratively run the golden script from isoblaze on the design checkpoint to get the file
    # that maps BELs to IPs
    design_id = ".".split(args.output_dump, maxsplit=1)[0]
    label_bels(
        design_checkpoint=args.design,
        golden_output=DUMP_TOOL_BUILD_PATH / f"golden_{design_id}.dump",
        ip_file=DUMP_TOOL_BUILD_PATH / f"{design_id}_ip_list.txt",
    )
