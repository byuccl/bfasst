""" Run confomal comparison tool"""

import re
import socket
import pathlib

# Suppress paramiko warning
# import warnings

# warnings.filterwarnings(action="ignore", module=".*paramiko.*")

import paramiko
import scp

import bfasst
from bfasst import paths
from bfasst.design import HdlType
from bfasst.tool import ToolProduct
from bfasst.status import BfasstException, Status, CompareStatus
from bfasst.compare.base import CompareTool
from bfasst.types import Vendor
from bfasst.utils import error


class ConformalCompareTool(CompareTool):
    """Run confomal comparison tool"""

    TOOL_WORK_DIR = "conformal"
    LOG_FILE_NAME = "log.txt"
    DO_FILE_NAME = "compare.do"
    GUI_FILE_NAME = "run_conformal_gui.sh"
    MAPPED_POINTS_FILE_NAME = "mapped_points.txt"

    def __init__(self, cwd, flow_args, vendor):
        super().__init__(cwd, flow_args)

        assert isinstance(vendor, Vendor)
        self.vendor = vendor

        self.remote_libs_dir_path = None
        self.local_libs_paths = None

    def compare_netlists(self, design):
        """Compare given netlists"""
        log_path = self.work_dir / self.LOG_FILE_NAME

        generate_comparison = ToolProduct(None, log_path, self.check_compare_status)
        status = self.get_prev_run_status(
            tool_products=(generate_comparison,),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime,
                design.reversed_netlist_path.stat().st_mtime,
            ),
        )

        if status is not None:
            self.print_skipping_compare()
            return status

        self.print_running_compare()

        # Connect to remote machine
        client = self.connect_to_remote_machine()

        # Handle libraries
        if self.vendor == Vendor.XILINX:
            self.remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "xilinx"
            self.local_libs_paths = list(
                (paths.RESOURCES_PATH / "conformal" / "libraries" / "xilinx").iterdir()
            )

            self.local_libs_paths = []
            yosys_xilinx_libs_path = (
                paths.ROOT_PATH
                / "third_party/fasm2bels/third_party/prjxray/third_party/yosys/techlibs/xilinx/"
            )
            self.local_libs_paths.append(yosys_xilinx_libs_path / "cells_sim.v")
        elif self.vendor == Vendor.LATTICE:
            self.remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "lattice"
            self.local_libs_paths = (
                paths.RESOURCES_PATH / "conformal" / "libraries" / "lattice" / "sb_ice_syn.v",
            )
        else:
            assert False, self.vendor

        # Create do file
        do_file_path = self.create_do_file(design)

        # Create remote machine folders
        cmd = "mkdir -p bfasst_libs;" + "mkdir -p bfasst_libs/xilinx;" + "mkdir -p bfasst_work;"

        print(cmd)
        # (stdin, stdout, stderr) =
        client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        # Copy files to remote machine
        self.copy_files_to_remote_machine(client, design, do_file_path)

        # Run conformal remotely
        try:
            status = self.run_conformal(client)
        except BfasstException as e:
            if e.error != CompareStatus.TIMEOUT:
                raise e
            status = e

        # Copy back conformal log file
        self.copy_log_from_remote_machine(client)
        client.close()

        if status.status == CompareStatus.TIMEOUT:
            with open(log_path, "a") as fp:
                fp.write("\nTimeout\n")

        # Check conformal log
        status = self.check_compare_status(log_path)

        return self.success_status

    def connect_to_remote_machine(self):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(
            bfasst.config.CONFORMAL_REMOTE_MACHINE,
            username=bfasst.config.CONFORMAL_REMOTE_MACHINE_USER,
        )
        return client

    def run_conformal(self, client):
        """Run the conformal tool on the remote server"""
        cmd = (
            "source "
            + str(bfasst.config.CONFORMAL_REMOTE_SOURCE_SCRIPT)
            + ";"
            + "cd "
            + str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR)
            + ";"
            + str(bfasst.config.CONFORMAL_REMOTE_PATH)
            + " -Dofile "
            + self.DO_FILE_NAME
            + " -Logfile "
            + self.LOG_FILE_NAME
            + " -NOGui"
        )

        print(cmd)
        (stdin, stdout, stderr) = client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        stdin.write("yes\n")

        try:
            stdout.read()
            stdout.channel.recv_exit_status()
        except socket.timeout:
            return Status(CompareStatus.TIMEOUT)

        stderr = stderr.read().decode()
        if "License check failed" in stderr:
            return Status(CompareStatus.NO_LICENSE)

        return Status(CompareStatus.SUCCESS)

    def create_do_file(self, design):
        """Create the conformal do file"""
        do_file_path = self.work_dir / self.DO_FILE_NAME

        with open(do_file_path, "w") as fp:
            fp.write(
                "read library -Both -sensitive -Verilog "
                + " ".join(str(self.remote_libs_dir_path / f.name) for f in self.local_libs_paths)
                + " -nooptimize\n"
            )

            if design.get_golden_hdl_type() == HdlType.VERILOG:
                src_type = "-Verilog"
            elif design.get_golden_hdl_type() == HdlType.VHDL:
                src_type = "-Vhdl"
            else:
                error("Unsupported golden HDL type: ", design.get_golden_hdl_type())

            fp.write(
                "read design "
                + " ".join([golden.name for golden in design.get_golden_files()])
                + " "
                + src_type
                + " -Golden -sensitive -continuousassignment Bidirectional"
                + " -nokeep_unreach -nosupply\n"
            )
            # fp.write("read design " + design.top_file + " " +
            # " ".join(design.get_support_files()) + " " + src_type +
            # " -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n")

            fp.write(
                "read design "
                + design.reversed_netlist_path.name
                + " -Verilog -Revised -sensitive -continuousassignment Bidirectional"
                + " -nokeep_unreach -nosupply\n"
            )
            fp.write(r"add renaming rule vector_expand %s\[%d\] @1_@2 -Both -map" + "\n")

            # if mapping_algorithm == "ccl":
            #     fp.write("set system mode lec -nomap\n")
            #     fp.write("REAd MApped Points mapped_points.txt\n")

            # else:
            fp.write("set system mode lec\n")

            fp.write("add compared points -all\n")
            fp.write("compare\n")
            fp.write("report verification\n")
            fp.write("exit -f\n")

        # Create script to run GUI on caedm
        run_gui_path = self.work_dir / self.GUI_FILE_NAME
        with open(run_gui_path, "w") as fp:
            fp.write("source " + str(bfasst.config.CONFORMAL_REMOTE_SOURCE_SCRIPT) + ";\n")
            fp.write(
                str(bfasst.config.CONFORMAL_REMOTE_PATH) + " -Dofile " + self.DO_FILE_NAME + "\n"
            )

        return do_file_path

    def copy_files_to_remote_machine(self, client, design, do_file_path):
        """Copy files to remote machine"""
        scp_client = scp.SCPClient(client.get_transport())

        # Copy library files
        for f in self.local_libs_paths:
            scp_client.put(str(f), str(self.remote_libs_dir_path / f.name))

        # Copy do script
        scp_client.put(
            str(do_file_path),
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.DO_FILE_NAME),
        )

        # Copy gui script
        run_gui_path = self.work_dir / self.GUI_FILE_NAME
        scp_client.put(
            str(run_gui_path),
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.GUI_FILE_NAME),
        )

        # Copy mapped points
        # scpClient.put(
        #     str(mapped_points_file_path),
        #     str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.MAPPED_POINTS_FILE_NAME),
        # )

        for design_file in design.get_golden_files():
            scp_client.put(str(design_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        # Copy reverse netlist file
        scp_client.put(
            str(design.reversed_netlist_path),
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR),
        )

        scp_client.close()

    def copy_log_from_remote_machine(self, client):
        scp_client = scp.SCPClient(client.get_transport())
        scp_client.get(
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.LOG_FILE_NAME),
            str(self.work_dir),
        )
        scp_client.close()

    def check_compare_status(self, log_path):
        """Check log file for status"""
        log_text = open(log_path).read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        match = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
        if not match:
            return Status(CompareStatus.PARSE_PROBLEM)
        if match.group(1) == "PASS":
            return Status(CompareStatus.SUCCESS)
        return Status(CompareStatus.NOT_EQUIVALENT, match.group(1))
