import yaml
import shutil

from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus

class OneSpin_CompareTool(CompareTool):
    TOOL_WORK_DIR = "onespin"


    def compare_netlists(self, design):
        yaml_data = {}

        for f in design.compare_golden_files_paths:
            shutil.copyfile(f, self.work_dir / f.name)
        shutil.copyfile(design.reversed_netlist_path, self.work_dir / design.reversed_netlist_filename())


        yaml_data["golden_files"] = design.compare_golden_files
        yaml_data["revised_file"] = design.reversed_netlist_filename()

        if design.golden_is_verilog:
            yaml_data["golden_top"] = design.top
        elif design.top_architecture is not None:
            yaml_data["golden_top"] = design.top + "(" + design.top_architecture + ")"


        compare_yaml = self.work_dir / "design.yaml"
        with open(compare_yaml, 'w') as fp:
            yaml.dump(yaml_data, fp)


        return Status(CompareStatus.NEED_TO_RUN_ONESPIN)
