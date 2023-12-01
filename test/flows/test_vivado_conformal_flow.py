"""Unit tests for the VivadoConformal flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado_conformal import VivadoConformal
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.compare.conformal.conformal import Conformal
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    FLOWS_PATH,
)


class TestVivadoConformalFlow(unittest.TestCase):
    """Unit tests for the VivadoConformal flow."""

    @classmethod
    def setUpClass(cls) -> None:
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoConformal(DESIGNS_PATH / "byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)
        self.assertIn("rule conformal", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 8 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 8)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja build file
        for reconfiguration"""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)
        expected = ["foo", "bar"]
        Xray(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoSynth(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoImpl(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        Conformal(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        expected.append(FLOWS_PATH / "vivado_conformal.py")
        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), FLOWS_PATH / "vivado_conformal.py"
        )


if __name__ == "__main__":
    unittest.main()
