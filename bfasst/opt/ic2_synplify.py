""" Run Synplify logic optimization"""
import shutil
import re
import os

import bfasst
from bfasst import paths
from bfasst.design import Design
from bfasst.opt.ic2_base import Ic2BaseOptTool
from bfasst.status import Status, OptStatus

PROJECT_TEMPLATE_FILE = "template_sp.prj"
IC2_SYNPLIFY_PROJ_FILE = "synplify_project.prj"


class Ic2SynplifyOptTool(Ic2BaseOptTool):
    """Synplify logic optimization"""

    def run_sythesis(self, prj_path):
        """Run synthesis tool"""
        cmd = [
            bfasst.config.IC2_INSTALL_DIR
            / "sbt_backend"
            / "bin"
            / "linux"
            / "opt"
            / "synpwrap"
            / "synpwrap",
            "-prj",
            prj_path,
        ]
        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = (
            bfasst.config.IC2_INSTALL_DIR / "sbt_backend" / "bin" / "linux" / "opt" / "synpwrap"
        )
        env["SYNPLIFY_PATH"] = bfasst.config.IC2_INSTALL_DIR / "synpbase"
        env["SBT_DIR"] = bfasst.config.IC2_INSTALL_DIR / "sbt_backend"

        return self.exec_synth_tool(cmd, env)

    def create_project_file(self, design, edif_path, in_files, lib_files):
        """Create icecube2 project file"""
        assert isinstance(design, Design)

        template_file = paths.I2C_RESOURCES / PROJECT_TEMPLATE_FILE
        project_file = self.work_dir / IC2_SYNPLIFY_PROJ_FILE
        shutil.copyfile(template_file, project_file)

        with open(project_file, "a") as fp:
            fp.write("set_option -top_module " + design.top + "\n")
            for design_file in in_files:
                if os.path.splitext(design_file)[1].lower() == ".v":
                    fp.write(
                        "add_file -verilog -lib work " + str(design.full_path / design_file) + "\n"
                    )
                elif os.path.splitext(design_file)[1].lower() == ".vhd":
                    fp.write(
                        "add_file -vhdl -lib work " + str(design.full_path / design_file) + "\n"
                    )

            for vhdl_lib_file_path, vhdl_lib in lib_files:
                fp.write("add_file -vhdl -lib " + vhdl_lib + " " + str(vhdl_lib_file_path) + "\n")
            fp.write("project -result_file " + str(edif_path) + "\n")

        # 	@echo "-top $(NAME)" >> $@
        # 	@echo "-output_edif ../../$(IC2_EDIF_FILE)" >> $@
        return project_file

    def check_opt_log(self, synth_log):
        """Check log for errors"""
        text = open(synth_log).read()

        if re.search("^Timeout$", text, re.M):
            return Status(OptStatus.TIMEOUT)

        match = re.search(
            r'Job: "compiler" terminated with error status: \d+\nSee log file: "(.*?)"', text, re.M
        )
        if match:
            text = open(match.group(1)).read()
            match = re.search(r"^@E:\s*(.*?)$", text, re.M)
            if match:
                return Status(OptStatus.COMPILE_ERROR, match.group(1))
            return Status(OptStatus.COMPILE_ERROR)

        match = re.search(
            r'Job: "fpga_mapper" terminated with error status: \d+\nSee log file: "(.*?)"',
            text,
            re.M,
        )
        if match:
            text = open(match.group(1)).read()
            match = re.search(r"^@E:\s*(.*?)$", text, re.M)
            if match:
                return Status(OptStatus.MAPPER_ERROR, match.group(1))
            return Status(OptStatus.MAPPER_ERROR)

        return Status(OptStatus.SUCCESS)

    # def write_result_file(self, design):
    #     if design.results_summary_path is None:
    #         print("No results path set!")
    #         return
    #     with open(design.results_summary_path, "a") as res_f:
    #         res_f.write("Synplify results summary:\n")
    #         with open(design.netlist_path, "r") as net_f:
    #             netlist = net_f.read()
    #             num_luts = netlist.count("cellRef SB_LUT4")
    #             num_carrys = netlist.count("cellRef SB_CARRY")
    #             num_flops = netlist.count("cellRef SB_DFF")
    #             num_rams = netlist.count("cellRef SB_RAM")
    #             # num_roms ?
    #             num_ios = netlist.count("cellRef SB_IO")
    #             num_gb_ios = netlist.count("cellRef SB_GB_IO")
    #             res_f.write("  # LUTs: " + str(num_luts) + "\n")
    #             res_f.write("  # carrys: " + str(num_carrys) + "\n")
    #             res_f.write("  # DFFs: " + str(num_flops) + "\n")
    #             res_f.write("  # RAMs: " + str(num_rams) + "\n")
    #             res_f.write("  # IOs: " + str(num_ios) + "\n")
    #             res_f.write("  # GB IOs: " + str(num_gb_ios) + "\n")
    #             res_f.write("\n")
