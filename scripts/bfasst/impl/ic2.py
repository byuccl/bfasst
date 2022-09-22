import shutil
import subprocess
import re
import os
import time

import bfasst
from bfasst import paths
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus


class IC2_ImplementationTool(ImplementationTool):
    TOOL_WORK_DIR = "ic2_impl"

    def implement_bitstream(self, design):
        # print("Running Impl")

        log_path = self.work_dir / bfasst.config.IMPL_LOG_NAME
        design.bitstream_path = self.cwd / (design.top + ".bit")

        # Check if implementation needs to be run
        need_to_run = False

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if there is no bitstream, and no error message in the log file
        need_to_run |= (not need_to_run) and (
            not design.bitstream_path.is_file() and not self.check_impl_status(log_path).error
        )

        # Run if last run is out of date
        need_to_run |= (not need_to_run) and (
            design.netlist_path.stat().st_mtime > log_path.stat().st_mtime
        )

        if need_to_run:
            # Create impl tcl script
            tcl_path = self.create_run_tcl()

            # Copy netlist into impl working folder
            new_netlist_path = self.work_dir / design.netlist_path.name
            shutil.copyfile(design.netlist_path, new_netlist_path)

            # Run implementation
            status = self.run_implement(design, new_netlist_path, tcl_path, log_path)

        # Check implementation log
        status = self.check_impl_status(log_path)

        # Update a file in the main directory with info about impl results
        self.write_to_results_file(design, log_path, need_to_run)

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

    def run_implement(self, design, netlist_path, tcl_path, log_path):
        netlist_no_ext = netlist_path.stem

        cmd = ["tclsh", tcl_path, design.top, ".", netlist_no_ext]
        env = os.environ.copy()
        env["SBT_DIR"] = bfasst.config.IC2_INSTALL_DIR / "sbt_backend"
        with open(log_path, "w") as fp:
            p = subprocess.run(cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir, env=env)
            if p.returncode != 0:
                return Status(ImplStatus.ERROR)

        return Status(ImplStatus.SUCCESS)

    def create_run_tcl(self):
        tcl_path = self.work_dir / "run_impl.tcl"
        shutil.copyfile(paths.I2C_RESOURCES / "template.tcl", tcl_path)
        return tcl_path

    def check_impl_status(self, log_path):
        text = open(log_path).read()

        m = re.search(
            r"^Design LUT Count \((\d+)\) exceeded Device LUT Count \((\d+)\)$", text, re.M
        )
        if m:
            return Status(ImplStatus.TOO_MANY_LUTS, m.group(1) + "/" + m.group(2))
        m = re.search(r"^Design FF Count \((\d+)\) exceeded Device FF Count \((\d+)\)$", text, re.M)
        if m:
            return Status(ImplStatus.TOO_MANY_FF, m.group(1) + "/" + m.group(2))

        # Too many I/Os
        m = re.search(
            r"Unable to fit the design into the selected device/package$\n^DEVICE IO Count:.*?Regular IOs.*?(\d+).*?DESIGN IO Count:.*?Regular IOs.*?(\d+)",
            text,
            re.M | re.S,
        )
        if m:
            return Status(ImplStatus.TOO_MANY_IO, m.group(2) + "/" + m.group(1))

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

    def write_to_results_file(self, design, log_path, need_to_run):
        if design.results_summary_path is None:
            print("No results path set!")
        else:
            with open(design.results_summary_path, "a") as res_f:
                time_modified = time.ctime(os.path.getmtime(log_path))
                res_f.write("Results summary (IC2) (" + time_modified + ")\n")
                # How can I differentiate between different versions of the design?
                if not need_to_run:
                    res_f.write("Note: need_to_run is false, design stats may be out of date\n")
                with open(log_path, "r") as log_f:
                    # Look for the results summary line
                    for line in log_f:
                        if line.strip() == "Final Design Statistics":
                            # There's 11 results summay lines, copy all of them
                            for itr in range(11):
                                res_line = next(log_f)
                                res_f.write(res_line)
                res_f.write("\n")
