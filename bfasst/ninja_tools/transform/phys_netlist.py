"""Create rule and build snippets for phys netlist creation."""

import json

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_TRANSFORM_TOOLS_PATH,
    NINJA_UTILS_PATH,
    PHYS_NETLIST_RULES_PATH,
)
from bfasst.utils import compare_json


class PhysNetlist(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, flow, design):
        super().__init__(flow, design)

        self.build_path = self.design_build_path / "vivado_phys_netlist"
        self.phys_netlist_path = self.build_path / "viv_impl_physical.v"

        self._init_outputs()

    def create_rule_snippets(self):
        with open(PHYS_NETLIST_RULES_PATH, "r") as f:
            phys_netlist_rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_netlist_rules)

    def create_build_snippets(self, impl_dcp, impl_edf):
        self.__write_json_file()
        self.__append_build_snippets(impl_dcp, impl_edf)

    def __write_json_file(self):
        checkpoint_to_v = {
            "phys_netlist_verilog_path": str(self.phys_netlist_path),
            "phys_netlist_checkpoint": str(self.build_path / "phys_netlist.dcp"),
        }

        checkpoint_to_v_json = json.dumps(checkpoint_to_v, indent=4)

        json_equivalent = compare_json(
            self.build_path / "checkpoint_to_v.json", checkpoint_to_v_json
        )
        if not json_equivalent:
            with open(self.build_path / "checkpoint_to_v.json", "w") as f:
                f.write(checkpoint_to_v_json)

    def __append_build_snippets(self, impl_dcp, impl_edf):
        with open(NINJA_TRANSFORM_TOOLS_PATH / "phys_netlist_build.ninja.mustache") as f:
            phys_netlist_ninja = chevron.render(
                f,
                {
                    "phys_netlist_output": self.build_path,
                    "phys_netlist_library": NINJA_TRANSFORM_TOOLS_PATH,
                    "build_dir": self.build_path.parent,
                    "impl_dcp": impl_dcp,
                    "impl_edf": impl_edf,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_netlist_ninja)

    def _init_outputs(self):
        self.outputs["checkpoint_to_v_tcl"] = self.build_path / "checkpoint_to_v.tcl"
        self.outputs["viv_impl_physical_edf"] = self.build_path / "viv_impl_physical.edf"
        self.outputs["viv_impl_physical_v"] = self.phys_netlist_path
        self.outputs["phys_netlist_checkpoint"] = self.build_path / "phys_netlist.dcp"
        self.outputs["phys_netlist_log"] = self.build_path / "log.txt"
        self.outputs["checkpoint_to_v_json"] = self.build_path / "checkpoint_to_v.json"
        self.outputs["rapidwright_log"] = self.build_path / "rapidwright_stdout.log"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(NINJA_UTILS_PATH / "rw_phys_netlist.py")
        deps.append(NINJA_TRANSFORM_TOOLS_PATH / "checkpoint_to_v.tcl.mustache")
