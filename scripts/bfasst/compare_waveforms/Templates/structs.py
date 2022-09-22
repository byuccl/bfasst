data = {
    """A data structure used to store the list of inputs, outputs, and their respective bits."""
    "input_list": [],
    "input_bits_list": [],
    "output_list": [],
    "output_bits_list": [],
    "total_list": [],
    "random_list": [],
}


def clear_data(data):
    data["input_list"].clear()
    data["input_bits_list"].clear()
    data["output_list"].clear()
    data["output_bits_list"].clear()
    data["total_list"].clear()
    data["random_list"].clear()
    return data
