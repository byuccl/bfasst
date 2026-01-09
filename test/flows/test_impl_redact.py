"""Unit tests for ImplRedact flow."""
# pylint: disable=duplicate-code

import unittest
import os

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.impl_redact import ImplRedact
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH, FLOWS_PATH


class TestImplRedact(unittest.TestCase):
    """Unit tests for the ImplRedact flow."""

    @classmethod
    def setUpClass(cls):
        create_build_file()

        cls.flow = ImplRedact(DESIGNS_PATH / "byu/alu")
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()


    def test_rule_snippets_exist(self):
        """Check that core Vivado / transform / compare rules are in build.ninja."""
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja = f.read()
        self.assertIn("rule vivado", ninja)
        self.assertIn("rule netlist_redact", ninja)
        self.assertIn("rule netlist_unredact", ninja)
        self.assertIn("rule physcmp", ninja)


    def test_build_targets_exist(self):
        """Verify that each stage (synth, impl, reimpl, transform, physcmp) appears."""
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja = f.read()
        self.assertIn("vivado_synth", ninja)
        self.assertIn("vivado_impl", ninja)
        self.assertIn("vivado_reimpl", ninja)
        self.assertIn("netlist_redact.log", ninja)
        self.assertIn("netlist_unredact.log", ninja)
        self.assertIn("full_timing_summary.txt", ninja)
        self.assertIn("physcmp.log", ninja)


    def test_get_top_level_flow_path(self):
        """Ensure get_top_level_flow_path points at the correct file."""
        expected = f"{FLOWS_PATH}/impl_redact.py"
        self.assertEqual(str(self.flow.get_top_level_flow_path()), expected)


if __name__ == "__main__":
    unittest.main()
