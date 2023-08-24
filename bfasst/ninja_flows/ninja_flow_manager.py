"""Utility to manage the creation and execution of ninja flows."""
from argparse import ArgumentParser
import json
import chevron
from bfasst.ninja_flows.flow_utils import create_build_file, get_flow
from bfasst.paths import DESIGNS_PATH, NINJA_BUILD_PATH, NINJA_FLOWS_PATH, ROOT_PATH


class NinjaFlowManager:
    """Utility to manage the creation and execution of ninja flows."""

    def __init__(self):
        self.flows = None
        self.designs = None
        self.flow_name = None
        self.flow_args = None

    def create_flows(self, flow_name, designs, flow_args=None):
        """Create the ninja flows for the given designs."""
        self.flow_name = flow_name
        self.flows = []
        self.designs = designs
        self.flow_args = flow_args
        for design in designs:
            flow = get_flow(flow_name)(design, flow_args)
            self.flows.append(flow)

    def run_flows(self):
        """Run the ninja flows"""
        create_build_file()
        self.__create_master_ninja()

        # Get the rules from the first flow
        self.flows[0].create_rule_snippets()

        for flow in self.flows:
            flow.create_build_snippets()

    def __create_master_ninja(self):
        master_ninja = self.__populate_template()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(master_ninja)

    def __populate_template(self):
        self.__get_absolute_design_paths()
        with open(ROOT_PATH / "master.ninja.mustache", "r") as f:
            master_ninja = chevron.render(
                f,
                {
                    "ninja_flows_path": str(NINJA_FLOWS_PATH),
                    "designs": self.designs,
                    "deps": self.flows[0].add_ninja_deps(),
                    "flow": self.flow_name,
                    "flow_args": self.flow_args,
                },
            )

        return master_ninja

    def __get_absolute_design_paths(self):
        self.designs = [str(DESIGNS_PATH / design) for design in self.designs]


def get_design_basenames(designs):
    return [("/").join(design.split("/")[-2:]) for design in designs]


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--flow", type=str, required=True, help="Name of the flow to run")
    parser.add_argument("--flow_args", type=str, help="Additional cmd line arguments for the flow")
    parser.add_argument("--designs", required=True, nargs="+", help="Designs to run the flow on")
    parsed_args = parser.parse_args()

    # convert the flow args from string to dict, but replace ' with "
    # so that json can read the string
    if parsed_args.flow_args:
        FLOW_ARGS_DICT = json.loads(parsed_args.flow_args.replace("'", '"'))
    else:
        FLOW_ARGS_DICT = None

    flow_manager = NinjaFlowManager()
    flow_manager.create_flows(
        parsed_args.flow, get_design_basenames(parsed_args.designs), FLOW_ARGS_DICT
    )
    flow_manager.run_flows()
