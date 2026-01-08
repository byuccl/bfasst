"""
Code to run Yosys synthesis on a design
"""

import os
import subprocess
import time

import bfasst
from bfasst import paths
from bfasst.tools_legacy.synth.base import SynthesisException, SynthesisTool

YOSYS_SCRIPT_TEMPLATE = "ex_yos_tech.yos"
YOSYS_SCRIPT_FILE = "script.yos"
YOSYS_LOG_FILE = "yosys.log"


class YosysTechSynthTool(SynthesisTool):
    """Yosys synthesis tool"""

    TOOL_WORK_DIR = "yosys_synth"

    def create_netlist(self):
        """Create netlist"""
        self.launch()
        # Target netlist output
        self.design.netlist_path = self.cwd / (self.design.top + "_yosys_tech.v")

        log_path = self.work_dir / YOSYS_LOG_FILE

        # TODO: Add "need to run" checks

        # Create the yosys script that generates the netlist
        self.create_yosys_script(self.design.netlist_path)
        self.design.yosys_netlist_path = self.design.netlist_path

        # Run Yosys on the design
        # This assumes that the VHDL module *is* installed!
        cmd = [
            os.path.join(paths.YOSYS_PATH, "yosys"),
            "-m",
            "vhdl",
            "-s",
            YOSYS_SCRIPT_FILE,
            "-l",
            YOSYS_LOG_FILE,
        ]

        try:
            proc = self.exec_and_log(cmd, timeout=bfasst.config.YOSYS_TIMEOUT)
        except subprocess.TimeoutExpired as e:
            # TODO: Write to logs here
            raise SynthesisException("Yosys synthesis timed out") from e
        if proc.returncode != 0:
            raise SynthesisException(f"Yosys synthesis failed with return code {proc.returncode}")

        self.write_to_results_file(log_path)
        self.cleanup()

    def create_yosys_script(self, netlist_path):
        """Create the yosys script that generates the netlist"""
        path_to_script_builder = paths.BFASST_SCRIPTS / "yosys" / "createYosScript.py"
        script_template_file = paths.YOSYS_RESOURCES / YOSYS_SCRIPT_TEMPLATE
        yosys_script_file = self.work_dir / YOSYS_SCRIPT_FILE

        # TODO: Figure out how to add VHDL library files to the yosys vhdl flow
        file_paths = str(self.design.rel_path / self.design.top_file_path)
        for design_file in self.design.verilog_file_paths:
            file_paths += " " + str(self.design.rel_path / design_file)
        for design_file in self.design.vhdl_file_paths:
            file_paths += " " + str(self.design.rel_path / design_file)
        # TODO: Add the same error handling as in other synth flows
        try:
            cmd = [
                "python3",
                str(path_to_script_builder),
                "-s " + str(file_paths),
                "-i" + str(script_template_file),
                "-o" + str(yosys_script_file),
                "-v" + str(netlist_path),
            ]
            proc = self.exec_and_log(cmd, timeout=bfasst.config.I2C_LSE_TIMEOUT)
        except subprocess.TimeoutExpired as e:
            raise SynthesisException("Yosys script generation timed out") from e
        if proc.returncode != 0:
            raise SynthesisException(
                f"Yosys script generation failed with return code {proc.returncode}"
            )

    def write_to_results_file(self, log_path):
        """Write the results of the run to the log"""
        with open(self.design.results_summary_path, "a") as res_f:
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
