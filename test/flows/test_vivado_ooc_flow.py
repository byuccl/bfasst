"""Unit tests for the Vivado ooc flow."""

import unittest
from bfasst.flows.vivado_ooc import VivadoOoc
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH, FLOWS_PATH


class TestVivadoOocFlow(unittest.TestCase):
    """Unit tests for the Vivado ooc flow."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        with open(NINJA_BUILD_PATH, "w") as f:
            f.write("")

        cls.flow = VivadoOoc(DESIGNS_PATH / "byu/alu")
        cls.flow.create_tool_build_dirs()
        cls.flow.create_rule_snippets()
        cls.flow.create_build_snippets()

    def test_ooc_default(self):
        # test that the flow is ooc by default
        self.assertTrue(self.flow.ooc)

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, template, but not ioparse
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()
        self.assertIn("rule vivado", ninja_rules)
        self.assertNotIn("rule vivado_ioparse", ninja_rules)

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), FLOWS_PATH / "vivado_ooc.py")


if __name__ == "__main__":
    unittest.main()
