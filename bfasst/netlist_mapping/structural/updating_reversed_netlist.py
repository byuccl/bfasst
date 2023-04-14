"""This file has a function used to update the reversed netlist"""


def update_wires_in_reversed_netlist(reversed_netlist, old_wire_name, new_wire_name):
    """Updates the wires in the reversed_netlist after mapping a block"""

    # Update wire in netlist
    for reversed_block in reversed_netlist:
        # Updating Inputs
        for i, reversed_block_input_wire in enumerate(reversed_block.input_wires["names"]):
            if reversed_block_input_wire == old_wire_name:
                reversed_block.input_wires["names"][i] = new_wire_name
        # Updating Outputs
        for i, reversed_block_output_wire in enumerate(reversed_block.output_wires["names"]):
            if reversed_block_output_wire == old_wire_name:
                reversed_block.output_wires["names"][i] = new_wire_name

    return reversed_netlist
