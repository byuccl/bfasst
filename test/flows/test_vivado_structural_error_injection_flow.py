"""Unit tests for VivadoStructuralErrorInjection class"""
import unittest

from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_structural_error_injection import VivadoStructuralErrorInjection
from bfasst.ninja_tools.compare.structural.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.error_injector import ErrorInjector
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.ninja_tools.vivado.vivado import Vivado
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)


class TestVivadoStructuralErrorInjection(unittest.TestCase):
    """Unit tests for VivadoStructuralErrorInjection class"""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoStructuralErrorInjection("byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_rule_snippets_exist(self):
        """Test that there is a rule for vivado, ioparse, phys_netlist,
        bit_to_fasm, fasm_to_netlist, compare, and inject"""
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()

        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)
        self.assertIn("rule phys_netlist", ninja_rules)
        self.assertIn("rule bit_to_fasm", ninja_rules)
        self.assertIn("rule fasm_to_netlist", ninja_rules)
        self.assertIn("rule compare", ninja_rules)
        self.assertIn("rule inject", ninja_rules)

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # there should be 410 build statements for a single design using this flow
        self.assertEqual(build_statement_count, 410)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies to the ninja file"""
        observed = self.flow.add_ninja_deps(["foo", "bar"])
        expected = [
            "foo",
            "bar",
        ]
        expected.extend(Vivado("byu/alu").add_ninja_deps())
        expected.extend(ErrorInjector("byu/alu").add_ninja_deps())
        expected.extend(PhysNetlist("byu/alu").add_ninja_deps())
        expected.extend(Xray("byu/alu").add_ninja_deps())
        expected.extend(Structural("byu/alu").add_ninja_deps())
        expected.append(f"{NINJA_FLOWS_PATH}/vivado_structural_error_injection.py")

        observed.sort()
        expected.sort()
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(),
            f"{NINJA_FLOWS_PATH}/vivado_structural_error_injection.py",
        )


if __name__ == "__main__":
    unittest.main()
