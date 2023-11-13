"""Flow to compare reversed netlist to original using yosys."""
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.compare.yosys.yosys import Yosys
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_flows.flow_utils import configure_vivado_synth_tool


class VivadoYosysImpl(Flow):
    """Flow to compare reversed netlist to original using yosys."""

    def __init__(self, design, flow_args=None):
        super().__init__(design)
        self.vivado_synth_tool = configure_vivado_synth_tool(design, flow_args)
        self.vivado_impl_tool = VivadoImpl(design)
        self.xrev_tool = Xray(design)
        self.yosys_tool = Yosys(design)

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()
        self.xrev_tool.create_rule_snippets()
        self.yosys_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets(str(self.vivado_impl_tool.outputs["bitstream"]))
        self.yosys_tool.create_build_snippets(
            gold_netlist=self.vivado_impl_tool.outputs["impl_verilog"],
            rev_netlist=self.xrev_tool.outputs["xray_netlist"],
        )

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        self.xrev_tool.add_ninja_deps(deps)
        self.yosys_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado_yosys_impl.py")

    def get_top_level_flow_path(self):
        return f"{NINJA_FLOWS_PATH}/vivado_yosys_impl.py"
