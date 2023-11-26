"""Base class for all ninja flows"""
import abc

from bfasst.paths import BUILD_PATH, DESIGNS_PATH


class FlowBase(abc.ABC):
    """Base class for all ninja flows"""

    def __init__(self) -> None:
        super().__init__()

        # A list of tools used by this flow
        self.tools = []

        # A list of rule files already copied into the build.ninja file
        self.rule_paths = []

    def create_rule_snippets(self):
        """Create the rule snippets for the flow and append them to build.ninja"""
        for tool in self.tools:
            tool.create_rule_snippets()

    def create_build_snippets(self):
        """Create the build snippets for the flow and append them to build.ninja"""
        for tool in self.tools:
            tool.create_build_snippets()

    def add_ninja_deps(self, deps):
        """Add the template and flow paths of this flow
        and its sub-flows as dependencies of the build.ninja file"""
        for tool in self.tools:
            tool.add_ninja_deps(deps)
        deps.append(self.get_top_level_flow_path())

    @abc.abstractmethod
    def get_top_level_flow_path(self) -> str:
        """Get the path to the top level flow file for this flow"""

    def create_tool_build_dirs(self):
        """Create the build directories for all tools used by this flow"""
        for tool in self.tools:
            tool.build_path.mkdir(parents=True, exist_ok=True)

    def post_execute(self):
        """Perform any post-execution actions"""


class Flow(FlowBase):
    """Base class for all ninja flows that use a design as input.
    This is the common case.  Some flows, e.g. rand_soc, create their own designs."""

    def __init__(self, design_path):
        super().__init__()
        self.design_path = design_path
        self.design_build_path = BUILD_PATH / design_path.relative_to(DESIGNS_PATH)


class FlowNoDesign(FlowBase):
    """Base class for all ninja flows that do not use a design as input."""

    def __init__(self):
        super().__init__()
        # self.design_build_path = BUILD_DIR / self.flow_build_dir_name()

    @classmethod
    @abc.abstractmethod
    def flow_build_dir_name(cls) -> str:
        """Get the name of the build directory for this flow"""
        raise NotImplementedError
