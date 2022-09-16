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
    paths["vcd"].append(paths["build_dir"] / (paths["modules"][1] + ".vcd"))
    paths["vcd"].append(paths["build_dir"] / (paths["modules"][2] + ".vcd"))
    paths["dsn"] = paths["build_dir"] / ("dsn")
    paths["cells_sim"] = bfasst.paths.ROOT_PATH / (
        "third_party/yosys/techlibs/xilinx/cells_sim.v"
    )
    paths["sample_tb"] = bfasst.paths.ROOT_PATH / (
        "scripts/bfasst/compare_waveforms/Templates/sample_tb.v"
    )
    paths["tcl"].append(
        self.work_dir
        / (
            design.impl_netlist_path.name[
                0 : len(design.impl_netlist_path.name) - 2
            ]
            + ".tcl"
        )
    )
    paths["tcl"].append(
        self.work_dir
        / (
            design.reversed_netlist_path.name[
                0 : len(design.reversed_netlist_path.name) - 2
            ]
            + ".tcl"
        )
    )
    paths["parsed_diff"] = self.work_dir / ("parsed_diff.txt")

    return(paths)