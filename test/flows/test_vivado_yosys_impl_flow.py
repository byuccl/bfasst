"""Unit tests for the VivadoYosysImpl flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado_yosys_cmp import VivadoYosysCmp
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH, FLOWS_PATH


class TestVivadoYosysImplFlow(unittest.TestCase):
    """Unit tests for the VivadoYosysImpl flow."""

    @classmethod
    def setUpClass(cls) -> None:
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoYosysCmp(DESIGNS_PATH / "byu/alu")
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule yosys", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), FLOWS_PATH / "vivado_yosys_cmp.py")


if __name__ == "__main__":
    unittest.main()
