import os, yaml

import bfasst

class Experiment():
    def __init__(self, exp_name):
        
        yaml_path = os.path.join(bfasst.EXPERIMENTS_PATH, exp_name + ".yaml")
        
        # Read experiment YAML
        with open(yaml_path) as fp:
            experiment_props = yaml.safe_load(fp)

        # Get the flow fcn pointer
        if not "flow" in experiment_props:
            bfasst.utils.error("'flow' property missing from experiment YAML", yaml_path)
        self.flow_fcn = bfasst.flow.get_flow_fcn_by_name(experiment_props["flow"])
        
        # Create design objects for all designs
        design_paths = []
        if "designs" in experiment_props:
            for d in experiment_props["designs"]:
                design_paths.append(d)

        if "design_dirs" in experiment_props:
            for design_dir in experiment_props["design_dirs"]:
                design_dir_path = os.path.join(bfasst.EXAMPLES_PATH, design_dir)
                if not (os.path.isdir(design_dir_path)):
                    bfasst.utils.error(design_dir_path, "is not a directory" )
                
                for dir_item in os.listdir(design_dir_path):
                    item_path = os.path.join(design_dir_path, dir_item)
                    if os.path.isdir(item_path):
                        design_paths.append(os.path.join(design_dir, dir_item))



        # Uniquify
        design_paths = list(set(design_paths))
        design_paths.sort()

        self.designs = []
        for design_path in design_paths:    
            design = bfasst.design.Design(design_path)
            self.designs.append(design)

    def get_longest_design_name(self):
        return max([len(d.design_dir) for d in self.designs])
        # # Validate that designs exist
        # build_dir = bfasst.utils.create_build_dir(exp_dir)
        # design_build_dirs = {}
        # for design in all_designs:
        #     design_build_dirs[design] = bfasst.utils.create_build_design_dir(build_dir, design)

        # # Now run each design
        # for (design, build_dir) in design_build_dirs.items():
        #     sys.stdout.write(design)
            
        #     bfasst.flow.flow_fcns[flow_type]()(design, build_dir)
        #     sys.stdout.write('\n')

