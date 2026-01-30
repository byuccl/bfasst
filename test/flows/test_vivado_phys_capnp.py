"""Unit tests for the VivadoPhysCapnp class."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado_phys_capnp import VivadoPhysCapnp
from bfasst.paths import BFASST_DESIGNS, BFASST_FLOWS, NINJA_BUILD_PATH


class TestVivadoPhysCapnp(unittest.TestCase):
    """Unit test for the VivadoPhysCapnp class."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoPhysCapnp(BFASST_DESIGNS / "byu/alu")
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, ioparse, phys_netlist

        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)
        self.assertIn("rule phys_capnp_cmp", ninja_rules)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), f"{BFASST_FLOWS}/vivado_phys_capnp.py"
        )


if __name__ == "__main__":
    unittest.main()
