import yaml
import shutil
import pathlib

from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus

class OneSpin_CompareTool(CompareTool):
    TOOL_WORK_DIR = "onespin"


    def compare_netlists(self, design):
        yaml_data = {}

        for f in design.compare_golden_files_paths:
            shutil.copyfile(f, self.work_dir / f.name)
        print("copying reversed netlist", design.reversed_netlist_path)
        shutil.copyfile(design.reversed_netlist_path, self.work_dir / design.reversed_netlist_filename())

        if design.corrupt_netlist_paths is not None:
            for netlist in design.corrupt_netlist_paths:
                shutil.copyfile(netlist, self.work_dir / netlist.name)

        pathlib.Path(self.work_dir / "rtl").mkdir(exist_ok=True);
        rtl_paths = [design.full_path / f for f in design.get_support_files()]
        rtl_paths.append(pathlib.Path(design.top_path()))
        for f in rtl_paths:
            shutil.copyfile(f, self.work_dir / "rtl" / f.name)

        yaml_data["golden_files"] = design.compare_golden_files
        yaml_data["revised_file"] = design.reversed_netlist_filename()
        yaml_data["rtl_files"] = ["rtl/" + f.name for f in rtl_paths]

        if design.golden_is_verilog:
            yaml_data["golden_top"] = design.top
        elif design.top_architecture is not None:
            yaml_data["golden_top"] = design.top + "(" + design.top_architecture + ")"

        if design.top_is_verilog:
            yaml_data["rtl_top"] = design.top
        elif design.top_architecture is not None:
            yaml_data["rtl_top"] = design.top + "(" + design.top_architecture + ")"


        compare_yaml = self.work_dir / "design.yaml"
        with open(compare_yaml, 'w') as fp:
            yaml.dump(yaml_data, fp)


        return Status(CompareStatus.NEED_TO_RUN_ONESPIN)
