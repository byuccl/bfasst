"""Unit tests for the VivadoAndReversed flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_bit_analysis import VivadoBitAnalysis
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.netlist_cleanup import NetlistCleanupTool
from bfasst.ninja_tools.transform.netlist_phys_to_logical import NetlistPhysToLogicalTool
from bfasst.ninja_tools.vivado.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.vivado.vivado import Vivado
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)


class TestVivadoAndReversedFlow(unittest.TestCase):
    """Unit tests for the VivadoAndReversed flow."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        # before all vivado based flows, make sure the Vivado parent class is
        # allowed to create its rule snippets
        Vivado.rules_appended_to_build = False

        cls.flow = VivadoBitAnalysis(DESIGNS_PATH / "byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, template, ioparse,
        # bit_to_fasm and fasm_to_netlist
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 8 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 9)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja file."""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)

        expected = ["foo", "bar"]
        Xray(DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoSynth(DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoImpl(DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        NetlistCleanupTool(DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        NetlistPhysToLogicalTool(DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)

        expected.append(NINJA_FLOWS_PATH / "vivado_bit_analysis.py")
        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), NINJA_FLOWS_PATH / "vivado_bit_analysis.py"
        )


if __name__ == "__main__":
    unittest.main()