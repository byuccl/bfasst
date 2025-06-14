"""Create rule and build snippets for phys netlist creation."""

import json

import chevron
from bfasst.tools.tool import Tool
from bfasst.paths import (
    NINJA_BUILD_PATH,
    COMPARE_TOOLS_PATH,
    BFASST_UTILS_PATH,
    NINJA_TRANSFORM_TOOLS_PATH,
)
from bfasst.utils import compare_json


class StructuralCapnpCmp(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(
        self,
        flow,
        design,
        impl_checkpoint,
        impl_edf,
        *,
        log_name="log.txt",
        phys_capnp=None,
        edf_capnp=None,
        logging_level="INFO",
    ):
        super().__init__(flow, design)

        self.impl_checkpoint = impl_checkpoint
        self.impl_edf = impl_edf
        self.phys_capnp = phys_capnp
        self.edf_capnp = edf_capnp
        self.logging_level = logging_level
        self.log_name = log_name

        self.build_path = self.design_build_path / "vivado_phys_capnp_cmp"

        self._init_outputs()
        self.rule_snippet_path = (
            COMPARE_TOOLS_PATH / "structural" / "structural_capnp_rules.ninja.mustache"
        )
        self.rules_render_dict = {
            "phys_capnp": self.phys_capnp,
            "edf_capnp": self.edf_capnp,
        }

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def __write_json_file(self):
        checkpoint_to_v = {
            "phys_capnp_verilog_path": str(self.outputs["viv_impl_physical_v"]),
            "phys_capnp_checkpoint": str(self.outputs["phys_capnp_checkpoint"]),
        }

        checkpoint_to_v_json = json.dumps(checkpoint_to_v, indent=4)

        json_equivalent = compare_json(
            self.build_path / "checkpoint_to_v.json", checkpoint_to_v_json
        )
        if not json_equivalent:
            with open(self.build_path / "checkpoint_to_v.json", "w") as f:
                f.write(checkpoint_to_v_json)

    def __append_build_snippets(self):
        build_dict = {
            "phys_capnp_output": self.build_path,
            "transform_library": NINJA_TRANSFORM_TOOLS_PATH,
            "build_dir": self.build_path.parent,
            "logging_level": self.logging_level,
            "impl_dcp": self.impl_checkpoint,
            "impl_edf": self.impl_edf,
            "phys_capnp": self.phys_capnp,
            "edf_capnp": self.edf_capnp,
        }
        build_dict.update({k: str(v) for k, v in self.outputs.items()})
        with open(COMPARE_TOOLS_PATH / "structural" / "structural_capnp_build.ninja.mustache") as f:
            phys_capnp_ninja = chevron.render(f, build_dict)

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_capnp_ninja)

    def _init_outputs(self):
        self.outputs["checkpoint_to_v_tcl"] = self.build_path / "checkpoint_to_v.tcl"
        self.outputs["viv_impl_physical_edf"] = self.build_path / "viv_impl_physical.edf"
        self.outputs["viv_impl_physical_v"] = self.build_path / "viv_impl_physical.v"
        self.outputs["phys_capnp_checkpoint"] = self.build_path / "phys_netlist.dcp"
        self.outputs["phys_capnp_log"] = self.build_path / self.log_name
        self.outputs["checkpoint_to_v_json"] = self.build_path / "checkpoint_to_v.json"
        self.outputs["rapidwright_log"] = self.build_path / "rapidwright_stdout.log"
        self.outputs["interchange"] = self.build_path / "phys_logical_netlist.capnp"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "rw_phys_netlist.py")
        deps.append(BFASST_UTILS_PATH / "rw_helpers.py")
        deps.append(BFASST_UTILS_PATH / "structural_capnp.py")
        deps.append(BFASST_UTILS_PATH / "capnp_cells.py")
        deps.append(BFASST_UTILS_PATH / "general.py")
        deps.append(NINJA_TRANSFORM_TOOLS_PATH / "checkpoint_to_v.tcl.mustache")
