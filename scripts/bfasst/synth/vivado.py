import subprocess
import re
import sys
import pathlib
import time

import bfasst
from bfasst.design import HdlType
from bfasst.synth.base import SynthesisTool
from bfasst.status import BfasstException, Status, SynthStatus
from bfasst.config import VIVADO_BIN_PATH
from bfasst.tool import ToolProduct


class Vivado_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "vivado_synth"

    def create_netlist(self, design):
        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")
        design.constraints_path = self.cwd / "constraints.xdc"

        generate_netlist = ToolProduct(design.netlist_path, log_path, self.check_synth_log)
        generate_constraints = ToolProduct(design.constraints_path)
        tool_products = [generate_netlist, generate_constraints]

        status = self.get_prev_run_status(
            tool_products,
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.last_modified_time()
            ),
        )

        if status is not None:
            self.print_skipping_synth()
            return status

        # Run synthesis flow
        self.print_running_synth()

        report_io_path = self.work_dir / "report_io.txt"

        # Run synthesis
        try:
            status = self.run_synth(design, log_path, report_io_path)
        except BfasstException as e:
            # See if the log parser can find an error message
            if log_path.is_file():
                status_log = self.check_synth_log(log_path)
            # Otherwise, synth failed, but we don't know why.  So just raise this status
            raise e

        # Extract contraint file from Vivado-assigned pins
        self.extract_contraints(design, report_io_path)

        # Check synthesis log
        status = self.check_synth_log(log_path)

        return self.success_status

    def run_synth(self, design, log_path, report_io_path):
        tcl_path = self.work_dir / ("synth.tcl")

        with open(tcl_path, "w") as fp:
            if design:
                fp.write("if { [ catch {\n")
                fp.write("set_part " + bfasst.config.PART + "\n")

                if design.get_top_hdl_type() == HdlType.VERILOG:
                    fp.write("read_verilog " + str(design.top_file_path) + "\n")
                elif design.get_top_hdl_type() == HdlType.SYSTEM_VERILOG:
                    fp.write("read_verilog -sv " + str(design.top_file_path) + "\n")
                else:
                    fp.write("read_vhdl " + str(design.top_file_path) + "\n")
                
                # Add verilog files
                for vf in design.verilog_file_paths:
                    fp.write("read_verilog " + str(vf) + "\n")
                
                # Add system verilog files
                for vf in design.system_verilog_file_paths:
                    fp.write("read_verilog -sv " + str(vf) + "\n")
                
                # Add VHDL files
                for vf in design.vhdl_file_paths:
                    fp.write("read_vhdl " + str(vf) + "\n")

                # Add vhdl library files
                for vf, libname in design.vhdl_libs.items():
                    fp.write("read_vhdl -library " + libname + " " + str(vf) + "\n")

                # Synthesize - do not include any DSP modules in the synthesized design
                fp.write("synth_design -top " + design.top + " -max_dsp 0" + "\n")

                # Auto-place ports
                fp.write("place_ports\n")
                fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")
                fp.write("write_checkpoint -force -file " + str(self.work_dir / "design.dcp") + "\n")

                # Save IO to determine where auto port placement occurred
                fp.write("report_io -force -file " + str(report_io_path) + "\n")

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
            return Status(SynthStatus.ERROR, m.group(1).strip())

        return self.success_status
