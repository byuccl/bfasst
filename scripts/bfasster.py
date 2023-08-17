"""Script to run a flow on one or more designs."""
from argparse import ArgumentParser
import pathlib
import subprocess
from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager
from bfasst.yaml_parser import YamlParser
from bfasst.utils import error
from bfasst.paths import ROOT_PATH


class ApplicationRunner:
    """Runs a given flow on one or more designs using Ninja."""

    def __init__(self):
        self.designs = None
        self.flow = None
        self.deps = None
        self.flow_args = None

    def run(self, args):
        """Run a flow on one or more designs."""

        # save the flow and design paths
        self.__parse_args(args)

        # create a flow manager to handle the build.ninja file creation and update by flows
        flow_manager = NinjaFlowManager()
        flow_manager.create_flows(self.flow, self.designs, self.flow_args)
        flow_manager.run_flows()

        # run the build.ninja file
        self.__run_ninja()

        # for the error injector flow, print the list of failed comparisons
        if self.flow == "vivado_structural_error_injection":
            self.__print_failed_comparisons()

    def __parse_args(self, args):
        if args.yaml:
            yaml_parser = YamlParser(args.yaml)
            yaml_parser.parse_design_flow()
            self.designs = yaml_parser.design_paths
            self.flow = yaml_parser.flow
            self.flow_args = yaml_parser.flow_args
        else:
            self.flow = args.flow
            self.designs = [args.design]

    def __run_ninja(self):
        cmd = ["ninja"]
        proc = subprocess.Popen(cmd, cwd=ROOT_PATH)
        proc.communicate()
        proc.wait()

    def __print_failed_comparisons(self):
        """Used to print which structural comparisons incorrectly
        passed in the error injection flow"""

        print("\nError injections not caught: ")
        fail_list = []

        for design in self.designs:
            cmp_dir = ROOT_PATH / "build" / design / "struct_cmp"
            for file in cmp_dir.iterdir():
                with open(file, "r") as f:
                    if "SUCCESS" in f.read():
                        fail_list.append(file.name.split("_cmp.log")[0])

        if fail_list:
            print("\n".join(fail_list))
        else:
            print("None")


def check_args(args):
    if args.yaml and (args.design or args.flow):
        error("Cannot specify both a yaml file and a design/flow")
    elif not args.yaml and not (args.design and args.flow):
        error("Must specify either a yaml file or a design/flow")


if __name__ == "__main__":
    arg_parser = ArgumentParser()
    arg_parser.add_argument("--yaml", type=pathlib.Path, help="Yaml file with flow specs")
    arg_parser.add_argument("--design", type=str, help="Design directory for single design flows")
    arg_parser.add_argument("--flow", type=str, help="Flow to run for single design flows")
    runner_args = arg_parser.parse_args()

    check_args(runner_args)
    ApplicationRunner().run(runner_args)
