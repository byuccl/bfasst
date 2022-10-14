import subprocess
import re
import sys
import pathlib
import time

import bfasst
from bfasst.design import HdlType
from bfasst.synth.base import SynthesisTool
from bfasst.synth import vivado_ioparse
from bfasst.status import BfasstException, Status, SynthStatus
from bfasst.config import VIVADO_BIN_PATH
from bfasst.tool import ToolProduct


def xdc_line(pin):
    return (
        "set_property -dict "
        f"{{ PACKAGE_PIN {pin[0]}   IOSTANDARD LVCMOS33 }} "
        f"[get_ports {{ {pin[1]} }}];\n"
    )

def write_xdc(pinmap, stream):
    for pin in pinmap:
        stream.write(xdc_line(pin))

def extract_contraints(design, report_io_path):
    with open(design.constraints_path, "w") as fp:
        write_xdc(vivado_ioparse.map_pins(report_io_path), fp)

class Vivado_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "vivado_synth"

    def create_netlist(self, design):
        default = "out_of_context" not in self.flow_args
        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / f"{design.top}.edf"
        design.constraints_path = self.cwd / "constraints.xdc"

        generate_netlist = ToolProduct(
            design.netlist_path, log_path, self.check_synth_log
        )
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
        if default:
            extract_contraints(design, report_io_path)

        # Check synthesis log
        status = self.check_synth_log(log_path)

        return self.success_status

    def run_synth(self, design, log_path, report_io_path):
        tcl_path = self.work_dir / "synth.tcl"

        with open(tcl_path, "w") as fp:
            if design:
                fp.write(f"if {{ [ catch {{\n")
                fp.write(f"set_part {bfasst.config.PART}\n")

                if design.get_top_hdl_type() == HdlType.VERILOG:
                    fp.write(f"read_verilog {design.top_file_path}\n")
                elif design.get_top_hdl_type() == HdlType.SYSTEM_VERILOG:
                    fp.write(f"read_verilog -sv {design.top_file_path}\n")
                else:
                    fp.write(f"read_vhdl {design.top_file_path}\n")

                # Add verilog files
                for vf in design.verilog_file_paths:
                    fp.write(f"read_verilog {vf}\n")

                # Add system verilog files
                for vf in design.system_verilog_file_paths:
                    fp.write(f"read_verilog -sv {vf}\n")

                # Add VHDL files
                for vf in design.vhdl_file_paths:
                    fp.write(f"read_vhdl {vf}\n")

                # Add vhdl library files
                for vf, libname in design.vhdl_libs.items():
                    fp.write(f"read_vhdl -library {libname} {vf}\n")

                if not self.flow_args:
                    # Synthesize - do not include any DSP modules in the synthesized design
                    fp.write(f"synth_design -top {design.top} -max_dsp 0\n")
                else:
                    top = f" -top {design.top} " if "top" not in self.flow_args else ""
                    dsp = " -max_dsp 0" if "max_dsp" not in self.flow_args else ""
                    fp.write(f"synth_design{top}{dsp} {self.flow_args}\n")

                if "out_of_context" not in self.flow_args:
                    # Auto-place ports
                    fp.write(f"place_ports\n")
                fp.write(f"write_edif -force {{{design.netlist_path}}}\n")
                fp.write(
                    f"write_checkpoint -force -file {self.work_dir / 'design.dcp'}\n"
                )

                if "out_of_context" not in self.flow_args:
                    # Save IO to determine where auto port placement occurred
                    fp.write(f"report_io -force -file {report_io_path}\n")

                fp.write(f"}} ] }} {{ exit 1 }}\n")
                fp.write(f"exit\n")

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



    def check_synth_log(self, log_path):
        text = open(log_path).read()

        m = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if m:
            return Status(SynthStatus.ERROR, m.group(1).strip())

        return self.success_status
