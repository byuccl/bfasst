import shutil
import subprocess
import re
import os

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
        design.netlist_path = self.cwd / (design.top + ".edf")

        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME
        edif_path_temp = self.work_dir / (design.top + ".edf")

        # Check if synthesis needs to be run
        need_to_run = False

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if there is no netlist, and no error message in the log file
        need_to_run |= (not need_to_run) and (not design.netlist_path.is_file() and not self.check_synth_log(log_path).error)

        # Run if last run is out of date
        need_to_run |= (not need_to_run) and (design.last_modified_time() > log_path.stat().st_mtime)

        if need_to_run:
            # Call the LSE optimizer -- it will perform the functions of our
            # synthesizer

            # build a list of files and libs
            design_files = [design.top_file]
            design_files.extend(design.verilog_files)
            design_files.extend(design.vhdl_files)
            lib_files = design.vhdl_libs.items()

            # call the lse optimizer
            opt_tool = bfasst.opt.ic2_lse.IC2_LSE_OptTool(self.cwd)
            status = opt_tool.create_netlist(design, design_files, lib_files)

            # Copy the log file so it can be used by this front-end
            opt_log_path = opt_tool.work_dir / bfasst.config.OPT_LOG_NAME
            shutil.copy(opt_log_path, log_path)
            
            return status
            
            # Create Icecube 2 LSE synthesis project file
            #prj_path = self.create_ic2_lse_project_file(design, edif_path_temp)

            # Run Icecube 2 LSE synthesis
            #status = self.run_sythesis(prj_path, log_path)
            #if status.error:
            #    return status

        # Parse synthesis log for errors
        status = self.check_synth_log(log_path)
        if status.error:
            return status

        if need_to_run:
            # Copy edif netlist out of project directory3
            if not edif_path_temp.is_file():
                return Status(SynthStatus.ERROR)
            shutil.copyfile(edif_path_temp, design.netlist_path)

        return Status(SynthStatus.SUCCESS)

    def check_synth_log(self, synth_log):
        text = open(synth_log).read()
        if re.search("^Timeout$", text, re.M):
            return Status(SynthStatus.TIMEOUT)

        return Status(SynthStatus.SUCCESS)
