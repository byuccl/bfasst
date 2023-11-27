"""Script to run a flow on one or more designs."""
import argparse
import ast
import pathlib
import subprocess
import sys

from bfasst.ninja_flows.flow_utils import get_flows
from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager
from bfasst.yaml_parser import RunParser
from bfasst.utils import error, ensure_tuple
from bfasst.paths import ROOT_PATH


class ApplicationRunner:
    """Runs a given flow on one or more designs using Ninja."""

    def __init__(self):
        self.designs = None
        self.flow = None
        self.deps = None
        self.flow_args = None
        self.flow_arguments = None

    def run_flow(self, flow, designs, flow_arguments):
        """Run one ore more designs with a given flow."""
        self.designs = ensure_tuple(designs)
        self.flow = flow
        self.flow_args = {}
        if flow_arguments:
            self.flow_arguments = ast.literal_eval(flow_arguments)
        self.__run_ninja()

    def run_yaml(self, yaml_path):
        """Run using a yaml configuration file"""

        run_config = RunParser(yaml_path)

        self.designs = run_config.design_paths
        self.flow = run_config.flow
        self.flow_args = run_config.flow_args
        self.flow_arguments = run_config.flow_arguments
        self.__run_ninja()

    def __run_ninja(self):
        # create a flow manager to handle the build.ninja file creation and update by flows
        flow_manager = NinjaFlowManager()
        flow_manager.create_flows(self.flow, self.designs, self.flow_args, self.flow_arguments)
        flow_manager.run_flows()

        # run the build.ninja file
        cmd = ["ninja"]
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH)
        proc.communicate()
        return_code = proc.wait()

        # for the error injector flow, print the list of failed comparisons
        flow_manager.run_complete()

        if return_code != 0:
            error("Ninja failed with return code", return_code)


def parse_args(args):
    """Parse main arguments"""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "flow_name_or_yaml_path", type=str, help="Flow name or yaml file with flow specs"
    )
    parser.add_argument(
        "design", type=pathlib.Path, help="Design directory (one or more)", nargs="*"
    )
    parser.add_argument("--flow_args", type=str, help="Additional cmd line arguments for the flow")
    parser.add_argument(
        "--flow_arguments",
        type=str,
        help="Arguments passed to the flow constructor, in the form of a dictionary",
    )
    args = parser.parse_args(args)

    if args.flow_name_or_yaml_path in get_flows():
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
                f"or a flow name. Valid flow names: {get_flows()}"
            )
        )

    return args


if __name__ == "__main__":
    parsed_args = parse_args(sys.argv[1:])

    if hasattr(parsed_args, "flow"):
        ApplicationRunner().run_flow(
            parsed_args.flow, parsed_args.design, parsed_args.flow_arguments
        )
    else:
        ApplicationRunner().run_yaml(parsed_args.yaml)
