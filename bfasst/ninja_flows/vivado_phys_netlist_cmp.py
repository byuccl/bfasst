"""Structural Comparison of physical netlist and reversed netlist"""

import chevron
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado_phys_netlist_xrev import VivadoPhysNetlistXrev
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_COMPARE_TOOLS_PATH,
    NINJA_FLOWS_PATH,
    NINJA_UTILS_PATH,
    ROOT_PATH,
)
from bfasst.yaml_parser import YamlParser


class VivadoPhysNetlistCmp(Flow):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design):
        super().__init__(design)
        self.build = ROOT_PATH / "build" / design / "struct_cmp"

        self.phys_netlist_path = self.build.parent / "vivado_phys_netlist" / "viv_impl_physical.v"
        self.top = YamlParser(self.design / "design.yaml").parse_top_module()
        self.rev_netlist_path = self.build.parent / "xray" / f"{self.top}_reversed.v"

        self.phys_and_xrev_flow = VivadoPhysNetlistXrev(design)

    def create_rule_snippets(self):
        self.phys_and_xrev_flow.create_rule_snippets()
        with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": str(NINJA_UTILS_PATH)})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self):
        self.phys_and_xrev_flow.create_build_snippets()
        with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_build.mustache", "r") as f:
            build = chevron.render(
                f,
                {
                    "build": str(self.build.parent),
                    "netlist_a": str(
                        self.build.parent / "vivado_phys_netlist" / "viv_impl_physical.v"
                    ),
                    "netlist_b": str(self.build.parent / "xray" / f"{self.top}_reversed.v"),
                    "log_path": str(self.build / "log.txt"),
                },
            )

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.phys_and_xrev_flow.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_cmp.py ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_rules.mustache ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_build.mustache ")
        deps.append(f"{NINJA_UTILS_PATH}/structural.py ")
        return deps

    def get_top_level_flow_path(self):
        path = str(NINJA_FLOWS_PATH / "vivado_phys_netlist_cmp.py")
        return path
