"""Unit testsw for the VivadoConformal flow."""
import unittest
from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado_conformal import VivadoConformal
from bfasst.ninja_tools.vivado.vivado import Vivado
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.compare.conformal.conformal import Conformal
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)


class TestVivadoConformalFlow(unittest.TestCase):
    """Unit testsw for the VivadoConformal flow."""

    @classmethod
    def setUpClass(cls) -> None:
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = VivadoConformal("byu/alu")
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
        observed = self.flow.add_ninja_deps(["foo", "bar"])
        expected = ["foo", "bar"]
        expected.extend(Xray("byu/alu").add_ninja_deps())
        expected.extend(Vivado("byu/alu").add_ninja_deps())
        expected.extend(Conformal("byu/alu").add_ninja_deps())
        expected.append(f"{NINJA_FLOWS_PATH}/vivado_conformal.py ")
        observed.sort()
        expected.sort()
        self.assertEqual(observed, expected)

    def test_get_top_level_flow_path(self):
        self.assertEqual(
            self.flow.get_top_level_flow_path(), f"{NINJA_FLOWS_PATH}/vivado_conformal.py"
        )


if __name__ == "__main__":
    unittest.main()
