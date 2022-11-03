"""Gets the paths for the waveform comparison tool."""


def get_paths(work_dir, root_path, design):

    """A function that gets all of the necessary paths used by the waveform comparison tool."""

    paths = {}

    # The base directory that files are stored in
    paths["build_dir"] = work_dir

    # Cells sim is used as a reference for any modules that are defined such as IBUF
    paths["cells_sim"] = root_path / ("third_party/yosys/techlibs/xilinx/cells_sim.v")

    # Path to the sample testbench used for creating the automatic testbench
    paths["sample_tb"] = root_path / (
        "scripts/bfasst/compare_waveforms/templates/sample_tb.v"
    )

    # Paths to the implicit and reversed netlists
    paths["path"] = []
    paths["path"].append(design.impl_netlist_path)
    paths["path"].append(design.reversed_netlist_path)

    # Paths to the output files for the implicit and reversed netlists
    paths["file"] = []
    paths["file"].append(paths["build_dir"] / (paths["path"][0].name))
    paths["file"].append(paths["build_dir"] / (paths["path"][1].name))

    # The list of module names (Ex: add4, add4_impl, add4_reversed)
    paths["modules"] = []
    paths["modules"].append(paths["path"][0].name[0 : len(paths["path"][0].name) - 7])
    paths["modules"].append(paths["path"][0].name[0 : len(paths["path"][0].name) - 2])
    paths["modules"].append(paths["path"][1].name[0 : len(paths["path"][1].name) - 2])

    # Path to the diff txt file
    paths["diff"] = paths["build_dir"] / "diff.txt"

    # Paths to the testbench files
    paths["tb"] = []
    paths["tb"].append(paths["build_dir"] / (f"{paths['modules'][1]}_tb.v"))
    paths["tb"].append(paths["build_dir"] / (f"{paths['modules'][2]}_tb.v"))

    # Paths to the VCD files
    paths["vcd"] = []
    paths["vcd"].append(paths["build_dir"] / (f"{paths['modules'][1]}.vcd"))
    paths["vcd"].append(paths["build_dir"] / (f"{paths['modules'][2]}.vcd"))

    # Path to the dsn file (A file generated between the TCL and VCD files)
    paths["dsn"] = paths["build_dir"] / ("dsn")

    # Paths to the TCL files
    paths["tcl"] = []
    paths["tcl"].append(paths["build_dir"] / (f"{paths['modules'][1]}.tcl"))
    paths["tcl"].append(paths["build_dir"] / (f"{paths['modules'][2]}.tcl"))

    # Paths to the fst files (temporary files)
    paths["fst"] = []
    paths["fst"].append(paths["build_dir"] / (f"{paths['modules'][1]}_temp.vcd.fst"))
    paths["fst"].append(paths["build_dir"] / (f"{paths['modules'][2]}_temp.vcd.fst"))

    # Path to the test.v file used in multiple_file parsing
    paths["test"] = paths["build_dir"] / "test.v"

    return paths
