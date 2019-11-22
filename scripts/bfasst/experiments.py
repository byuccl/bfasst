import sys
import os
import logging

import bfasst

def run(exp_dir, flow_type, designs, design_dirs):
    # Combine all designs and check that directory exists
    all_designs = []
    for d in designs:
        design_dir = os.path.join(bfasst.EXAMPLES_PATH, d)
        if (not os.path.isdir(design_dir)):
            bfasst.utils.error(design_dir, "is not a directory" )
        all_designs.append(d)

    for d in design_dirs:
        design_dir = os.path.join(bfasst.EXAMPLES_PATH, d)
        if not (os.path.isdir(design_dir)):
            bfasst.utils.error(design_dir, "is not a directory" )
        
        for design in os.listdir(design_dir):
            all_designs.append(os.path.join(d, design))

    # Uniquify
    all_designs = list(set(all_designs))
    print(all_designs)

    # Validate that designs exist
    build_dir = bfasst.utils.create_build_dir(exp_dir)
    design_build_dirs = {}
    for design in all_designs:
        design_build_dirs[design] = bfasst.utils.create_build_design_dir(build_dir, design)

    # Now run each design
    for (design, build_dir) in design_build_dirs.items():
        sys.stdout.write(design)
        
        bfasst.flow.flow_fcns[flow_type]()(design, build_dir)
        sys.stdout.write('\n')