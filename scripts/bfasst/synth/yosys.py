import os
import shutil
import subprocess
import time

import bfasst
from bfasst import paths
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus

YOSYS_SCRIPT_TEMPLATE = "ex_yos_tech.yos"
YOSYS_SCRIPT_FILE = "script.yos"
YOSYS_LOG_FILE = "yosys.log"


class Yosys_Tech_SynthTool(SynthesisTool):
    TOOL_WORK_DIR = "yosys_synth"

    def create_netlist(self, design):
        # Target netlist output
        design.netlist_path = self.cwd / (design.top + "_yosys_tech.v")

        log_path = self.work_dir / YOSYS_LOG_FILE

        # TODO: Add "need to run" checks

        # Create the yosys script that generates the netlist
        self.create_yosys_script(design, design.netlist_path)
        design.yosys_netlist_path = design.netlist_path

        # Run Yosys on the design
        # This assumes that the VHDL module *is* installed!
        cmd = [
            os.path.join(bfasst.config.YOSYS_INSTALL_DIR, "yosys"),     #  pylint: disable=E1101
            "-m",
            "vhdl",
            "-s",
            YOSYS_SCRIPT_FILE,
            "-l",
            YOSYS_LOG_FILE,
        ]
        try:
            p = subprocess.run(
                cmd,
                cwd=self.work_dir,
                stdout=subprocess.DEVNULL,
                timeout=bfasst.config.YOSYS_TIMEOUT,
            )
        except subprocess.TimeoutExpired:
            # TODO: Write to logs here
            return Status(SynthStatus.TIMEOUT)
        else:
            if p.returncode != 0:
                return Status(SynthStatus.ERROR)

        if p.returncode != 0:
            return Status(SynthStatus.ERROR)
        else:
            self.write_to_results_file(design, log_path)
            return Status(SynthStatus.SUCCESS)

    def create_yosys_script(self, design, netlist_path):
        # It's a little messy, but I want to just call my existing script that
        #   does this
        path_to_script_builder = paths.SCRIPTS_PATH / "yosys" / "createYosScript.py"
        script_template_file = paths.YOSYS_RESOURCES / YOSYS_SCRIPT_TEMPLATE
        yosys_script_file = self.work_dir / YOSYS_SCRIPT_FILE

        # TODO: Figure out how to add VHDL library files to the yosys vhdl flow
        file_paths = str(design.full_path / design.top_file)
        for design_file in design.verilog_files:
            file_paths += " " + str(design.full_path / design_file)
        for design_file in design.vhdl_files:
            file_paths += " " + str(design.full_path / design_file)
        # TODO: Add the same error handling as in other synth flows
        try:
            p = subprocess.run(
                [
                    "python3",
                    str(path_to_script_builder),
                    "-s " + str(file_paths),
                    "-i" + str(script_template_file),
                    "-o" + str(yosys_script_file),
                    "-v" + str(netlist_path),
                ],
                cwd=self.work_dir,
                timeout=bfasst.config.I2C_LSE_TIMEOUT,
            )
        except subprocess.TimeoutExpired:
            return Status(SynthStatus.TIMEOUT)
        else:
            if p.returncode != 0:
                return Status(SynthStatus.ERROR)

        return Status(SynthStatus.SUCCESS)

    def write_to_results_file(self, design, log_path):
        with open(design.results_summary_path, "a") as res_f:
            time_modified = time.ctime(os.path.getmtime(log_path))
            res_f.write("Results Summary (Yosys) (" + time_modified + ")\n")
            with open(log_path, "r") as log_f:
                for line in log_f:
                    if line.strip()[:16] == "Number of wires:":
                        res_f.write(line)
                        res_line = next(log_f)
                        while res_line.strip() != "":
                            res_f.write(res_line)
                            res_line = next(log_f)
            res_f.write("\n")
