"""Unit tests for the VivadoYosysImpl flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado_yosys_cmp import VivadoYosysCmp
from bfasst.tools.compare.yosys.yosys import Yosys
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
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

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # there should be 9 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 9)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja build file
        for reconfiguration"""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)
        expected = ["foo", "bar"]
        design_path = DESIGNS_PATH / "byu/alu"
        Xray(None, design_path).add_ninja_deps(expected)
        VivadoSynth(None, design_path).add_ninja_deps(expected)
        VivadoImpl(None, design_path).add_ninja_deps(expected)
        Yosys(None, design_path).add_ninja_deps(expected)
        expected.append(self.flow.get_top_level_flow_path())

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertListEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), FLOWS_PATH / "vivado_yosys_cmp.py")


if __name__ == "__main__":
    unittest.main()
