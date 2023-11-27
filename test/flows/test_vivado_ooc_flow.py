"""Unit tests for the Vivado ooc flow."""
import json
import unittest
from bfasst import config
from bfasst.ninja_flows.vivado_ooc import VivadoOoc
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
)
from bfasst.utils import compare_json


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

    def test_tcl_json_accurate(self):
        """Test that the json file used to template the tcl file is accurate"""
        synth_dict = {
            "part": config.PART,
            "verilog": self.flow.vivado_synth_tool.verilog,
            "system_verilog": self.flow.vivado_synth_tool.system_verilog,
            "vhdl": [],
            "vhdl_libs": [],
            "top": self.flow.vivado_synth_tool.design_props.top,
            "io": False,
            "synth_output": str(self.flow.vivado_synth_tool.build_path),
            "flow_args": "",
        }
        expected_synth_json = json.dumps(synth_dict, indent=4)
        self.assertTrue(
            compare_json(self.flow.vivado_synth_tool.build_path / "synth.json", expected_synth_json)
        )

        impl_dict = {
            "part": config.PART,
            "xdc": False,
            "bit": False,
            "impl_output": str(self.flow.vivado_impl_tool.build_path),
            "synth_output": str(self.flow.vivado_synth_tool.build_path),
        }
        expected_impl_json = json.dumps(impl_dict, indent=4)
        self.assertTrue(
            compare_json(self.flow.vivado_impl_tool.build_path / "impl.json", expected_impl_json),
            msg="observed: "
            + str(self.flow.vivado_impl_tool.build_path / "impl.json")
            + "\nexpected: "
            + str(expected_impl_json),
        )

    def test_build_snippets_exist(self):
        with open(NINJA_BUILD_PATH, "r") as f:
            build_statement_count = f.read().count("\nbuild ")

        # There should be 4 build statements for a single design ooc
        self.assertEqual(build_statement_count, 4)

    def test_add_ninja_deps(self):
        """Test that the flow adds the correct dependencies for the build.ninja file."""
        observed = ["foo", "bar"]
        self.flow.add_ninja_deps(observed)
        expected = [
            "foo",
            "bar",
        ]
        VivadoSynth(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        VivadoImpl(None, DESIGNS_PATH / "byu/alu").add_ninja_deps(expected)
        expected.append(NINJA_FLOWS_PATH / "vivado_ooc.py")
        expected.append(NINJA_FLOWS_PATH / "vivado.py")

        observed = sorted([str(s) for s in observed])
        expected = sorted([str(s) for s in expected])

        self.assertEqual(
            observed, expected, msg="observed: " + str(observed) + "\nexpected: " + str(expected)
        )

    def test_get_top_level_flow_path(self):
        self.assertEqual(self.flow.get_top_level_flow_path(), NINJA_FLOWS_PATH / "vivado_ooc.py")


if __name__ == "__main__":
    unittest.main()
