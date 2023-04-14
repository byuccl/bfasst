"""Instance class used for the automated block mapping."""


class Instance:
    """Class used to save block data in netlist automated block mapping."""

    def __init__(self, instance, input_wires, output_wires, other_wires):
        self.instance = instance
        self.input_wires = input_wires
        self.output_wires = output_wires
        self.other_wires = other_wires

    def get_input_wires(self):
        """Returns input wires"""
        return self.input_wires

    def get_output_wires(self):
        """Returns output wires"""
        return self.output_wires

    def get_other_wires(self):
        """Returns other wires"""
        return self.other_wires
