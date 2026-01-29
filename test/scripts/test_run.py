"""Unit tests for the run.py ApplicationRunner class."""

import io
import subprocess
import unittest
from contextlib import redirect_stderr

from bfasst.flows.flow import FlowNoDesign
from bfasst.paths import BFASST_ROOT, BFASST_TESTS
from bfasst.yaml_parser import FlowDescriptionParser
from scripts.run import parse_args


class TestApplicationRunner(unittest.TestCase):
    """Unit tests for the run.py ApplicationRunner class."""

    def __run_flow(self, flow, flow_args=None):  # pylint: disable=unused-private-member
        # run the run.py script with the given flow

        cmd = ["python", "scripts/run.py", flow]

        # some flows don't need a design to run, and will error if one is passed in
        flow_type = FlowDescriptionParser().get_flow_class(flow)
        if not issubclass(flow_type, FlowNoDesign):
            cmd.append("byu/alu")

        # we may want to use flow args to limit the number of runs of a repetitive flow
        if flow_args:
            cmd.append(flow_args)

        # capture the output of the runner with subprocess.PIPE so it doesn't print to the console.
        # the first time run.py runs, ninja will get everything up to date.
        proc = subprocess.Popen(
            cmd, cwd=BFASST_ROOT, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        proc.communicate()

        status = proc.wait()
        self.assertEqual(
            status, 0, msg=f"run.py failed with return code {status}, command: {' '.join(cmd)}"
        )

        # the second time run.py runs, ninja will have nothing to do.
        proc = subprocess.Popen(
            cmd, cwd=BFASST_ROOT, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        (output, _) = proc.communicate()
        status = proc.wait()
        self.assertEqual(
            status, 0, msg=f"run.py failed with return code {status}, command: {' '.join(cmd)}"
        )

        self.assertIn("ninja: no work to do.", str(output))

    # It would be nice to have the below tests added in,
    # but they have serious issues with runtime.

    # def test_run_vivado_ooc_flow(self):
    #     """Test that the runner runs the vivado_ooc flow without errors"""
    #     self.__run_flow("VivadoOoc")

    # def test_run_vivado_bit_analysis_flow(self):
    #     """Test that the runner runs the vivado_bit_analysis flow without errors"""
    #     self.__run_flow("VivadoBitAnalysis")

    # def test_run_vivado_bit_to_netlist(self):
    #     """Test that the runner runs the vivado_bit_to_netlist flow without errors"""
    #     self.__run_flow("VivadoBitToNetlist")

    # def test_run_vivado_phys_netlist_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist flow without errors"""
    #     self.__run_flow("VivadoPhysNetlist")

    # def test_run_vivado_phys_netlist_cmp_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
    #     self.__run_flow("VivadoPhysNetlistCmp")

    # def test_run_vivado_structural_error_injection_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
    #     self.__run_flow("VivadoStructuralErrorInjection", "{'num_runs': 3}")

    # def test_run_vivado_conformal_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
    #     self.__run_flow("VivadoConformal")

    # def test_run_vivado_yosys_impl_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
    #     self.__run_flow("VivadoYosysImpl")

    # def test_run_rand_soc_flow(self):
    #     """Test that the runner runs the vivado_phys_netlist_cmp flow without errors"""
    #     self.__run_flow("RandSoc")

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
