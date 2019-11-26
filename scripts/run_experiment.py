import argparse
import glob
import sys
import pathlib

import bfasst


def main():
    parser = argparse.ArgumentParser()

    # Find all experiments in the experiments/ directory
    experiments = []
    for dir_item in bfasst.EXPERIMENTS_PATH.glob('*'):
        if (bfasst.EXPERIMENTS_PATH / dir_item).is_file() and dir_item.suffix == ".yaml":
            experiments.append(dir_item.stem)

    # Set up command line arguments
    parser.add_argument("experiment_name", choices=experiments,
                        help="Name of folder in experiments directory (with experiment.yaml file).")
    parser.add_argument("--force", action='store_true')
    args = parser.parse_args()

    # Build experiment object
    experiment = bfasst.experiment.Experiment(args.experiment_name)

    # Create temp folder
    build_dir = pathlib.Path.cwd() / "build" / args.experiment_name
    if not build_dir.is_dir():
        build_dir.mkdir(parents = True)
    elif not args.force:
        bfasst.utils.error("Build directory", build_dir, "already exists.  Use --force to overwrite")
    else:
        pass

    # For each design
    ljust = experiment.get_longest_design_name() + 5

    for design in experiment.designs:

        # Create a per-design build directory
        design_dir = build_dir / design.top
        try:
            design_dir.mkdir()
        except FileExistsError:
            pass


        sys.stdout.write(design.design_dir.ljust(ljust))
        sys.stdout.flush()
        
        # Run the design
        status = experiment.flow_fcn(design, design_dir)
        sys.stdout.write(str(status))
        sys.stdout.write("\n")


if __name__ == "__main__":
    main()
