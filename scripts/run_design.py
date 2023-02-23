""" Run a design through a given flow """

from argparse import ArgumentParser
from collections import defaultdict
from pathlib import Path

from bfasst.design import Design
from bfasst import paths
from bfasst.flows import Flows, run_flow
from bfasst.tool_wrappers import ToolType


def run_design(design_path, flow, error_flow, flow_args):
    """Run a design through a given flow"""

    # Load the design
    design = Design(design_path)

    # Create temp folder
    build_dir = Path.cwd() / "build" / flow / (design_path.relative_to(paths.EXAMPLES_PATH))
    build_dir.mkdir(parents=True, exist_ok=True)

    # Store the error flow for later
    if error_flow:
        design.error_flow_yaml = error_flow + ".yaml"

    # Get the flow object
    flow = Flows(flow)

    # Run the design
    status = run_flow(design, flow, flow_args, build_dir)

    print(status)


def main():
    """Parse argument and run design"""

    parser = ArgumentParser()

    parser.add_argument("design_path", help="Path to design in examples directory.")
    parser.add_argument("flow", choices=[e.value for e in Flows])
    parser.add_argument("--synth", help="Synthesis args", nargs=1, type=str, default="")
    parser.add_argument("--impl", help="Implementation args", nargs=1, type=str, default="")
    parser.add_argument("--map", help="Mapping args", nargs=1, type=str, default="")
    parser.add_argument("--cmp", help="Comparison args", nargs=1, type=str, default="")
    parser.add_argument("--err", help="Error flow args", nargs=1, type=str, default="")
    parser.add_argument("--quiet", action="store_true")

    error_flows = []
    for dir_item in paths.ERROR_FLOW_PATH.iterdir():
        if (paths.EXPERIMENTS_PATH / dir_item).is_file() and dir_item.suffix == ".yaml":
            error_flows.append(dir_item.stem)
    parser.add_argument(
        "--error_flow",
        choices=error_flows,
        help=(
            "YAML file describing errors to inject for testing."
            "Only works with flows designed for error injection"
        ),
    )
    args = parser.parse_args()

    # Build per-tool arguments into flow_args dictionary
    flow_args = defaultdict(str)
    flow_args_map = {
        "synth": ToolType.SYNTH,
        "impl": ToolType.IMPL,
        "map": ToolType.MAP,
        "cmp": ToolType.CMP,
        "reverse": ToolType.REVERSE,
    }
    print(flow_args[ToolType.SYNTH])
    for arg_name, enum in flow_args_map.items():
        flow_args[enum] = getattr(args, arg_name)

    design_path = Path(args.design_path)
    if not design_path.is_dir() and (paths.EXAMPLES_PATH / design_path).is_dir():
        design_path = paths.EXAMPLES_PATH / design_path
    design_path = design_path.absolute()

    run_design(design_path, args.flow, args.error_flow, flow_args=flow_args)


if __name__ == "__main__":
    main()
