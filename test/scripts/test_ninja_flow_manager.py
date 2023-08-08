"""Unit tests for the NinjaFlowManager class."""

import unittest
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH
from bfasst.ninja_flows.vivado import Vivado

from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager, get_design_basenames


class TestNinjaFlowManager(unittest.TestCase):
    """Unit tests for the NinjaFlowManager class."""

    @classmethod
    def setUpClass(cls):
        cls.flow_manager = NinjaFlowManager()

    def test_create_flows(self):
        """Test that the flow manager creates the correct flows."""
        self.flow_manager.create_flows("vivado", ["byu/alu", "byu/counter"])

        self.assertIsInstance(self.flow_manager.flows[0], Vivado)
        self.assertIsInstance(self.flow_manager.flows[1], Vivado)
        self.assertEqual(self.flow_manager.designs, ["byu/alu", "byu/counter"])
        self.assertEqual(self.flow_manager.flow_name, "vivado")

    def test_run_flows(self):
        """Test that the flow manager runs the flows correctly."""
        self.flow_manager.create_flows("vivado", ["byu/alu", "byu/counter"])
        self.flow_manager.run_flows()

        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_build = f.read()

        self.assertIn(" configure\n", ninja_build)
        self.assertIn(f" configure {DESIGNS_PATH}/byu/alu {DESIGNS_PATH}/byu/counter ", ninja_build)

        build_statement_count = ninja_build.count("\nbuild ")
        # should have 1 configure build statement, and 5 each for the 2 flows = 11 total
        self.assertEqual(build_statement_count, 11)

    def test_get_design_basenames(self):
        """Test that the design basenames are returned correctly."""
        designs = ["some/long/path/byu/alu", "another/path/byu/counter"]
        basenames = get_design_basenames(designs)
        self.assertEqual(basenames, ["byu/alu", "byu/counter"])
