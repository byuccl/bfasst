""" This file provides tools to wrap Vivado for synthesis purposes """

import re
import pathlib

import bfasst
from bfasst.design import HdlType
from bfasst.synth.base import SynthesisTool, SynthesisException
from bfasst.synth import vivado_ioparse
from bfasst.config import VIVADO_COMMAND
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

    def up_to_date(self):
        """Check if synthesis has already been run"""

        # Save edif netlist path to design object
        self.design.netlist_path = self.cwd / f"{self.design.top}.edf"
        self.design.constraints_path = self.cwd / "constraints.xdc"

        generate_netlist = ToolProduct(
            self.design.netlist_path, self.log_path, self.check_synth_log
        )
        if self.args.out_of_context:
            tool_products = [generate_netlist]
        else:
            generate_constraints = ToolProduct(self.design.constraints_path)
            tool_products = [generate_netlist, generate_constraints]

        return not self.need_to_rerun(
            tool_products,
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, self.design.last_modified_time()
            ),
        )

    def create_netlist(self):
        """create netlist from design"""

        if self.up_to_date():
            self.print_skipping_synth()
            return

        # Run synthesis flow
        self.print_running_synth()

        report_io_path = self.work_dir / "report_io.txt"

        # Run synthesis
        self.run_synth(report_io_path)

        # Extract contraint file from Vivado-assigned pins
        if not self.args.out_of_context:
            extract_contraints(self.design, report_io_path)

        # Check synthesis log
        self.check_synth_log(self.log_path)

    def write_header(self, stream):
        stream.write("if { [ catch {\n")
        stream.write(f"set_part {bfasst.config.PART}\n")

    def write_hdl(self, stream):
        """write out read_<hdl> commands to the stream.  To be used in a tcl file"""
        if self.design.get_top_hdl_type() == HdlType.VERILOG:
            stream.write(f"read_verilog {self.design.top_file_path}\n")
        elif self.design.get_top_hdl_type() == HdlType.SYSTEM_VERILOG:
            stream.write(f"read_verilog -sv {self.design.top_file_path}\n")
        else:
            stream.write(f"read_vhdl {self.design.top_file_path}\n")

        # Add verilog files
        for hdl_file in self.design.verilog_file_paths:
            stream.write(f"read_verilog {hdl_file}\n")

        # Add system verilog files
        for hdl_file in self.design.system_verilog_file_paths:
            stream.write(f"read_verilog -sv {hdl_file}\n")

        # Add VHDL files
        for hdl_file in self.design.vhdl_file_paths:
            stream.write(f"read_vhdl {hdl_file}\n")

        # Add vhdl library files
        for hdl_file, libname in self.design.vhdl_libs.items():
            stream.write(f"read_vhdl -library {libname} {hdl_file}\n")

    def write_synth(self, stream):
        top = f" -top {self.design.top}" if "top" not in self.args else ""
        flatten = " -flatten_hierarchy full" if self.args.flatten else ""
        dsp = f" -max_dsp {self.args.max_dsp}" if self.args.max_dsp is not None else ""
        ooc = " -mode out_of_context" if self.args.out_of_context else ""

        stream.write(f"synth_design{top}{dsp}{flatten}{ooc}\n")

    def write_products(self, report_io_path, stream):
        if not self.args.out_of_context:
            # Auto-place ports
            stream.write("place_ports\n")
        stream.write(f"write_edif -force {{{self.design.netlist_path}}}\n")
        stream.write(f"write_checkpoint -force -file {self.work_dir / 'design.dcp'}\n")

        if not self.args.out_of_context:
            # Save IO to determine where auto port placement occurred
            stream.write(f"report_io -force -file {report_io_path}\n")

    def write_footer(self, stream):
        stream.write("} ] } { exit 1 }\n")
        stream.write("exit\n")

    def write_tcl(self, report_io_path, stream):
        self.write_header(stream)
        self.write_hdl(stream)
        self.write_synth(stream)
        self.write_products(report_io_path, stream)
        self.write_footer(stream)

    def run_synth(self, report_io_path):
        """run vivado synthesis step, capturing edif file, log, and io_report"""

        tcl_path = self.work_dir / "synth.tcl"
        with open(tcl_path, "w") as stream:
            self.write_tcl(report_io_path, stream)

        cmd = VIVADO_COMMAND + ["-source", str(tcl_path)]
        proc = self.exec_and_log(cmd)
        if proc.returncode:
            raise SynthesisException(f"Vivado synthesis failed with return code {proc.returncode}")

    def check_synth_log(self, log_path):
        text = open(log_path).read()

        match = re.search(r"^ERROR:\s*(.*?)$", text, re.M)
        if match:
            raise SynthesisException(f"Vivado synthesis failed with error: {match.group(1)}")
