""" Track a BFASST experiment configuration (flow with multiple designs)"""

import datetime
import pathlib

import yaml

from bfasst import paths
from bfasst.design import Design
from bfasst.flows_legacy.flow import get_flow
from bfasst.types import ToolType
from bfasst.utils import error


class Experiment:
    """Tracks a single experiment (flow with multiple designs)"""

    def __init__(self, yaml_path, work_dir=None):
        self.yaml_path = yaml_path
        self.experiment_props = None
        self.__read_experiment_yaml()

        self.__check_experiment_props_for_flow()

        self.post_run = None
        self.__check_for_post_run()

        self.work_dir = None
        self.name = yaml_path.stem
        self.__create_work_dir(work_dir)

        self.design_paths = []
        self.__collect_design_paths()

        self.__uniquify_design_paths()

        self.designs = []
        self.__create_design_objects()

        self.flow_args = {k: "" for k in ToolType}
        self.__read_tool_types()

        self.flows = []  # One top level flow per design, many flows per experiment
        self.__create_flows()

    def __read_experiment_yaml(self):
        with open(self.yaml_path) as fp:
            self.experiment_props = yaml.safe_load(fp)

    def __check_experiment_props_for_flow(self):
        if "flow" not in self.experiment_props:
            error(f"Experiment {self.yaml_path} does not specify a flow")

    def __collect_design_paths(self):
        """Get all designs from the config yaml"""

        if "designs" in self.experiment_props:
            for design in self.experiment_props.pop("designs"):
                design_path = paths.DESIGNS_PATH / design
                if not design_path.is_dir():
                    error("Provided design directory", design_path, "does not exist")

                # Check if provided directory contains a design
                if (design_path / "design.yaml").is_file():
                    self.design_paths.append(str(design_path))
                    continue

                for design_child in design_path.rglob("*"):
                    if not design_child.is_dir():
                        continue

                    if (design_child / "design.yaml").is_file():
                        self.design_paths.append(str(design_child))
                        continue

        if "design_dirs" in self.experiment_props:
            for design_dir in self.experiment_props.pop("design_dirs"):
                design_dir_path = paths.DESIGNS_PATH / design_dir
                if not design_dir_path.is_dir():
                    error(f"{design_dir_path} is not a directory")

                for dir_item in design_dir_path.iterdir():
                    item_path = design_dir_path / dir_item
                    if item_path.is_dir():
                        self.design_paths.append(str(pathlib.Path(design_dir) / dir_item.name))

    def __check_for_post_run(self):
        if "post_run" in self.experiment_props:
            self.post_run = getattr(self, self.experiment_props.pop("post_run"))

    def __create_work_dir(self, work_dir):
        if work_dir is None:
            work_dir = pathlib.Path.cwd() / "build" / self.name
        work_dir.mkdir(exist_ok=True, parents=True)
        self.work_dir = work_dir

    def __uniquify_design_paths(self):
        self.design_paths = list(set(self.design_paths))
        self.design_paths.sort()

    def __create_design_objects(self):
        for design_path in self.design_paths:
            design = Design(paths.DESIGNS_PATH / design_path, self.work_dir)
            self.designs.append(design)

    def __read_tool_types(self):
        for key, val in self.experiment_props.items():
            try:
                key = ToolType[key.upper()]
                self.flow_args[key] = val
            except KeyError:
                continue

    def __create_flows(self):
        for design in self.designs:
            self.__add_error_flow_to_design(design)

            # Create the top level flow for the design
            flow = get_flow(self.experiment_props["flow"])(design, self.flow_args)
            self.flows.append(flow)

    def __add_error_flow_to_design(self, design):
        if "error_flow" in self.experiment_props:
            design.error_flow_yaml = self.experiment_props.pop("error_flow") + ".yaml"

    def get_length_of_longest_design_name(self):
        return max(len(str(design.rel_path)) for design in self.designs)

    def init_design_start_times(self, running_list):
        for design in self.designs:
            running_list[design.rel_path] = datetime.datetime.now()
