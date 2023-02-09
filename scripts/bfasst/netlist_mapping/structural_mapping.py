"""Mapping includes: Automated Block Mapping, Structural Mapping through Block Chains."""

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# WARNING: Both netlists must have the exact same inputs and outputs!                             #
# WARNING: The Carry mapping is only for CARRY4 instances!                                        #
# WARNING: If there is multiple counters with the same number of FFs, the mapping might be wrong! #
#          (Multiple Carry chain not yet supported)                                               #
# WARNING: Accessing the wires and pins from the S port of the CARRIES assuming                   #
#          that they go from index 0 to 3!                                                        #
# WARNING: If a LUT is connected to the carry, the algorithm will grab any FF                     #
#          connected to that LUT!                                                                 #
# WARNING: Algorithm assumes that there is only one CARRY chain in each netlist!                  #
# WARNING: When mapping the nets between carries and flipflops it is assumed that their nets      #
#          are accessed in the same order.                                                        #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import argparse
import spydrnet as sdn
from print_data import print_conformal_input_output_points
from print_data import print_conformal_structural_points
from structural.netlist import get_netlist
from structural.automated_block_mapping import automatically_map_blocks


def structurally_map_netlists(golden_netlist_arg, reversed_netlist_arg):
    """Map the golden and reversed netlists through automated block mapping"""

    # Loads the first netlist as intermediate representation (ir1)
    ir1 = sdn.parse(golden_netlist_arg)

    # Get the first library in the netlist
    library1 = ir1.libraries[0]

    # Loads the second netlist as intermediate representation (ir2)
    ir2 = sdn.parse(reversed_netlist_arg)

    # Get the first library in the netlist
    library2 = ir2.libraries[0]

    # Get netlists for the structural mapping algorithm
    golden_netlist = get_netlist(library1)
    reversed_netlist = get_netlist(library2)

    # Structurally map the rest of the netlists
    mapped_blocks = 0
    mapped_points = []
    mapped_points = automatically_map_blocks(
        golden_netlist, reversed_netlist, mapped_points, mapped_blocks
    )

    # Print the Mapped Points File to be used by Conformal
    print_conformal_input_output_points(
        ir1.top_instance,
        ir1.top_instance.reference.name,
        ir2.top_instance.reference.name,
    )
    print_conformal_structural_points(
        mapped_points, ir1.top_instance.reference.name, ir2.top_instance.reference.name
    )


def main():
    """Used to map the golden and reversed netlist"""

    parser = argparse.ArgumentParser()
    parser.add_argument("golden_netlist")
    parser.add_argument("reversed_netlist")
    args = parser.parse_args()
    structurally_map_netlists(args.golden_netlist, args.reversed_netlist)


if __name__ == "__main__":
    main()
