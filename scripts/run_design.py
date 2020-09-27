#!/usr/bin/python3

import argparse
import glob
import pathlib

import bfasst
from bfasst import paths, flows


def main():
    parser = argparse.ArgumentParser()

    # designs = []
    # for directory in bfasst.EXAMPLES_PATH.rglob("*"):
    #     if (directory / "design.yaml").is_file():
    #         designs.append(str(directory.relative_to(bfasst.EXAMPLES_PATH)))

    parser.add_argument("design_path", help="Path to design in examples directory.")
    parser.add_argument("flow", choices=[e.value for e in flows.Flows])
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
    args = parser.parse_args()

    design_path = pathlib.Path(args.design_path)
    if not design_path.is_dir() and (paths.examples_path / design_path).is_dir():
        design_path = paths.examples_path / design_path
    design_path = design_path.absolute()

    # Load the design
    design = bfasst.design.Design(design_path)

    # Create temp folder
    build_dir = (
        pathlib.Path.cwd() / "build" / args.flow / (design_path.relative_to(paths.EXAMPLES_PATH))
    )
    build_dir.mkdir(parents=True, exist_ok=True)

    # Store the error flow for later
    if args.error_flow:
        design.error_flow_yaml = args.error_flow + ".yaml"

    # Get the flow object
    for flow_itr in flows.Flows:
        if args.flow == flow_itr.value:
            flow = flow_itr
            break

    # Run the design
    # status = bfasst.flow.run_flow(design, bfasst.flow.Flows.IC2_LSE_CONFORMAL, build_dir)
    status = flows.run_flow(design, flow, build_dir, print_to_stdout=not args.quiet)

    print(status)


if __name__ == "__main__":
    main()
