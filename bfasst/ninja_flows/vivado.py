"""Flow to create Vivado synthesis and implementation ninja snippets."""
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.vivado.impl.vivado_impl import VivadoImpl
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_tools.vivado.synth.vivado_synth import VivadoSynth
from bfasst.utils.general import ensure


class Vivado(Flow):
    """Flow to create Vivado synthesis and implementation ninja snippets."""

    def __init__(self, design, flow_args=None, ooc=False):
        super().__init__(design)
        self.ooc = ooc
        self.vivado_synth_tool = VivadoSynth(design, ensure(flow_args, {}).get("synth"), ooc)
        self.vivado_impl_tool = VivadoImpl(design, ooc)

    def create_rule_snippets(self):
        self.vivado_synth_tool.create_rule_snippets()
        self.vivado_impl_tool.create_rule_snippets()

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()

    def add_ninja_deps(self, deps):
        self.vivado_synth_tool.add_ninja_deps(deps)
        self.vivado_impl_tool.add_ninja_deps(deps)
        deps.append(NINJA_FLOWS_PATH / "vivado.py")
        if self.ooc:
            deps.append(NINJA_FLOWS_PATH / "vivado_ooc.py")

    def get_top_level_flow_path(self):
        return NINJA_FLOWS_PATH / "vivado.py"
