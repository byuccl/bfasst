import bfasst
import paramiko
import scp
import sys
import re
import socket

# Suppress paramiko warning
import warnings

warnings.filterwarnings(action="ignore", module=".*paramiko.*")

from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst import flows, paths


class Conformal_CompareTool(CompareTool):
    TOOL_WORK_DIR = "conformal"

    LOG_FILE_NAME = "log.txt"
    DO_FILE_NAME = "compare.do"
    GUI_FILE_NAME = "run_conformal_gui.sh"

    def __init__(self, cwd, vendor):
        super().__init__(cwd)

        assert type(vendor) is flows.Vendor
        self.vendor = vendor

    def compare_netlists(self, design, print_to_stdout=True):
        self.print_to_stdout = print_to_stdout

        log_path = self.work_dir / self.LOG_FILE_NAME

        # Check if compare needs to be run
        need_to_run = False

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if last compare is out of date
        need_to_run |= (not need_to_run) and (
            design.bitstream_path.stat().st_mtime > log_path.stat().st_mtime
        )

        if need_to_run:
            if self.print_to_stdout:
                self.print_running_compare()

            # Connect to remote machine
            client = self.connect_to_remote_machine()

            # Create do file
            do_file_path = self.create_do_file(design)

            # Copy files to remote machine
            self.copy_files_to_remote_machine(client, design, do_file_path)

            # Run conformal remotely
            status = self.run_conformal(client)
            if status.error and not status.status == CompareStatus.TIMEOUT:
                return status

            # Copy back conformal log file
            self.copy_log_from_remote_machine(client)
            client.close()

            if status.status == CompareStatus.TIMEOUT:
                with open(log_path, "a") as fp:
                    fp.write("\nTimeout\n")
        elif self.print_to_stdout:
            self.print_skipping_compare()

        # Check conformal log
        status = self.check_compare_status()
        if status.error:
            return status

        return Status(CompareStatus.SUCCESS)

    def connect_to_remote_machine(self):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(
            bfasst.config.CONFORMAL_REMOTE_MACHINE,
            username=bfasst.config.CONFORMAL_REMOTE_MACHINE_USER,
        )
        return client

    def run_conformal(self, client):
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
        if self.print_to_stdout:
            print(cmd)
        (stdin, stdout, stderr) = client.exec_command(cmd, timeout=bfasst.config.CONFORMAL_TIMEOUT)

        stdin.write("yes\n")

        try:
            s = stdout.read()
            stdout.channel.recv_exit_status()
        except socket.timeout:
            return Status(CompareStatus.TIMEOUT)

        stderr = stderr.read().decode()
        if "License check failed" in stderr:
            return Status(CompareStatus.NO_LICENSE)

        return Status(CompareStatus.SUCCESS)

    def create_do_file(self, design):
        do_file_path = self.work_dir / self.DO_FILE_NAME

        with open(do_file_path, "w") as fp:
            if self.vendor == flows.Vendor.XILINX:
                remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "xilinx"
                local_libs_dir_path = paths.RESOURCES_PATH / "conformal" / "libraries" / "xilinx"
            elif self.vendor == flows.Vendor.LATTICE:
                remote_libs_dir_path = bfasst.config.CONFORMAL_REMOTE_LIBS_DIR / "lattice"
                local_libs_dir_path = paths.RESOURCES_PATH / "conformal" / "libraries" / "xilinx"
            else:
                assert False, self.vendor

            fp.write(
                "read library -Both -sensitive -Verilog "
                + " ".join(
                    str(remote_libs_dir_path / f.name) for f in local_libs_dir_path.glob("*")
                )
                + " -nooptimize\n"
            )

            if design.top_is_verilog():
                src_type = "-Verilog"
            else:
                src_type = "-Vhdl"
            fp.write(
                "read design "
                + " ".join([golden.name for golden in design.get_golden_files()])
                + " "
                + src_type
                + " -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n"
            )
            # fp.write("read design " + design.top_file + " " + " ".join(design.get_support_files()) + " " + src_type + " -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n")

            fp.write(
                "read design "
                + design.reversed_netlist_filename()
                + " -Verilog -Revised -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n"
            )
            fp.write(r"add renaming rule vector_expand %s\[%d\] @1_@2 -Both -map" + "\n")
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
        scpClient = scp.SCPClient(client.get_transport())

        # Copy do script
        scpClient.put(
            str(do_file_path), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.DO_FILE_NAME)
        )

        # Copy gui script
        run_gui_path = self.work_dir / self.GUI_FILE_NAME
        scpClient.put(
            str(run_gui_path), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.GUI_FILE_NAME)
        )

        # Copy top
        # scpClient.put(str(design.top_path()), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        # Copy all support files
        # Todo
        # for verilog_file in design.verilog_files:
        #    scpClient.put(str(design.full_path / verilog_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))
        # for vhdl_file in design.vhdl_files:
        #    scpClient.put(str(design.full_path / vhdl_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        for design_file in design.compare_golden_files_paths:
            scpClient.put(str(design_file), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR))

        # @$(foreach var, $(VERILOG_SUPPORT_FILES),scp $(DESIGN_DIR)/$(var) caedm:$(CONFORMAL_WORK_DIR)/ >> $@;)
        # @$(foreach var, $(VHDL_SUPPORT_FILES),scp $(DESIGN_DIR)/$(var) caedm:$(CONFORMAL_WORK_DIR)/ >> $@;)

        # Copy reverse netlist file
        scpClient.put(
            str(design.reversed_netlist_path), str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR)
        )

        scpClient.close()

    def copy_log_from_remote_machine(self, client):
        scpClient = scp.SCPClient(client.get_transport())
        scpClient.get(
            str(bfasst.config.CONFORMAL_REMOTE_WORK_DIR / self.LOG_FILE_NAME), str(self.work_dir)
        )
        scpClient.close()

    def check_compare_status(self):
        log_path = self.work_dir / self.LOG_FILE_NAME

        log_text = open(log_path).read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        m = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
        if not m:
            return Status(CompareStatus.PARSE_PROBLEM)
        if m.group(1) == "PASS":
            return Status(CompareStatus.SUCCESS)
        else:
            return Status(CompareStatus.NOT_EQUIVALENT, m.group(1))


# for line in execute([, "-Dofile", "compare.do", "-Logfile", "log.txt", "-NOGui"]):
#     sys.stdout.write(line)
#     sys.stdout.flush()
#     if re.search("'dofile .*compare.do' is aborted", line):
#         sys.exit(1)
#     if re.match("// Command: exit", line):
#         sys.exit(0)


# sftp = client.open_sftp()
# sftp.put
# $(CONFORMAL_LOG): $(CONFORMAL_SCP_LOG)
# @echo -e $(COLOR_YELLOW) Running conformal compare \> $(CONFORMAL_LOG) $(NO_COLOR)
# @ssh caedm "source /ee2/Cadence/local/designkits/ee451/cdssetup/bashrc_cadence && \
#     cd $(CONFORMAL_WORK_DIR) && \


#     python run_conformal_and_monitor.py" > $(CONFORMAL_LOG) 2>&1
