"""Unit tests for the NinjaFlowManager class."""

# Disable this since we are testing a class
# pylint: disable=too-many-public-methods
# pylint: disable=duplicate-code

import subprocess
import time
import unittest
from bfasst.ninja_flows.flow_utils import get_flows
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    ROOT_PATH,
)
from bfasst.ninja_flows.vivado import Vivado
from bfasst.ninja_flows.vivado_bit_analysis import VivadoBitAnalysis
from bfasst.ninja_flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.ninja_flows.vivado_phys_netlist_xrev import VivadoPhysNetlistXrev
from bfasst.ninja_flows.vivado_phys_netlist_cmp import VivadoPhysNetlistCmp
from bfasst.ninja_flows.vivado_structural_error_injection import VivadoStructuralErrorInjection
from bfasst.ninja_flows.vivado_conformal import VivadoConformal
from bfasst.ninja_flows.vivado_yosys_impl import VivadoYosysImpl

from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager, get_design_basenames


class TestNinjaFlowManager(unittest.TestCase):
    """Unit tests for the NinjaFlowManager class."""

    @classmethod
    def setUpClass(cls):
        cls.flow_manager = NinjaFlowManager()

    def __check_flow_creation(self, flow_type, name):
        """Check that a given flow is correctly instantiated by the flow manager"""
        self.flow_manager.create_flows(name, ["byu/alu", "byu/counter"])
        self.assertIsInstance(self.flow_manager.flows[0], flow_type)
        self.assertIsInstance(self.flow_manager.flows[1], flow_type)
        self.assertEqual(
            self.flow_manager.designs, [DESIGNS_PATH / "byu/alu", DESIGNS_PATH / "byu/counter"]
        )
        self.assertEqual(self.flow_manager.flow_name, name)

    def test_create_vivado_flow(self):
        self.__check_flow_creation(Vivado, "vivado")

    def test_create_vivado_ooc_flow(self):
        self.__check_flow_creation(Vivado, "vivado_ooc")
        self.assertTrue(self.flow_manager.flows[0].ooc)

    def test_create_vivado_reversed_flow(self):
        self.__check_flow_creation(VivadoBitAnalysis, "vivado_bit_analysis")

    def test_create_vivado_phys_netlist_flow(self):
        self.__check_flow_creation(VivadoPhysNetlist, "vivado_phys_netlist")

    def test_create_phys_reversed_flow(self):
        self.__check_flow_creation(VivadoPhysNetlistXrev, "vivado_phys_netlist_xrev")

    def test_create_phys_compare_flow(self):
        self.__check_flow_creation(VivadoPhysNetlistCmp, "vivado_phys_netlist_cmp")

    def test_create_cmp_error_injection_flow(self):
        self.__check_flow_creation(
            VivadoStructuralErrorInjection, "vivado_structural_error_injection"
        )

    def test_create_vivado_conformal_flow(self):
        self.__check_flow_creation(VivadoConformal, "vivado_conformal")

    def test_create_vivado_yosys_impl_flow(self):
        self.__check_flow_creation(VivadoYosysImpl, "vivado_yosys_impl")

    def __check_flow_run(self, name, correct_num_build_statements):
        """Check that running flows correctly creates the build.ninja file"""
        # Only run with byu/alu. This design is supported by all flows.
        # Some designs are not successfully run by all flows, for various reasons
        # including comparison algorithm limitations and Vivado limitations.
        self.flow_manager.create_flows(name, ["byu/alu"])
        self.flow_manager.run_flows()

        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_build = f.read()

        self.assertIn(" configure\n", ninja_build)
        self.assertIn(f" configure {DESIGNS_PATH}/byu/alu ", ninja_build)

        build_statement_count = ninja_build.count("\nbuild ")
        self.assertEqual(build_statement_count, correct_num_build_statements)

    def test_run_vivado_flow(self):
        self.__check_flow_run("vivado", 6)

    def test_run_vivado_ooc_flow(self):
        self.__check_flow_run("vivado_ooc", 5)

    def test_run_vivado_reversed_flow(self):
        self.__check_flow_run("vivado_bit_analysis", 9)

    def test_run_vivado_phys_netlist_flow(self):
        self.__check_flow_run("vivado_phys_netlist", 9)

    def test_run_phys_reversed_flow(self):
        self.__check_flow_run("vivado_phys_netlist_xrev", 11)

    def test_run_phys_compare_flow(self):
        self.__check_flow_run("vivado_phys_netlist_cmp", 12)

    def test_run_cmp_error_injection_flow(self):
        # There should be 200 injections and 200 comparisons for two flows
        # plus all the build statements for the phys_reversed_flow
        # ((200 * 2) * 2) + 21 = 821 build statements
        self.__check_flow_run("vivado_structural_error_injection", 411)

    def test_run_vivado_conformal_flow(self):
        self.__check_flow_run("vivado_conformal", 9)

    def test_run_vivado_yosys_impl_flow(self):
        self.__check_flow_run("vivado_yosys_impl", 10)

    def test_ninja_rebuilds(self):
        """Test that the build.ninja file rebuilds itself if any flow or template changes."""
        flows = get_flows()
        for flow in flows:
            # TODO: Remove this clause when comparison errors are fixed
            # structural error injection currently failing on some injections
            if flow == "vivado_structural_error_injection":
                continue
            self.__check_all_rebuild_deps(flow)

    def __check_all_rebuild_deps(self, flow_name):
        """Check that modification of all flows and templates related to a given flow
        trigger a ninja rebuild"""
        self.flow_manager.create_flows(flow_name, ["byu/alu"])
        self.flow_manager.run_flows()

        deps = []
        self.flow_manager.flows[0].add_ninja_deps(deps)

        for dep in deps:
            self.__check_rebuild_dependency(dep, flow_name)

    def __check_rebuild_dependency(self, dependency_path, flow_name):
        """Run the build.ninja file and check that it rebuilds if the given dependency changes."""
        # get the mtime of the build.ninja file
        old_mtime = NINJA_BUILD_PATH.stat().st_mtime

        # update the dependency file's mtime
        dependency_path.touch()
        time.sleep(1)

        # running the build.ninja file should rebuild it
        self.__run_ninja()

        # For some reason you need to wait a bit after running ninja for the mtime to update
        time.sleep(1)

        new_mtime = NINJA_BUILD_PATH.stat().st_mtime

        self.assertGreater(
            new_mtime,
            old_mtime,
            msg=f"{dependency_path} did not trigger a rebuild for flow {flow_name}",
        )

    def __run_ninja(self):
        """Run the build.ninja file and ensure it completes successfully."""
        proc = subprocess.run("ninja", cwd=ROOT_PATH, stdout=subprocess.PIPE)
        self.assertEqual(proc.returncode, 0)

    def test_get_design_basenames(self):
        """Test that the design basenames are returned correctly."""
        designs = ["some/long/path/byu/alu", "another/path/byu/counter"]
        basenames = get_design_basenames(designs)
        self.assertEqual(basenames, ["byu/alu", "byu/counter"])


if __name__ == "__main__":
    unittest.main()
