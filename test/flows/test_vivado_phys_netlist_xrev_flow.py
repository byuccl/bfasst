"""Unit tests for the VivadoPhysNetlistXrev class."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_phys_netlist_xrev import VivadoPhysNetlistXrev
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)


class TestVivadoPhysNetlistXrev(unittest.TestCase):
    """Unit tests for the VivadoPhysNetlistXrev class."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoPhysNetlistXrev(DESIGNS_PATH / "byu/alu")
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
        expected.append(NINJA_FLOWS_PATH / "vivado_phys_netlist_xrev.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), NINJA_FLOWS_PATH / "vivado_phys_netlist_xrev.py"
        )


if __name__ == "__main__":
    unittest.main()
