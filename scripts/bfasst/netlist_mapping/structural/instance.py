class Instance:
    def __init__(
        self,
        instance_name,
        instance_type,
        input_wires_names,
        input_wires_number,
        input_wires_matching_number,
        output_wires_names,
        output_wires_number,
        output_wires_matching_number,
        other_wires_names,
        other_wires_number,
    ):
        self.instance_name = instance_name
        self.instance_type = instance_type
        self.input_wires_names = input_wires_names
        self.input_wires_number = input_wires_number
        self.input_wires_matching_number = input_wires_matching_number
        self.output_wires_names = output_wires_names
        self.output_wires_number = output_wires_number
        self.output_wires_matching_number = output_wires_matching_number
        self.other_wires_names = other_wires_names
        self.other_wires_number = other_wires_number