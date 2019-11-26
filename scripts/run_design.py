import argparse
import os
import glob

import bfasst

def main():
    parser = argparse.ArgumentParser()

    designs = []
    for directory in glob.iglob(bfasst.EXAMPLES_PATH + "/**", recursive=True):
        if os.path.isfile(os.path.join(directory, "design.yaml")):
            designs.append(os.path.relpath(directory, bfasst.EXAMPLES_PATH))

    parser.add_argument("design_path", choices = designs, help = "Path to design, relative to examples directory.")
    parser.add_argument("flow", choices=[e.value for e in bfasst.flow.Flows])
    parser.add_argument("--force", action='store_true')
    args = parser.parse_args()

    # Load the design
    design = bfasst.design.Design(args.design_path)

    # Create temp folder
    build_dir = os.path.join(os.getcwd(), "build", args.flow, args.design_path)
    if not os.path.isdir(build_dir):
        os.makedirs(build_dir)
    elif not args.force:
        bfasst.utils.error("Build directory", build_dir, "already exists.  Use --force to overwrite")
    else:
        pass
        # bfasst.utils.clean_folder(build_dir)


    # Run the design
    status = bfasst.flow.run_flow(design, bfasst.flow.Flows.IC2_LSE_CONFORMAL, build_dir)

    print(status)


if __name__ == "__main__":
    main()
