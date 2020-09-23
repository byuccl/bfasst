import yaml
import zipfile
import pathlib
import shutil

import bfasst
from bfasst import paths


class Experiment():
    def __init__(self, yaml_path):
        self.post_run = None
        self.yaml_path = yaml_path
        self.name = yaml_path.stem
        
        # Read experiment YAML
        with open(yaml_path) as fp:
            experiment_props = yaml.safe_load(fp)

        # Get the flow fcn pointer
        if not "flow" in experiment_props:
            bfasst.utils.error("'flow' property missing from experiment YAML", yaml_path)
        self.flow_fcn = bfasst.flow.get_flow_fcn_by_name(experiment_props["flow"])
        
        # Create design objects for all designs
        self.design_paths = []
        if "designs" in experiment_props:
            for d in experiment_props["designs"]:
                self.design_paths.append(pathlib.Path(d))

        if "design_dirs" in experiment_props:
            for design_dir in experiment_props["design_dirs"]:
                design_dir_path = paths.EXAMPLES_PATH / design_dir
                if not design_dir_path.is_dir():
                    bfasst.utils.error(design_dir_path, "is not a directory" )
                
                for dir_item in design_dir_path.iterdir():
                    item_path = design_dir_path / dir_item
                    if item_path.is_dir():                
                        self.design_paths.append(pathlib.Path(design_dir) / dir_item.name)

        if "post_run" in experiment_props:
            self.post_run = getattr(self, experiment_props["post_run"])


        # Uniquify
        self.design_paths = list(set(self.design_paths))
        self.design_paths.sort()

        self.designs = []
        for design_path in self.design_paths:            
            design = bfasst.design.Design(paths.EXAMPLES_PATH / design_path)
            self.designs.append(design)

        for design in self.designs:
            if "error_flow" in experiment_props:
                design.error_flow_yaml = experiment_props["error_flow"] + ".yaml"
            

    def get_longest_design_name(self):
        return max([len(str(d.rel_path)) for d in self.designs])
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


    def export_to_onespin(self, build_dir):
        i = 0
        with zipfile.ZipFile(build_dir / "onespin.zip", 'w') as z:
            onespin_bash_path = bfasst.ONESPIN_RESOURCES / "run_onespin.bash"
            z.write(onespin_bash_path, arcname=(onespin_bash_path.name))
            for p in self.design_paths:
                onespin_path = build_dir / p.name / bfasst.compare.onespin.OneSpin_CompareTool.TOOL_WORK_DIR
                if not onespin_path.is_dir():
                    continue
                
                i += 1
                for f in onespin_path.iterdir():
                    # print(f)
                    z.write(f, arcname=(p.name + "/" + f.name))
                    # This isn't fully recursive, and will only copy the 1st
                    #   subdirectory
                    if f.is_dir():
                        for sub_f in f.iterdir():
                            z.write(sub_f, arcname=(p.name + "/" + f.name + "/" + sub_f.name))
                        

        print("onespin.zip created with", i, "designs")
                
