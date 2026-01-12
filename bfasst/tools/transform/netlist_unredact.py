"""Tool to generate ninja snippets for netlist unredaction (property restoration)"""

import pathlib
from bfasst.tools.tool import Tool
from bfasst.paths import NINJA_TRANSFORM_TOOLS_PATH, BFASST_UTILS_PATH


class NetlistUnredact(Tool):
    """Tool to generate ninja snippets for netlist unredaction"""

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
        pre_phys_opt_dcp=None,
        pre_phys_opt_edf=None,
        post_place_dir=None,
        post_route_dir=None,
        log_file="netlist_unredact.log",
    ):
        super().__init__(flow, design)

        self.dcp_path = pathlib.Path(dcp_path)
        self.edf_path = pathlib.Path(edf_path)
        self.unmodified_dcp_path = pathlib.Path(unmodified_dcp_path)
        self.unmodified_edf_path = pathlib.Path(unmodified_edf_path)
        self.props_json = pathlib.Path(props_json)
        self.pre_phys_opt_dcp = pathlib.Path(pre_phys_opt_dcp) if pre_phys_opt_dcp else None
        self.pre_phys_opt_edf = pathlib.Path(pre_phys_opt_edf) if pre_phys_opt_edf else None
        self.post_place_dir = pathlib.Path(post_place_dir) if post_place_dir else None
        self.post_route_dir = pathlib.Path(post_route_dir) if post_route_dir else None
        self.log_file = log_file
        self.build_path = self.design_build_path / "netlist_unredact"
        self._init_outputs()

        self.rule_snippet_path = (
            NINJA_TRANSFORM_TOOLS_PATH / "netlist_unredact_rules.ninja.mustache"
        )
        self.rules_render_dict = {
            "unredact_script_path": str(BFASST_UTILS_PATH / "transform" / "netlist_unredact.py"),
            "dcp_in": str(self.dcp_path),
            "edf_in": str(self.edf_path),
            "unmodified_dcp_in": str(self.unmodified_dcp_path),
            "unmodified_edf_in": str(self.unmodified_edf_path),
            "props": str(self.props_json),
            "out_dcp": str(self.outputs["unredact_dcp"]),
            "out_edf": str(self.outputs["unredact_edf"]),
            "unmodified_out_dcp": str(self.outputs["unmodified_unredact_dcp"]),
            "unmodified_out_edf": str(self.outputs["unmodified_unredact_edf"]),
            "log_path": str(self.outputs["log_file"]),
            "build_path": str(self.build_path),
            "has_restruct_opt": self.pre_phys_opt_dcp is not None,
            "pre_phys_opt_dcp": str(self.pre_phys_opt_dcp) if self.pre_phys_opt_dcp else "",
            "pre_phys_opt_edf": str(self.pre_phys_opt_edf) if self.pre_phys_opt_edf else "",
            "post_place_dir": str(self.post_place_dir) if self.post_place_dir else "",
            "post_route_dir": str(self.post_route_dir) if self.post_route_dir else "",
        }

    def _init_outputs(self):
        bp = self.build_path
        self.outputs["log_file"] = bp / self.log_file
        self.outputs["unredact_dcp"] = bp / "impl_unredact.dcp"
        self.outputs["unredact_edf"] = bp / "impl_unredact.edf"
        self.outputs["unmodified_unredact_dcp"] = bp / "unmodified_impl_unredact.dcp"
        self.outputs["unmodified_unredact_edf"] = bp / "unmodified_impl_unredact.edf"

    def create_build_snippets(self):
        self._append_build_snippets_default(__file__, self.rules_render_dict)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "transform" / "netlist_unredact.py")
        deps.append(self.dcp_path)
        deps.append(self.edf_path)
        deps.append(self.unmodified_dcp_path)
        deps.append(self.unmodified_edf_path)
        deps.append(self.props_json)
        if self.pre_phys_opt_dcp:
            deps.append(BFASST_UTILS_PATH / "transform" / "restruct_transform.py")
            deps.append(self.pre_phys_opt_dcp)
            deps.append(self.pre_phys_opt_edf)
