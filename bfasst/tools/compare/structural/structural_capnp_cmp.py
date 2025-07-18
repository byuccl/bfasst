"""Create rule and build snippets for phys netlist creation."""

import json

import chevron

from bfasst.paths import (
    BFASST_UTILS_PATH,
    COMPARE_TOOLS_PATH,
    NINJA_BUILD_PATH,
    NINJA_TRANSFORM_TOOLS_PATH,
)
from bfasst.tools.tool import Tool
from bfasst.utils import compare_json


class StructuralCapnpCmp(Tool):
    """Create rule and build snippets for phys netlist creation."""

    # pylint: disable=too-many-positional-arguments
    def __init__(
        self,
        flow,
        design,
        impl_checkpoint,
        impl_edf,
        synth_checkpoint,
        synth_edf,
        *,
        log_name="log.txt",
        phys_capnp=None,
        edf_capnp=None,
        logging_level="INFO",
    ):
        super().__init__(flow, design)
        self.synth_checkpoint = synth_checkpoint
        self.synth_edf = synth_edf
        self.impl_checkpoint = impl_checkpoint
        self.impl_edf = impl_edf
        self.phys_capnp = phys_capnp
        self.edf_capnp = edf_capnp
        self.logging_level = logging_level
        self.log_name = log_name

        self.build_path = self.design_build_path / "capnp_cmp"

        self._init_outputs()
        self.rule_snippet_path = (
            COMPARE_TOOLS_PATH / "structural" / "structural_capnp_rules.ninja.mustache"
        )
        self.rules_render_dict = {
            "phys_capnp": self.phys_capnp,
            "edf_capnp": self.edf_capnp,
        }

    # pylint: enable=too-many-positional-arguments

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def __write_json_file(self):
        checkpoint_to_v = {
            "phys_netlist_verilog_path": str(self.outputs["viv_impl_physical_v"]),
            "phys_netlist_checkpoint": str(self.outputs["phys_capnp_checkpoint"]),
            "cmp_time": str(self.outputs["cmp_time"]),
        }
        checkpoint_to_v_json = json.dumps(checkpoint_to_v, indent=4)
        json_equivalent = compare_json(self.outputs["checkpoint_to_v_json"], checkpoint_to_v_json)
        if not json_equivalent:
            with open(self.build_path / "checkpoint_to_v.json", "w") as f:
                f.write(checkpoint_to_v_json)

    def __append_build_snippets(self):
        build_dict = {
            "utils_path": str(BFASST_UTILS_PATH),
            "phys_capnp_output": self.build_path,
            "transform_library": NINJA_TRANSFORM_TOOLS_PATH,
            "build_dir": self.build_path.parent,
            "logging_level": self.logging_level,
            "synth_dcp": self.synth_checkpoint,
            "synth_edf": self.synth_edf,
            "impl_dcp": self.impl_checkpoint,
            "impl_edf": self.impl_edf,
            "phys_capnp": self.phys_capnp,
            "edf_capnp": self.edf_capnp,
            "design": f"{self.design_build_path.parent.name}/{self.design_build_path.name}",
        }
        build_dict.update({k: str(v) for k, v in self.outputs.items()})
        with open(COMPARE_TOOLS_PATH / "structural" / "structural_capnp_build.ninja.mustache") as f:
            phys_capnp_ninja = chevron.render(f, build_dict)

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_capnp_ninja)

    def _init_outputs(self):
        phys_net_dir = self.design_build_path / "vivado_phys_netlist"
        self.outputs["checkpoint_to_v_tcl"] = phys_net_dir / "checkpoint_to_v.tcl"
        self.outputs["viv_impl_physical_edf"] = phys_net_dir / "viv_impl_physical.edf"
        self.outputs["viv_impl_physical_v"] = phys_net_dir / "viv_impl_physical.v"
        self.outputs["phys_capnp_checkpoint"] = phys_net_dir / "phys_netlist.dcp"
        self.outputs["phys_capnp_log"] = self.build_path / self.log_name
        self.outputs["checkpoint_to_v_json"] = phys_net_dir / "checkpoint_to_v.json"
        self.outputs["rapidwright_log"] = self.build_path / "rapidwright_stdout.log"
        self.outputs["interchange"] = phys_net_dir / "phys_logical_netlist.capnp"
        self.outputs["cmp_time"] = self.build_path / "cmp_time.txt"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS_PATH / "transform" / "rw_phys_netlist.py")
        deps.append(BFASST_UTILS_PATH / "rw_helpers.py")
        deps.append(BFASST_UTILS_PATH / "compare" / "structural_capnp.py")
        deps.append(BFASST_UTILS_PATH / "capnp_cells.py")
        deps.append(BFASST_UTILS_PATH / "general.py")
