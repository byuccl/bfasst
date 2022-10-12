'''Module wrapping around icecube2 lse optimization pass'''
import shutil
import subprocess
import re
import os
import os.path
import in_place

import bfasst
from bfasst import paths
from bfasst.opt.base import OptTool
from bfasst.status import BfasstException, Status, OptStatus
from bfasst.utils import error

PROJECT_TEMPLATE_FILE = "template_lse.prj"
IC2_LSE_PROJ_FILE = "lse_project.prj"


class Ic2LseOptTool(OptTool):
    '''wrapper class around icecube2 lse optimization step'''
    TOOL_WORK_DIR = "ic2_opt"

    def get_log_path(self):
        '''return logpath as configured in config.py'''
        return self.work_dir / bfasst.config.OPT_LOG_NAME

    def get_last_runtime(self):
        '''return last runtime'''
        log_path = self.get_log_path()
        if not log_path.is_file():
            return None
        return log_path.stat().st_mtime

    def create_netlist(self, design, in_files, lib_files, force_run=False):
        '''optimize netlist'''

        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        log_path = self.get_log_path()
        edif_path_temp = self.work_dir / (design.top + ".edf")

        # Check if synthesis needs to be run
        need_to_run = force_run

        # Run if there is no log file
        need_to_run |= not log_path.is_file()

        # Run if there is no netlist, and no error message in the log file
        need_to_run |= (not need_to_run) and (
            not design.netlist_path.is_file() and not self.check_opt_log(log_path).error
        )

        # Run if last run is out of date
        need_to_run |= (not need_to_run) and (
            design.last_modified_time() > log_path.stat().st_mtime
        )

        if need_to_run:
            # Create Icecube 2 LSE synthesis project file
            prj_path = self.create_ic2_lse_project_file(design, edif_path_temp, in_files, lib_files)

            # Run Icecube 2 LSE synthesis
            try:
                self.run_sythesis(prj_path, log_path)
            except BfasstException as e:
                # If generic error, see if log has something more specific
                if e.error == OptStatus.ERROR:
                    self.check_opt_log(log_path)
                raise e

        # Parse synthesis log for errors
        self.check_opt_log(log_path)

        if need_to_run:
            # Copy edif netlist out of project directory3
            if not edif_path_temp.is_file():
                return Status(OptStatus.ERROR)
            shutil.copyfile(edif_path_temp, design.netlist_path)

        self.write_result_file(design)
        return Status(OptStatus.SUCCESS)

    def run_sythesis(self, prj_path, log_path):
        '''run synthesis on netlist'''
        syth_bin_path = bfasst.config.IC2_INSTALL_DIR / "LSE" / "bin" / "lin64" / "synthesis"
        if not syth_bin_path.is_file():
            error(syth_bin_path, "does not exist")

        cmd = [syth_bin_path, "-f", prj_path]
        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = bfasst.config.IC2_INSTALL_DIR / "LSE" / "bin" / "lin64"
        env["FOUNDRY"] = bfasst.config.IC2_INSTALL_DIR / "LSE"
        env["SBT_DIR"] = bfasst.config.IC2_INSTALL_DIR / "sbt_backend"
        with open(log_path, "w") as fp:
            try:
                proc = subprocess.run(
                    cmd,
                    stdout=fp,
                    stderr=subprocess.STDOUT,
                    cwd=self.work_dir,
                    env=env,
                    timeout=bfasst.config.I2C_LSE_TIMEOUT,
                )
            except subprocess.TimeoutExpired:
                fp.write("\nTimeout\n")
                return Status(OptStatus.TIMEOUT)
            else:
                if proc.returncode != 0:
                    return Status(OptStatus.ERROR)

            return Status(OptStatus.SUCCESS)

    def create_ic2_lse_project_file(self, design, edif_path, in_files, lib_files):
        '''create project file for icecube2 lse'''
        assert isinstance(design, bfasst.design.Design)

        template_file = paths.I2C_RESOURCES / PROJECT_TEMPLATE_FILE
        project_file = self.work_dir / IC2_LSE_PROJ_FILE
        shutil.copyfile(template_file, project_file)

        with open(project_file, "a") as fp:
            fp.write("-p " + str(design.full_path) + "\n")

            for design_file in in_files:
                if os.path.splitext(design_file)[1].lower() == ".v":
                    fp.write("-lib work -ver " + design_file + "\n")
                elif os.path.splitext(design_file)[1].lower() == ".vhd":
                    fp.write("-lib work -vhd " + design_file + "\n")

            for (vhdl_lib_file_path, vhdl_lib) in lib_files or []:
                fp.write("-lib " + vhdl_lib + " -vhd " + str(vhdl_lib_file_path) + "\n")
            fp.write("-top " + design.top + "\n")
            fp.write("-output_edif " + str(edif_path) + "\n")

        #   @echo "-top $(NAME)" >> $@
        #   @echo "-output_edif ../../$(IC2_EDIF_FILE)" >> $@
        return project_file

    def check_opt_log(self, synth_log):
        '''check optimization log for errors'''
        text = open(synth_log).read()
        if re.search("^Timeout$", text, re.M):
            return Status(OptStatus.TIMEOUT)

        return Status(OptStatus.SUCCESS)

    def fix_lut_inits(self, design):
        '''This function goes through the generated netlist and
        changes binary LUT inits to hex. Apparently LSE generates
        binary LUT inits under some conditions, and the IC2 backend
        doesn't like that.'''

        with in_place.InPlace(design.netlist_path) as n_f:
            found_first_init = False
            for line in n_f:
                if line.strip().split()[0:2] == ["(property", "LUT_INIT"]:
                    # Skip the first LUT init (it's formatted correctly for
                    #    some reason)
                    if not found_first_init:
                        found_first_init = True
                        continue
                    # Try to grab the binary string
                    bin_string = line.strip().split()[3][1:-3]
                    # Convert the string to hex
                    # Use a try block so we only do this if the string is
                    #   actually binary
                    try:
                        hex_string = hex(int(bin_string, 2))[2:]
                        # Form a new line using the hex string
                        line_list = line.split()
                        line_list[3] = '"' + hex_string + '"))'
                        new_line = " ".join(line_list)
                        # Grab the indenting from the old line
                        indent = line.split("(")[0]
                        new_line = indent + new_line + "\n"
                        # Write the new line back into the file
                        n_f.write(new_line)
                    except ValueError:
                        n_f.write(line)
                else:
                    n_f.write(line)

    def write_result_file(self, design):
        '''write out results to file'''
        if design.results_summary_path is None:
            print("No results path set!")
            return
        with open(design.results_summary_path, "a") as res_f:
            res_f.write("LSE results summary:\n")
            with open(design.netlist_path, "r") as net_f:
                netlist = net_f.read()
                num_luts = netlist.count("cellRef SB_LUT4")
                num_carrys = netlist.count("cellRef SB_CARRY")
                num_flops = netlist.count("cellRef SB_DFF")
                num_rams = netlist.count("cellRef SB_RAM")
                # num_roms ?
                num_ios = netlist.count("cellRef SB_IO")
                num_gb_ios = netlist.count("cellRef SB_GB_IO")
                res_f.write("  # LUTs: " + str(num_luts) + "\n")
                res_f.write("  # carrys: " + str(num_carrys) + "\n")
                res_f.write("  # DFFs: " + str(num_flops) + "\n")
                res_f.write("  # RAMs: " + str(num_rams) + "\n")
                res_f.write("  # IOs: " + str(num_ios) + "\n")
                res_f.write("  # GB IOs: " + str(num_gb_ios) + "\n")
                res_f.write("\n")
