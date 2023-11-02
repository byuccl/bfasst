"""Base class for all ninja flows"""
import abc

from bfasst.ninja_tools.vivado.synth.vivado_synth import VivadoSynth
from bfasst.paths import BUILD_DIR, DESIGNS_PATH


class Flow(abc.ABC):
    """Base class for all ninja flows"""

    def __init__(self, design_path):
        self.design_path = design_path
        self.design_build_path = BUILD_DIR / design_path.relative_to(DESIGNS_PATH)

    @abc.abstractmethod
    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja"""

    @abc.abstractmethod
    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja"""

    @abc.abstractmethod
    def add_ninja_deps(self):
        """Add the template and flow paths of this flow
        and its sub-flows as dependencies of the build.ninja file"""

    @abc.abstractmethod
    def get_top_level_flow_path(self) -> str:
        """Get the path to the top level flow file for this flow"""

    def configure_vivado_synth_tool(self, design, flow_args, ooc=False):
        if isinstance(flow_args, dict) and "synth" in flow_args:
            return VivadoSynth(design, flow_args["synth"], ooc)
        return VivadoSynth(design, ooc=ooc)
