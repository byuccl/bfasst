"""A data structure used to store the list of inputs, outputs, and their respective bits."""
data = {
    "input_list": [],
    "input_bits_list": [],
    "output_list": [],
    "output_bits_list": [],
    "total_list": [],
    "random_list": [],
}

"""A data structure used to store all of the paths so they aren't redefined in multiple functions."""
paths = {
    "modules": [],  # The list of module names (Ex: add4, add4_impl, add4_reversed)
    "build_dir": "",  # The base directory that files are stored in
    "path": [],  # Paths to the implicit and reversed netlists
    "file": [],  # Paths to the output files for the implicit and reversed netlists
    "diff": "",  # Path to the diff txt file
    "parsed_diff": "",  # Path to the parsed_diff txt file
    "vcd": [],  # Paths to the VCD files
    "tcl": [],  # Paths to the TCL files
    "tb": [],  # Paths to the testbench files
    "sample_tb": "",  # Path to the sample testbench used for creating the automatic testbench
}

def clear_data(data):
    data["input_list"].clear()
    data["input_bits_list"].clear()
    data["output_list"].clear()
    data["output_bits_list"].clear()
    data["total_list"].clear()
    data["random_list"].clear()
    return(data)