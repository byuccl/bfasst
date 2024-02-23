"""Module that changes binary LUT inits to hex in an LSE netlist"""

import argparse
import in_place


def fix_lut_inits(netlist_path):
    """This function goes through the generated netlist and
    changes binary LUT inits to hex. Apparently LSE generates
    binary LUT inits under some conditions, and the IC2 backend
    doesn't like that."""

    with in_place.InPlace(netlist_path) as n_f:
        found_first_init = False
        for line in n_f:
            if line.strip().split()[0:2] == ["(property", "LUT_INIT"]:
                # Skip the first LUT init (it's formatted correctly for some reason)
                if not found_first_init:
                    found_first_init = True
                    continue
                # Try to grab the binary string
                bin_string = line.strip().split()[3][1:-3]
                # Convert the string to hex
                # Use a try block so we only do this if the string is
                #   actually binary
                try:
                    hex_string = hex(int(bin_string, 2))[2:]
                    # Form a new line using the hex string
                    line_list = line.split()
                    line_list[3] = '"' + hex_string + '"))'
                    new_line = " ".join(line_list)
                    # Grab the indenting from the old line
                    indent = line.split("(")[0]
                    new_line = indent + new_line + "\n"
                    # Write the new line back into the file
                    n_f.write(new_line)
                except ValueError:
                    n_f.write(line)
            else:
                n_f.write(line)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("netlist_path", help="Path to netlist to fix")
    args = parser.parse_args()
    fix_lut_inits(args.netlist_path)
