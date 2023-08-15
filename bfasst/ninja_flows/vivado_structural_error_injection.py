"""Inject an error into a xrev netlist and run a structural compare to detect it."""
import random

import chevron
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado_phys_netlist_xrev import VivadoPhysNetlistXrev
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_COMPARE_TOOLS_PATH,
    NINJA_FLOWS_PATH,
    NINJA_TRANSFORM_TOOLS_PATH,
    NINJA_UTILS_PATH,
    ROOT_PATH,
)

from bfasst.ninja_utils.error_injector import ErrorType
from bfasst.yaml_parser import YamlParser


class VivadoStructuralErrorInjection(Flow):
    """Inject an error into a xrev netlist and run a structural compare to detect it."""

    def __init__(self, design):
        super().__init__(design)

        self.build = ROOT_PATH / "build" / design / "error_injection"
        self.__create_build_dir()

        self.phys_xrev_flow = VivadoPhysNetlistXrev(design)

        random.seed(0)
        self.top = YamlParser(self.design / "design.yaml").parse_top_module()

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        self.phys_xrev_flow.create_rule_snippets()
        with open(NINJA_TRANSFORM_TOOLS_PATH / "error_injector.ninja_rules.mustache", "r") as f:
            rules = chevron.render(f, {"utils": NINJA_UTILS_PATH})

        with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_rules.mustache", "r") as f:
            rules += chevron.render(f, {"utils": NINJA_UTILS_PATH})

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self):
        self.phys_xrev_flow.create_build_snippets()

        random_seed_multiplier = 1
        error_type = [ErrorType.BIT_FLIP, ErrorType.WIRE_SWAP]
        for error in error_type:
            num_runs = 100

            for i in range(1, num_runs + 1):
                injection_log_path = self.build / f"{error.name.lower()}_{i}.log"
                corrupt_netlist_path = self.build / f"{error.name.lower()}_{i}.v"
                compare_log_path = (
                    self.build.parent / "struct_cmp" / f"{error.name.lower()}_{i}_cmp.log"
                )
                with open(
                    NINJA_TRANSFORM_TOOLS_PATH / "error_injector.ninja_build.mustache", "r"
                ) as f:
                    build = chevron.render(
                        f,
                        {
                            "log_path": str(injection_log_path),
                            "corrupt_netlist_path": corrupt_netlist_path,
                            "build_dir": self.build.parent,
                            "top": self.top,
                            "seed": random_seed_multiplier * i,
                            "error_type": error.name,
                        },
                    )

                with open(NINJA_COMPARE_TOOLS_PATH / "structural.ninja_build.mustache", "r") as f:
                    build += chevron.render(
                        f,
                        {
                            "build": str(self.build.parent),
                            "netlist_a": str(
                                self.phys_xrev_flow.phys_netlist_flow.build / "viv_impl_physical.v"
                            ),
                            "netlist_b": str(corrupt_netlist_path),
                            "log_path": str(compare_log_path),
                        },
                    )

                with open(NINJA_BUILD_PATH, "a") as f:
                    f.write(build)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.phys_xrev_flow.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_structural_error_injection.py ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/error_injector.ninja_rules.mustache ")
        deps.append(f"{NINJA_TRANSFORM_TOOLS_PATH}/error_injector.ninja_build.mustache ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_rules.mustache ")
        deps.append(f"{NINJA_COMPARE_TOOLS_PATH}/structural.ninja_build.mustache ")
        return deps

    def get_top_level_flow_path(self) -> str:
        path = str(NINJA_FLOWS_PATH / "vivado_structural_error_injection.py")
        return path
