"""This file contains the class and necessary functions to create
a binary search tree used to filter configuration bits in a LUT"""


class Node:
    """Class used to create a node object"""

    def __init__(self):
        self.value = None
        self.children = None

def add_children(parent_node):
    """Function used to add new children to a node"""

    child_1 = Node()
    child_2 = Node()
    new_children = [child_1, child_2]
    parent_node.children = new_children
    return parent_node


def create_tree(new_node, generations, conf_bits_index, conf_bits):
    """Function used to create a tree with recursion"""

    new_node = add_children(new_node)
    # Generation 1: Return the parent node with values on children
    if generations == 1:
        for child in new_node.children:
            child.value = conf_bits[conf_bits_index]
            conf_bits_index += 1
        return new_node, conf_bits_index
    # Generations 2 or Higher: Return parent node connected with children
    if generations > 1:
        for child in new_node.children:
            child, conf_bits_index = create_tree(
                child, generations - 1, conf_bits_index, conf_bits
            )
        return new_node, conf_bits_index


def get_filtered_values(node, generations, lut_inputs, filtered_bst_values):
    """Function used to get the filtered values of a LUT using recursion"""

    # Getting the index of the inputs to the LUT from the generations
    inputs_index = generations - 1
    # Generation 1: Append the children values
    if generations == 1:
        if lut_inputs[inputs_index] == r"\<constb> ":
            filtered_bst_values.append(node.children[1].value)
        else:
            filtered_bst_values.append(node.children[0].value)
            filtered_bst_values.append(node.children[1].value)
        return filtered_bst_values

    # Generations 2 or Higher: Keep iterating through tree
    if generations > 1:
        if lut_inputs[inputs_index] == r"\<constb> ":
            filtered_bst_values = get_filtered_values(
                node.children[1], generations - 1, lut_inputs, filtered_bst_values
            )
        else:
            filtered_bst_values = get_filtered_values(
                node.children[0], generations - 1, lut_inputs, filtered_bst_values
            )
            filtered_bst_values = get_filtered_values(
                node.children[1], generations - 1, lut_inputs, filtered_bst_values
            )
        return filtered_bst_values
