"""Base IceCub2 optimization class"""


from abc import abstractmethod
import pathlib
import shutil
import subprocess

import bfasst
from bfasst.opt.base import OptException, OptTool
from bfasst.tool import ToolProduct


class Ic2BaseOptTool(OptTool):
    """Base IceCub2 optimization class"""

    TOOL_WORK_DIR = "ic2_opt"

    def create_netlist(self, in_files, lib_files, force_run=False):
        """Create netlist"""

        # Save edif netlist path to design object
        self.design.netlist_path = self.cwd / (self.design.top + ".edf")

        if (
            not self.need_to_rerun(
                tool_products=[
                    ToolProduct(self.design.netlist_path, self.log_path, self.check_opt_log)
                ],
                dependency_modified_time=max(
                    pathlib.Path(__file__).stat().st_mtime, self.design.last_modified_time()
                ),
            )
            and not force_run
        ):
            self.print_skipping_opt()
            return

        edif_path_temp = self.work_dir / (self.design.top + ".edf")

        # Create Icecube 2 LSE synthesis project file
        prj_path = self.create_project_file(edif_path_temp, in_files, lib_files)

        # Run Icecube 2 LSE synthesis
        try:
            self.run_sythesis(prj_path)
        except OptException as e:
            # If generic error, see if log has something more specific
            if e == OptException("Synthesis failed"):
                self.check_opt_log(self.log_path)
            raise e

        # Parse synthesis log for errors
        self.check_opt_log(self.log_path)

        # Copy edif netlist out of project directory3
        if not edif_path_temp.is_file():
            raise OptException("Synthesis failed to produce netlist")
        shutil.copyfile(edif_path_temp, self.design.netlist_path)

        # self.write_result_file(design)

    @abstractmethod
    def run_sythesis(self, prj_path):
        """run synthesis on netlist"""
        raise NotImplementedError

    @abstractmethod
    def create_project_file(self, edif_path, in_files, lib_files):
        """create project file for icecube2"""
        raise NotImplementedError

    @abstractmethod
    def check_opt_log(self, synth_log):
        """Check optimization log for errors"""
        raise NotImplementedError

    def exec_synth_tool(self, cmd, env):
        try:
            proc = self.exec_and_log(cmd, env=env, timeout=bfasst.config.I2C_LSE_TIMEOUT)
        except subprocess.TimeoutExpired as e:
            raise OptException("Synthesis timed out") from e
        if proc.returncode != 0:
            raise OptException("Synthesis failed")
