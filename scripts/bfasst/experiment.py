""" Track a BFASST experiment configuration (flow with multiple desings)"""

import pathlib

import yaml

from bfasst import paths
from bfasst.design import Design
from bfasst.flows import get_flow_fcn_by_name, ToolType
from bfasst.utils import error


class Experiment:
    """Tracks a single expermeint (flow with multiple designs)"""

    def __init__(self, yaml_path, work_dir=None):
        self.post_run = None
        self.yaml_path = yaml_path
        self.name = yaml_path.stem
        self.flow_args = {k: "" for k in ToolType}

        # Read experiment YAML
        with open(yaml_path) as fp:
            experiment_props = yaml.safe_load(fp)

        # Get the flow fcn pointer
        if not "flow" in experiment_props:
            error("'flow' property missing from experiment YAML", yaml_path)
        self.flow_fcn = get_flow_fcn_by_name(experiment_props.pop("flow"))

        # Create design objects for all designs
        self.design_paths = []
        self.collect_designs(experiment_props)

        if "post_run" in experiment_props:
            self.post_run = getattr(self, experiment_props.pop("post_run"))

        # Uniquify
        self.design_paths = list(set(self.design_paths))
        self.design_paths.sort()

        self.designs = []
        for design_path in self.design_paths:
            design = Design(paths.EXAMPLES_PATH / design_path)
            self.designs.append(design)

        for design in self.designs:
            if "error_flow" in experiment_props:
                design.error_flow_yaml = experiment_props.pop("error_flow") + ".yaml"

        for key, val in experiment_props.items():
            try:
                key = ToolType[key.upper()]
                self.flow_args[key] = val
            except KeyError:
                continue

        # Create temp folder
        if work_dir is None:
            work_dir = pathlib.Path.cwd() / "build" / self.name
        work_dir.mkdir(exist_ok=True, parents=True)
        self.work_dir = work_dir

    def collect_designs(self, experiment_props):
        """Get all designs from the config YAML"""

        if "designs" in experiment_props:
            for design in experiment_props.pop("designs"):
                d_path = paths.EXAMPLES_PATH / design
                if not d_path.is_dir():
                    error("Provided design directory", d_path, "does not exist")

                # Check if provided directory contains a design
                if (d_path / "design.yaml").is_file():
                    self.design_paths.append(d_path)
                    continue

                # Otherwise this is a directory of designs, and include them all
                for d_child in d_path.rglob("*"):
                    if not d_child.is_dir():
                        continue
                    if (d_child / "design.yaml").is_file():
                        self.design_paths.append(d_child)

        if "design_dirs" in experiment_props:
            for design_dir in experiment_props.pop("design_dirs"):
                design_dir_path = paths.EXAMPLES_PATH / design_dir
                if not design_dir_path.is_dir():
                    error(design_dir_path, "is not a directory")

                for dir_item in design_dir_path.iterdir():
                    item_path = design_dir_path / dir_item
                    if item_path.is_dir():
                        self.design_paths.append(pathlib.Path(design_dir) / dir_item.name)

    def get_longest_design_name(self):
        return max(len(str(d.rel_path)) for d in self.designs)

    # def export_to_onespin(self, build_dir):
    #     i = 0
    #     with zipfile.ZipFile(build_dir / "onespin.zip", "w") as z:
    #         onespin_bash_path = paths.ONESPIN_RESOURCES / "run_onespin.bash"
    #         z.write(onespin_bash_path, arcname=(onespin_bash_path.name))
    #         for p in self.design_paths:
    #             onespin_path = build_dir / p.name / OneSpin_CompareTool.TOOL_WORK_DIR
    #             if not onespin_path.is_dir():
    #                 continue

    #             i += 1
    #             for f in onespin_path.iterdir():
    #                 # print(f)
    #                 z.write(f, arcname=(p.name + "/" + f.name))
    #                 # This isn't fully recursive, and will only copy the 1st
    #                 #   subdirectory
    #                 if f.is_dir():
    #                     for sub_f in f.iterdir():
    #                         z.write(sub_f, arcname=(p.name + "/" + f.name + "/" + sub_f.name))

    #     print("onespin.zip created with", i, "designs")
