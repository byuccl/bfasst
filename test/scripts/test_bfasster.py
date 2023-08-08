"""Unit tests for the bfasster ApplicationRunner class."""

from argparse import Namespace
from pathlib import PosixPath
import subprocess
import unittest
import io
from contextlib import redirect_stdout
from bfasst.paths import ROOT_PATH

from scripts.bfasster import check_args


class TestBfassterApplicationRunner(unittest.TestCase):
    """Unit tests for the bfasster ApplicationRunner class."""

    def __run_flow(self, flow):
        # run the bfasster script with the given flow
        cmd = ["python", "scripts/bfasster.py", "--design", "byu/alu", "--flow", flow]

        # capture the output of the runner with subprocess.PIPE so it doesn't print to the console.
        # the first time bfasster runs, ninja will get everything up to date.
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        proc.communicate()

        status = proc.wait()
        self.assertEqual(status, 0)

        # the second time bfasster runs, ninja will have nothing to do.
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        (output, _) = proc.communicate()
        status = proc.wait()
        self.assertEqual(status, 0)
        self.assertIn("ninja: no work to do.", str(output))

    def test_run_vivado_flow(self):
        """Test that the runner runs the vivado flow without errors"""
        self.__run_flow("vivado")

    def test_run_vivado_ooc_flow(self):
        """Test that the runner runs the vivado_ooc flow without errors"""
        self.__run_flow("vivado_ooc")

    def test_run_vivado_and_reversed_flow(self):
        """Test that the runner runs the vivado and reversed flow without errors"""
        self.__run_flow("vivado_and_reversed")

    def __try_check_args_for_success(self, args):
        try:
            check_args(args)
        except SystemExit:
            self.fail("check_args raised SystemExit unexpectedly!")

    def test_check_args_succeeds_on_yaml_only(self):
        """Test that the check_args function accepts only a yaml or a design/flow"""
        args = Namespace(yaml=PosixPath("experiments/tests/test.yaml"), design=None, flow=None)
        self.__try_check_args_for_success(args)

    def test_check_args_succeeds_on_design_and_flow_only(self):
        args = Namespace(yaml=None, design="byu/alu", flow="vivado")
        self.__try_check_args_for_success(args)

    def __produce_check_args_failure(self, args):
        """Capture the output of utils.py error function so that it doesn't print to the console"""
        with self.assertRaises(SystemExit):
            buf = io.StringIO()
            with redirect_stdout(buf):
                check_args(args)

    def test_check_args_fails_on_yaml_and_design_and_flow(self):
        args = Namespace(
            yaml=PosixPath("experiments/tests/test.yaml"), design="byu/alu", flow="vivado"
        )
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_no_args(self):
        args = Namespace(yaml=None, design=None, flow=None)
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_yaml_and_design(self):
        args = Namespace(yaml=PosixPath("experiments/tests/test.yaml"), design="byu/alu", flow=None)
        self.__produce_check_args_failure(args)

    def test_check_args_fails_on_yaml_and_flow(self):
        args = Namespace(yaml=PosixPath("experiments/tests/test.yaml"), design=None, flow="vivado")
        self.__produce_check_args_failure(args)
