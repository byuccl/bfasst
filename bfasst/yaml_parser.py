"""Parse a yaml file to obtain a flow and a list of target designs"""
# pylint: disable=duplicate-code
from abc import ABC
from pathlib import Path
import yaml

from bfasst.utils import error
from bfasst import paths


class YamlParser(ABC):
    def __init__(self, yaml_path):
        self.yaml_path = yaml_path

        # Read the yaml file
        with open(yaml_path) as f:
            self.props = yaml.safe_load(f)


class RunParser(YamlParser):
    """Parses a yaml file to obtain a flow and list of target designs"""

    def __init__(self, yaml_path):
        super().__init__(yaml_path)
        self.post_run = None
        self.design_paths = []
        self.flow = None
        self.flow_arguments = {}
        self.flow_args = {}

        # Verify required fields are present
        assert "flow" in self.props, f"Experiment {self.yaml_path} does not specify a flow"
        self.flow = self.props["flow"]
        self.props.pop("flow")

        # Check for optional fields that aren't passed to the flow
        if "post_run" in self.props:
            self.post_run = getattr(self, self.props("post_run"))
            self.props.pop("post_run")

        # Collect the design paths
        self._collect_design_paths()
        self._uniquify_design_paths()

        self._get_flow_args()

        # Anything remaining will be passed to the flow
        self.flow_arguments = self.props

    def _collect_design_paths(self):
        """Get all designs from the config yaml"""

        if "designs" in self.props:
            for design in self.props.pop("designs"):
                design_path = paths.DESIGNS_PATH / design
                if not design_path.is_dir():
                    error("Provided design directory", design_path, "does not exist")

                # Check if provided directory contains a design
                if (design_path / "design.yaml").is_file():
                    self.design_paths.append(str(design))
                    continue

                # This handles the case of passing a directory containing multiple designs in yaml
                # with the designs key rather than design_dirs key,
                # as seen in most of the CI checks:
                # designs:
                #   - byu/
                #   - ooc/
                for design_child in design_path.rglob("*"):
                    if not design_child.is_dir():
                        continue

                    # For each child design (eg. designs/byu/alu),
                    # we only want the last two parts (byu/alu part)
                    if (design_child / "design.yaml").is_file():
                        design_name = Path(*design_child.parts[-2:])
                        self.design_paths.append(str(design_name))
                        continue

        if "design_dirs" in self.props:
            for design_dir in self.props.pop("design_dirs"):
                design_dir_path = paths.DESIGNS_PATH / design_dir
                if not design_dir_path.is_dir():
                    error(f"{design_dir_path} is not a directory")

                for dir_item in design_dir_path.iterdir():
                    item_path = design_dir_path / dir_item
                    if item_path.is_dir():
                        self.design_paths.append(dir_item.name)

    def _uniquify_design_paths(self):
        self.design_paths = list(set(self.design_paths))
        self.design_paths.sort()

    def _get_flow_args(self):
        if "synth" in self.props:
            synth_args = self.props["synth"]
            self.flow_args.update({"synth": synth_args})
            self.props.pop("synth")
        else:
            synth_args = ""
        self.flow_args.update({"synth": synth_args})


class DesignParser(YamlParser):
    """Parses a design yaml file"""

    def __init__(self, yaml_path):
        super().__init__(yaml_path)

        # Get top module name
        if "top" not in self.props:
            error(f"Design {self.yaml_path} does not specify a top module")
        self.top = self.props["top"]

        # Parse VHDL libraries
        self.vhdl_libs = None
        if "vhdl_libs" in self.props:
            self.vhdl_libs = self.props["vhdl_libs"]
