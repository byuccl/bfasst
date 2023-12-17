"""Base Icecube2 synth tool"""

from abc import abstractmethod
from bfasst.tools_legacy.synth.base import SynthesisTool


class Ic2BaseSynthesisTool(SynthesisTool):
    """Base Icecube2 synth tool"""

    TOOL_WORK_DIR = "ic2_synth"

    def create_netlist(self):
        """Create netlist"""
        self.launch()
        # Save edif netlist path to design object
        self.design.netlist_path = self.cwd / (self.design.top + ".edf")

        # Use the LSE optimizer -- it will perform the functions of our synthesis
        self.opt_tool = self.get_tool()

        # TODO: Improve the logic here
        force_new_opt_run = True
        force_run = force_new_opt_run

        # build a list of files and libs
        design_files = [self.design.top_file_path]
        design_files.extend(self.design.verilog_file_paths)
        design_files.extend(self.design.vhdl_file_paths)
        lib_files = self.design.vhdl_libs.items()

        # call the lse optimizer
        self.opt_tool.create_netlist(lib_files, force_run)

        self.cleanup()

    @abstractmethod
    def get_tool(self):
        raise NotImplementedError
