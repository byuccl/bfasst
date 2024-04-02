"""Manage creating rule and build snippets for a given tool."""

import abc
import pathlib

import chevron
from bfasst.flows.flow import FlowBase

from bfasst.paths import BUILD_PATH, DESIGNS_PATH, NINJA_BUILD_PATH
from bfasst.yaml_parser import DesignParser


class ToolBase(abc.ABC):
    """Base Tool class"""

    def __init__(self, flow):
        self.flow = flow
        if flow:
            assert isinstance(flow, FlowBase), "Flow must be a FlowBase object"
            self.flow.tools.append(self)

        self.build_path = None
        self.outputs = {}

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
    def _init_outputs(self):
        """Fill the self.outputs dictionary that lists
        all files the tool is responsible for creating"""

    def _append_rule_snippets_default(self, py_tool_path, render_dict=None, rules_path=None):
        """Create the rule snippets for a python tool,
        assuming default filenames are used
        """

        py_tool_path = pathlib.Path(py_tool_path)

        if rules_path is None:
            if render_dict:
                rules_path = py_tool_path.parent / (py_tool_path.stem + "_rules.ninja.mustache")
            else:
                rules_path = py_tool_path.parent / (py_tool_path.stem + "_rules.ninja")

        if rules_path in self.flow.rule_paths:
            return

        self.flow.rule_paths.append(rules_path)

        with open(rules_path, "r") as f:
            if render_dict:
                rules = chevron.render(f, render_dict)
            else:
                rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def _append_build_snippets_default(self, py_tool_path, render_dict):
        """Create the build snippets for a python tool,
        assuming default filenames are used"""
        py_tool_path = pathlib.Path(py_tool_path)

        build_snippet_path = py_tool_path.parent / (py_tool_path.stem + "_build.ninja.mustache")
        assert (
            build_snippet_path.is_file()
        ), f"Build snippet template {build_snippet_path} does not exist"

        with open(build_snippet_path) as f:
            build_snippet = chevron.render(f, render_dict)

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build_snippet)

    def _add_ninja_deps_default(self, deps, py_tool_path):
        """Add default ninja filenames as dependencies"""
        py_tool_path = pathlib.Path(py_tool_path)

        # Possible deps
        possible_deps = []
        possible_deps.append(py_tool_path.parent / (py_tool_path.stem + "_rules.ninja"))
        possible_deps.append(py_tool_path.parent / (py_tool_path.stem + "_rules.ninja.mustache"))
        possible_deps.append(py_tool_path.parent / (py_tool_path.stem + "_build.ninja.mustache"))

        for dep in possible_deps:
            if dep.is_file():
                deps.append(dep)
        deps.append(py_tool_path)


class Tool(ToolBase, abc.ABC):
    """Base class for tools that operate on a design"""

    def __init__(self, flow, design_path) -> None:
        super().__init__(flow)
        self.design_path = design_path

        if design_path.is_relative_to(DESIGNS_PATH):
            self.design_build_path = BUILD_PATH / design_path.relative_to(DESIGNS_PATH)
        else:
            self.design_build_path = BUILD_PATH / "<external>" / design_path

        design_yaml = design_path / "design.yaml"
        self.design_props = None
        if design_yaml.is_file():
            self.design_props = DesignParser(design_yaml)
