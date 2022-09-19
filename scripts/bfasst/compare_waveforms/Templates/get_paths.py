import bfasst
from bfasst.compare_waveforms.Templates import structs

paths = structs.paths

def get_paths(self, design):
    paths["build_dir"] = self.work_dir
    paths["path"].append(design.impl_netlist_path)
    paths["path"].append(design.reversed_netlist_path)
    paths["file"].append(paths["build_dir"] / (paths["path"][0].name))
    paths["file"].append(paths["build_dir"] / (paths["path"][1].name))
    paths["modules"].append(
        paths["path"][0].name[0 : len(paths["path"][0].name) - 7]
    )
    paths["modules"].append(
        paths["path"][0].name[0 : len(paths["path"][0].name) - 2]
    )
    paths["modules"].append(
        paths["path"][1].name[0 : len(paths["path"][1].name) - 2]
    )
    paths["diff"] = paths["build_dir"] / "diff.txt"
    paths["tb"].append(paths["build_dir"] / (paths["modules"][1] + "_tb.v"))
    paths["tb"].append(paths["build_dir"] / (paths["modules"][2] + "_tb.v"))
    paths["vcd"].append(paths["build_dir"] / (paths["modules"][1] + ".vcd"))
    paths["vcd"].append(paths["build_dir"] / (paths["modules"][2] + ".vcd"))
    paths["temp_vcd"].append(paths["build_dir"] / (paths["modules"][1] + "_temp.vcd"))
    paths["temp_vcd"].append(paths["build_dir"] / (paths["modules"][2] + "_temp.vcd"))
    paths["dsn"] = paths["build_dir"] / ("dsn")
    paths["cells_sim"] = bfasst.paths.ROOT_PATH / (
        "third_party/yosys/techlibs/xilinx/cells_sim.v"
    )
    paths["sample_tb"] = bfasst.paths.ROOT_PATH / (
        "scripts/bfasst/compare_waveforms/Templates/sample_tb.v"
    )
    paths["tcl"].append(paths["build_dir"] / (paths["modules"][1] + ".tcl"))
    paths["tcl"].append(paths["build_dir"] / (paths["modules"][2] + ".tcl"))
    paths["fst"].append(paths["build_dir"] / (paths["modules"][1] + "_temp.vcd.fst"))
    paths["fst"].append(paths["build_dir"] / (paths["modules"][2] + "_temp.vcd.fst"))
    paths["parsed_diff"] = self.work_dir / ("parsed_diff.txt")
    paths["test"] = paths["build_dir"] / "test.v"

    return(paths)