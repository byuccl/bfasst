import spydrnet as sdn
import bfasst
from bfasst.compare_waveforms.Templates import structs

data = structs.data
clear_data = structs.clear_data


"""Uses spydrnet to analyze the netlist and add the names of all inputs, outputs, and their respective bit sizes to the data structure."""
def parse(file):
    netlist = sdn.parse(file)
    library = netlist.libraries[0]
    definition = library.definitions[0]

    # Use design.yaml_path to find yaml file. Read to find if more modules exist.
    for port in definition.ports:
        if str(port.direction) == "Direction.OUT":
            data["output_list"].append(port.name)
            data["total_list"].append(port.name)
            data["output_bits_list"].append(len(port.pins) - 1)
        elif str(port.direction) == "Direction.IN":
            data["input_list"].append(port.name)
            data["total_list"].append(port.name)
            data["input_bits_list"].append(len(port.pins) - 1)
    if data["input_list"].__contains__("clk"):
        if data["input_list"].index("clk") == 0:
            data["input_list"].append(data["input_list"].pop(0))
    return(data)

"""A specific parse function in the situation where multiple verilog files exist. The design has multiple layers of ports, so finding the equivalent
ports requires comparing the ports in each layer to the ports in the reversed_netlist. Once both have the same equivalence, they are stored."""

def parse_multiple(file, reversed_file):
    total_reversed = []

    netlist = sdn.parse(reversed_file)
    library = netlist.libraries[0]
    definition = library.definitions[0]

    # Stores the reversed_netlist ports in one array.
    for port in definition.ports:
        total_reversed.append(port.name)

    netlist = sdn.parse(file)
    library = netlist.libraries[0]

    contains_item = False
    not_port = False

    for i in library.definitions:
        for port in i.ports:
            for item in total_reversed:
                if item == port.name:
                    contains_item = True
            if contains_item == False:
                not_port = True
            else:
                contains_item = False
        if not_port == False:
            for port in i.ports:
                if str(port.direction) == "Direction.OUT":
                    data["output_list"].append(port.name)
                    data["total_list"].append(port.name)
                    data["output_bits_list"].append(len(port.pins) - 1)
                elif str(port.direction) == "Direction.IN":
                    data["input_list"].append(port.name)
                    data["total_list"].append(port.name)
                    data["input_bits_list"].append(len(port.pins) - 1)
                    
            if data["input_list"].__contains__("clk"):
                if data["input_list"].index("clk") == 0:
                    data["input_list"].append(data["input_list"].pop(0))
        else:
            not_port = False
    return(data)

"""Due to reversed netlists having incomplete ports that can cause issues with spydrnet, this function removes
all of the excess data the spydrnet doesn't need so that the inputs and outputs can still be parsed."""

def parse_reversed(path, multiple_files, file_name, i, paths):
    test_file = paths["build_dir"] / "test.v"
    with path.open() as file:
        if test_file.exists():
            test_file.unlink()
        with test_file.open("x") as newFile:
            j = 0
            # Only includes lines that declare the module, the inputs, or the outputs or the line directly after them.
            for line in file:
                if "module" in line:
                    newFile.write(line)
                elif "input" in line:
                    newFile.write(line)
                elif "output" in line:
                    newFile.write(line)
                else:
                    if j == 0:
                        j = 1
                        newFile.write(line)
    if multiple_files:
        return(parse_multiple(file_name, newFile.name))
    else:
        return(parse(newFile.name))  # Parses this newly-generated simplified netlist.
