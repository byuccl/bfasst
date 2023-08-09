"""Creates a Vivado netlist that has only physical primitives."""

import json

import chevron
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado import Vivado
from bfasst.paths import NINJA_BUILD_PATH, NINJA_FLOWS_PATH, NINJA_TRANSFORM_TOOLS_PATH, ROOT_PATH
from bfasst.utils import compare_json


class VivadoPhysNetlist(Flow):
    """Creates a Vivado netlist that has only physical primitives."""

    def __init__(self, design):
        super().__init__(design)
        self.vivado_flow = Vivado(design)
        self.build = ROOT_PATH / "build" / design / "vivado_phys_netlist"

    def create_rule_snippets(self):
        return

    def create_build_snippets(self):
        self.__write_json_file()
        self.__append_build_snippets()

    def __write_json_file(self):
        checkpoint_to_v = {
            "phys_netlist_verilog_path": str(self.build / "viv_impl_physical.v"),
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
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(phys_netlist_ninja)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_flow.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist.py ")
        return deps

    def get_top_level_flow_path(self):
        path = str(NINJA_FLOWS_PATH / "vivado_phys_netlist.py")
        return path
