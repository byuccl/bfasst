import shutil
import subprocess
import re
import os

import bfasst
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus

class IC2_LSE_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "ic2_synth"

    def create_netlist(self, design):

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        # Write to the log file
        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME
        with open(log_path, 'w') as fp:
            fp.write("Running ic2_lse opt tool for synthesis")
        
        # Use the LSE optimizer -- it will perform the functions of our synthesis
        opt_tool = bfasst.opt.ic2_lse.IC2_LSE_OptTool(self.cwd)

        # The opt tool just takes a list of input files, it doesn't know if the design has
        # been modified (ie the design.yaml file), so we add this check here
        force_new_opt_run = (opt_tool.get_last_runtime() is not None) and (opt_tool.get_last_runtime() < design.last_modified_time())

        # build a list of files and libs
        design_files = [design.top_file]
        design_files.extend(design.verilog_files)
        design_files.extend(design.vhdl_files)
        lib_files = design.vhdl_libs.items()

        # call the lse optimizer
        status = opt_tool.create_netlist(design, design_files, lib_files, force_run=force_new_opt_run)
            
        return status