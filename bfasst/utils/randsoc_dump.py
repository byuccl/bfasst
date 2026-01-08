"""Dump a single design with isoblaze. This will create two files:
One that lists all the bels, properties, and connections in a design,
and one that lists which BEL belongs to which IP in a design."""

import argparse
import pathlib
import shutil
import subprocess

from bfasst.config import VIVADO
from bfasst.paths import BFASST_BUILD, BFASST_UTILS


class NetlistDump:
    """Dump a single design with isoblaze. This will create two files:
    One that lists all the bels with their properties, and connections
    between them in a design, and one that lists which BEL belongs to
    which IP in the design."""

    # paths to isoblaze scripts, stored as class variables for convenience
    ISOBLAZE_DUMP_PATH = BFASST_UTILS / "dump.tcl"
    ISOBLAZE_DUMP_DCP_PATH = BFASST_UTILS / "dump-dcp.tcl"
    ISOBLAZE_GOLDEN_PATH = BFASST_UTILS / "golden.tcl"

    def __init__(self, design_checkpoint, dump_file):
        self.design_checkpoint = design_checkpoint
        self.dump_file = dump_file
        self.build_path = pathlib.Path(BFASST_BUILD / "randsoc_dump" / pathlib.Path(dump_file).stem)
        self.build_path.mkdir(parents=True, exist_ok=True)

    def run(self) -> None:
        """Run the utility to generate the dump_file and label_file"""

        # Dump the design
        # NOTE: Isoblaze appends the ".dcp" suffix to the checkpoint path on its own.
        dumpfile = self.dump_design(pathlib.Path(self.design_checkpoint).with_suffix(""))

        # rename the dump file (and move it to the correct build subdir)
        dumpfile.rename(self.build_path / self.dump_file)

        # remove the .Xil directory since it is unnecessary
        shutil.rmtree(self.build_path / ".Xil")

    def dump_design(self, design_checkpoint) -> pathlib.Path:
        """Dump the design's impl.dcp to isoblaze dumpfile format,
        and return the path to the dumpfile"""
        command = [
            f"{VIVADO}",
            "-mode",
            "batch",
            "-source",
            f"{self.ISOBLAZE_DUMP_PATH}",
            "-source",
            f"{self.ISOBLAZE_DUMP_DCP_PATH}",
            "-tclargs",
            f"{design_checkpoint}",
        ]

        proc = subprocess.Popen(command, cwd=self.build_path, stdout=subprocess.PIPE)
        proc.communicate()
        return_code = proc.wait()

        if return_code != 0:
            raise RuntimeError(f"Failed to dump design {design_checkpoint}")

        # if we pass this point, the dump was successful and the vivado artifacts can be removed
        self.remove_vivado_artifacts(self.build_path)

        # isoblaze will create a dump file with the same name
        # as the design checkpoint with a .dump extension
        return pathlib.Path(design_checkpoint).with_suffix(".dump")

    def remove_vivado_artifacts(self, directory):
        """Remove all vivado artifacts from a directory"""
        for file in directory.iterdir():
            if "vivado" in file.name and file.suffix in [".log", ".jou"] and file.is_file():
                file.unlink()


if __name__ == "__main__":
    # Create an argparser that takes in the design name:
    parser = argparse.ArgumentParser()
    parser.add_argument("design", type=str, help="Name of the design checkpoint to dump")
    parser.add_argument(
        "dumpfile",
        type=str,
        help="Name of the output dump file that uniquely identifies the design",
    )
    args = parser.parse_args()

    # Create a NetlistDump object and run it
    netlist_dump = NetlistDump(args.design, args.dumpfile)
    netlist_dump.run()
