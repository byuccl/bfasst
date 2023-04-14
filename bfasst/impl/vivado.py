""" Runs Vivado implementation (place/route)"""

import re
import os
import time

import bfasst
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus
from bfasst.synth import vivado_ioparse
from bfasst.config import VIVADO_BIN_PATH


class VivadoImplementationTool(ImplementationTool):
    """Run Vivado Implementation"""

    TOOL_WORK_DIR = "vivado_impl"

    def __init__(self, cwd, flow_args=""):
        super().__init__(cwd, flow_args)

    def implement_bitstream(self, design):
        design.impl_netlist_path = self.cwd / (design.top + "_impl.v")
        design.impl_edif_path = design.impl_netlist_path.with_suffix(".edf")
        design.xilinx_impl_checkpoint_path = self.work_dir / "design.dcp"
        design.bitstream_path = self.cwd / (design.top + ".bit")

        status = self.common_startup(design, self.check_impl_status)
        if status:
            return status

        # Run implementation
        status = self.run_implementation(design)

        # Check implementation log
        status = self.check_impl_status(self.log_path)

        # Update a file in the main directory with info about impl results
        # self.write_to_results_file(design, log_path, need_to_run)

        return self.success_status

    def run_implementation(self, design):
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
            if not self.args.out_of_context:
                fp.write("read_xdc " + str(design.constraints_path) + "\n")
            fp.write("opt_design\n")
            fp.write("place_design\n")
            fp.write("route_design\n")

            fp.write("write_checkpoint -force -file " + str(self.work_dir / "design.dcp") + "\n")
            # fp.write("write_edif -force -file " + str(design.impl_netlist_path.with_suffix
            # (".edf")) + "\n")

            fp.write("write_verilog -force -file " + str(design.impl_netlist_path) + "\n")
            if not self.args.out_of_context:
                fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
            # fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")
            fp.write("} ] } { exit 1 }\n")
            fp.write("exit\n")

        cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
        proc = self.exec_and_log(cmd)
        if proc.returncode:
            return Status(ImplStatus.ERROR)

        return self.success_status

    def run_implementation_yosys(self, design, log_path):
        """This function runs the implementation for Yosys"""
        tcl_path = self.work_dir / ("impl.tcl")
        design.bitstream_path = self.cwd / (design.top + ".bit")
        design.constraints_path = self.cwd / "constraints.xdc"
        report_io_path = str(design.netlist_path.parent) + "/yosys_synth/report_io.txt"

        with open(tcl_path, "w") as fp:
            # fp.write("set_part " + bfasst.config.PART + "\n")
            fp.write("if { [ catch {\n")
            # fp.write("read_edif " + str(design.netlist_path.parent) +
            # "/yosys_synth/yosys.edf" + "\n")
            # fp.write("read_edif " + str(design.netlist_path.parent) +
            # "/yosys_synth/" + pathlib.Path(edif_path).stem + ".edf" + "\n")
            fp.write(
                "read_edif "
                + str(design.netlist_path.parent)
                + "/yosys_synth/"
                + design.top
                + ".edf"
                + "\n"
            )

            # for vf in design.verilog_files:
            #     fp.write("read_verilog " + str(design.))

            fp.write("set_property design_mode GateLvl [current_fileset]\n")
            # fp.write(
            #     "set_property edif_top_file "
            #     + str(design.netlist_path)
            #     #  + str(design.top_file_path.stem)
            #     + " [current_fileset]\n"
            # )
            fp.write("link_design -part " + bfasst.config.PART + "\n")
            # if not self.ooc:
            #     fp.write("read_xdc " + str(design.constraints_path) + "\n")
            fp.write("opt_design\n")
            fp.write("place_design\n")
            fp.write("route_design\n")
            fp.write("write_checkpoint -force -file " + str(self.work_dir / "design.dcp") + "\n")
            # fp.write("write_edif -force -file " +
            # str(design.impl_netlist_path.with_suffix(".edf")) + "\n")
            # fp.write("write_edif -force -file " +
            # str(design.impl_netlist_path)[:-2] + ".edif" + "\n")
            fp.write("write_verilog -force -file " + str(design.impl_netlist_path) + "\n")
            # report_io_path = str(design.netlist_path.parent) + "/yosys_synth/report_io.txt"
            fp.write("report_io -force -file " + report_io_path + "\n")

            # if not self.ooc:
            #     fp.write("read_xdc " + str(design.constraints_path) + "\n")
            #     fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
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
                if re.match("\\s*ERROR:", line):
                    proc.kill()
            proc.communicate()
            if proc.returncode:
                return Status(ImplStatus.ERROR)

        extract_contraints(design, report_io_path)
        tcl_path = self.work_dir / ("impl_2.tcl")
        with open(tcl_path, "w") as fp:
            if not self.ooc:
                fp.write("if { [ catch {\n")
                fp.write("open_checkpoint -file " + str(self.work_dir / "design.dcp") + "\n")
                fp.write("read_xdc " + str(design.constraints_path) + "\n")
                fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
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
                if re.match("\\s*ERROR:", line):
                    proc.kill()
            proc.communicate()
            if proc.returncode:
                return Status(ImplStatus.ERROR)

        return self.success_status

    # def run_implementation_only_2(self, design, log_path):
    # tcl_path = self.work_dir / ("impl_2.tcl")
    # design.bitstream_path = self.cwd / (design.top + ".bit")
    # design.constraints_path = self.cwd / "constraints.xdc"
    # report_io_path = str(design.netlist_path.parent) + "/yosys_synth/report_io.txt"
    # extract_contraints(design, report_io_path)
    # with open(tcl_path, "w") as fp:
    #     if not self.ooc:
    #         fp.write("if { [ catch {\n")
    #         fp.write("open_checkpoint -file " + str(self.work_dir / "design.dcp") + "\n")
    #         fp.write("read_xdc " + str(design.constraints_path) + "\n")
    #         fp.write("write_bitstream -force " + str(design.bitstream_path) + "\n")
    #         fp.write("} ] } { exit 1 }\n")
    #     fp.write("exit\n")

    # with open(log_path, "w") as fp:
    #     cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
    #     proc = subprocess.Popen(
    #         cmd,
    #         cwd=self.work_dir,
    #         stdout=subprocess.PIPE,
    #         stderr=subprocess.STDOUT,
    #         universal_newlines=True,
    #     )
    #     for line in proc.stdout:
    #         sys.stdout.write(line)
    #         sys.stdout.flush()
    #         fp.write(line)
    #         fp.flush()
    #         if re.match("\s*ERROR:", line):
    #             proc.kill()
    #     proc.communicate()
    #     if proc.returncode:
    #         return Status(ImplStatus.ERROR)

    # return self.success_status

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
