"""Base IceCub2 optimization class"""


from abc import abstractmethod
import pathlib
import shutil
import subprocess

import bfasst
from bfasst.opt.base import OptTool
from bfasst.status import BfasstException, OptStatus, Status
from bfasst.tool import ToolProduct


class Ic2BaseOptTool(OptTool):
    """Base IceCub2 optimization class"""

    TOOL_WORK_DIR = "ic2_opt"

    def create_netlist(self, design, in_files, lib_files, force_run=False):
        """Create netlist"""

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        status = self.get_prev_run_status(
            tool_products=[ToolProduct(design.netlist_path, self.log_path, self.check_opt_log)],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.last_modified_time()
            ),
        )

        if status is not None and not force_run:
            self.print_skipping_opt()
            return status

        edif_path_temp = self.work_dir / (design.top + ".edf")

        # Create Icecube 2 LSE synthesis project file
        prj_path = self.create_project_file(design, edif_path_temp, in_files, lib_files)

        # Run Icecube 2 LSE synthesis
        try:
            self.run_sythesis(prj_path)
        except BfasstException as e:
            # If generic error, see if log has something more specific
            if e.error == OptStatus.ERROR:
                self.check_opt_log(self.log_path)
            raise e

        # Parse synthesis log for errors
        status = self.check_opt_log(self.log_path)
        if status.error:
            return status

        # Copy edif netlist out of project directory3
        if not edif_path_temp.is_file():
            return Status(OptStatus.ERROR)
        shutil.copyfile(edif_path_temp, design.netlist_path)

        # self.write_result_file(design)
        return Status(OptStatus.SUCCESS)

    @abstractmethod
    def run_sythesis(self, prj_path):
        """run synthesis on netlist"""
        raise NotImplementedError

    @abstractmethod
    def create_project_file(self, design, edif_path, in_files, lib_files):
        """create project file for icecube2"""
        raise NotImplementedError

    @abstractmethod
    def check_opt_log(self, synth_log):
        """Check optimization log for errors"""
        raise NotImplementedError

    def exec_synth_tool(self, cmd, env):
        try:
            proc = self.exec_and_log(cmd, env=env, timeout=bfasst.config.I2C_LSE_TIMEOUT)
        except subprocess.TimeoutExpired:
            return Status(OptStatus.TIMEOUT)
        if proc.returncode != 0:
            return Status(OptStatus.ERROR)
        return Status(OptStatus.SUCCESS)
