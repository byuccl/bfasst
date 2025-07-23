"""Tool to generate ninja snippets for netlist deobfuscation"""

import pathlib
from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_TRANSFORM_TOOLS_PATH, BFASST_UTILS_PATH


class NetlistDeobfuscate(Tool):
    """Tool to generate ninja snippets for netlist deobfuscation"""

    def __init__(
        self,
        flow,
        design,
        *,
        dcp_path,
        edf_path,
        unmodified_dcp_path,
        unmodified_edf_path,
        props_json,
        log_file="netlist_deobfuscate.log",
    ):
        super().__init__(flow, design)

        self.dcp_path = pathlib.Path(dcp_path)
        self.edf_path = pathlib.Path(edf_path)
        self.unmodified_dcp_path = pathlib.Path(unmodified_dcp_path)
        self.unmodified_edf_path = pathlib.Path(unmodified_edf_path)
        self.props_json = pathlib.Path(props_json)
        self.log_file = log_file
        self.build_path = self.design_build_path / "netlist_deobfuscate"
        self._init_outputs()

        self.rule_snippet_path = (
            NINJA_TRANSFORM_TOOLS_PATH / "netlist_deobfuscate_rules.ninja.mustache"
        )
        self.rules_render_dict = {
            "transform_script_path": str(BFASST_UTILS_PATH / "transform" /  "netlist_deobfuscate.py"),
            "dcp_in": str(self.dcp_path),
            "edf_in": str(self.edf_path),
            "unmodified_dcp_in": str(self.unmodified_dcp_path),
            "unmodified_edf_in": str(self.unmodified_edf_path),
            "props": str(self.props_json),
            "out_dcp": str(self.outputs["deobf_dcp"]),
            "out_edf": str(self.outputs["deobf_edf"]),
            "unmodified_out_dcp": str(self.outputs["unmodified_deobf_dcp"]),
            "unmodified_out_edf": str(self.outputs["unmodified_deobf_edf"]),
            "log_path": str(self.outputs["log_file"]),
            "build_path": str(self.build_path),
        }

    def _init_outputs(self):
        bp = self.build_path
        self.outputs["log_file"] = bp / self.log_file
        self.outputs["deobf_dcp"] = bp / "impl_deobf.dcp"
        self.outputs["deobf_edf"] = bp / "impl_deobf.edf"
        self.outputs["unmodified_deobf_dcp"] = bp / "unmodified_impl_deobf.dcp"
        self.outputs["unmodified_deobf_edf"] = bp / "unmodified_impl_deobf.edf"

    def create_build_snippets(self):
        self._append_build_snippets_default(__file__, self.rules_render_dict)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "transform" / "netlist_deobfuscate.py")
        deps.append(self.dcp_path)
        deps.append(self.edf_path)
        deps.append(self.unmodified_dcp_path)
        deps.append(self.unmodified_edf_path)
        deps.append(self.props_json)
