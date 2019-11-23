import os
import shutil
import subprocess

import bfasst
from bfasst.impl.base import ImplementationTool
from bfasst.status import Status, ImplStatus


class IC2_ImplementationTool(ImplementationTool):

    def implement_bitstream(self, design):
        # Create working directory
        proj_dir = self.make_project_folder(self.cwd)

        # Create impl tcl script
        tcl_path = self.create_run_tcl(proj_dir)

        # Copy netlist into impl working folder
        new_netlist_path = os.path.join(proj_dir, os.path.basename(design.netlist_path))
        shutil.copyfile(design.netlist_path, new_netlist_path)

        # Run implementation
        status = self.run_implement(design, new_netlist_path, tcl_path, proj_dir)

        # Copy bitstream out of working directory
        bitstream_proj_path = os.path.join(proj_dir, "sbt", "outputs", "bitmap", design.top + "_bitmap.bin")
        design.bitstream_path = os.path.join(self.cwd, design.top + ".bit")        
        if not status.error:
            shutil.copyfile(bitstream_proj_path, design.bitstream_path)

        # Copy constraints out of working directory
        constraints_proj_path = os.path.join(proj_dir, "sbt", "outputs", "placer", design.top + "_sbt.pcf")
        design.constraints_path = os.path.join(self.cwd, design.top + ".pcf")
        if not status.error:
            shutil.copyfile(constraints_proj_path, design.constraints_path)

    	# @$(SCRIPTS)/check_,ic2_design_fit.py $(IC2_IMPL_LOG)
        
        return status

    def run_implement(self, design, netlist_path, tcl_path, proj_dir):
        impl_log_file = os.path.join(proj_dir, bfasst.config.IMPL_LOG_NAME)
        netlist_no_ext = os.path.splitext(os.path.basename(netlist_path))[0]

        cmd = ["tclsh", tcl_path, design.top, ".", netlist_no_ext]
        env = os.environ.copy()
        env["SBT_DIR"] = os.path.join(bfasst.config.IC2_INSTALL_DIR, "sbt_backend")
        with open(impl_log_file, 'w') as fp:
            p = subprocess.run(cmd, stdout = fp, stderr = subprocess.STDOUT, cwd = proj_dir, env = env)
            if p.returncode != 0:
                return Status(ImplStatus.ERROR)
            
        return Status(ImplStatus.SUCCESS)
    
    def create_run_tcl(self, proj_dir):
        tcl_path = os.path.join(proj_dir, "run_impl.tcl")
        shutil.copyfile(os.path.join(bfasst.I2C_RESOURCES, "template.tcl"), tcl_path)
        return tcl_path

    def make_project_folder(self, build_dir):
        ic2_proj_dir = os.path.join(build_dir, bfasst.config.I2C_IMPL_FOLDER)

        if not os.path.isdir(ic2_proj_dir):
            os.mkdir(ic2_proj_dir)
            return ic2_proj_dir