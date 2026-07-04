"""Unit tests for the Vivado flow."""

# Disable this since we are testing a class
# pylint: disable=duplicate-code

import unittest

from bfasst.flows.flow_utils import create_build_file
from bfasst.flows.vivado import Vivado
from bfasst.paths import BFASST_DESIGNS, BFASST_FLOWS, NINJA_BUILD_PATH


class TestVivadoFlow(unittest.TestCase):
    """Unit tests for the Vivado flow."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        create_build_file()

        cls.flow = Vivado(BFASST_DESIGNS / "byu/alu")
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_in_context_default(self):
        # test that the flow is in-context by default
        self.assertFalse(self.flow.ooc)

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, template, and ioparse
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()
        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)

    def test_json_exist(self):
        # test that the json files for synth and impl templates exist
        self.assertTrue((self.flow.vivado_synth_tool.build_path / "synth.json").exists())
        self.assertTrue((self.flow.vivado_impl_tool.build_path / "impl.json").exists())

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), BFASST_FLOWS / "vivado.py")


if __name__ == "__main__":
    unittest.main()
