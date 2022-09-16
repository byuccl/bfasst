import subprocess
import time
import os
import sys
import re
import pathlib

from bfasst.reverse_bit.base import ReverseBitTool
from bfasst.status import BfasstException, Status, BitReverseStatus
from bfasst import paths, config
from bfasst.tool import ToolProduct


class XRay_ReverseBitTool(ReverseBitTool):
    TOOL_WORK_DIR = "xray"

    def __init__(self, cwd):
        super().__init__(cwd)

        self.fasm2bels_path = paths.ROOT_PATH / "third_party" / "fasm2bels"
        self.fasm2bels_python_path = (
            self.fasm2bels_path
            / "env"
            / "conda"
            / "envs"
            / "symbiflow_xc_fasm2bels"
            / "bin"
            / "python3"
        )
        self.xray_path = self.fasm2bels_path / "third_party" / "prjxray"
        self.xray_db_path = self.fasm2bels_path / "third_party" / "prjxray-db"
        self.db_root = self.xray_db_path / config.PART_FAMILY

    def reverse_bitstream(self, design):
        # To fasm process
        fasm_path = self.work_dir / (design.top + ".fasm")
        generate_fasm = ToolProduct(fasm_path)

        # To reversed netlist process
        design.reversed_netlist_path = self.cwd / (design.top + "_reversed.v")
        self.to_netlist_log = self.work_dir / "to_netlist.log"
        self.to_fasm_log = self.work_dir / "to_fasm.log"
        generate_netlist = ToolProduct(
            design.reversed_netlist_path, self.to_netlist_log, self.to_netlist_log_parser
        )

        if design.cur_error_flow_name is not None:
            design.reversed_netlist_path = self.cwd / (
                design.top + "_" + design.cur_error_flow_name + "_reversed.v"
            )

        status = self.get_prev_run_status(
            [generate_fasm, generate_netlist],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.bitstream_path.stat().st_mtime
            ),
        )

        if status is not None:
            self.print_skipping_reverse_bit()
            return status

        self.print_running_reverse_bit()

        # Bitstream to fasm file
        status = self.convert_bit_to_fasm(design.bitstream_path, fasm_path)

        # fasm to netlist
        xdc_path = self.work_dir / (design.top + "_reversed.xdc")
        try:
            status = self.convert_fasm_to_netlist(
                fasm_path, design.constraints_path, design.reversed_netlist_path, xdc_path
            )
        except BfasstException as e:
            # See if the log parser can find an error message
            if self.to_netlist_log.is_file():
                status_log = self.to_netlist_log_parser(self.to_netlist_log)
            raise e

        return self.to_netlist_log_parser(self.to_netlist_log)

    def convert_bit_to_fasm(self, bitstream_path, fasm_path):

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

        with open(fasm_path, "w") as fp, open(self.to_fasm_log, "w") as fp_err:
            proc = subprocess.run(
                cmd,
                stdout=fp,
                stderr=fp_err,
                cwd=self.work_dir,
                env=my_env,
            )
            if proc.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    def convert_fasm_to_netlist(self, fasm_path, constraints_path, netlist_path, xdc_path):
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

        print(" ".join((str(s) for s in cmd)))

        with open(self.to_netlist_log, "w") as fp:
            proc = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                cwd=self.fasm2bels_path,
                universal_newlines=True,
            )
            for line in proc.stdout:
                sys.stdout.write(line)
                sys.stdout.flush()
                fp.write(line)
                fp.flush()
            proc.communicate()

            if proc.returncode:
                return Status(BitReverseStatus.ERROR)

        return Status(BitReverseStatus.SUCCESS)

    def to_netlist_log_parser(self, log_path):
        text = open(log_path).read()

        m = re.search(r"^\s*(assert .*?)$", text, re.M)
        if m:
            return Status(BitReverseStatus.ERROR, m.group(1).strip())

        m = re.search(r"^\s*KeyError: '(DSP_[LR])'\s*$", text, re.M)
        if m:
            return Status(BitReverseStatus.UNSUPPORTED_PRIMITVE, m.group(1).strip())

        # KeyError: 'DSP_L'
        return Status(BitReverseStatus.SUCCESS)

    def write_to_results_file(self, design, netlist_path, need_to_run):
        raise NotImplementedError

        if design.results_summary_path is None:
            print("No results path set!")
            return
        with open(design.results_summary_path, "a") as res_f:
            time_modified = time.ctime(os.path.getmtime(netlist_path))
            res_f.write("Results from icestorm netlist (" + time_modified + "):\n")
            if not need_to_run:
                res_f.write("need_to_run is false, results may be out of date\n")
            with open(netlist_path, "r") as net_f:
                netlist = net_f.read()
                num_luts = netlist.count("/* LUT")
                num_carries = netlist.count("/* CARRY")
                num_ffs = netlist.count("/* FF")
                num_always_ffs = netlist.count("always @")
                num_assign_ffs = num_ffs - num_always_ffs
                num_ram40s = netlist.count("SB_RAM40_4K")
                res_f.write("  Number of LUTs: " + str(num_luts) + "\n")
                res_f.write("  Number of carry cells: " + str(num_carries) + "\n")
                res_f.write("  Number of flip flops: " + str(num_ffs) + "\n")
                res_f.write("    Flops w/ assign statements: " + str(num_assign_ffs) + "\n")
                res_f.write("    Flops w/ always statements: " + str(num_always_ffs) + "\n")
                res_f.write("  Number of RAM40Ks: " + str(num_ram40s) + "\n")
            res_f.write("\n")
