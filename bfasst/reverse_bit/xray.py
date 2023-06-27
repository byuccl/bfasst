""" X-ray bitstream to netlist tool"""
import os
import re
import pathlib

from bfasst.reverse_bit.base import ReverseBitTool, ReverseBitException
from bfasst import paths, config
from bfasst.tool import ToolProduct


class XRayReverseBitTool(ReverseBitTool):
    """X-ray bitstream to netlist tool"""

    TOOL_WORK_DIR = "xray"

    def __init__(self, cwd, design, flow_args):
        super().__init__(cwd, design, flow_args)

        self.fasm2bels_path = paths.ROOT_PATH / "third_party" / "fasm2bels"
        self.fasm2bels_python_path = (
            self.fasm2bels_path
            / "env"
            / "conda"
            / "envs"
            / "f4pga_xc_fasm2bels"
            / "bin"
            / "python3"
        )
        self.xray_path = self.fasm2bels_path / "third_party" / "prjxray"
        self.xray_db_path = self.fasm2bels_path / "third_party" / "prjxray-db"
        self.db_root = self.xray_db_path / config.PART_FAMILY
        self.to_netlist_log = self.work_dir / "to_netlist.log"
        self.to_fasm_log = self.work_dir / "to_fasm.log"

    def reverse_bitstream(self):
        """Run bitstream to netlist conversion"""
        self.open_log()
        # To fasm process
        fasm_path = self.work_dir / (self.design.top + ".fasm")
        generate_fasm = ToolProduct(fasm_path)

        # To reversed netlist process
        self.design.reversed_netlist_path = self.cwd / (self.design.top + "_reversed.v")
        generate_netlist = ToolProduct(
            self.design.reversed_netlist_path, self.to_netlist_log, self.to_netlist_log_parser
        )

        if self.design.cur_error_flow_name is not None:
            self.design.reversed_netlist_path = self.cwd / (
                self.design.top + "_" + self.design.cur_error_flow_name + "_reversed.v"
            )

        if not self.need_to_rerun(
            [generate_fasm, generate_netlist],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, self.design.bitstream_path.stat().st_mtime
            ),
        ):
            self.print_skipping_reverse_bit()
            return

        self.print_running_reverse_bit()

        # Bitstream to fasm file
        self.convert_bit_to_fasm(self.design.bitstream_path, fasm_path)

        # fasm to netlist
        xdc_path = self.work_dir / (self.design.top + "_reversed.xdc")
        try:
            self.convert_fasm_to_netlist(
                fasm_path, self.design.constraints_path, self.design.reversed_netlist_path, xdc_path
            )
        except ReverseBitException as e:
            # See if the log parser can find an error message
            if self.to_netlist_log.is_file():
                self.to_netlist_log_parser(self.to_netlist_log)
            raise e

        self.to_netlist_log_parser(self.to_netlist_log)

    def convert_bit_to_fasm(self, bitstream_path, fasm_path):
        """Convert bitstream to FASM file"""
        self.log_title("Converting bitstream to FASM")

        my_env = os.environ.copy()
        my_env["PATH"] = str(self.xray_path / "build" / "tools") + os.pathsep + my_env["PATH"]
        cmd = [
            self.fasm2bels_python_path,
            self.xray_path / "utils" / "bit2fasm.py",
            "--db-root",
            self.db_root,
            "--part",
            config.PART,
            bitstream_path,
        ]

        self.log("Creating FASM file", fasm_path)
        self.log("Saving log output to", self.to_fasm_log)
        self.log("\n", *cmd, "\n")
        with open(fasm_path, "w") as fp, open(self.to_fasm_log, "w") as fp_err:
            proc = self.exec_and_log(cmd, fp=fp, fp_err=fp_err, env=my_env)
            if proc.returncode:
                raise ReverseBitException("Failed to convert bitstream to FASM file")

    def convert_fasm_to_netlist(self, fasm_path, constraints_path, netlist_path, xdc_path):
        """Convert the FASM file to a netlist"""
        self.log_title("Converting FASM to netlist")

        cmd = [
            self.fasm2bels_python_path,
            "-mfasm2bels",
            "--connection_database",
            config.PART + "_db",
            "--db_root",
            self.db_root,
            "--part",
            config.PART,
            "--fasm_file",
            fasm_path,
            "--verilog_file",
            netlist_path,
            "--xdc_file",
            xdc_path,
            "--input_xdc",
            constraints_path,
        ]
        self.log("\n", *cmd, "\n")

        with open(self.to_netlist_log, "w") as fp:
            proc = self.exec_and_log(cmd, fp=fp, cwd=self.fasm2bels_path)
        if proc.returncode:
            raise ReverseBitException("Failed to convert FASM to netlist")

    def to_netlist_log_parser(self, log_path):
        """Parse the 'To netlist' log file for errors"""
        text = open(log_path).read()

        matches = re.search(r"^\s*(assert .*?)$", text, re.M)
        if matches:
            raise ReverseBitException(
                "FASM to netlist assertion failed: " + matches.group(1).strip()
            )

        matches = re.search(r"^\s*KeyError: '(DSP_[LR])'\s*$", text, re.M)
        if matches:
            raise ReverseBitException("Unsupported Primitive: " + matches.group(1).strip())

        # KeyError: 'DSP_L'

    # def write_to_results_file(self, design, netlist_path, need_to_run):
    #     raise NotImplementedError

    #     if design.results_summary_path is None:
    #         print("No results path set!")
    #         return
    #     with open(design.results_summary_path, "a") as res_f:
    #         time_modified = time.ctime(os.path.getmtime(netlist_path))
    #         res_f.write("Results from icestorm netlist (" + time_modified + "):\n")
    #         if not need_to_run:
    #             res_f.write("need_to_run is false, results may be out of date\n")
    #         with open(netlist_path, "r") as net_f:
    #             netlist = net_f.read()
    #             num_luts = netlist.count("/* LUT")
    #             num_carries = netlist.count("/* CARRY")
    #             num_ffs = netlist.count("/* FF")
    #             num_always_ffs = netlist.count("always @")
    #             num_assign_ffs = num_ffs - num_always_ffs
    #             num_ram40s = netlist.count("SB_RAM40_4K")
    #             res_f.write("  Number of LUTs: " + str(num_luts) + "\n")
    #             res_f.write("  Number of carry cells: " + str(num_carries) + "\n")
    #             res_f.write("  Number of flip flops: " + str(num_ffs) + "\n")
    #             res_f.write("    Flops w/ assign statements: " + str(num_assign_ffs) + "\n")
    #             res_f.write("    Flops w/ always statements: " + str(num_always_ffs) + "\n")
    #             res_f.write("  Number of RAM40Ks: " + str(num_ram40s) + "\n")
    #         res_f.write("\n")
