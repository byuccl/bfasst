"""Dump a single design with isoblaze. This will create two files:
One that lists all the bels, properties, and connections in a design,
and one that lists which BEL belongs to which IP in a design."""
import subprocess
import pathlib
import argparse

from bfasst.paths import (
    ISOBLAZE_DUMP_DCP_PATH,
    ISOBLAZE_DUMP_PATH,
    ISOBLAZE_GOLDEN_PATH,
    DUMP_TOOL_BUILD_PATH,
    COLLECT_IP_TCL_PATH,
)


class NetlistDump:
    """Dump a single design with isoblaze. This will create two files:
    One that lists all the bels with their properties, and connections
    between them in a design, and one that lists which BEL belongs to
    which IP in the design."""

    def __init__(self, design_checkpoint, dump_file, label_file):
        self.design_checkpoint = design_checkpoint
        self.dump_file = dump_file
        self.label_file = label_file

    def run(self) -> None:
        """Run the utility to generate the dump_file and label_file"""

        # Dump the design
        dumpfile = self.dump_design(self.design_checkpoint)

        # rename the dump file (and move it to the correct build subdir)
        dumpfile.rename(DUMP_TOOL_BUILD_PATH / self.dump_file)

        # get a path to the ipfile
        ipfile_path = DUMP_TOOL_BUILD_PATH / f"{self.label_file}_ip_list.txt"

        # label the bels with the IP they belong to
        self.label_bels(
            design_checkpoint=self.design_checkpoint,
            goldfile_path=DUMP_TOOL_BUILD_PATH / self.label_file,
            ipfile_path=ipfile_path,
        )

        # remove the ip files since they are unnecessary
        pathlib.Path(ipfile_path).unlink()

    def dump_design(self, design_checkpoint) -> pathlib.Path:
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

        proc = subprocess.Popen(command, cwd=DUMP_TOOL_BUILD_PATH)
        proc.communicate()
        return_code = proc.wait()

        if return_code != 0:
            raise RuntimeError(f"Failed to dump design {design_checkpoint}")

        # if we pass this point, the dump was successful and the vivado artifacts can be removed
        self.remove_vivado_artifacts(DUMP_TOOL_BUILD_PATH)

        # isoblaze will create a dump file with the same name
        # as the design checkpoint with a .dump extension
        return pathlib.Path(design_checkpoint).with_suffix(".dump")

    def remove_vivado_artifacts(self, directory):
        """Remove all vivado artifacts from a directory"""
        for file in directory.iterdir():
            if "vivado" in file.name and file.suffix in [".log", ".jou"] and file.is_file():
                file.unlink()

    def label_bels(self, design_checkpoint, goldfile_path, ipfile_path):
        """Label the bels with the IP they belong to"""

        # generate a file that lists all ip in a given design
        self.write_ip_file(design_checkpoint, ipfile_path)

        # read the ip file, and save all the ip from the design into a list
        with open(ipfile_path, "r") as f:
            ip_list = f.readlines()
        ip_list = [ip.strip() for ip in ip_list]

        # create the goldfile
        with open(goldfile_path, "w") as f:
            pass

        # iterate through the ip list and label the bels in the golden_output
        isoblaze_goldfiles = {}
        for ip in ip_list:
            isoblaze_goldfile = self.generate_isoblaze_goldfile(ip, design_checkpoint)
            isoblaze_goldfiles[ip] = isoblaze_goldfile

        # bels that belong to ip now written to golden.{ip}
        # append them to the golden_output
        self.concat_bels_from_isoblaze_goldfiles(isoblaze_goldfiles, goldfile_path)

    def write_ip_file(self, design_checkpoint, ipfile_path) -> None:
        """Generate a file that lists all ip in a given design"""
        command = [
            "vivado",
            f"{design_checkpoint}",
            "-mode",
            "batch",
            "-source",
            f"{COLLECT_IP_TCL_PATH}",
            "-tclargs",
            f"{ipfile_path}",
        ]

        proc = subprocess.Popen(command, cwd=DUMP_TOOL_BUILD_PATH)
        proc.communicate()
        return_code = proc.wait()

        if return_code != 0:
            raise RuntimeError(f"Failed to collect IPs from design {design_checkpoint}")

        self.remove_vivado_artifacts(DUMP_TOOL_BUILD_PATH)

    def generate_isoblaze_goldfile(self, ip, design_checkpoint) -> pathlib.Path:
        """Use Isoblaze to collect bels that belong to a given IP"""
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

        proc = subprocess.Popen(command, cwd=DUMP_TOOL_BUILD_PATH)
        proc.communicate()
        return_code = proc.wait()

        if return_code != 0:
            raise RuntimeError(f"Failed to dump design {design_checkpoint}")

        self.remove_vivado_artifacts(DUMP_TOOL_BUILD_PATH)

        # isoblaze will create a golden file called golden.{ip}
        return pathlib.Path(f"{DUMP_TOOL_BUILD_PATH}/golden.{ip}")

    def concat_bels_from_isoblaze_goldfiles(self, isoblaze_goldfiles, goldfile_path) -> None:
        """Concatenate the bels from the isoblaze_goldfiles into the goldfile"""
        for ip, isoblaze_goldfile in isoblaze_goldfiles.items():
            with open(isoblaze_goldfile, "r") as f:
                bels = f.readlines()

            with open(goldfile_path, "a") as f:
                # write the ip name
                f.write(f"{ip}: \n")

                # indent the bels that belong to it, and write one per line
                for bel in bels:
                    f.write(f"\t{bel}")

            # remove the golden.{ip} file since it is unnecessary
            pathlib.Path(isoblaze_goldfile).unlink()


if __name__ == "__main__":
    # Create an argparser that takes in the design name:
    parser = argparse.ArgumentParser()
    parser.add_argument("design", type=str, help="Name of the design checkpoint to dump")
    parser.add_argument(
        "dumpfile",
        type=str,
        help="Name of the output dump file that uniquely identifies the design",
    )
    parser.add_argument(
        "labelfile",
        type=str,
        help="Name of the output label file that uniquely identifies the design",
    )
    args = parser.parse_args()

    # Create a NetlistDump object and run it
    netlist_dump = NetlistDump(args.design, args.dumpfile, args.labelfile)
    netlist_dump.run()
