""" Run a design through a given flow """

from argparse import ArgumentParser
from collections import defaultdict
from pathlib import Path
import time
import traceback

from bfasst.design import Design
from bfasst import paths
from bfasst.flows_legacy.flow import get_flow, get_flows
from bfasst.tool import BfasstException
from bfasst.types import ToolType


def run_design(design_path, flow, error_flow, flow_args):
    """Run a design through a given flow"""

    # Create temp folder
    build_dir = Path.cwd() / "build" / flow
    build_dir.mkdir(parents=True, exist_ok=True)

    # Load the design
    design = Design(design_path, build_dir)

    # Store the error flow for later
    if error_flow:
        design.error_flow_yaml = error_flow + ".yaml"

    # Get the flow object
    flow = get_flow(flow)(design, flow_args)

    # Create the jobs
    jobs = flow.create()

    t_start = time.perf_counter()
    try:
        while jobs:
            for job in jobs:
                if not job.dependencies:
                    job.function()
                    cleanup(job, jobs)
        print("Success!")
    except BfasstException as e:
        print(e)
    except AssertionError:
        line = ""
        for line in reversed(traceback.format_exc().splitlines()):
            if line.strip().startswith("File"):
                break
        print(f"AssertionErrror: {line}")
    finally:
        t_end = time.perf_counter()

        runtime = t_end - t_start
        print(f"Execution took {round(runtime, 1)} seconds")


def cleanup(curr_job, jobs):
    jobs.remove(curr_job)
    for job in jobs:
        job.dependencies.discard(curr_job.uuid)


def main():
    """Parse argument and run design"""

    parser = ArgumentParser()

    parser.add_argument("design_path", help="Path to design in examples directory.")
    parser.add_argument("flow", choices=sorted(list(get_flows())))
    parser.add_argument("--synth", help="Synthesis args", type=str, default="")
    parser.add_argument("--impl", help="Implementation args", type=str, default="")
    parser.add_argument("--map", help="Mapping args", type=str, default="")
    parser.add_argument("--cmp", help="Comparison args", type=str, default="")
    parser.add_argument("--reverse", help="Reverse args", type=str, default="")
    parser.add_argument("--err", help="Error flow args", type=str, default="")
    parser.add_argument("--quiet", action="store_true")

    error_flows = []
    for dir_item in paths.ERROR_FLOW_PATH.iterdir():
        if (paths.TESTS_PATH / dir_item).is_file() and dir_item.suffix == ".yaml":
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
    for arg_name, enum in flow_args_map.items():
        flow_args[enum] = getattr(args, arg_name)

    run_design(Path(args.design_path), args.flow, args.error_flow, flow_args=flow_args)


if __name__ == "__main__":
    main()
