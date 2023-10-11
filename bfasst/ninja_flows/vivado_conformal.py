"""Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.conformal.conformal import Conformal
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.types import Vendor


class VivadoConformal(Flow):
    """Run vivado, phys_netlist, reverse with xray, then compare with conformal."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.xrev_tool = Xray(design)
        self.conformal_tool = Conformal(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.conformal_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_tool.outputs["bitstream"]))
        self.conformal_tool.create_build_snippets(
            impl_netlist=str(self.vivado_tool.outputs["impl_verilog"]),
            rev_netlist=str(self.xrev_tool.outputs["xray_netlist"]),
            vendor=Vendor.XILINX,
        )

    def add_ninja_deps(self, deps):
        self.vivado_tool.add_ninja_deps(deps)
        self.xrev_tool.add_ninja_deps(deps)
        self.conformal_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_conformal.py")

    def get_top_level_flow_path(self) -> str:
        return f"{NINJA_FLOWS_PATH}/vivado_conformal.py"
