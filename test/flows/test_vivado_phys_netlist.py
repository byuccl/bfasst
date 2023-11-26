"""Unit tests for the VivadoPhysNetlist class."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)


class TestVivadoPhysNetlist(unittest.TestCase):
    """Unit test for the VivadoPhysNetlist class."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoPhysNetlist(DESIGNS_PATH / "byu/alu")
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, ioparse, phys_netlist

        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule phys_netlist", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 8 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 8)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja file"""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)

        expected = [
            "foo",
            "bar",
        ]
        VivadoSynth(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoImpl(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        PhysNetlist(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        expected.append(NINJA_FLOWS_PATH / "vivado_phys_netlist.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), NINJA_FLOWS_PATH / "vivado_phys_netlist.py"
        )


if __name__ == "__main__":
    unittest.main()
