#!/usr/bin/python3
from argparse import ArgumentParser, Action
from pathlib import Path

from bfasst.design import Design
from bfasst import paths
from bfasst.flows import Flows, run_flow, FlowArgs


def main(design_path, flow, error_flow, flow_args):
    # Load the design
    design = Design(design_path)

    # Create temp folder
    build_dir = (
        Path.cwd() / "build" / flow / (design_path.relative_to(paths.EXAMPLES_PATH))
    )
    build_dir.mkdir(parents=True, exist_ok=True)

    # Store the error flow for later
    if error_flow:
        design.error_flow_yaml = error_flow + ".yaml"

    # Get the flow object
    flow = Flows(flow)

    # Run the design
    status = run_flow(design, flow, flow_args, build_dir)

    print(status)


class SetFlowArgs(Action):
    """
    Make argparse automatically set flow_args dictionary variables.
    """
    def __init__(self, option_strings, dest, nargs=None, **kwargs):
        if nargs is not None:
            raise ValueError("nargs not allowed")
        super().__init__(option_strings, dest, **kwargs)
    def __call__(self, parser, namespace, values, option_string=None):
        key = FlowArgs[option_string[2:].upper()]
        getattr(namespace, self.dest)[key] = values

class Args:
    def __init__(self):
        # Set default values for flow_args here
        self.flow_args = {k: "" for k in FlowArgs}

if __name__ == "__main__":
    parser = ArgumentParser()

    # designs = []
    # for directory in bfasst.EXAMPLES_PATH.rglob("*"):
    #     if (directory / "design.yaml").is_file():
    #         designs.append(str(directory.relative_to(bfasst.EXAMPLES_PATH)))

    parser.add_argument("design_path", help="Path to design in examples directory.")
    parser.add_argument("flow", choices=[e.value for e in Flows])
    parser.add_argument("--synth", help="Arguments for synthesis", 
                        action=SetFlowArgs, dest="flow_args")
    parser.add_argument("--impl", help="Arguments for implementation", 
                        action=SetFlowArgs, dest="flow_args")
    parser.add_argument("--map", help="Arguments for mapping", 
                        action=SetFlowArgs, dest="flow_args")
    parser.add_argument("--cmp", help="Arguments for comparison", 
                        action=SetFlowArgs, dest="flow_args")
    parser.add_argument("--err", help="Arguements for error flow", 
                        action=SetFlowArgs, dest="flow_args")    
    parser.add_argument("--quiet", action="store_true")

    error_flows = []
    for dir_item in paths.ERROR_FLOW_PATH.iterdir():
        if (paths.EXPERIMENTS_PATH / dir_item).is_file() and dir_item.suffix == ".yaml":
            error_flows.append(dir_item.stem)
    parser.add_argument(
        "--error_flow",
        choices=error_flows,
        help="YAML file describing errors to inject for testing. Only works with flows designed for error injection",
    )
    args = Args()
    parser.parse_args(namespace=args)

    design_path = Path(args.design_path)
    if not design_path.is_dir() and (paths.EXAMPLES_PATH / design_path).is_dir():
        design_path = paths.EXAMPLES_PATH / design_path
    design_path = design_path.absolute()
    
    main(design_path, args.flow, args.error_flow, args.flow_args)