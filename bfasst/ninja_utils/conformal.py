"""Run conformal comparison tool"""
import re
import socket
from pathlib import Path

import paramiko
import scp

import bfasst
from bfasst import paths
from bfasst.types import Vendor
from bfasst.locks import conformal_lock


class ConformalCompareError(Exception):
    """Exception raised when an error occurs in the conformal comparison"""


class ConformalCompare:
    """Run conformal comparison tool"""

    COMPARE_WORK_DIR = "conformal"
    LOG_FILE_NAME = "log.txt"
    DO_FILE_NAME = "compare.do"
    GUI_FILE_NAME = "run_conformal_gui.sh"
    MAPPED_POINTS_FILE_NAME = "mapped_points.txt"

    def __init__(self, build_dir, netlist_a, netlist_b, vendor):
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / self.COMPARE_WORK_DIR

        assert isinstance(vendor, Vendor)
        self.vendor = vendor
        self.netlist_a = netlist_a
        self.netlist_b = netlist_b

        self.remote_libs_dir_path = None
        self.local_libs_paths = None

    def compare_netlists(self):
        with conformal_lock:
            self._compare_netlists()

    def _compare_netlists(self):
        """Compare given netlists"""
        client = self.__connect_to_remote_machine()

        # Handle libraries
        if self.vendor == Vendor.XILINX:
            self.remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "xilinx"
            self.local_libs_paths = list(
                (paths.RESOURCES_PATH / "conformal" / "libraries" / "xilinx").iterdir()
            )

            yosys_xilinx_libs_path = (
                paths.XRAY_PATH / "third_party" / "yosys" / "techlibs" / "xilinx"
            )
            self.local_libs_paths.append(yosys_xilinx_libs_path / "cells_sim.v")

        elif self.vendor == Vendor.LATTICE:
            self.remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "lattice"
            self.local_libs_paths = (
                paths.RESOURCES_PATH / "conformal" / "libraries" / "lattice" / "sb_ice_syn.v"
            )

        else:
            assert False, self.vendor

        do_file_path = self.__create_do_file()

        # Create remote directories
        cmd = "mkdir - bfasst_libs;" + "mkdir -p bfasst_libs/xilinx;" + "mkdir -p bfasst_work;"
        client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        self.__copy_files_to_remote(client, do_file_path)

        # Run conformal remotely
        self.__run_conformal(client)

        # Copy back log file
        self.__copy_log_from_remote(client)
        client.close()

        log_path = self.stage_dir / self.LOG_FILE_NAME
        self.__check_compare_status(log_path)

    def __connect_to_remote_machine(self):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(
            bfasst.config.CONFORMAL_REMOTE_MACHINE,
            username=bfasst.config.CONFORMAL_REMOTE_MACHINE_USER,
        )
        return client

    def __create_do_file(self):
        """Create the conformal do file"""
        do_file_path = self.stage_dir / self.DO_FILE_NAME

        with open(do_file_path, "w") as f:
            # TODO: template with chevron
            f.write("")

        run_gui_path = self.stage_dir / self.GUI_FILE_NAME
        with open(run_gui_path, "w") as f:
            # TODO: template with chevron
            f.write("")

        return do_file_path

    def __copy_files_to_remote(self, client, do_file):
        scp_client = scp.SCPClient(client.get_transport())

        # Copy library files
        for f in self.local_libs_paths:
            scp_client.put(str(f), str(self.remote_libs_dir_path / f.name))

        # Copy do script
        scp_client.put(
            str(do_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.DO_FILE_NAME)
        )

        # Copy gui script
        run_gui_path = self.stage_dir / self.GUI_FILE_NAME
        scp_client.put(
            str(run_gui_path), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.GUI_FILE_NAME)
        )

        # Copy mapped points
        # mapped_points_file_path = self.stage_dir / self.MAPPED_POINTS_FILE_NAME
        # scpClient.put(
        #     str(mapped_points_file_path),
        #     str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.MAPPED_POINTS_FILE_NAME),
        # )

        # TODO: Copy golden files -- which ones?
        scp_client.put(str(self.netlist_a), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        # Copy reverse netlist file
        scp_client.put(str(self.netlist_b), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        scp_client.close()

    def __run_conformal(self, client):
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

        (stdin, stdout, stderr) = client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        stdin.write("yes\n")

        try:
            stdout.read()
            stdout.channel.recv_exit_status()
        except socket.timeout as e:
            raise ConformalCompareError("The conformal tool timed out") from e

        stderr = stderr.read().decode()
        if "License check failed" in stderr:
            raise ConformalCompareError("The conformal tool failed to run due to license issues")

    def __copy_log_from_remote(self, client):
        scp_client = scp.SCPClient(client.get_transport())
        scp_client.get(
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.LOG_FILE_NAME),
            str(self.stage_dir),
        )
        scp_client.close()

    def __check_compare_status(self, log_path):
        with open(log_path, "r") as f:
            log_text = f.read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            raise ConformalCompareError("Conformal timed out")

        # Regex search for result
        match = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
        if not match:
            raise ConformalCompareError("There was a parse problem with the comparison log file")
        if match.group(1) != "PASS":
            raise ConformalCompareError("The netlists are not equivalent")
