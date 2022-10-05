import spydrnet as sdn


def parse(file):
    """Uses spydrnet to analyze the netlist and add the names of all inputs, outputs, and their respective bit sizes to the data structure."""
    netlist = sdn.parse(str(file))
    library = netlist.libraries[0]
    definition = library.definitions[0]

    data = {}
    data["output_list"] = []
    data["input_list"] = []
    data["total_list"] = []
    data["input_bits_list"] = []
    data["output_bits_list"] = []

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
    if "clk" in data["input_list"]:
        if data["input_list"].index("clk") == 0:
            data["input_list"].append(data["input_list"].pop(0))

    return data


def parse_multiple(file, reversed_file):
    """A specific parse function in the situation where multiple verilog files exist. The design has multiple layers of ports, so finding the equivalent
    ports requires comparing the ports in each layer to the ports in the reversed_netlist. Once both have the same equivalence, they are stored."""
    data = {}
    data["output_list"] = []
    data["input_list"] = []
    data["total_list"] = []
    data["input_bits_list"] = []
    data["output_bits_list"] = []
    total_reversed = []

    netlist = sdn.parse(str(reversed_file))
    library = netlist.libraries[0]
    definition = library.definitions[0]

    # Stores the reversed_netlist ports in one array.
    for port in definition.ports:
        total_reversed.append(port.name)

    netlist = sdn.parse(str(file))
    library = netlist.libraries[0]

    contains_item = False
    not_port = False

    for i in library.definitions:
        for port in i.ports:
            for item in total_reversed:
                if item == port.name:
                    contains_item = True
            if contains_item is False:
                not_port = True
            else:
                contains_item = False
        if not_port is False:
            for port in i.ports:
                if str(port.direction) == "Direction.OUT":
                    data["output_list"].append(port.name)
                    data["total_list"].append(port.name)
                    data["output_bits_list"].append(len(port.pins) - 1)
                elif str(port.direction) == "Direction.IN":
                    data["input_list"].append(port.name)
                    data["total_list"].append(port.name)
                    data["input_bits_list"].append(len(port.pins) - 1)
            if "clk" in data["input_list"]:
                if data["input_list"].index("clk") == 0:
                    data["input_list"].append(data["input_list"].pop(0))
        else:
            not_port = False
    reversed_file.unlink()
    return data


def parse_reversed(paths, i):
    """Due to reversed netlists having incomplete ports that can cause issues with spydrnet, this function removes
    all of the excess data the spydrnet doesn't need so that the inputs and outputs can still be parsed."""
    with paths["file"][1].open("r") as file:
        if paths["test"].exists():
            paths["test"].unlink()
        with paths["test"].open("x") as newFile:
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
    if i == 0:
        return parse_multiple(paths["path"][i], paths["test"])
    return parse(paths["test"])  # Parses this newly-generated simplified netlist.
