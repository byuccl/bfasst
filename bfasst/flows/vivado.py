"""Flow to create Vivado synthesis and implementation ninja snippets."""

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, ooc=False):
        super().__init__(design)
        self.ooc = ooc
        self.vivado_synth_tool = VivadoSynth(self, design, ooc)
        self.vivado_impl_tool = VivadoImpl(
            self, design, prev_tool_outputs=self.vivado_synth_tool.outputs, ooc=ooc
        )

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        deps.append(FLOWS_PATH / "vivado.py")
        if self.ooc:
            deps.append(FLOWS_PATH / "vivado_ooc.py")

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado.py"
