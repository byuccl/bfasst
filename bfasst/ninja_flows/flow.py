"""Base class for all ninja flows"""
import abc

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
