import os
import shutil
import subprocess

import bfasst
from bfasst.reverse_bit.base import ReverseBitTool
from bfasst.status import Status, BitReverseStatus

# PROJECT_TEMPLATE_FILE = 'template_lse.prj'
# IC2_LSE_PROJ_FILE = 'lse_project.prj'


class Icestorm_ReverseBitTool(ReverseBitTool):
    def reverse_bitstream(self, design):

        # Create work directory
        proj_dir = self.make_project_folder(self.cwd)

        # Bitstream to ascii file
        asc_path = os.path.join(proj_dir, design.top + ".asc")
        status = self.convert_bit_to_asc(
            design.bitstream_path, asc_path, proj_dir)
        if status.error:
            return status

        # Ascii to netlist
        design.reverse_netlist_path = os.path.join(
            self.cwd, design.top + "_reversed.v")
        status = self.convert_asc_to_netlist(
            asc_path, design.constraints_path, design.reverse_netlist_path, proj_dir)
        if status.error:
            return status

        return status

    def convert_bit_to_asc(self, bitstream_path, asc_path, proj_dir):
        cmd = [os.path.join(bfasst.config.ICESTORM_INSTALL_DIR,
                            "icepack", "iceunpack"), bitstream_path]

        with open(asc_path, 'w') as fp:
            p = subprocess.run(
                cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=proj_dir)

            if p.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    def convert_asc_to_netlist(self, asc_path, constraints_path, netlist_path, proj_dir):
        cmd = [os.path.join(bfasst.config.ICESTORM_INSTALL_DIR, "icebox",
                            "icebox_vlog.py"), "-P", constraints_path, "-s", asc_path]

        with open(netlist_path, 'w') as fp:
            p = subprocess.run(
                cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=proj_dir)

            if p.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    def make_project_folder(self, build_dir):
        icestorm_proj_dir = os.path.join(
            build_dir, bfasst.config.ICESTORM_FOLDER)

        if not os.path.isdir(icestorm_proj_dir):
            os.mkdir(icestorm_proj_dir)
            return icestorm_proj_dir
