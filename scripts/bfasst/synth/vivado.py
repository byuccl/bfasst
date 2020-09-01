import shutil
import subprocess
import re
import os

import bfasst
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus
from bfasst.config import VIVADO_BIN_PATH


class Vivado_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "vivado_synth"

    PART = "xc7a200tfbg676-2"

    def create_netlist(self, design):
        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")
        design.constraints_path = self.cwd / "contraints.xdc"

        # Check if this is already run and up to date
        need_to_run = False

        # Run if there is no netlist, or if the netlist is out of date
        need_to_run |= (not need_to_run) and (not design.netlist_path.is_file())

        # Run if last run is out of date
        need_to_run |= (not need_to_run) and (
            design.last_modified_time() > design.netlist_path.stat().st_mtime
        )

        if need_to_run:
            report_io_path = self.work_dir / "report_io.txt"

            # Run synthesis
            self.run_synth(design, report_io_path)

            # Extract contraint file from Vivado-assigned pins
            self.extract_contraints(design, report_io_path)

        return Status(SynthStatus.SUCCESS)

    def run_synth(self, design, report_io_path):
        tcl_path = self.work_dir / ("synth.tcl")

        with open(tcl_path, "w") as fp:
            if design.top_is_verilog:
                fp.write("set_part " + bfasst.config.PART + "\n")
                fp.write("read_verilog " + str(design.top_path()) + "\n")
                # for vf in design.verilog_files:
                #     fp.write("read_verilog " + str(design.))

                fp.write("synth_design -top " + design.top + "\n")
                fp.write("place_ports\n")
                fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")

                # Save IO
                fp.write("report_io -file " + str(report_io_path) + "\n")

                fp.write("exit\n")

        cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
        subprocess.run(cmd, cwd=self.work_dir)

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
