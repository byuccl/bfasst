import enum
import yaml
import random
import re

import bfasst
from bfasst import paths
from bfasst.error_injection.base import ErrorInjectionTool
from bfasst.status import Status, ErrorInjectionStatus


class ErrorInjector_ErrorInjectionTool(ErrorInjectionTool):
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
    def __init__(self, build_dir):
        super().__init__(build_dir)
        self.flow_fcn_map = {
            self.Errors.LUT_BIT_FLIP: lambda: self.lut_bit_flip_fcn,
            self.Errors.CROSS_LUT_WIRES: lambda: self.cross_lut_wires_fcn,
            self.Errors.ADD_SIGNAL_TAP: lambda: self.add_signal_tap,
        }

    def get_flow_fcn_from_name(self, flow_name):
        invalid_flow = False

        try:
            flow_enum = self.Errors(flow_name)
        except ValueError:
            invalid_flow = True

        if invalid_flow:
            bfasst.utils.error(flow_name, "is not a valid error flow name")

        fcn = self.flow_fcn_map[flow_enum]()
        return fcn

    def run_error_flows(self, design):
        design.nets_to_remove_from_pcf.clear()

        # Open the YAML file (if there is one) and read the flow information
        if design.error_flow_yaml is None:
            return (Status(ErrorInjectionStatus.NO_YAML), None)
        with open(paths.ERROR_FLOW_PATH / design.error_flow_yaml) as fp:
            error_flow_info = yaml.safe_load(fp)

        corrupt_netlists = []
        for flow in error_flow_info["error_injection_flows"]:
            corrupt_netlist_path = self.work_dir / (design.top + "_" + flow["name"] + ".v")
            corrupt_netlist_path = design.netlist_path.parent / corrupt_netlist_path
            print(design.yosys_netlist_path)
            netlist_buffer = self.read_netlist_to_buffer(design.yosys_netlist_path)
            for p in flow["passes"]:
                flow_name = p[0]
                num_iterations = p[1]
                flow_fcn = self.get_flow_fcn_from_name(flow_name)
                for itr in range(num_iterations):
                    flow_ret = flow_fcn(netlist_buffer, design)
                    netlist_buffer = flow_ret[1]
            self.write_buffer_to_netlist(netlist_buffer, corrupt_netlist_path)
            corrupt_netlists.append(corrupt_netlist_path)
        design.corrupt_netlist_paths = corrupt_netlists
        # Get a list of the names of flows we're using to return as well
        flow_name_list = [flow["name"] for flow in error_flow_info["error_injection_flows"]]
        design.error_flow_names = flow_name_list
        tuple_list = list(zip(corrupt_netlists, flow_name_list))
        return (Status(ErrorInjectionStatus.SUCCESS), tuple_list)

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

    def lut_bit_flip_fcn(self, netlist_buffer, design):
        # Go through the golden file. Copy everything to an internal buffer,
        #   and note where LUT inits happen.
        #   Once the whole thing is read, pick a random lut and change 1 bit
        #   Then write the file out to output_netlist
        init_linenos = []
        lineno = 0
        for line in netlist_buffer:
            if line.strip()[:9] == ".LUT_INIT":
                init_linenos.append(lineno)
            lineno += 1
        if len(init_linenos) == 0:
            print("No inits in netlist!")
            return (Status(ErrorInjectionStatus.FCN_ERROR), netlist_buffer)
        # Pick a random LUT to flip
        lut_to_change_idx = random.randint(0, len(init_linenos) - 1)
        lut_to_change = netlist_buffer[init_linenos[lut_to_change_idx]]
        # Extract the LUT init value (hex)
        match_obj = re.search("'h[0-9A-Fa-f]*\)$", lut_to_change.strip())
        init_value = match_obj.group(0)[2:-1]
        init_int = int(init_value, 16)
        # Find the LUT size
        lut_size_str = re.findall("[1-9][0-9]?'h", lut_to_change.strip())[0]
        lut_size = int(lut_size_str[:-2])
        # Pick a bit to flip and flip it
        bit_to_flip = random.randint(0, lut_size)
        flip_mask = 1 << bit_to_flip
        new_init = init_int ^ flip_mask
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
        return (Status(ErrorInjectionStatus.FCN_SUCCESS), netlist_buffer)

    def cross_lut_wires_fcn(self, netlist_buffer, design):
        # Look for lut outputs
        lut_out_linenos = []
        for lineno in range(len(netlist_buffer)):
            line = netlist_buffer[lineno]
            if line.strip()[0:3] == ".O(":
                lut_out_linenos.append(lineno)
        # if there's fewer than 2 LUTs, don't do anything.
        # TODO: probably return a different status
        if len(lut_out_linenos) < 2:
            return (Status(ErrorInjectionStatus.FCN_SUCCESS), netlist_buffer)
        # select two to swap
        random.shuffle(lut_out_linenos)
        lut1_lineno = lut_out_linenos[0]
        lut2_lineno = lut_out_linenos[1]
        # Grab the associated wires for the luts
        lut1_wire = re.findall("\(.*\)", netlist_buffer[lut1_lineno])[0][1:-1]
        lut2_wire = re.findall("\(.*\)", netlist_buffer[lut2_lineno])[0][1:-1]
        # Replace the output declarations with the other wire
        new_lut1_out = ".O(" + lut2_wire + ")\n"
        new_lut2_out = ".O(" + lut1_wire + ")\n"
        netlist_buffer[lut1_lineno] = new_lut1_out
        netlist_buffer[lut2_lineno] = new_lut2_out
        print("Swapped LUT outputs on lines", lut1_lineno, "and", lut2_lineno)
        return (Status(ErrorInjectionStatus.FCN_SUCCESS), netlist_buffer)

    def add_signal_tap(self, netlist_buffer, design):
        # Find where the module declaration, wire statements, output
        #   statements, and assign statements are in the design
        module_decl_line = None
        output_decl_line = None
        assign_statement_line = None
        wire_list = []
        for line_idx in range(len(netlist_buffer)):
            line = netlist_buffer[line_idx]
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
            elif line.split()[0] == "endmodule" and assign_statement_line == None:
                # If we hit the end and can't find an assign statement, just put
                #   it at the end
                assign_statement_line = line_idx - 1
        if (
            module_decl_line == None
            or output_decl_line == None
            or assign_statement_line == None
            or len(wire_list) == 0
        ):
            print("Couldn't find one or more of module, output, assign, or wires in design!\n")
            return (Status(ErrorInjectionStatus.FCN_SUCCESS), netlist_buffer)
        # Select a random wire to tap
        random.shuffle(wire_list)
        print("tapping line", wire_list[0])
        print(netlist_buffer[wire_list[0]])
        wire_to_tap = netlist_buffer[wire_list[0]].split()[-1][0:-1]
        if wire_to_tap == "":
            wire_to_tap = netlist_buffer[wire_list[0]].split()[-2]
        if wire_to_tap[0] == "\\":
            escaped_name = True
        else:
            escaped_name = False
        print("tapping", wire_to_tap)
        # Also grab the bus declaration, if there is one
        # m = re.search("\[.*\]", netlist_buffer[wire_list[0]])
        m = re.match("\[.*\]", netlist_buffer[wire_list[0]].split()[1])
        bus = None
        if m:
            bus = m.group(0)
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
            design.nets_to_remove_from_pcf.add(wire_to_tap[1:])
        else:
            design.nets_to_remove_from_pcf.add(wire_to_tap)

        return (Status(ErrorInjectionStatus.FCN_SUCCESS), netlist_buffer)
