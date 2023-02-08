""" Runs Vivado implementation (place/route)"""

import subprocess
import re
import os
import time
import sys
import pathlib

import bfasst
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus
from bfasst.config import VIVADO_BIN_PATH
from bfasst.tool import ToolProduct


class VivadoImplementationTool(ImplementationTool):
    """Run Vivado Implementation"""

    TOOL_WORK_DIR = "vivado_impl"

    def __init__(self, cwd, flow_args="", ooc=False):
        super().__init__(cwd, flow_args)
        self.ooc = ooc

    def implement_bitstream(self, design):
        log_path = self.work_dir / bfasst.config.IMPL_LOG_NAME
        design.impl_netlist_path = self.cwd / (design.top + "_impl.v")
        design.impl_edif_path = design.impl_netlist_path.with_suffix(".edf")
        design.xilinx_impl_checkpoint_path = self.work_dir / "design.dcp"
        design.bitstream_path = self.cwd / (design.top + ".bit")

        # Check for up to date previous run
        status = self.get_prev_run_status(
            tool_products=[
                ToolProduct(design.bitstream_path, log_path, self.check_impl_status),
            ],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.netlist_path.stat().st_mtime
            ),
        )

        if status is not None:
            self.print_skipping_impl()
            return status

        self.print_running_impl()

        # Run implementation
        status = self.run_implementation(design, log_path)

        # Check implementation log
        status = self.check_impl_status(log_path)

        # Update a file in the main directory with info about impl results
        # self.write_to_results_file(design, log_path, need_to_run)

        return self.success_status

    def run_implementation(self, design, log_path):
        """Run vivado executable to perform implementation"""

        tcl_path = self.work_dir / ("impl.tcl")

        with open(tcl_path, "w") as fp:
            # fp.write("set_part " + bfasst.config.PART + "\n")
            fp.write("if { [ catch {\n")
            fp.write("read_edif " + str(design.netlist_path) + "\n")

            # for vf in design.verilog_files:
            #     fp.write("read_verilog " + str(design.))

            fp.write("set_property design_mode GateLvl [current_fileset]\n")
            fp.write(
                "set_property edif_top_file " + str(design.netlist_path) + " [current_fileset]\n"
            )
            fp.write("link_design -part " + bfasst.config.PART + "\n")
            if not self.ooc:
                fp.write("read_xdc " + str(design.constraints_path) + "\n")
            fp.write("opt_design\n")
            fp.write("place_design\n")
            fp.write("route_design\n")
            fp.write(
                "write_checkpoint -force -file " + str(design.xilinx_impl_checkpoint_path) + "\n"
            )
            fp.write("write_edif -force -file " + str(design.impl_edif_path) + "\n")
            fp.write("write_verilog -force -file " + str(design.impl_netlist_path) + "\n")
            if not self.ooc:
                fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
            # fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")
            fp.write("} ] } { exit 1 }\n")
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
                sys.stdout.write(line)
                sys.stdout.flush()
                fp.write(line)
                fp.flush()
                if re.match(r"\s*ERROR:", line):
                    proc.kill()
            proc.communicate()
            if proc.returncode:
                return Status(ImplStatus.ERROR)

        return self.success_status

    def check_impl_status(self, log_path):
        """Checks the status of Vivado execution for errors"""
        text = open(log_path).read()

        matches = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if matches:
            return Status(ImplStatus.ERROR, matches.group(1).strip())

        matches = re.search(
            r"^Design LUT Count \((\d+)\) exceeded Device LUT Count \((\d+)\)$", text, re.M
        )
        if matches:
            return Status(ImplStatus.TOO_MANY_LUTS, matches.group(1) + "/" + matches.group(2))
        matches = re.search(
            r"^Design FF Count \((\d+)\) exceeded Device FF Count \((\d+)\)$", text, re.M
        )
        if matches:
            return Status(ImplStatus.TOO_MANY_FF, matches.group(1) + "/" + matches.group(2))

        # Too many I/Os
        matches = re.search(
            (
                r"Unable to fit the design into the selected device/package$\n",
                r"^DEVICE IO Count:.*?Regular IOs.*?(\d+).*?DESIGN IO Count:.*?Regular IOs.*?(\d+)",
            ),
            text,
            re.M | re.S,
        )
        if matches:
            return Status(ImplStatus.TOO_MANY_IO, matches.group(2) + "/" + matches.group(1))

        return self.success_status

    def write_to_results_file(self, design, log_path, need_to_run):
        """This function writes results to a file.  Not sure if it's used anymore?"""

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
                            for _ in range(11):
                                res_line = next(log_f)
                                res_f.write(res_line)
                res_f.write("\n")
