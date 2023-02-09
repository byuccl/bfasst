# Mapping algorithm based on the accumulated configuration bits of the LUTs before a FF.
# It also uses the basic inputs and outputs mapping algorithm for the implemented and reversed netlists.
# WARNING: Both netlists must have the exact same inputs and outputs!
# WARNING: The LUT reduction algorithm only works for LUTs with 2 inputs or more, where I0 and I1 are not constants!
# WARNING: This algorithm cannot iterate through Muxes yet!!!
# WARNING: When SpyDrNet grabs the name of the Flipflop it has a \ as the first character!
# WARNING: Max number of Inputs to a LUT must be 6!
# WARNING: All terms in the list returned from the qm library may not be essential prime implicants! Now they are all Prime Implicants!


from re import A
import spydrnet as sdn
import argparse
from print_data import print_conformal_input_output_points
from print_data import print_conformal_ff_points
from print_data import print_data
from structural.carry_chain_mapping import map_carries_and_flipflops
from functional.configuration_bits_mapping import map_flipflops_based_on_conf_bits
from functional.logic_functions_mapping import map_flipflops_based_on_logic_functions
from functional.netlist_flipflops_data import get_flipflops_and_configuration_bits


def functionally_map_netlists(golden_netlist_arg, reversed_netlist_arg):
    # Loads the first netlist as intermediate representation (ir1)
    ir1 = sdn.parse(golden_netlist_arg)
    # Get the first library in the netlist
    library1 = ir1.libraries[0]

    # Loads the second netlist as intermediate representation (ir2)
    ir2 = sdn.parse(reversed_netlist_arg)
    # Get the second library in the netlist
    library2 = ir2.libraries[0]

    # Get mapped carries and flipflops from the counters
    mapped_carries = []
    carry_chain_mapped_flipflops = []
    #mapped_carries, carry_chain_mapped_flipflops = map_carries_and_flipflops(library1, library2)  
    #print(mapped_carries)

    # Filling the first flipflops data object
    #print("Golden")
    netlist_flipflops_data_1 = get_flipflops_and_configuration_bits(library1, carry_chain_mapped_flipflops, True) 

    # Filling the second flipflops data object
    #print("Reversed")
    netlist_flipflops_data_2 = get_flipflops_and_configuration_bits(library2, carry_chain_mapped_flipflops, False)

    # Printing Flipflops and Logic Equation's Trees
    #print("Golden")
    #print_data(netlist_flipflops_data_1)
    #print("Reversed")
    #print_data(netlist_flipflops_data_2)

    # Map Netlists based on the flipflops data (flipflop name, configuration bits)
    #mapped_flipflops = map_flipflops_based_on_conf_bits(netlist_flipflops_data_1, netlist_flipflops_data_2)

    # Map Netlists based on the flipflops data (flipflop name, configuration bits, sop)
    
    functionally_mapped_flipflops = map_flipflops_based_on_logic_functions(netlist_flipflops_data_1, netlist_flipflops_data_2)

    # ################ Print the Mapped Points File to be used by Conformal ################
    print_conformal_input_output_points(
        ir1.top_instance,
        ir1.top_instance.reference.name,
        ir2.top_instance.reference.name,
    )

    print_conformal_ff_points(
        carry_chain_mapped_flipflops,
        ir1.top_instance.reference.name,
        ir2.top_instance.reference.name,
    )

    print_conformal_ff_points(
        functionally_mapped_flipflops,
        ir1.top_instance.reference.name,
        ir2.top_instance.reference.name,
    )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("golden_netlist")
    parser.add_argument("reversed_netlist")
    args = parser.parse_args()
    functionally_map_netlists(args.golden_netlist, args.reversed_netlist)

    
if __name__ == "__main__":
    main()
