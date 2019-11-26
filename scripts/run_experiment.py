import argparse
import os
import glob
import sys

import bfasst


def main():
    parser = argparse.ArgumentParser()

    # Find all experiments in the experiments/ directory
    experiments = []
    for dir_item in os.listdir(bfasst.EXPERIMENTS_PATH):
        if os.path.isfile(os.path.join(bfasst.EXPERIMENTS_PATH, dir_item)) and os.path.splitext(dir_item)[1] == ".yaml":
            experiments.append(os.path.splitext(dir_item)[0])

    # Set up command line arguments
    parser.add_argument("experiment_name", choices=experiments,
                        help="Name of folder in experiments directory (with experiment.yaml file).")
    parser.add_argument("--force", action='store_true')
    args = parser.parse_args()

    # Build experiment object
    experiment = bfasst.experiment.Experiment(args.experiment_name)

    # Create temp folder
    build_dir = os.path.join(os.getcwd(), "build", args.experiment_name)
    if not os.path.isdir(build_dir):
        os.makedirs(build_dir)
    elif not args.force:
        bfasst.utils.error("Build directory", build_dir, "already exists.  Use --force to overwrite")
    else:
        pass

    # For each design
    ljust = experiment.get_longest_design_name() + 5

    for design in experiment.designs:

        # Create a per-design build directory
        design_dir = os.path.join(build_dir, design.top)
        try:
            os.mkdir(design_dir)
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
