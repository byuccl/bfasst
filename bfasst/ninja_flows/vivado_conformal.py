"""Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.conformal import Conformal
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.types import Vendor


class VivadoConformal(Flow):
    """Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

    def __init__(self, design, flow_args=None):
        super().__init__()
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.phys_netlist_tool = PhysNetlist(design)
        self.xrev_tool = Xray(design)
        self.conformal_tool = Conformal(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.phys_netlist_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.conformal_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets()
        self.conformal_tool.create_build_snippets(
            self.phys_netlist_tool.phys_netlist_path,
            self.xrev_tool.reversed_netlist_path,
            Vendor.XILINX,
        )

    def add_ninja_deps(self, deps=None):
        # pylint: disable=duplicate-code
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.phys_netlist_tool.add_ninja_deps())
        deps.extend(self.xrev_tool.add_ninja_deps())
        deps.extend(self.conformal_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_conformal.py ")
        # pylint: enable=duplicate-code
        return deps

    def get_top_level_flow_path(self) -> str:
        return f"{NINJA_FLOWS_PATH}/vivado_conformal.py"
