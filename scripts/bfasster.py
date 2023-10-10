"""Script to run a flow on one or more designs."""
import argparse
import pathlib
import subprocess

from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager
from bfasst.utils.general import clean_error_injections_and_comparisons
from bfasst.yaml_parser import YamlParser
from bfasst.utils import error, ensure_tuple
from bfasst.paths import ROOT_PATH


class ApplicationRunner:
    """Runs a given flow on one or more designs using Ninja."""

    def __init__(self):
        self.designs = None
        self.flow = None
        self.deps = None
        self.flow_args = None

    def run_designs(self, flow, designs):
        """Run one ore more designs with a given flow."""
        self.designs = ensure_tuple(designs)
        self.flow = flow
        self.flow_args = {}
        self.__run_ninja()

    def run_yaml(self, yaml_path):
        """Run using a yaml configuration file"""

        yaml_parser = YamlParser(yaml_path)
        yaml_parser.parse_design_flow()

        self.designs = yaml_parser.design_paths
        self.flow = yaml_parser.flow
        self.flow_args = yaml_parser.flow_args
        self.__run_ninja()

    def __run_ninja(self):
        # create a flow manager to handle the build.ninja file creation and update by flows
        flow_manager = NinjaFlowManager()
        flow_manager.create_flows(self.flow, self.designs, self.flow_args)
        flow_manager.run_flows()

        # run the build.ninja file
        cmd = ["ninja"]
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH)
        proc.communicate()
        return_code = proc.wait()

        # for the error injector flow, print the list of failed comparisons
        if self.flow == "vivado_structural_error_injection":
            clean_error_injections_and_comparisons(self.designs)

        if return_code != 0:
            error("Ninja failed with return code", return_code)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--yaml", type=pathlib.Path, help="Yaml file with flow specs")
    parser.add_argument(
        "--design", type=pathlib.Path, help="Design directory for single design flows"
    )
    parser.add_argument("--flow", type=str, help="Flow to run for single design flows")
    args = parser.parse_args()

    if args.yaml and (args.design or args.flow):
        parser.error("Cannot specify both a yaml file and a design/flow")
    elif not args.yaml and not (args.design and args.flow):
        parser.error("Must specify either a yaml file or a design/flow")

    if args.yaml:
        ApplicationRunner().run_yaml(args.yaml)
    else:
        ApplicationRunner().run_designs(args.flow, args.design)
