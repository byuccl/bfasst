"""Unit tests for the RandSoc flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.tools.design_create.rand_soc import RandSoC
from bfasst.tools.synth.vivado_synth_tcl import VivadoSynthFromTcl
from bfasst.flows.rand_soc import RandSoc
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import (
    NINJA_BUILD_PATH,
    BUILD_PATH,
    FLOWS_PATH,
)


class TestRandSocFlow(unittest.TestCase):
    """Unit tests for the RandSoc flow."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()
        cls.flow = RandSoc()
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, template, ioparse,
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 5 build statements for a single design generated from this flow
        self.assertEqual(build_statement_count, 5)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja file."""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)

        expected = ["foo", "bar"]
        
        design_path = BUILD_PATH / "rand_soc" / "design_0"
        RandSoC(self.flow, num_designs=1).add_ninja_deps(expected)
        VivadoSynthFromTcl(None, design_path / "design.tcl").add_ninja_deps(expected)
        VivadoImpl(None, design_path).add_ninja_deps(expected)
        expected.append(FLOWS_PATH / "rand_soc.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), FLOWS_PATH / "rand_soc.py")


if __name__ == "__main__":
    unittest.main()
