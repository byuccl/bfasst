"""Flow to compare reversed netlist to original using yosys."""
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.compare.yosys.yosys import Yosys
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.paths import NINJA_FLOWS_PATH


class VivadoYosysImpl(Flow):
    """Flow to compare reversed netlist to original using yosys."""

    def __init__(self, design, flow_args=None):
        super().__init__()
        self.vivado_tool = self.configure_vivado_tool(design, flow_args)
        self.xrev_tool = Xray(design)
        self.yosys_tool = Yosys(design)

    def create_rule_snippets(self):
        self.vivado_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.yosys_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_tool.outputs["bitstream"]))
        self.yosys_tool.create_build_snippets(
            gold_netlist=self.vivado_tool.outputs["impl_edf"],
            rev_netlist=self.xrev_tool.outputs["xray_netlist"],
        )

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.extend(self.xrev_tool.add_ninja_deps())
        deps.extend(self.yosys_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_yosys_impl.py")
        return deps

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_yosys_impl.py"
