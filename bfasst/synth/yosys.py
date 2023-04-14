"""
Code to run Yosys synthesis on a design
"""

import os
import subprocess
import time

import bfasst
from bfasst import paths
from bfasst.vendor import Vendor
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus

YOSYS_SCRIPT_TEMPLATE = "ex_yos_tech.yos"
YOSYS_XILINX_SYNTH_SCRIPT_TEMPLATE = "ex_yos_tech_xilinx.yos"
YOSYS_LATTICE_SYNTH_SCRIPT_TEMPLATE = "yos_synth_tech_lattice.yos"
YOSYS_SCRIPT_FILE = "script.yos"
YOSYS_LOG_FILE = "yosys.log"


class YosysTechSynthTool(SynthesisTool):
    """Yosys synthesis tool"""

    TOOL_WORK_DIR = "yosys_synth"

    def __init__(self, cwd, vendor):
        super().__init__(cwd)

        assert isinstance(vendor) is Vendor
        self.vendor = vendor

    def create_netlist(self, design):
        temp_gold_files = design.get_golden_files()
        for files in temp_gold_files:
            if files.suffix in ".vhd" or files.suffix in ".vhdl":
                return Status(SynthStatus.VHDL)

        # Target netlist output
        design.netlist_path = self.cwd / (design.top + "_yosys_tech.v")

        log_path = self.work_dir / YOSYS_LOG_FILE

        # TODO: Add "need to run" checks

        # Create the yosys script that generates the netlist
        self.create_yosys_script(design, design.netlist_path)
        design.yosys_netlist_path = design.netlist_path

        # Run Yosys on the design
        # This assumes that the VHDL module *is* installed!
        # yosys_path = "/home/jthompson3198/bfasst/third_party/yosys"
        yosys_path = paths.ROOT_PATH / "third_party" / "yosys"
        cmd = [
            os.path.join(paths.YOSYS_INSTALL_DIR, "yosys"),
            "-m",
            "vhdl",
            "-s",
            YOSYS_SCRIPT_FILE,
            "-l",
            YOSYS_LOG_FILE,
        ]

        try:
            proc = self.exec_and_log(cmd, timeout=bfasst.config.YOSYS_TIMEOUT)
        except subprocess.TimeoutExpired:
            # TODO: Write to logs here
            return Status(SynthStatus.TIMEOUT)
        if proc.returncode != 0:
            return Status(SynthStatus.ERROR)

        self.write_to_results_file(design, log_path)
        return Status(SynthStatus.SUCCESS)

    def create_yosys_script(self, design, netlist_path):
        """Create the yosys script that generates the netlist"""
        path_to_script_builder = paths.SCRIPTS_PATH / "yosys" / "createYosScript.py"
        if self.vendor == Vendor.XILINX:
            script_template_file = paths.YOSYS_RESOURCES / YOSYS_XILINX_SYNTH_SCRIPT_TEMPLATE
        elif self.vendor == Vendor.LATTICE:
            script_template_file = paths.YOSYS_RESOURCES / YOSYS_LATTICE_SYNTH_SCRIPT_TEMPLATE
        else:
            script_template_file = paths.YOSYS_RESOURCES / YOSYS_SCRIPT_TEMPLATE
        yosys_script_file = self.work_dir / YOSYS_SCRIPT_FILE

        # TODO: Figure out how to add VHDL library files to the yosys vhdl flow
        # file_paths = str(design.full_path / design.top_file)
        # for design_file in design.verilog_files:
        #     file_paths += " " + str(design.full_path / design_file)
        # for design_file in design.vhdl_files:
        #     file_paths += " " + str(design.full_path / design_file)
        file_paths = str(design.rel_path / design.top_file_path)
        for design_file in design.verilog_file_paths:
            file_paths += " " + str(design.rel_path / design_file)
        for design_file in design.vhdl_file_paths:
            file_paths += " " + str(design.rel_path / design_file)
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
        except subprocess.TimeoutExpired:
            return Status(SynthStatus.TIMEOUT)
        if proc.returncode != 0:
            return Status(SynthStatus.ERROR)

        return Status(SynthStatus.SUCCESS)

    def write_to_results_file(self, design, log_path):
        """Write the results of the run to the log"""
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
