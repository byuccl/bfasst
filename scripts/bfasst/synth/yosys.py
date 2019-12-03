import os
import shutil
import subprocess

import bfasst
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus

YOSYS_SCRIPT_TEMPLATE = "ex_yos_tech.yos"
YOSYS_SCRIPT_FILE = "script.yos"
YOSYS_LOG_FILE = "yosys.log"

class Yosys_Tech_SynthTool(SynthesisTool):
    TOOL_WORK_DIR = "yosys_synth"

    def create_netlist(self, design):
        # Target netlist output
        design.netlist_path = os.path.join(self.cwd, design.top + "_yosys_tech.v")

        # Create the yosys script that generates the netlist
        self.create_yosys_script(design, design.netlist_path)

        # Run Yosys on the design
        # This assumes that the VHDL module *is* installed!
        cmd = [os.path.join(bfasst.config.YOSYS_INSTALL_DIR, "yosys"), "-m", "vhdl", "-s", YOSYS_SCRIPT_FILE, "-l", YOSYS_LOG_FILE]
        p = subprocess.run(cmd, cwd = self.work_dir, stdout = subprocess.DEVNULL)

        if p.returncode != 0:
            return Status(SynthStatus.ERROR)
        else:
            return Status(SynthStatus.SUCCESS)

    def create_yosys_script(self, design, netlist_path):
        # It's a little messy, but I want to just call my existing script that
        #   does this
        path_to_script_builder = os.path.join(bfasst.SCRIPTS_PATH, "yosys", "createYosScript.py")
        script_template_file = os.path.join(bfasst.YOSYS_RESOURCES, YOSYS_SCRIPT_TEMPLATE)
        yosys_script_file = os.path.join(self.work_dir, YOSYS_SCRIPT_FILE)
        
        # TODO: Change this so we can have multiple file projects
        #       (currently only runs on top file)
        file_paths = os.path.join(design.full_dir, design.top_file)
        subprocess.run(["python3", path_to_script_builder,"-s " + file_paths,"-i" + script_template_file,"-o" + yosys_script_file, "-v" + netlist_path])
        
