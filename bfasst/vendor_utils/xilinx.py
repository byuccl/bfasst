"""Module for xilinx utilities"""


def get_unisim_cell_inputs_and_outputs():
    """
    Gets the inputs and outputs for UNISIM cells. The format for a cell
    is a tuple of three elements. The first element is a tuple of strings
    that are the names of the cells. The second element is a tuple of strings
    that are the names of the inputs. The third element is a tuple of strings
    that are the names of the outputs.
    """
    cell_inputs_and_outputs = (
        (("LUT6_2",), ("I0", "I1", "I2", "I3", "I4", "I5"), ("O5", "O6")),
        (("IBUF", "OBUF", "OBUFT"), ("I", "T"), ("O",)),
        (("GND",), (), ("G",)),
        (("VCC",), (), ("P",)),
        (("FDSE", "FDRE"), ("D", "CE", "R", "C", "S"), ("Q",)),
        (("CARRY4",), ("CI", "CYINIT", "DI", "S"), ("O", "CO")),
        (("BUFGCTRL",), ("CE0", "CE1", "I0", "I1", "IGNORE0", "IGNORE1", "S0", "S1"), ("O",)),
        (("MUXF7", "MUXF8"), ("I0", "I1", "S"), ("O",)),
    )
    return cell_inputs_and_outputs
