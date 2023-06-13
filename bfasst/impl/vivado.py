""" Runs Vivado implementation (place/route)"""

import re
import os
import time

import bfasst
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus
from bfasst.config import VIVADO_COMMAND


class VivadoImplementationTool(ImplementationTool):
    """Run Vivado Implementation"""

    TOOL_WORK_DIR = "vivado_impl"

    def __init__(self, cwd, design, flow_args=""):
        super().__init__(cwd, design, flow_args)

    def init_design(self):
        """Initialize design object with paths to files needed for implementation"""
        self.design.flow_paths["impl_netlist_path"] = self.cwd / (self.design.top + "_impl.v")
        self.design.flow_paths["impl_edif_path"] = self.design.flow_paths[
            "impl_netlist_path"
        ].with_suffix(".edf")
        self.design.xilinx_impl_checkpoint_path = self.work_dir / "design.dcp"
        self.design.utilization_path = self.work_dir / "utilization.txt"
        self.design.flow_paths["bitstream_path"] = self.cwd / (self.design.top + ".bit")

    def implement_bitstream(self):
        """Run vivado executable to perform implementation"""
        self.init_design()

        status = self.common_startup(self.check_impl_status)
        if status:
            return status

        # Run implementation
        status = self.run_implementation()

        # Check implementation log
        status = self.check_impl_status(self.log_path)

        # Update a file in the main directory with info about impl results
        # self.write_to_results_file(design, log_path, need_to_run)

        return self.success_status

    def write_header(self, fp):
        fp.write("if { [ catch {\n")
        fp.write("read_edif " + str(self.design.netlist_path) + "\n")
        fp.write("set_property top_file " + str(self.design.netlist_path) + " [current_fileset]\n")
        fp.write("link_design -part " + bfasst.config.PART + "\n")
        if not self.args.out_of_context:
            fp.write("read_xdc " + str(self.design.flow_paths["constraints_path"]) + "\n")

    def write_impl(self, fp):
        fp.write("set_property design_mode GateLvl [current_fileset]\n")
        fp.write("opt_design\n")
        fp.write("place_design\n")
        fp.write("route_design\n")

    def write_outputs(self, fp):
        fp.write(
            "write_checkpoint -force -file " + str(self.design.xilinx_impl_checkpoint_path) + "\n"
        )
        fp.write("write_edif -force -file " + str(self.design.flow_paths["impl_edif_path"]) + "\n")
        fp.write(
            "write_verilog -force -file " + str(self.design.flow_paths["impl_netlist_path"]) + "\n"
        )
        fp.write("report_utilization -file " + str(self.design.utilization_path) + "\n")
        if not self.args.out_of_context:
            fp.write(
                "write_bitstream -force " + str(self.design.flow_paths["bitstream_path"]) + "\n"
            )

    def write_footer(self, fp):
        fp.write("} ] } { exit 1 }\n")
        fp.write("exit\n")

    def run_implementation(self):
        """Run vivado executable to perform implementation"""

        tcl_path = self.work_dir / ("impl.tcl")

        with open(tcl_path, "w") as fp:
            self.write_header(fp)
            self.write_impl(fp)
            self.write_outputs(fp)
            self.write_footer(fp)

        cmd = VIVADO_COMMAND + ["-source", str(tcl_path)]
        proc = self.exec_and_log(cmd)
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
                r"Unable to fit the design into the selected device/package$\n"
                r"^DEVICE IO Count:.*?Regular IOs.*?(\d+).*?DESIGN IO Count:.*?Regular IOs.*?(\d+)"
            ),
            text,
            re.M | re.S,
        )
        if matches:
            return Status(ImplStatus.TOO_MANY_IO, matches.group(2) + "/" + matches.group(1))

        return self.success_status

    def write_to_results_file(self, log_path, need_to_run):
        """This function writes results to a file.  Not sure if it's used anymore?"""

        if self.design.flow_paths["results_summary_path"] is None:
            print("No results path set!")
        else:
            with open(self.design.flow_paths["results_summary_path"], "a") as res_f:
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
