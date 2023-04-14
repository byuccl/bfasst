""" IceCube2 Implementation tool"""

import shutil
import subprocess
import re
import os

import bfasst
from bfasst import paths
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus


class Ic2ImplementationTool(ImplementationTool):
    """Run IceCube2 tools"""

    TOOL_WORK_DIR = "ic2_impl"

    def implement_bitstream(self, design):
        design.bitstream_path = self.cwd / (design.top + ".bit")

        status = self.common_startup(design, self.check_impl_status)
        if status:
            return status

        # Create impl tcl script
        tcl_path = self.create_run_tcl()

        # Copy netlist into impl working folder
        new_netlist_path = self.work_dir / design.netlist_path.name
        shutil.copyfile(design.netlist_path, new_netlist_path)

        # Run implementation
        status = self.run_implementation(design, new_netlist_path, tcl_path)

        # Check implementation log
        status = self.check_impl_status(self.log_path)

        # if need_to_run:
        # Copy bitstream out of working directory
        bitstream_proj_path = (
            self.work_dir / "sbt" / "outputs" / "bitmap" / (design.top + "_bitmap.bin")
        )
        try:
            shutil.copyfile(bitstream_proj_path, design.bitstream_path)
        except FileNotFoundError:
            return Status(ImplStatus.ERROR)

        # Copy constraints out of working directory
        constraints_proj_path = (
            self.work_dir / "sbt" / "outputs" / "placer" / (design.top + "_sbt.pcf")
        )
        design.constraints_path = self.cwd / (design.top + ".pcf")
        try:
            shutil.copyfile(constraints_proj_path, design.constraints_path)
        except FileNotFoundError:
            return Status(ImplStatus.ERROR)

        # Always set the constraints path since we need it later
        # design.constraints_path = self.cwd/(design.top + ".pcf")

        return Status(ImplStatus.SUCCESS)

    def run_implementation(self, design, netlist_path, tcl_path):
        """Run implemention"""
        netlist_no_ext = netlist_path.stem

        cmd = ["tclsh", tcl_path, design.top, ".", netlist_no_ext]
        env = os.environ.copy()
        env["SBT_DIR"] = bfasst.config.IC2_INSTALL_DIR / "sbt_backend"
        with open(self.log_path, "a") as fp:
            proc = subprocess.run(
                cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir, env=env
            )
            if proc.returncode != 0:
                return Status(ImplStatus.ERROR)

        return Status(ImplStatus.SUCCESS)

    def create_run_tcl(self):
        tcl_path = self.work_dir / "run_impl.tcl"
        shutil.copyfile(paths.I2C_RESOURCES / "template.tcl", tcl_path)
        return tcl_path

    def check_impl_status(self, log_path):
        """Check log file for errors"""
        text = open(log_path).read()

        match = re.search(
            r"^Design LUT Count \((\d+)\) exceeded Device LUT Count \((\d+)\)$", text, re.M
        )
        if match:
            return Status(ImplStatus.TOO_MANY_LUTS, match.group(1) + "/" + match.group(2))
        match = re.search(
            r"^Design FF Count \((\d+)\) exceeded Device FF Count \((\d+)\)$", text, re.M
        )
        if match:
            return Status(ImplStatus.TOO_MANY_FF, match.group(1) + "/" + match.group(2))

        # Too many I/Os
        match = re.search(
            (
                r"Unable to fit the design into the selected device/package$\n^DEVICE IO Count:.*?"
                r"Regular IOs.*?(\d+).*?DESIGN IO Count:.*?Regular IOs.*?(\d+)"
            ),
            text,
            re.M | re.S,
        )
        if match:
            return Status(ImplStatus.TOO_MANY_IO, match.group(2) + "/" + match.group(1))

        # if too_large_str:
        #     err_str += "Design does not fit. " + too_large_str

        # # Invalid primitives
        # m = re.search("^Error: (Module.*?is not a valid primitive.)", text, re.M)
        # if (m):
        #     err_str += m.group(1)

        # if (err_str):
        #     sys.stdout.write(err_str)
        #     return True

        return Status(ImplStatus.SUCCESS)

    # def write_to_results_file(self, design, log_path, need_to_run):

    #     if design.results_summary_path is None:
    #         print("No results path set!")
    #     else:
    #         with open(design.results_summary_path, "a") as res_f:
    #             time_modified = time.ctime(os.path.getmtime(log_path))
    #             res_f.write("Results summary (IC2) (" + time_modified + ")\n")
    #             # How can I differentiate between different versions of the design?
    #             if not need_to_run:
    #                 res_f.write("Note: need_to_run is false, design stats may be out of date\n")
    #             with open(log_path, "r") as log_f:
    #                 # Look for the results summary line
    #                 for line in log_f:
    #                     if line.strip() == "Final Design Statistics":
    #                         # There's 11 results summay lines, copy all of them
    #                         for itr in range(11):
    #                             res_line = next(log_f)
    #                             res_f.write(res_line)
    #             res_f.write("\n")
