"""Create rule and build snippets for phys netlist creation."""

import json

import chevron
from bfasst.ninja_tools.tool import Tool
from bfasst.paths import (
    BUILD_DIR,
    NINJA_BUILD_PATH,
    NINJA_TRANSFORM_TOOLS_PATH,
    NINJA_UTILS_PATH,
    PHYS_NETLIST_RULES_PATH,
)
from bfasst.utils import compare_json


class PhysNetlist(Tool):
    """Create rule and build snippets for phys netlist creation."""

    def __init__(self, design):
        super().__init__(design)

        self.build = BUILD_DIR / design / "vivado_phys_netlist"
        self.phys_netlist_path = self.build / "viv_impl_physical.v"
        self.__create_build_dir()

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        with open(PHYS_NETLIST_RULES_PATH, "r") as f:
            phys_netlist_rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_netlist_rules)

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def __write_json_file(self):
        checkpoint_to_v = {
            "phys_netlist_verilog_path": str(self.phys_netlist_path),
            "phys_netlist_checkpoint": str(self.build / "phys_netlist.dcp"),
        }

        checkpoint_to_v_json = json.dumps(checkpoint_to_v, indent=4)

        json_equivalent = compare_json(self.build / "checkpoint_to_v.json", checkpoint_to_v_json)
        if not json_equivalent:
            with open(self.build / "checkpoint_to_v.json", "w") as f:
                f.write(checkpoint_to_v_json)

    def __append_build_snippets(self):
        with open(NINJA_TRANSFORM_TOOLS_PATH / "phys_netlist_build.ninja.mustache") as f:
            phys_netlist_ninja = chevron.render(
                f,
                {
                    "phys_netlist_output": self.build,
                    "phys_netlist_library": NINJA_TRANSFORM_TOOLS_PATH,
                    "build_dir": self.build.parent,
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_netlist_ninja)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/phys_netlist.py ")
        deps.append(f"{NINJA_UTILS_PATH}/rw_phys_netlist.py ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/phys_netlist_build.ninja.mustache ")
        deps.append(f"{PHYS_NETLIST_RULES_PATH} ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/checkpoint_to_v.tcl.mustache ")
        return deps
