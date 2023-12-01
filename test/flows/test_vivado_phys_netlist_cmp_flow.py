"""Unit tests for VivadoPhysNetlistCmp class."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado_phys_netlist_cmp import VivadoPhysNetlistCmp
from bfasst.tools.compare.structural.structural import Structural
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.transform.netlist_cleanup import NetlistCleanupTool
from bfasst.tools.transform.phys_netlist import PhysNetlist
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    FLOWS_PATH,
)


class TestVivadoPhysNetlistCmp(unittest.TestCase):
    """Unit tests for VivadoPhysNetlistCmp class."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoPhysNetlistCmp(DESIGNS_PATH / "byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        """Test that there is a rule for vivado, ioparse, phys_netlist
        bit_to_fasm, fasm_to_netlist, and compare"""
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule phys_netlist", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)
        self.assertIn("rule compare", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 11 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 12)

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
        Xray(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        NetlistCleanupTool(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        Structural(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        expected.append(FLOWS_PATH / "vivado_phys_netlist_cmp.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), f"{FLOWS_PATH}/vivado_phys_netlist_cmp.py"
        )


if __name__ == "__main__":
    unittest.main()
