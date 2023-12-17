"""Mapping algorithm based on block chains and the functional trees of the LUTs before a FF."""


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# WARNING: Both netlists must have the exact same inputs and outputs!                             #
# WARNING: The LUT reduction algorithm only works for LUTs with 2 inputs or more,                 #
#          where I0 and I1 are not constants!                                                     #
# WARNING: This algorithm cannot iterate through Muxes yet!                                       #
# WARNING: When SpyDrNet grabs the name of the Flipflop it has a \ as the first character!        #
# WARNING: Max number of Inputs to a LUT must be 6!                                               #
# WARNING: All terms in the list returned from the qm library may not be                          #
#          essential prime implicants! Now they are all Prime Implicants!                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


import argparse
import spydrnet as sdn
from bfasst.tools_legacy.netlist_mapping.print_data import (
    print_conformal_input_output_points,
    print_conformal_mapped_ffs,
)
from bfasst.tools_legacy.netlist_mapping.structural.carry_chain_mapping import map_carries_and_ffs
from bfasst.tools_legacy.netlist_mapping.structural.shift_register_mapping import (
    map_shift_register_and_output_ffs,
)
from bfasst.tools_legacy.netlist_mapping.functional.logic_functions_mapping import (
    map_ffs_based_on_logic_func,
)
from bfasst.tools_legacy.netlist_mapping.functional.netlist_flipflops_data import (
    get_ffs_and_conf_bits,
)


def map_netlists(golden_netlist_arg, reversed_netlist_arg):
    """Maps the golden and reversed netlist based on block chains and functional trees"""
    print(f"golden: {golden_netlist_arg} reversed: {reversed_netlist_arg}")
    # Loads the first netlist as intermediate representation (ccl_ir1)
    ccl_ir1 = sdn.parse(golden_netlist_arg)

    # Get the first library in the netlist
    library1 = ccl_ir1.libraries[0]

    # Loads the second netlist as intermediate representation (ccl_ir2)
    ccl_ir2 = sdn.parse(reversed_netlist_arg)

    # Get the second library in the netlist
    library2 = ccl_ir2.libraries[0]

    # Structurally map flipflops
    structurally_mapped_ffs = []

    # Get mapped carries and flipflops from the counters
    carry_chain_mapped_flipflops = []
    carry_chain_mapped_flipflops = map_carries_and_ffs(library1, library2)

    structurally_mapped_ffs += carry_chain_mapped_flipflops

    # Get mapped flipflops from the shift-register and its output
    shift_register_and_output_flipflops = []

    shift_register_and_output_flipflops = map_shift_register_and_output_ffs(library1, library2)

    structurally_mapped_ffs += shift_register_and_output_flipflops

    # Filling the first flipflops data object
    netlist_ffs_data_1 = get_ffs_and_conf_bits(library1, structurally_mapped_ffs, True)

    # Filling the second flipflops data object
    netlist_ffs_data_2 = get_ffs_and_conf_bits(library2, structurally_mapped_ffs, False)

    # Printing Flipflops and Logic Equation's Trees for debugging
    # print("Golden")
    # print_data(netlist_ffs_data_1)
    # print("Reversed")
    # print_data(netlist_ffs_data_2)

    # Map Netlists based on the flipflops data (flipflop name, configuration bits, sop)
    func_mapped_ffs = map_ffs_based_on_logic_func(netlist_ffs_data_1, netlist_ffs_data_2)

    # Print the Mapped Points File to be used by Conformal
    print_conformal_input_output_points(
        ccl_ir1.top_instance,
        ccl_ir1.top_instance.reference.name,
        ccl_ir2.top_instance.reference.name,
    )

    print_conformal_mapped_ffs(
        structurally_mapped_ffs,
        func_mapped_ffs,
        ccl_ir1.top_instance.reference.name,
        ccl_ir2.top_instance.reference.name,
    )


def main():
    """Used to map the golden and reversed netlist"""

    ccl_parser = argparse.ArgumentParser()
    ccl_parser.add_argument("golden_netlist")
    ccl_parser.add_argument("reversed_netlist")
    args = ccl_parser.parse_args()
    map_netlists(args.golden_netlist, args.reversed_netlist)


if __name__ == "__main__":
    main()
