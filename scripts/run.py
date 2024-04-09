"""Script to run a flow on one or more designs."""

import argparse
import ast
import pathlib
import subprocess
import sys

from bfasst import external_tools
from bfasst.flows.ninja_flow_manager import NinjaFlowManager
from bfasst.yaml_parser import FlowDescriptionParser, RunParser
from bfasst.utils import error, ensure_tuple
from bfasst.paths import ROOT_PATH


class ApplicationRunner:
    """Runs a given flow on one or more designs using Ninja."""

    def __init__(self):
        self.designs = None
        self.flow = None
        self.deps = None
        self.flow_arguments = None
        self.ninja_mode = None

    def run_flow(self, flow, designs, flow_arguments, check_tools, ninja_mode):
        """Run one ore more designs with a given flow."""
        self.designs = ensure_tuple(designs)
        self.flow = flow
        self.ninja_mode = ninja_mode
        if check_tools:
            success = external_tools.check_flow(self.flow)
            if not success:
                error("External tools check failed")
        if flow_arguments:
            self.flow_arguments = ast.literal_eval(flow_arguments)
        self.__run_ninja()

    def run_yaml(self, yaml_path, check_tools, ninja_mode):
        """Run using a yaml configuration file"""

        run_config = RunParser(yaml_path)

        self.designs = run_config.design_paths
        self.flow = run_config.flow
        self.flow_arguments = run_config.flow_arguments
        self.ninja_mode = ninja_mode 
        if check_tools:
            success = external_tools.check_flow(self.flow)
            if not success:
                error("External tools check failed")
        self.__run_ninja()

    def __run_ninja(self):
        # create a flow manager to handle the build.ninja file creation and update by flows
        flow_manager = NinjaFlowManager()
        flow_manager.create_flows(self.flow, self.designs, self.flow_arguments)
        flow_manager.run_flows()

        # run the build.ninja file
        cmd = ["ninja"]
        if self.ninja_mode == "serial":
            print("serial mode")
            cmd.append("-j")
            cmd.append("1")

        proc = subprocess.Popen(cmd, cwd=ROOT_PATH)
        proc.communicate()
        return_code = proc.wait()

        # for the error injector flow, print the list of failed comparisons
        flow_manager.run_complete()

        if return_code != 0:
            error("Ninja failed with return code", return_code)


def get_flow_choices() -> list[str]:
    """Get a list of formatted flow choices"""
    return [
        f"  {flow_name:<35}{flow_description}"
        for flow_name, flow_description in FlowDescriptionParser().get_flow_names_and_descriptions()
    ]


def parse_args(args):
    """Parse main arguments"""
    flow_choices: str = "\n".join(get_flow_choices())
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "flow_name_or_yaml_path", type=str, help="Flow name or yaml file with flow specs"
    )
    parser.add_argument(
        "design", type=pathlib.Path, help="Design directory (one or more)", nargs="*"
    )
    parser.add_argument(
        "--flow_arguments",
        type=str,
        help="Arguments passed to the flow constructor, in the form of a dictionary",
    )
    parser.add_argument("--no_tool_checks", action="store_true", help="Skip tool checks")
    parser.add_argument(
        "--ninja_mode",
        type=str,
        choices=["serial", "parallel"],
        default="parallel",
        help="Run ninja in serial or parallel mode",
    )

    # try to parse the arguments, and if none are provided, print the flow choices
    try:
        args = parser.parse_args(args)
    except SystemExit as e:
        if e.code == 2:
            print(f"Valid flow names:\n{flow_choices}")
            sys.exit(2)
        else:
            raise e

    flows_list = FlowDescriptionParser().get_flow_names()

    if args.flow_name_or_yaml_path in flows_list:
        args.flow = args.flow_name_or_yaml_path
    elif pathlib.Path(args.flow_name_or_yaml_path).is_file():
        args.yaml = pathlib.Path(args.flow_name_or_yaml_path)
        assert not args.flow_arguments, (
            "Cannot specify flow arguments when using a yaml file. "
            "Specify them in the yaml file instead."
        )
    else:
        parser.error(
            (
                f"First argument ({args.flow_name_or_yaml_path}) must specify either a yaml file "
                f"or a flow name.\nValid flow names:\n"
                f"{flow_choices}"
            )
        )

    return args


if __name__ == "__main__":
    parsed_args = parse_args(sys.argv[1:])

    if hasattr(parsed_args, "flow"):
        ApplicationRunner().run_flow(
            parsed_args.flow,
            parsed_args.design,
            parsed_args.flow_arguments,
            check_tools=not parsed_args.no_tool_checks,
            ninja_mode=parsed_args.ninja_mode,
        )
    else:
        ApplicationRunner().run_yaml(
            parsed_args.yaml,
            check_tools=parsed_args.no_tool_checks,
            ninja_mode=parsed_args.ninja_mode,
        )
