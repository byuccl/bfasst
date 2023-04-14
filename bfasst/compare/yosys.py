import bfasst
import subprocess
import pathlib
import sys
import re
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct


class Yosys_CompareTool(CompareTool):
    TOOL_WORK_DIR = "yosys"
    LOG_FILE_NAME = "log.txt"
    SCRIPT_FILE_NAME = "compare.ys"
    def compare_netlists(self, design):
        log_path = self.work_dir / self.LOG_FILE_NAME

        generate_comparison = ToolProduct(None, log_path, self.check_compare_status)
        status = self.get_prev_run_status(
            tool_products=(generate_comparison,),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.reversed_netlist_path.stat().st_mtime
            ),
        )

        if status is not None:
            self.print_skipping_compare()
            return status


        self.print_running_compare()

        # Create Yosys script
        script_file_path = self.create_script_file(design)

        # Run Yosys
        with open(log_path, "w") as fp:
            cmd = ["./yosys", script_file_path]
            proc = subprocess.Popen(
                cmd,
                cwd=str(pathlib.Path.cwd()) + "/third_party/yosys",
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                universal_newlines=True,    
            )
            for line in proc.stdout:
                sys.stdout.write(line)
                fp.write(line)
                fp.flush()
            proc.communicate()
            if proc.returncode:
                return Status(CompareStatus.NOT_EQUIVALENT)
            
        return self.success_status
    
    def create_script_file(self, design):
        script_file_path = self.work_dir / self.SCRIPT_FILE_NAME

        with open(script_file_path, "w") as fp:
            ##fp.write("read_verilog " + str(design.impl_netlist_path) + "\n")
            ##fp.write("rename -top gold\n")
            ##fp.write("splitnets -ports;;\n")
            ##fp.write("design -stash gold\n")
            ##fp.write("read_verilog " + str(design.reversed_netlist_path) + "\n")
            ##fp.write("hierarchy -auto-top\n")
            ##fp.write("rename -top gate\n")
            ##fp.write("splitnets -ports;;\n")
            ##fp.write("design -stash gate\n")
            ##fp.write("read_verilog " + str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v" + "\n")
            ##fp.write("design -copy-from gold -as gold gold\n")
            ##fp.write("design -copy-from gate -as gate gate\n")
            ##fp.write("equiv_make gold gate equiv\n")
            ##fp.write("prep -flatten -top equiv\n")
            ##fp.write("equiv_induct\n")
            ##fp.write("equiv_status -assert\n")

            ##NEW VERSION?
            fp.write("read_verilog " + str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v" + "; ")
            fp.write("read_verilog " + str(design.impl_netlist_path) + "; ")
            fp.write("prep -flatten; ")
            fp.write("hierarchy -auto-top; ")
            fp.write("rename -top gold; ")
            fp.write("splitnets -ports;; ")
            fp.write("design -stash gold\n")
            fp.write("read_verilog " + str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v" + "; ")
            fp.write("read_verilog " + str(design.reversed_netlist_path) + "; ")
            fp.write("prep -flatten; ")
            fp.write("hierarchy -auto-top; ")
            fp.write("rename -top gate; ")
            fp.write("splitnets -ports;; ")
            fp.write("design -stash gate\n")
            fp.write("design -copy-from gold -as gold gold; ")
            fp.write("design -copy-from gate -as gate gate; ")
            fp.write("equiv_make gold gate equiv; ")
            fp.write("hierarchy -top equiv;; ")
            fp.write("equiv_simple\n")
            # fp.write("equiv_struct;;\n")
            fp.write("equiv_induct\n")
            fp.write("equiv_status -assert\n")

        return script_file_path

    def check_compare_status(self, log_path):
        log_text = open(log_path).read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        m = re.search(r"Equivalence successfully proven!", log_text, re.M)
        if m:
            return Status(CompareStatus.SUCCESS)

        m = re.search(r"ERROR", log_text, re.M)
        if m:
            return Status(CompareStatus.NOT_EQUIVALENT)
