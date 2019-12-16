import shutil
import subprocess
import re
import os
import os.path

import bfasst
from bfasst.opt.base import OptTool
from bfasst.status import Status, OptStatus

PROJECT_TEMPLATE_FILE = 'template_sp.prj'
IC2_SYNPLIFY_PROJ_FILE = 'synplify_project.prj'

class IC2_Synplify_OptTool(OptTool):
    TOOL_WORK_DIR = "ic2_opt"

    def get_log_path(self):
        return self.work_dir / bfasst.config.OPT_LOG_NAME

    def get_last_runtime(self):
        log_path = self.get_log_path()
        if not log_path.is_file():
            return None
        else:
            return log_path.stat().st_mtime

    def create_netlist(self, design, in_files, lib_files, force_run = False):

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        log_path = self.get_log_path() 
        edif_path_temp = self.work_dir / (design.top + ".edf")

        # Check if synthesis needs to be run
        need_to_run = force_run

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if there is no netlist, and no error message in the log file
        need_to_run |= (not need_to_run) and (not design.netlist_path.is_file() and not self.check_opt_log(log_path).error)

        # Run if last run is out of date
        need_to_run |= (not need_to_run) and (design.last_modified_time() > log_path.stat().st_mtime)

        if need_to_run:
            # Create Icecube 2 LSE synthesis project file
            prj_path = self.create_ic2_synplify_project_file(design, edif_path_temp, \
                                                        in_files, lib_files)

            # Run Icecube 2 LSE synthesis
            status = self.run_sythesis(prj_path, log_path)
            if status.error:
                # If generic error, see if log has something more specific
                if status.status == OptStatus.ERROR:
                    new_status = self.check_opt_log(log_path)
                    if new_status.error:
                        return new_status
                return status

        # Parse synthesis log for errors
        status = self.check_opt_log(log_path)
        if status.error:
            return status

        if need_to_run:
            # Copy edif netlist out of project directory3
            if not edif_path_temp.is_file():
                return Status(OptStatus.ERROR)
            shutil.copyfile(edif_path_temp, design.netlist_path)

        return Status(OptStatus.SUCCESS)

    def run_sythesis(self, prj_path, log_path):
        cmd = [bfasst.config.IC2_INSTALL_DIR /"sbt_backend"/"bin"/"linux"/"opt"/"synpwrap"/"synpwrap", "-prj", prj_path]
        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = bfasst.config.IC2_INSTALL_DIR/"sbt_backend"/"bin"/"linux"/"opt"/"synpwrap"
        env["SYNPLIFY_PATH"] = bfasst.config.IC2_INSTALL_DIR/"synpbase"
        env["SBT_DIR"] = bfasst.config.IC2_INSTALL_DIR/"sbt_backend"
        with open(log_path, 'w') as fp:
            try:
                p = subprocess.run(
                    cmd, stdout=fp, stderr=subprocess.STDOUT, cwd=self.work_dir, env=env, timeout=bfasst.config.I2C_LSE_TIMEOUT)
            except subprocess.TimeoutExpired:
                fp.write("\nTimeout\n")
                return Status(OptStatus.TIMEOUT)
            else:
                if p.returncode != 0:
                    return Status(OptStatus.ERROR)

            return Status(OptStatus.SUCCESS)

    def create_ic2_synplify_project_file(self, design, edif_path, in_files, lib_files):
        assert type(design) is bfasst.design.Design

        template_file = bfasst.I2C_RESOURCES / PROJECT_TEMPLATE_FILE
        project_file = self.work_dir / IC2_SYNPLIFY_PROJ_FILE
        shutil.copyfile(template_file, project_file)

        with open(project_file, 'a') as fp:
            for design_file in in_files:
                if os.path.splitext(design_file)[1].lower() == ".v":
                    fp.write("add_file -verilog -lib work " + str(design.full_path / design_file) + "\n")
                elif os.path.splitext(design_file)[1].lower() == ".vhd":
                    fp.write("add_file -vhdl -lib work " + str(design.full_path / design_file) + "\n")

            for (vhdl_lib_file_path, vhdl_lib) in lib_files:
                fp.write("add_file -vhdl -lib " + vhdl_lib + " " + str(vhdl_lib_file_path) + "\n")
            fp.write("project -result_file " + str(edif_path) + "\n")

    # 	@echo "-top $(NAME)" >> $@
    # 	@echo "-output_edif ../../$(IC2_EDIF_FILE)" >> $@
        return project_file

    def check_opt_log(self, synth_log):
        text = open(synth_log).read()

        if re.search("^Timeout$", text, re.M):
            return Status(OptStatus.TIMEOUT)

        # if re.search(r'Job: "fpga_mapper', text, re.M):
        m = re.search(r'Job: "fpga_mapper" terminated with error status: \d+\nSee log file: "(.*?)"', text, re.M)
        if m:
            text = open(m.group(1)).read()
            if re.search(r'^@E:.*?larger than the total number of registers available', text, re.M):
                return Status(OptStatus.TOO_MANY_FF)

        return Status(OptStatus.SUCCESS)
