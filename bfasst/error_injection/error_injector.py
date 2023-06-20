"""
This file contains the ErrorInjector_ErrorInjectionTool class, which is
responsible for running the error injection flows.
"""
import enum
import random
import re
import yaml

import bfasst
from bfasst import paths
from bfasst.error_injection.base import ErrorInjectionTool, ErrorInjectionException


class ErrorInjector(ErrorInjectionTool):
    """Error injector tool"""

    TOOL_WORK_DIR = "injection"

    # This picks enum and map pick a flow function to run, very similar (i.e.
    #   pretty much identical) to the way flows are selected in flow.py
    @enum.unique
    class Errors(enum.Enum):
        LUT_BIT_FLIP = "LUT_bit_flip"
        CROSS_LUT_WIRES = "cross_LUT_wires"
        ADD_SIGNAL_TAP = "add_signal_tap"

    # For now these will be lambda functions, but it might be worth having a
    #   separate class system for error injection flows if they end up being
    #   very complicated (which they well could be)
    def __init__(self, build_dir, design):
        super().__init__(build_dir, design)
        self.flow_fcn_map = {
            self.Errors.LUT_BIT_FLIP: lambda: self.lut_bit_flip_fcn,
            self.Errors.CROSS_LUT_WIRES: lambda: self.cross_lut_wires_fcn,
            self.Errors.ADD_SIGNAL_TAP: lambda: self.add_signal_tap,
        }

    def get_flow_fcn_from_name(self, flow_name):
        """Returns the flow function corresponding to the given flow name"""
        invalid_flow = False

        try:
            flow_enum = self.Errors(flow_name)
        except ValueError:
            invalid_flow = True

        if invalid_flow:
            bfasst.utils.error(flow_name, "is not a valid error flow name")

        fcn = self.flow_fcn_map[flow_enum]()
        return fcn

    def run_error_flows(self):
        self.design.nets_to_remove_from_pcf.clear()

        # Open the YAML file (if there is one) and read the flow information
        if self.design.error_flow_yaml is None:
            raise ErrorInjectionException("No error flow YAML file specified")
        with open(paths.ERROR_FLOW_PATH / self.design.error_flow_yaml) as fp:
            error_flow_info = yaml.safe_load(fp)

        corrupt_netlists = []
        for flow in error_flow_info["error_injection_flows"]:
            corrupt_netlist_path = self.work_dir / (self.design.top + "_" + flow["name"] + ".v")
            corrupt_netlist_path = self.design.netlist_path.parent / corrupt_netlist_path
            print(self.design.yosys_netlist_path)
            netlist_buffer = self.read_netlist_to_buffer(self.design.yosys_netlist_path)
            for curr_pass in flow["passes"]:
                flow_name = curr_pass[0]
                num_iterations = curr_pass[1]
                flow_fcn = self.get_flow_fcn_from_name(flow_name)
                for _ in range(num_iterations):
                    flow_ret = flow_fcn(netlist_buffer, self.design)
                    netlist_buffer = flow_ret[1]
            self.write_buffer_to_netlist(netlist_buffer, corrupt_netlist_path)
            corrupt_netlists.append(corrupt_netlist_path)
        self.design.corrupt_netlist_paths = corrupt_netlists
        # Get a list of the names of flows we're using to return as well
        flow_name_list = [flow["name"] for flow in error_flow_info["error_injection_flows"]]
        self.design.error_flow_names = flow_name_list

    def read_netlist_to_buffer(self, netlist):
        lines = []
        with open(netlist) as fp:
            for line in fp:
                lines.append(line)
        return lines

    def write_buffer_to_netlist(self, lines, netlist):
        with open(netlist, "w") as fp:
            for line in lines:
                fp.write(line)

    def flip_bit(self, lut_size, init_int):
        bit_to_flip = random.randint(0, lut_size)
        flip_mask = 1 << bit_to_flip
        return init_int ^ flip_mask

    def lut_bit_flip_fcn(self, netlist_buffer):
        """
        Goes through the golden file, copies everything to an internal
        buffer, and notes where LUT inits happen. Once the whole thing is
        read, picks a random LUT and changes 1 bit. Then writes the file out
        to output_netlist
        """
        init_linenos = []
        lineno = 0
        for line in netlist_buffer:
            if line.strip()[:9] == ".LUT_INIT":
                init_linenos.append(lineno)
            lineno += 1
        if len(init_linenos) == 0:
            print("No inits in netlist!")
            raise ErrorInjectionException("No inits in netlist!")
        # Pick a random LUT to flip
        lut_to_change_idx = random.randint(0, len(init_linenos) - 1)
        lut_to_change = netlist_buffer[init_linenos[lut_to_change_idx]]
        # Extract the LUT init value (hex)
        match_obj = re.search(r"'h[0-9A-Fa-f]*\)$", lut_to_change.strip())
        init_value = match_obj.group(0)[2:-1]
        init_int = int(init_value, 16)
        # Find the LUT size
        lut_size_str = re.findall("[1-9][0-9]?'h", lut_to_change.strip())[0]
        lut_size = int(lut_size_str[:-2])
        # Pick a bit to flip and flip it
        new_init = self.flip_bit(lut_size, init_int)
        # Replace the old LUT init with this new value
        new_init_hex = hex(new_init)[2:]
        # I'm not going to worry about correct indentation...
        new_init_str = ".LUT_INIT(" + str(lut_size) + "'h" + new_init_hex + ")\n"
        netlist_buffer[init_linenos[lut_to_change_idx]] = new_init_str
        print(
            "Corrupted lut init",
            lut_to_change.strip(),
            "to",
            new_init_str[:-1],
            "on line",
            init_linenos[lut_to_change_idx] + 1,
        )

    def cross_lut_wires_fcn(self, netlist_buffer):
        """Swaps the outputs of two LUTs in the netlist"""
        # Look for lut outputs
        lut_out_linenos = []
        for lineno, line in enumerate(netlist_buffer):
            if line.strip()[0:3] == ".O(":
                lut_out_linenos.append(lineno)
        # if there's fewer than 2 LUTs, don't do anything.
        # TODO: probably return a different status
        if len(lut_out_linenos) < 2:
            return
        # select two to swap
        random.shuffle(lut_out_linenos)
        lut1_lineno = lut_out_linenos[0]
        lut2_lineno = lut_out_linenos[1]
        # Grab the associated wires for the luts
        lut1_wire = re.findall(r"\(.*\)", netlist_buffer[lut1_lineno])[0][1:-1]
        lut2_wire = re.findall(r"\(.*\)", netlist_buffer[lut2_lineno])[0][1:-1]
        # Replace the output declarations with the other wire
        new_lut1_out = ".O(" + lut2_wire + ")\n"
        new_lut2_out = ".O(" + lut1_wire + ")\n"
        netlist_buffer[lut1_lineno] = new_lut1_out
        netlist_buffer[lut2_lineno] = new_lut2_out
        print("Swapped LUT outputs on lines", lut1_lineno, "and", lut2_lineno)

    def find_design_statements(self, netlist_buffer):
        """Finds the module declaration, wire statements, output
        statements, and assign statements in the design"""
        module_decl_line = None
        output_decl_line = None
        assign_statement_line = None
        wire_list = []
        for line_idx, line in enumerate(netlist_buffer):
            if len(line.split()) == 0:
                continue
            if line.split()[0] == "module":
                module_decl_line = line_idx
            elif line.split()[0] == "output":
                output_decl_line = line_idx
            elif line.split()[0] == "wire":
                wire_list.append(line_idx)
            elif line.split()[0] == "assign":
                assign_statement_line = line_idx
            elif line.split()[0] == "endmodule" and assign_statement_line is None:
                # If we hit the end and can't find an assign statement, just put
                #   it at the end
                assign_statement_line = line_idx - 1
        return (module_decl_line, output_decl_line, assign_statement_line, wire_list)

    def add_signal_tap(self, netlist_buffer):
        """Adds a signal tap to a random wire in the design"""
        (
            module_decl_line,
            output_decl_line,
            assign_statement_line,
            wire_list,
        ) = self.find_design_statements(netlist_buffer)
        if (
            module_decl_line is None
            or output_decl_line is None
            or assign_statement_line is None
            or len(wire_list) == 0
        ):
            print("Couldn't find one or more of module, output, assign, or wires in design!\n")
            raise ErrorInjectionException(
                "Couldn't find one or more of module, output, assign, or wires in design!\n"
            )
        # Select a random wire to tap
        random.shuffle(wire_list)
        print("tapping line", wire_list[0])
        print(netlist_buffer[wire_list[0]])
        wire_to_tap = netlist_buffer[wire_list[0]].split()[-1][0:-1]
        if wire_to_tap == "":
            wire_to_tap = netlist_buffer[wire_list[0]].split()[-2]
        escaped_name = bool(wire_to_tap[0] == "\\")
        print("tapping", wire_to_tap)
        # Also grab the bus declaration, if there is one
        # m = re.search("\[.*\]", netlist_buffer[wire_list[0]])
        match = re.match(r"\[.*\]", netlist_buffer[wire_list[0]].split()[1])
        bus = None
        if match:
            bus = match.group(0)
        # make a new output statement
        new_out = "output "
        if bus:
            new_out += bus + " "
        new_out += wire_to_tap + "_tap_out ;\n"
        # Make a new module declaration to replace the old one
        new_module_decl = netlist_buffer[module_decl_line][:-3]
        new_module_decl += ", " + wire_to_tap + "_tap_out );\n"
        # Make a new assign statement to write to the output
        new_assign_statement = "assign " + wire_to_tap + "_tap_out = " + wire_to_tap + " ;\n"
        # Replace the module declaration
        netlist_buffer[module_decl_line] = new_module_decl
        # Add the new assign statement
        netlist_buffer.insert(assign_statement_line + 1, new_assign_statement)
        # Add the new output statement
        netlist_buffer.insert(output_decl_line + 1, new_out)

        # Note what the tapped net is so we can remove it from the pcf (since
        #   we're "modifying" the bitstream)
        if escaped_name:
            self.design.nets_to_remove_from_pcf.add(wire_to_tap[1:])
        else:
            self.design.nets_to_remove_from_pcf.add(wire_to_tap)
