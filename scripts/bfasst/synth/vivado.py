import shutil
import subprocess
import re
import os

import bfasst
from bfasst.synth.base import SynthesisTool
from bfasst.status import Status, SynthStatus
from bfasst.config import VIVADO_BIN_PATH


class Vivado_SynthesisTool(SynthesisTool):
    TOOL_WORK_DIR = "vivado_synth"

    PART = "xc7a200tfbg676-2"

    def create_netlist(self, design):
        # Save edif netlist path to design object
        design.netlist_path = self.cwd / (design.top + ".edf")

        tcl_path = self.work_dir / ("synth.tcl")

        with open(tcl_path, "w") as fp:
            if design.top_is_verilog:
                fp.write("set_part " + self.PART + "\n")
                fp.write("read_verilog " + str(design.top_path()) + "\n")

                # for vf in design.verilog_files:
                #     fp.write("read_verilog " + str(design.))

                fp.write("synth_design -top " + design.top + "\n")
                fp.write("write_edif -force {" + str(design.netlist_path) + "}\n")
                fp.write("exit\n")

        cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
        subprocess.run(cmd, cwd=self.work_dir)

        return Status(SynthStatus.SUCCESS)
