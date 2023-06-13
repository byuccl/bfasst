"""Yosys equivalence checker"""
import pathlib
import re
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct


class YosysCompareTool(CompareTool):
    """Yosys equivalence checker"""

    TOOL_WORK_DIR = "yosys"
    LOG_FILE_NAME = "log.txt"
    SCRIPT_FILE_NAME = "compare.ys"

    def compare_netlists(self):
        log_path = self.work_dir / self.LOG_FILE_NAME

        generate_comparison = ToolProduct(None, log_path, self.check_compare_status)

        status = self.up_to_date(generate_comparison)
        if status is not None:
            return status

        # Run Yosys
        cmd = ["./yosys", self.create_script_file()]
        cwd = str(pathlib.Path.cwd()) + "/third_party/yosys"
        with open(log_path, "w") as fp:
            if self.exec_and_log(cmd, cwd, fp).returncode:
                return Status(CompareStatus.NOT_EQUIVALENT)
        return Status(CompareStatus.SUCCESS)

    def create_script_file(self):
        """Creates a Tcl script that asserts equivalence between the two designs"""
        script_file_path = self.work_dir / self.SCRIPT_FILE_NAME

        with open(script_file_path, "w") as fp:
            ##fp.write("read_verilog " + str(design.flow_paths["impl_netlist_path"]) + "\n")
            ##fp.write("rename -top gold\n")
            ##fp.write("splitnets -ports;;\n")
            ##fp.write("design -stash gold\n")
            ##fp.write("read_verilog " + str(design.reversed_netlist_path) + "\n")
            ##fp.write("hierarchy -auto-top\n")
            ##fp.write("rename -top gate\n")
            ##fp.write("splitnets -ports;;\n")
            ##fp.write("design -stash gate\n")
            ##fp.write("read_verilog " + str(pathlib.Path.cwd())
            ## + "/third_party/yosys/techlibs/xilinx/cells_sim.v" + "\n")
            ##fp.write("design -copy-from gold -as gold gold\n")
            ##fp.write("design -copy-from gate -as gate gate\n")
            ##fp.write("equiv_make gold gate equiv\n")
            ##fp.write("prep -flatten -top equiv\n")
            ##fp.write("equiv_induct\n")
            ##fp.write("equiv_status -assert\n")

            ##NEW VERSION?
            fp.write(
                "read_verilog "
                + str(pathlib.Path.cwd())
                + "/third_party/yosys/techlibs/xilinx/cells_sim.v"
                + "; "
            )
            fp.write("read_verilog " + self.gold_netlist + "; ")
            fp.write("prep -flatten; ")
            fp.write("hierarchy -auto-top; ")
            fp.write("rename -top gold; ")
            fp.write("splitnets -ports;; ")
            fp.write("design -stash gold\n")
            fp.write(
                "read_verilog "
                + str(pathlib.Path.cwd())
                + "/third_party/yosys/techlibs/xilinx/cells_sim.v"
                + "; "
            )
            fp.write("read_verilog " + self.rev_netlist + "; ")
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
        """Checks the log file for the result of the equivalence check"""
        log_text = open(log_path).read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        match = re.search(r"Equivalence successfully proven!", log_text, re.M)
        if match:
            return Status(CompareStatus.SUCCESS)

        match = re.search(r"ERROR", log_text, re.M)
        if match:
            return Status(CompareStatus.NOT_EQUIVALENT)

        return Status(CompareStatus.PARSE_PROBLEM)
