import shutil
import subprocess
import re
import os
import sys

import bfasst
from bfasst import utils
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus
from bfasst.config import VIVADO_BIN_PATH


class Vivado_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "vivado_synth"

    PART = "xc7a200tfbg676-2"

    def create_netlist(self, design, print_to_stdout=True):
        self.print_to_stdout = print_to_stdout
        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")
        design.constraints_path = self.cwd / "contraints.xdc"

        # Check if this is already run and up to date
        need_to_run = False

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if there is no netlist, and no error message in the log file
        need_to_run |= (
            (not need_to_run)
            and (not design.netlist_path.is_file())
            and (not self.check_synth_log(log_path).error)
        )

        # Run if last run is out of date
        need_to_run |= (
            (not need_to_run)
            and (design.netlist_path.is_file())
            and (design.last_modified_time() > design.netlist_path.stat().st_mtime)
        )

        if need_to_run:
            if self.print_to_stdout:
                self.print_running_synth()

            report_io_path = self.work_dir / "report_io.txt"

            # Run synthesis
            status = self.run_synth(design, log_path, report_io_path)
            if status.error:
                # See if the log parser can find an error message
                if log_path.is_file():
                    status_log = self.check_synth_log(log_path)
                    if status_log.error:
                        return status_log

                # Otherwise, synth failed, but we don't know why.  So just return this status
                return status

            # Extract contraint file from Vivado-assigned pins
            self.extract_contraints(design, report_io_path)

        elif self.print_to_stdout:
            self.print_skipping_synth()

        # Check synthesis log
        status = self.check_synth_log(log_path)
        if status.error:
            return status

        return Status(SynthStatus.SUCCESS)

    def run_synth(self, design, log_path, report_io_path):
        tcl_path = self.work_dir / ("synth.tcl")

        with open(tcl_path, "w") as fp:
            if design.top_is_verilog:
                fp.write("if { [ catch {\n")
                fp.write("set_part " + bfasst.config.PART + "\n")
                fp.write("read_verilog " + str(design.top_file_path) + "\n")
                for vf in design.verilog_file_paths:
                    fp.write("read_verilog " + str(vf) + "\n")

                fp.write("synth_design -top " + design.top + '\n')
                fp.write("place_ports\n")
                fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")

                # Save IO
                fp.write("report_io -file " + str(report_io_path) + "\n")

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
                if self.print_to_stdout:
                    sys.stdout.write(line)
                fp.write(line)
                fp.flush()
                # if re.match("\s*ERROR:", line):
                #     proc.kill()
                #     return Status(SynthStatus.ERROR)
            proc.communicate()
            if proc.returncode:
                return Status(SynthStatus.ERROR)
        return Status(SynthStatus.SUCCESS)

    def extract_contraints(self, design, report_io_path):
        with open(report_io_path, "r") as fp:
            txt = fp.read()

        match = re.search("2. IO Assignments by Package Pin\n------(.*)$", txt, re.DOTALL)

        lines = match.group(1).splitlines()
        with open(design.constraints_path, "w") as fp:
            for line in lines:
                m = re.match("\|\s+([A-Z]+[0-9]+)\s+\|\s+(\S+)\s+\|", line)
                if m and m.group(2) != "|":
                    fp.write(
                        "set_property -dict { PACKAGE_PIN "
                        + m.group(1)
                        + "   IOSTANDARD LVCMOS33 } [get_ports { "
                        + m.group(2)
                        + " }];\n"
                    )

    def check_synth_log(self, log_path):
        text = open(log_path).read()

        m = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if m:
            return Status(SynthStatus.ERROR, m.group(1))

        return Status(SynthStatus.SUCCESS)