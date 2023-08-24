"""Manage creating rule and build snippets for a given tool."""

import abc

from bfasst.paths import DESIGNS_PATH


class Tool(abc.ABC):
    """Manage creating rule and build snippets"""

    def __init__(self, design):
        self.design = DESIGNS_PATH / design

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
