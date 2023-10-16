# pylint: disable=duplicate-code
"""Inject an error into a xrev netlist and run a structural compare to detect it."""
import random

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.structural.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.error_injector import ErrorInjector
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH

from bfasst.ninja_utils.error_injector import ErrorType


class VivadoStructuralErrorInjection(Flow):
    """Inject an error into a xrev netlist and run a structural compare to detect it."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        random.seed(0)
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xrev_tool = Xray(design)
        self.error_injector_tool = ErrorInjector(design)
        self.compare_tool = Structural(design)

        self.error_injector_build = self.design_build_path / "error_injection"

    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja."""
        self.vivado_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.error_injector_tool.create_rule_snippets()
        self.compare_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_tool.outputs["impl_edf"],
        )
        self.xrev_tool.create_build_snippets(self.vivado_tool.outputs["bitstream"])

        random_seed_multiplier = 1
        error_type = [ErrorType.BIT_FLIP, ErrorType.WIRE_SWAP]
        for error in error_type:
            num_runs = 100

            for i in range(1, num_runs + 1):
                self.error_injector_tool.create_build_snippets(
                    error_type=error,
                    num=i,
                    multiplier=random_seed_multiplier,
                    reversed_netlist=self.xrev_tool.outputs["xray_netlist"],
                )
                corrupt_netlist_path = self.error_injector_build / f"{error.name.lower()}_{i}.v"
                self.compare_tool.create_build_snippets(
                    self.phys_netlist_tool.phys_netlist_path,
                    corrupt_netlist_path,
                    f"{error.name.lower()}_{i}_cmp.log",
                )

    def add_ninja_deps(self, deps):
        self.vivado_tool.add_ninja_deps(deps)
        self.phys_netlist_tool.add_ninja_deps(deps)
        self.xrev_tool.add_ninja_deps(deps)
        self.error_injector_tool.add_ninja_deps(deps)
        self.compare_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_structural_error_injection.py")

    def get_top_level_flow_path(self) -> str:
        return f"{NINJA_FLOWS_PATH}/vivado_structural_error_injection.py"
