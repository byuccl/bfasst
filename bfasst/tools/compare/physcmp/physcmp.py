"""Tool to create RapidWright-based physical comparison ninja snippets."""

from bfasst.tools.tool import Tool
from bfasst.paths import BFASST_UTILS_PATH, COMPARE_TOOLS_PATH, BFASST_PATH


class PhysCmp(Tool):
    def __init__(self, flow, design, *, golden_dcp, golden_edf, test_dcp, test_edf, log_name="phys_cmp.log", logging_level="INFO"):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "phys_cmp"
        self.golden_dcp = golden_dcp
        self.golden_edf = golden_edf
        self.test_dcp = test_dcp
        self.test_edf = test_edf
        self.log_name = log_name
        self.logging_level = logging_level
        self._init_outputs()
        self.rule_snippet_path = COMPARE_TOOLS_PATH / "physcmp" / "physcmp_rules.ninja.mustache"

    def create_build_snippets(self):
        render_dict={
                "golden_dcp": str(self.golden_dcp),
                "golden_edf": str(self.golden_edf),
                "test_dcp": str(self.test_dcp),
                "test_edf": str(self.test_edf),
                "log_path": str(self.outputs["physcmp_log"]),
                "compare_script_path": str(BFASST_UTILS_PATH / "physcmp.py"),
                "logging_level": f"--logging_level {self.logging_level}",
                "bfasst_path": str(BFASST_PATH),
        }
        self._append_build_snippets_default(
            __file__,
            render_dict,
        )
        # print(f"render_dict: {render_dict}")

    def _init_outputs(self):
        self.outputs["physcmp_log"] = self.build_path / self.log_name

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "physcmp.py")
