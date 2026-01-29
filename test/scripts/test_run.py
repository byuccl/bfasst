"""
Unit tests for the run.py ApplicationRunner class.

Actual flows are tested using github actions running the test yamls in tests/ci and tests/weekly.
"""

import io
import unittest
from contextlib import redirect_stderr

from bfasst.paths import BFASST_TESTS
from scripts.run import parse_args


class TestApplicationRunner(unittest.TestCase):
    """Unit tests for the run.py ApplicationRunner class."""

    def __try_check_args_for_success(self, args):
        try:
            parse_args((str(arg) for arg in args))
        except SystemExit:
            self.fail("check_args raised SystemExit unexpectedly!")

    def test_check_args_succeeds_on_yaml(self):
        """Test that the check_args function accepts only a yaml or a design/flow"""
        args = [BFASST_TESTS / "ci/vivado_bit_analysis.yaml"]
        self.__try_check_args_for_success(args)

    def test_check_args_succeeds_on_flow_and_design(self):
        args = ["Vivado", "byu/alu"]
        self.__try_check_args_for_success(args)

    def test_check_args_succeeds_on_flow_and_designs(self):
        args = ["Vivado", "byu/alu", "byu/tx"]
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
