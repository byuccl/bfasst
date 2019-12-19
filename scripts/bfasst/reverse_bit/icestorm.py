import shutil
import subprocess
import re

import bfasst
from bfasst.reverse_bit.base import ReverseBitTool
from bfasst.status import Status, BitReverseStatus

# PROJECT_TEMPLATE_FILE = 'template_lse.prj'
# IC2_LSE_PROJ_FILE = 'lse_project.prj'


class Icestorm_ReverseBitTool(ReverseBitTool):
    TOOL_WORK_DIR = "icestorm"

    def reverse_bitstream(self, design):
        # print("Running ReverseBit")

        design.reversed_netlist_path = self.cwd / (design.top + "_reversed.v")

        # Decide if this needs to be run
        need_to_run = False

        # Run if reverse netlist file does not exist
        need_to_run |= not design.reversed_netlist_path.is_file()

        # Run if reverse netlist file is out of date
        need_to_run |= (not need_to_run) and (
            design.reversed_netlist_path.stat().st_mtime < design.bitstream_path.stat().st_mtime)

        if need_to_run:
            # First go through and remove any added stuff from pcf port names
            self.fix_pcf_names(design)
            # Bitstream to ascii file
            asc_path = self.work_dir / (design.top + ".asc")
            status = self.convert_bit_to_asc(design.bitstream_path, asc_path)
            if status.error:
                return status

            # Ascii to netlist
            status = self.convert_asc_to_netlist(
                asc_path, design.constraints_path, design.reversed_netlist_path)
            if status.error:
                return status

        return Status(BitReverseStatus.SUCCESS)

    def convert_bit_to_asc(self, bitstream_path, asc_path):
        cmd = [bfasst.config.ICESTORM_INSTALL_DIR/"icepack"/"iceunpack", bitstream_path]

        with open(asc_path, 'w') as fp:
            p = subprocess.run(
                cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir)

            if p.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    def convert_asc_to_netlist(self, asc_path, constraints_path, netlist_path):
        cmd = [bfasst.config.ICESTORM_INSTALL_DIR/"icebox" /
               "icebox_vlog.py", "-P", constraints_path, "-s", asc_path]

        with open(netlist_path, 'w') as fp:
            p = subprocess.run(
                cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir)

            if p.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    # Sometimes IC2 implementation can add stuff to signal names in PCF files
    #   (e.x. clk_i becomes clk_i_ibuf). This function removes those extra
    #   suffixes/prefixes. This also removes all location information from the
    #   PCF. For our purposes, we only need the set_io statements to infer
    #   the I/O signal names.
    # TODO: Ideally, this function should probably check against the top-level
    #       I/O on the original RTL to make sure that none of the signals have
    #       the suffixes we're removing (i.e. they weren't added by IC2). For
    #       now, though, we'll assume that all suf/prefixes are not in the RTL.
    def fix_pcf_names(self, design):
        set_io_lines = []
        with open(design.constraints_path, 'r') as pcf:
            for line in pcf:
                if line.split()[0] == "set_io":
                    set_io_lines.append(line)
        with open(design.constraints_path, 'w') as pcf:
            for line in set_io_lines:
                new_line = re.sub("_ibuf", "", line)
                new_line = re.sub("ibuf_", "", new_line)
                new_line = re.sub("_obuf", "", new_line)
                new_line = re.sub("obuf_", "", new_line)
                new_line = re.sub("_gb_io", "", new_line)
                pcf.write(new_line)
