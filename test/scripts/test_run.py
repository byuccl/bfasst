"""Unit tests for the run.py ApplicationRunner class."""

import subprocess
import unittest
import io
from contextlib import redirect_stderr
from bfasst.paths import EXPERIMENTS_PATH, ROOT_PATH

from scripts.run import parse_args


class TestApplicationRunner(unittest.TestCase):
    """Unit tests for the run.py ApplicationRunner class."""

    def __run_flow(self, flow):
        # run the run.py script with the given flow
        cmd = ["python", "scripts/run.py", flow, "byu/alu"]

        # capture the output of the runner with subprocess.PIPE so it doesn't print to the console.
        # the first time run.py runs, ninja will get everything up to date.
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        proc.communicate()

        status = proc.wait()
        self.assertEqual(
            status, 0, msg=f"run.py failed with return code {status}, command: {' '.join(cmd)}"
        )

        # the second time run.py runs, ninja will have nothing to do.
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        (output, _) = proc.communicate()
        status = proc.wait()
        self.assertEqual(
            status, 0, msg=f"run.py failed with return code {status}, command: {' '.join(cmd)}"
        )
        self.assertIn("ninja: no work to do.", str(output))

    def test_run_vivado_flow(self):
        """Test that the runner runs the vivado flow without errors"""
        self.__run_flow("vivado")

    def test_run_vivado_ooc_flow(self):
        """Test that the runner runs the vivado_ooc flow without errors"""
        self.__run_flow("vivado_ooc")

    def test_run_vivado_and_reversed_flow(self):
        """Test that the runner runs the vivado and reversed flow without errors"""
        self.__run_flow("vivado_bit_analysis")

    def test_run_vivado_phys_netlist_flow(self):
        """Test that the runner runs the vivado_phys_netlist flow without errors"""
        self.__run_flow("vivado_phys_netlist")

    def test_run_vivado_phys_netlist_xrev_flow(self):
        """Test that the runner runs the vivado_phys_netlist_xrev flow without errors"""
        self.__run_flow("vivado_phys_netlist_xrev")

    def test_run_vivado_phys_netlist_cmp_flow(self):
        """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
        self.__run_flow("vivado_phys_netlist_cmp")

    def __try_check_args_for_success(self, args):
        try:
            parse_args((str(arg) for arg in args))
        except SystemExit:
            self.fail("check_args raised SystemExit unexpectedly!")

    def test_check_args_succeeds_on_yaml(self):
        """Test that the check_args function accepts only a yaml or a design/flow"""
        args = [EXPERIMENTS_PATH / "tests/vivado_bit_analysis.yaml"]
        self.__try_check_args_for_success(args)

    def test_check_args_succeeds_on_flow_and_design(self):
        args = ["vivado", "byu/alu"]
        self.__try_check_args_for_success(args)

    def test_check_args_succeeds_on_flow_and_designs(self):
        args = ["vivado", "byu/alu", "byu/tx"]
        self.__try_check_args_for_success(args)

    def __produce_check_args_failure(self, args):
        """Capture the output of utils.py error function so that it doesn't print to the console"""
        with self.assertRaises(SystemExit):
            buf = io.StringIO()
            with redirect_stderr(buf):
                parse_args(args)

    def test_check_args_fails_on_yaml_and_design_and_flow(self):
        args = ["--yaml", "tests/ci/test.yaml", "--design", "byu/alu", "--flow", "vivado"]
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_no_args(self):
        args = []
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_yaml_and_design(self):
        args = ["--yaml", "tests/ci/test.yaml", "--design", "byu/alu"]
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_yaml_and_flow(self):
        args = ["--yaml", "tests/ci/test.yaml", "--flow", "vivado"]
        self.__produce_check_args_failure(args)
