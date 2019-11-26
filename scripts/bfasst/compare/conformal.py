import os
import bfasst
import paramiko
import scp
import sys
import re
import cryptography

# Suppress paramiko warning
import warnings
warnings.filterwarnings(action='ignore',module='.*paramiko.*')

from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus

class Conformal_CompareTool(CompareTool):
    TOOL_WORK_DIR = "conformal"    

    LOG_FILE_NAME = "log.txt"
    DO_FILE_NAME = "compare.do"

    def compare_netlists(self, design):
        # Skip if comparison log already exists
        log_file = os.path.join(self.work_dir, self.LOG_FILE_NAME)
        if not os.path.isfile(log_file):

            # Connect to remote machine
            client = self.connect_to_remote_machine()
            
            # Create do file
            do_file_path = self.create_do_file(design)

            # Copy files to remote machine
            self.copy_files_to_remote_machine(client, design, do_file_path)

            # Run conformal remotely
            status = self.run_conformal(client)
            if status.error:
                return status
            
            # Copy back conformal log file
            self.copy_log_from_remote_machine(client)
            client.close()

        # Check conformal log
        status = self.check_compare_status()
        if status.error:
            return status

        return Status(CompareStatus.SUCCESS)

    def connect_to_remote_machine(self):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(bfasst.config.CONFORMAL_REMOTE_MACHINE, username=bfasst.config.CONFORMAL_REMOTE_MACHINE_USER)
        return client

    def run_conformal(self, client):
        cmd = "source " + bfasst.config.CONFORMAL_REMOTE_SOURCE_SCRIPT + ";" + \
                "cd " + bfasst.config.CONFORMAL_REMOTE_WORK_DIR + ";" + \
                bfasst.config.CONFORMAL_REMOTE_PATH + " -Dofile " + self.DO_FILE_NAME + " -Logfile " + self.LOG_FILE_NAME + " -NOGui"
        
        # print("here")
        (stdin, stdout, stderr) = client.exec_command(cmd)

        # while True:
        #     l = stdout.readline()
        #     print(l)

        #     # l = stderr.readline()
        #     # print(l)
        #     # print(stdout.channel.exit_status_ready)
        #     if stdout.channel.exit_status_ready():
        #         break

        #     m = re.match("// Command: exit", l)
        #     if m:
        #         break

        # while True:
        #     l = stderr.readline()
        #     print(l)
        # print("Error")


        # stdout_text = stdout.read().decode()
        # print("stdout:", stdout_text)
        # if re.search("// Error", stdout_text, re.M):
        #     print("match")

        # stderr_text = stderr.read().decode()
        # if re.search("// Error", stderr_text, re.M):
        #     print("match")
        


        stdin.write("yes\n")

        stdout.channel.recv_exit_status()
        # for line in stdout:
        #     print(line)
        # for line in stderr:
        #     print(line)

        # stdout = stdout.read().decode()
        # print("stdout:", stdout)

        stderr = stderr.read().decode()
        if "License check failed" in stderr:
            return Status(CompareStatus.NO_LICENSE)

        return Status(CompareStatus.SUCCESS)

    def create_do_file(self, design):
        do_file_path = os.path.join(self.work_dir, self.DO_FILE_NAME)

        with open(do_file_path, 'w') as fp:
            fp.write("read library -Both -Replace -sensitive -Verilog " + bfasst.config.CONFORMAL_REMOTE_LIBS_DIR + "/sb_ice_syn.v -nooptimize\n")

            if design.top_is_verilog():
                src_type = "-Verilog"
            else:
                src_type = "-Vhdl"
            fp.write("read design " + design.top_file + " " + " ".join(design.get_support_files()) + " " + src_type + " -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n")

            fp.write("read design " + design.reversed_netlist_filename() + " -Verilog -Revised -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply\n")
            fp.write(r"add renaming rule vector_expand %s\[%d\] @1_@2 -Both -map" + "\n")
            fp.write("set system mode lec\n")
            fp.write("add compared points -all\n")
            fp.write("compare\n")
            fp.write("report verification\n")
            fp.write("exit\n")
        
        return do_file_path

    def copy_files_to_remote_machine(self, client, design, do_file_path):
        scpClient = scp.SCPClient(client.get_transport())
        
        # Copy do script
        scpClient.put(do_file_path, os.path.join(bfasst.config.CONFORMAL_REMOTE_WORK_DIR, self.DO_FILE_NAME))
        
        # Copy top
        scpClient.put(design.top_path(), bfasst.config.CONFORMAL_REMOTE_WORK_DIR)

        # Copy all support files
        # Todo
        # @$(foreach var, $(VERILOG_SUPPORT_FILES),scp $(DESIGN_DIR)/$(var) caedm:$(CONFORMAL_WORK_DIR)/ >> $@;)	
        # @$(foreach var, $(VHDL_SUPPORT_FILES),scp $(DESIGN_DIR)/$(var) caedm:$(CONFORMAL_WORK_DIR)/ >> $@;)	

        # Copy reverse netlist file
        scpClient.put(design.reversed_netlist_path, bfasst.config.CONFORMAL_REMOTE_WORK_DIR)

        scpClient.close()

    def copy_log_from_remote_machine(self, client):
        scpClient = scp.SCPClient(client.get_transport())
        scpClient.get(os.path.join(bfasst.config.CONFORMAL_REMOTE_WORK_DIR, self.LOG_FILE_NAME), self.work_dir)
        scpClient.close()

    def check_compare_status(self):
        log_path = os.path.join(self.work_dir, self.LOG_FILE_NAME)

        log_text = open(log_path).read()

        # Regex search for result
        m = re.search(r"^6\. Compare Results:\s+(.*)$", log_text, re.M)
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