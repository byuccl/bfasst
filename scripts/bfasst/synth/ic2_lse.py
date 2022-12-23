"""
Wrapper class for IC2 LSE Synthesis Tool.
"""

import bfasst
from bfasst.synth.base import SynthesisTool


class Ic2LseSynthesisTool(SynthesisTool):
    """
    Class to run IC2 LSE Synthesis Tool.
    """
    TOOL_WORK_DIR = "ic2_synth"

    def create_netlist(self, design):

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        # Write to the log file
        log_path = self.work_dir / bfasst.config.SYNTH_LOG_NAME
        with open(log_path, "w") as fp:
            fp.write("Running ic2_lse opt tool for synthesis")

        # Use the LSE optimizer -- it will perform the functions of our synthesis
        self.opt_tool = bfasst.opt.ic2_lse.Ic2LseOptTool(self.cwd)

        # The opt tool just takes a list of input files, it doesn't know if the design has
        # been modified (ie the design.yaml file), so we add this check here
        force_new_opt_run = (self.opt_tool.get_last_runtime() is not None) and (
            self.opt_tool.get_last_runtime() < design.last_modified_time()
        )

        # build a list of files and libs
        design_files = [design.top_file]
        design_files.extend(design.verilog_files)
        design_files.extend(design.vhdl_files)
        lib_files = design.vhdl_libs.items()

        # call the lse optimizer
        status = self.opt_tool.create_netlist(
            design, design_files, lib_files, force_run=force_new_opt_run
        )

        return status
