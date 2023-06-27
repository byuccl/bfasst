""" Run confomal comparison tool"""

import re
import socket

# Suppress paramiko warning
# import warnings

# warnings.filterwarnings(action="ignore", module=".*paramiko.*")

import paramiko
import scp

import bfasst
from bfasst import paths
from bfasst.design import HdlType
from bfasst.tool import BfasstException
from bfasst.compare.base import CompareException, CompareTool
from bfasst.types import Vendor
from bfasst.utils import error
from bfasst.locks import conformal_lock


class ConformalCompareTool(CompareTool):
    """Run confomal comparison tool"""

    TOOL_WORK_DIR = "conformal"
    LOG_FILE_NAME = "log.txt"
    DO_FILE_NAME = "compare.do"
    GUI_FILE_NAME = "run_conformal_gui.sh"
    MAPPED_POINTS_FILE_NAME = "mapped_points.txt"

    def __init__(self, cwd, design, gold_netlist, rev_netlist, flow_args, vendor):
        super().__init__(cwd, design, gold_netlist, rev_netlist, flow_args)

        assert isinstance(vendor, Vendor)
        self.vendor = vendor

        self.remote_libs_dir_path = None
        self.local_libs_paths = None

    def compare_netlists(self):
        self.open_log()
        with conformal_lock:
            self._compare_netlists()

    def _compare_netlists(self):
        """Compare given netlists"""
        if self.up_to_date(self.check_compare_status):
            return

        log_path = self.work_dir / self.LOG_FILE_NAME

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
        do_file_path = self.create_do_file()

        # Create remote machine folders
        cmd = "mkdir -p bfasst_libs;" + "mkdir -p bfasst_libs/xilinx;" + "mkdir -p bfasst_work;"

        print(cmd)
        # (stdin, stdout, stderr) =
        client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        # Copy files to remote machine
        self.copy_files_to_remote_machine(client, do_file_path)

        # Run conformal remotely
        try:
            self.run_conformal(client)
        except BfasstException as e:
            raise e

        # Copy back conformal log file
        self.copy_log_from_remote_machine(client)
        client.close()

        # Check conformal log
        self.check_compare_status(log_path)

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
        except socket.timeout as e:
            raise CompareException("The conformal tool timed out") from e

        stderr = stderr.read().decode()
        if "License check failed" in stderr:
            raise CompareException("The conformal tool failed to run due to license issues")

    def create_do_file(self):
        """Create the conformal do file"""
        do_file_path = self.work_dir / self.DO_FILE_NAME

        with open(do_file_path, "w") as fp:
            fp.write(
                "read library -Both -sensitive -Verilog "
                + " ".join(str(self.remote_libs_dir_path / f.name) for f in self.local_libs_paths)
                + " -nooptimize\n"
            )

            if self.design.get_golden_hdl_type() == HdlType.VERILOG:
                src_type = "-Verilog"
            elif self.design.get_golden_hdl_type() == HdlType.VHDL:
                src_type = "-Vhdl"
            else:
                error("Unsupported golden HDL type: ", self.design.get_golden_hdl_type())

            fp.write(
                "read design "
                + " ".join([golden.name for golden in self.design.get_golden_files()])
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
                + self.rev_netlist.name
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

    def copy_files_to_remote_machine(self, client, do_file_path):
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

        for design_file in self.design.get_golden_files():
            scp_client.put(str(design_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        # Copy reverse netlist file
        scp_client.put(
            str(self.design.reversed_netlist_path),
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
            raise CompareException("Conformal timed out")

        # Regex search for result
        match = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
        if not match:
            raise CompareException("There was a parse problem with the comparison log file")
        if match.group(1) != "PASS":
            raise CompareException("The netlists are not equivalent")
