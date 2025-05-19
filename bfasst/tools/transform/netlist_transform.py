""" Purge INIT values for all LUTs in a synthesized design and replace them with dummy values"""

from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_TRANSFORM_TOOLS_PATH, BFASST_UTILS_PATH


class NetlistTransform(Tool):
    """Purge INIT values for all LUTs in a synthesized design and replace them with dummy values"""

    def __init__(
        self,
        flow,
        design,
        *,
        dcp_path,
        edf_path,
        transform_type="purge_luts",
        logging_level="INFO",
        log_file="netlist_transform.log",
    ):
        super().__init__(flow, design)
        self.dcp_path = dcp_path
        self.edf_path = edf_path
        self.transform_type = transform_type
        self.build_path = self.design_build_path / "netlist_transform"
        self.logging_level = logging_level
        self.log_file = log_file
        self.rule_snippet_path = (
            NINJA_TRANSFORM_TOOLS_PATH / "netlist_transform_rules.ninja.mustache"
        )
        self._init_outputs()
        self.rules_render_dict = {
            "transform_script_path": str(BFASST_UTILS_PATH / "netlist_transform.py"),
            "dcp_path": str(self.dcp_path),
            "edf_path": str(self.edf_path),
            "transformed_synth_dcp": str(self.outputs["transformed_synth_dcp"]),
            "transformed_synth_edf": str(self.outputs["transformed_synth_edf"]),
            "log_path": str(self.outputs["log_file"]),
            "logging_level": f"--logging_level {self.logging_level}",
            "build_path": str(self.build_path),
        }

    def create_build_snippets(self):
        self.create_rule_snippets()
        self._append_build_snippets_default(
            __file__,
            self.rules_render_dict,
        )

    def _init_outputs(self):
        self.outputs["log_file"] = self.build_path / self.log_file
        self.outputs["transformed_synth_dcp"] = self.build_path / "transformed_synth.dcp"
        self.outputs["transformed_synth_edf"] = self.build_path / "transformed_synth.edf"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "netlist_transform.py")
