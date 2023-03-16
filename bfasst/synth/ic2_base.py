"""Base Icecube2 synth tool"""

from abc import abstractmethod
from bfasst.synth.base import SynthesisTool


class Ic2BaseSynthesisTool(SynthesisTool):
    """Base Icecube2 synth tool"""

    TOOL_WORK_DIR = "ic2_synth"

    def create_netlist(self, design):
        """Create netlist"""
        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        # Use the LSE optimizer -- it will perform the functions of our synthesis
        self.opt_tool = self.get_tool()

        # TODO: Improve the logic here
        force_new_opt_run = True

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

    @abstractmethod
    def get_tool(self):
        raise NotImplementedError
