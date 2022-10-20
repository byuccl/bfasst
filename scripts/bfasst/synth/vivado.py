""" This file provides tools to wrap Vivado for synthesis purposes """
import subprocess
import re
import sys
import pathlib

import bfasst
from bfasst.design import HdlType
from bfasst.synth.base import SynthesisTool
from bfasst.synth import vivado_ioparse
from bfasst.status import Status, SynthStatus
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
        design.mapped_io = tuple(vivado_ioparse.map_pins(report_io_path))
        write_xdc(design.mapped_io, fp)


class VivadoSynthesisTool(SynthesisTool):
    """A wrapper around vivado, for use in synthesizing designs"""

    TOOL_WORK_DIR = "vivado_synth"

    def create_netlist(self, design):
        """create netlist from design"""
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
        self.run_synth(design, log_path, report_io_path)

        # Extract contraint file from Vivado-assigned pins
        if default:
            extract_contraints(design, report_io_path)

        # Check synthesis log
        self.check_synth_log(log_path)

        return self.success_status

    def write_header(self, stream):
        stream.write("if { [ catch {\n")
        stream.write(f"set_part {bfasst.config.PART}\n")

    def write_hdl(self, design, stream):
        """write out read_<hdl> commands to the stream.  To be used in a tcl file"""
        if design.get_top_hdl_type() == HdlType.VERILOG:
            stream.write(f"read_verilog {design.top_file_path}\n")
        elif design.get_top_hdl_type() == HdlType.SYSTEM_VERILOG:
            stream.write(f"read_verilog -sv {design.top_file_path}\n")
        else:
            stream.write(f"read_vhdl {design.top_file_path}\n")

        # Add verilog files
        for hdl_file in design.verilog_file_paths:
            stream.write(f"read_verilog {hdl_file}\n")

        # Add system verilog files
        for hdl_file in design.system_verilog_file_paths:
            stream.write(f"read_verilog -sv {hdl_file}\n")

        # Add VHDL files
        for hdl_file in design.vhdl_file_paths:
            stream.write(f"read_vhdl {hdl_file}\n")

        # Add vhdl library files
        for hdl_file, libname in design.vhdl_libs.items():
            stream.write(f"read_vhdl -library {libname} {hdl_file}\n")

    def write_synth(self, design, stream):
        if not self.flow_args:
            # Synthesize - do not include any DSP modules in the synthesized design
            stream.write(f"synth_design -top {design.top} -max_dsp 0\n")
        else:
            top = f" -top {design.top} " if "top" not in self.flow_args else ""
            dsp = " -max_dsp 0" if "max_dsp" not in self.flow_args else ""
            stream.write(f"synth_design{top}{dsp} {self.flow_args}\n")

    def write_products(self, design, report_io_path, stream):
        if "out_of_context" not in self.flow_args:
            # Auto-place ports
            stream.write("place_ports\n")
        stream.write(f"write_edif -force {{{design.netlist_path}}}\n")
        stream.write(f"write_checkpoint -force -file {self.work_dir / 'design.dcp'}\n")

        if "out_of_context" not in self.flow_args:
            # Save IO to determine where auto port placement occurred
            stream.write(f"report_io -force -file {report_io_path}\n")

    def write_footer(self, stream):
        stream.write("} ] } { exit 1 }\n")
        stream.write("exit\n")

    def write_tcl(self, design, report_io_path, stream):
        self.write_header(stream)
        self.write_hdl(design, stream)
        self.write_synth(design, stream)
        self.write_products(design, report_io_path, stream)
        self.write_footer(stream)

    def run_synth(self, design, log_path, report_io_path):
        """run vivado synthesis step, capturing edif file, log, and io_report"""

        tcl_path = self.work_dir / "synth.tcl"
        with open(tcl_path, "w") as stream:
            self.write_tcl(design, report_io_path, stream)

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

        match = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if match:
            return Status(SynthStatus.ERROR, match.group(1).strip())

        return self.success_status
