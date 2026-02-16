"""Redact cell properties from a synthesized design and replace them with dummy values"""

from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_TRANSFORM_TOOLS_PATH, BFASST_UTILS_PATH


class NetlistRedact(Tool):
    """Redact cell properties from a synthesized design and replace them with dummy values"""

    def __init__(
        self,
        flow,
        design,
        *,
        dcp_path,
        edf_path,
        orig_dcp_path,
        orig_edf_path,
        logging_level="INFO",
        log_file="netlist_redact.log",
    ):
        super().__init__(flow, design)
        self.dcp_path = dcp_path
        self.edf_path = edf_path
        self.orig_dcp_path = orig_dcp_path
        self.orig_edf_path = orig_edf_path
        self.build_path = self.design_build_path / "netlist_redact"
        self.logging_level = logging_level
        self.log_file = log_file
        self.rule_snippet_path = NINJA_TRANSFORM_TOOLS_PATH / "netlist_redact_rules.ninja.mustache"
        self._init_outputs()
        self.rules_render_dict = {
            "redact_script_path": str(BFASST_UTILS_PATH / "transform" / "netlist_redact.py"),
            "dcp_path": str(self.dcp_path),
            "edf_path": str(self.edf_path),
            "orig_dcp_path": str(self.orig_dcp_path),
            "orig_edf_path": str(self.orig_edf_path),
            "redacted_synth_dcp": str(self.outputs["redacted_synth_dcp"]),
            "redacted_synth_edf": str(self.outputs["redacted_synth_edf"]),
            "unredacted_synth_dcp": str(self.outputs["unredacted_synth_dcp"]),
            "unredacted_synth_edf": str(self.outputs["unredacted_synth_edf"]),
            "original_cell_props": str(self.outputs["original_cell_props"]),
            "log_path": str(self.outputs["log_file"]),
            "logging_level": f"--logging_level {self.logging_level}",
            "build_path": str(self.build_path),
        }

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            self.rules_render_dict,
        )

    def _init_outputs(self):
        self.outputs["build_path"] = self.build_path
        self.outputs["log_file"] = self.build_path / self.log_file
        self.outputs["redacted_synth_dcp"] = self.build_path / "redacted_synth.dcp"
        self.outputs["redacted_synth_edf"] = self.build_path / "redacted_synth.edf"
        self.outputs["unredacted_synth_dcp"] = self.build_path / "unredacted_synth.dcp"
        self.outputs["unredacted_synth_edf"] = self.build_path / "unredacted_synth.edf"
        self.outputs["original_cell_props"] = self.build_path / "original_cell_props.json"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "transform" / "netlist_redact.py")
        deps.append(self.dcp_path)
        deps.append(self.edf_path)
        deps.append(self.orig_dcp_path)
        deps.append(self.orig_edf_path)
