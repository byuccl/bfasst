import os
import shutil
import subprocess

import bfasst
from bfasst.impl.base import ImplementationTool


class IC2_ImplementationTool(ImplementationTool):

    def implement_bitstream(self, design, netlist_path, build_dir):
        # Create working directory
        working_dir = self.make_project_folder(build_dir)

        # Create impl tcl script
        tcl_path = self.create_run_tcl(working_dir)

        # Copy netlist into impl working folder
        new_netlist_path = os.path.join(working_dir, os.path.basename(netlist_path))
        shutil.copyfile(netlist_path, new_netlist_path)

        # Run implementation
        status = self.run_implement(design, new_netlist_path, tcl_path, working_dir)

        # Copy bitstream out of working directory
        bistream_src_path = os.path.join(working_dir, "sbt", "outputs", "bitmap", design.top + "_bitmap.bin")
        bitstream_dest_path = os.path.join(build_dir, design.top + ".bit")        
        if not status.error:
            shutil.copyfile(bistream_src_path, bitstream_dest_path)

    	# @$(SCRIPTS)/check_ic2_design_fit.py $(IC2_IMPL_LOG)
        
        return (bitstream_dest_path, status)

    def run_implement(self, design, netlist_path, tcl_path, working_dir):
        impl_log_file = os.path.join(working_dir, bfasst.config.IMPL_LOG_NAME)
        netlist_no_ext = os.path.splitext(os.path.basename(netlist_path))[0]

        cmd = ["tclsh", tcl_path, design.top, ".", netlist_no_ext]
        env = os.environ.copy()
        env["SBT_DIR"] = os.path.join(bfasst.config.IC2_INSTALL_DIR, "sbt_backend")
        with open(impl_log_file, 'w') as fp:
            p = subprocess.run(cmd, stdout = fp, stderr = subprocess.STDOUT, cwd = working_dir, env = env)
            if p.returncode != 0:
                return bfasst.status.Status(bfasst.status.ImplStatus.ERROR)
            
        return bfasst.status.Status(bfasst.status.ImplStatus.SUCCESS)
    
    def create_run_tcl(self, working_dir):
        tcl_path = os.path.join(working_dir, "run_impl.tcl")
        shutil.copyfile(os.path.join(bfasst.I2C_RESOURCES, "template.tcl"), tcl_path)
        return tcl_path

    def make_project_folder(self, build_dir):
        ic2_proj_dir = os.path.join(build_dir, bfasst.config.I2C_IMPL_FOLDER)

        if not os.path.isdir(ic2_proj_dir):
            os.mkdir(ic2_proj_dir)
            return ic2_proj_dir