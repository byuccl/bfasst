"""Unit tests for the VivadoPhysNetlistXrev class."""
import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_phys_netlist_xrev import VivadoPhysNetlistXrev
from bfasst.paths import NINJA_BUILD_PATH, NINJA_FLOWS_PATH, NINJA_UTILS_PATH, REV_BIT_TOOLS_PATH


class TestVivadoPhysNetlistXrev(unittest.TestCase):
    """Unit tests for the VivadoPhysNetlistXrev class."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoPhysNetlistXrev("byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, ioparse,
        # phys_netlist, bit_to_fasm, and fasm_to_netlist
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule phys_netlist", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 10 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 10)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja file"""
        observed = self.flow.add_ninja_deps(["foo", "bar"])
        expected = [
            "foo",
            "bar",
            f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py ",
            f"{REV_BIT_TOOLS_PATH}/xray.ninja_rules ",
            f"{REV_BIT_TOOLS_PATH}/xray.ninja_build.mustache ",
        ]
        expected.extend(self.flow.phys_netlist_flow.add_ninja_deps())

        observed.sort()
        expected.sort()
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py"
        )


if __name__ == "__main__":
    unittest.main()
