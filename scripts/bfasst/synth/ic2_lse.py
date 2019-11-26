import os
import shutil
import subprocess
import re

import bfasst
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus

PROJECT_TEMPLATE_FILE = 'template_lse.prj'
IC2_LSE_PROJ_FILE = 'lse_project.prj'


class IC2_LSE_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "ic2_synth"

    def create_netlist(self, design):
        # print("Running Synth")

        # Save edif netlist path to design object
        design.netlist_path = os.path.join(self.cwd, design.top + ".edf")

        log_path = os.path.join(
            self.work_dir, bfasst.config.SYNTH_LOG_NAME)
        edif_path_temp = os.path.join(self.work_dir, design.top + ".edf")

        # Check if synthesis needs to be run
        need_to_run = False

        # Run if there is no log file
        need_to_run |= not os.path.isfile(log_path)

        # Run if there is no netlist, and no error message in the log file
        need_to_run |= (not os.path.isfile(design.netlist_path) and not self.check_synth_log(log_path).error)

        # Run if last run is out of date
        need_to_run |= design.last_modified_time() > os.path.getmtime(log_path)

        if need_to_run:
            # Create Icecube 2 LSE synthesis project file
            prj_path = self.create_ic2_lse_project_file(design, edif_path_temp)

            # Run Icecube 2 LSE synthesis
            status = self.run_sythesis(prj_path, log_path)
            if status.error:
                return status

        # Parse synthesis log for errors
        status = self.check_synth_log(log_path)
        if status.error:
            return status

        if need_to_run:
            # Copy edif netlist out of project directory3
            if not os.path.isfile(edif_path_temp):
                return Status(SynthStatus.ERROR)
            shutil.copyfile(edif_path_temp, design.netlist_path)

        return Status(SynthStatus.SUCCESS)

    def run_sythesis(self, prj_path, log_path):

        cmd = [os.path.join(bfasst.config.IC2_INSTALL_DIR,
                            "LSE", "bin", "lin64", "synthesis"), "-f", prj_path]
        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = os.path.join(
            bfasst.config.IC2_INSTALL_DIR, "LSE", "bin", "lin64")
        env["FOUNDRY"] = os.path.join(bfasst.config.IC2_INSTALL_DIR, "LSE")
        env["SBT_DIR"] = os.path.join(
            bfasst.config.IC2_INSTALL_DIR, "sbt_backend")
        with open(log_path, 'w') as fp:
            try:
                p = subprocess.run(
                    cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir, env=env, timeout=bfasst.config.I2C_LSE_TIMEOUT)
            except subprocess.TimeoutExpired:
                fp.write("\nTimeout\n")
                return Status(SynthStatus.TIMEOUT)
            else:
                if p.returncode != 0:
                    return Status(SynthStatus.ERROR)

            return Status(SynthStatus.SUCCESS)

    def create_ic2_lse_project_file(self, design, edif_path):
        assert type(design) is bfasst.design.Design

        template_file = os.path.join(
            bfasst.I2C_RESOURCES, PROJECT_TEMPLATE_FILE)
        project_file = os.path.join(self.work_dir, IC2_LSE_PROJ_FILE)
        shutil.copyfile(template_file, project_file)

        with open(project_file, 'a') as fp:
            fp.write("-p " + design.full_dir + "\n")

            if design.top_is_verilog():
                fp.write("-lib work -ver " + design.top_file + "\n")
            elif design.top_is_vhdl():
                fp.write("-lib work -vhd " + design.top_file + "\n")

            for verilog_file in design.verilog_files:
                fp.write("-ver " + verilog_file + "\n")
    # 	@$(foreach var, $(VERILOG_SUPPORT_FILES), echo "-ver $(var)" >> $@;)
    # 	@# @$(foreach var, $(VHDL_SUPPORT_FILES), echo "-lib $(firstword $(subst /, ,$(var))) -vhd $(var)" >> $@;)

    # 	@$(foreach var, $(VHDL_LIB_FILES), echo "-lib $(firstword $(subst /, ,$(var))) -vhd $(VHDL_LIBS_DIR)/$(var)" >> $@;)
            fp.write("-top " + design.top + "\n")
            fp.write("-output_edif " + edif_path + "\n")

    # 	@echo "-top $(NAME)" >> $@
    # 	@echo "-output_edif ../../$(IC2_EDIF_FILE)" >> $@
        return project_file

    def check_synth_log(self, synth_log):
        text = open(synth_log).read()
        if re.search("^Timeout$", text, re.M):
            return Status(SynthStatus.TIMEOUT)

        return Status(SynthStatus.SUCCESS)
