"""Unit tests for the Vivado flow."""
import json
import unittest
from bfasst.ninja_flows.vivado import Vivado
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
    NINJA_TOOLS_PATH,
    VIVADO_RULES_PATH,
)
from bfasst.utils import compare_json


class TestVivadoFlow(unittest.TestCase):
    """Unit tests for the Vivado flow."""

    @classmethod
    def setUpClass(cls):
        # overwrite the build file so it is not appended to incorrectly
        with open(NINJA_BUILD_PATH, "w") as f:
            f.write("")

        cls.flow = Vivado("byu/alu")
        cls.flow.create()

    def test_in_context_default(self):
        # test that the flow is in-context by default
        self.assertFalse(self.flow.ooc)

    def test_rule_snippets_exist(self):
        # test that there is a rule for vivado, template, and ioparse
        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_rules = f.read()
        self.assertIn("rule vivado", ninja_rules)
        self.assertIn("rule template", ninja_rules)
        self.assertIn("rule vivado_ioparse", ninja_rules)

    def test_json_exist(self):
        # test that the json files for synth and impl templates exist
        self.assertTrue((self.flow.synth_output / "synth.json").exists())
        self.assertTrue((self.flow.impl_output / "impl.json").exists())

    def test_tcl_json_accurate(self):
        synth_dict = {
            "part": self.flow.part,
            "verilog": self.flow.verilog,
            "system_verilog": self.flow.system_verilog,
            "top": self.flow.top,
            "io": str(self.flow.synth_output / "iofile.txt"),
            "synth_output": str(self.flow.synth_output),
        }
        expected_synth_json = json.dumps(synth_dict, indent=4)
        self.assertTrue(compare_json(self.flow.synth_output / "synth.json", expected_synth_json))

        impl_dict = {
            "part": self.flow.part,
            "xdc": str(self.flow.synth_output / (self.flow.top + ".xdc")),
            "bit": str(self.flow.impl_output / (self.flow.top + ".bit")),
            "impl_output": str(self.flow.impl_output),
            "synth_output": str(self.flow.synth_output),
        }
        expected_impl_json = json.dumps(impl_dict, indent=4)
        self.assertTrue(compare_json(self.flow.impl_output / "impl.json", expected_impl_json))

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 5 build statements for a single design in context
        self.assertEqual(build_statement_count, 5)

    def test_add_ninja_deps(self):
        observed = self.flow.add_ninja_deps(["foo", "bar"])
        expected = [
            "foo",
            "bar",
            f"{NINJA_TOOLS_PATH}/synth/viv_synth.ninja.mustache ",
            f"{NINJA_TOOLS_PATH}/impl/viv_impl.ninja.mustache ",
            f"{NINJA_FLOWS_PATH}/vivado.py ",
            f"{VIVADO_RULES_PATH}\n",
        ]

        self.assertEqual(observed, expected)

        # add_ninja_deps is only allowed to be called once.
        # Subsequent calls should return None.
        self.assertEqual(self.flow.add_ninja_deps([]), None)

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), f"{NINJA_FLOWS_PATH}/vivado.py")


if __name__ == "__main__":
    unittest.main()
