import shutil
import subprocess
import re
import os
import time
import sys

import bfasst
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus
from bfasst.config import VIVADO_BIN_PATH


class Vivado_ImplementationTool(ImplementationTool):
    TOOL_WORK_DIR = "vivado_impl"

    def implement_bitstream(self, design, print_to_stdout=True):
        self.print_to_stdout = print_to_stdout

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
            if self.print_to_stdout:
                self.print_running_impl()

            # Run implementation
            status = self.run_implementation(design, log_path)
            if status.error:
                return status

        elif self.print_to_stdout:
            self.print_skipping_impl()

        # Check implementation log
        status = self.check_impl_status(log_path)
        if status.error:
            return status

        # Update a file in the main directory with info about impl results
        # self.write_to_results_file(design, log_path, need_to_run)

        return Status(ImplStatus.SUCCESS)

    def run_implementation(self, design, log_path):
        tcl_path = self.work_dir / ("impl.tcl")

        with open(tcl_path, "w") as fp:
            if design.top_is_verilog:
                # fp.write("set_part " + bfasst.config.PART + "\n")
                fp.write("read_edif " + str(design.netlist_path) + "\n")

                # for vf in design.verilog_files:
                #     fp.write("read_verilog " + str(design.))

                fp.write("set_property design_mode GateLvl [current_fileset]\n")
                fp.write(
                    "set_property edif_top_file "
                    + str(design.netlist_path)
                    + " [current_fileset]\n"
                )
                fp.write("link_design -part " + bfasst.config.PART + "\n")
                fp.write("read_xdc " + str(design.constraints_path) + "\n")
                fp.write("opt_design\n")
                fp.write("place_design\n")
                fp.write("route_design\n")
                fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
                # fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")
                fp.write("exit\n")

        with open(log_path, "w") as fp:
            cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
            proc = subprocess.Popen(
                cmd,
                cwd=self.work_dir,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                universal_newlines=True,
            )
            for line in proc.stdout:
                if self.print_to_stdout:
                    sys.stdout.write(line)
                    sys.stdout.flush()
                fp.write(line)
                fp.flush()
                if re.match("\s*ERROR:", line):
                    proc.kill()
            proc.communicate()
            if proc.returncode:
                return Status(ImplStatus.ERROR)

        return Status(ImplStatus.SUCCESS)

    def check_impl_status(self, log_path):
        text = open(log_path).read()

        m = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if m:
            return Status(ImplStatus.ERROR, m.group(1))

        return Status(ImplStatus.SUCCESS)

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
