"""Unit tests for the VivadoYosysImpl flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_yosys_impl import VivadoYosysImpl
from bfasst.ninja_tools.compare.yosys.yosys import Yosys
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH, NINJA_FLOWS_PATH


class TestVivadoYosysImplFlow(unittest.TestCase):
    """Unit tests for the VivadoYosysImpl flow."""

    @classmethod
    def setUpClass(cls) -> None:
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.design_shortname = DESIGNS_PATH / "byu/alu"
        cls.flow = VivadoYosysImpl(cls.design_shortname)
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
        Xray(None, self.design_shortname).add_ninja_deps(expected)
        VivadoSynth(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoImpl(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        Yosys(None, self.design_shortname).add_ninja_deps(expected)
        expected.append(NINJA_FLOWS_PATH / "vivado_yosys_impl.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertListEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), NINJA_FLOWS_PATH / "vivado_yosys_impl.py"
        )


if __name__ == "__main__":
    unittest.main()
