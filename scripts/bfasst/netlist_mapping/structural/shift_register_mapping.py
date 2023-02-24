"""Maps the flipflops used for the shift register, and its output."""


import spydrnet as sdn


def analyze_new_instance(new_instance, next_ff, last_ff, ffs_builder, ffs):
    """Checks if the current FF is an output FF, or part of the shift-register"""

    # print("\t\t", new_instance.name)
    # Loop through the pins of the FF
    for pin in new_instance.pins:
        # Find the pin with the Q port
        if "Q" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire is not None:
                # Loop through the pins connected to the wire
                obuf_count = 0
                ff_count = 0
                for w_pin in pin.wire.pins:
                    # Check if it is either an output or the next FF
                    if "OBUF" in w_pin.instance.reference.name:
                        obuf_count += 1
                    elif ("FDRE" in w_pin.instance.reference.name) or (
                        "FDSE" in w_pin.instance.reference.name
                    ):
                        ff_count += 1
                # Logic for output or next FF
                if obuf_count > 0:
                    # print("\t\t\t Found OBUF")
                    ffs_builder["output_ffs"].append(new_instance.name)
                    # output_ffs.append(new_instance.name)
                elif ff_count > 1:
                    # print("\t\t\t Found FF")
                    next_ff = new_instance
                else:
                    last_ff = True
                    # print("\t\t\t Final FF")
                    ffs_builder["next_ffs"].append(new_instance.name)
                    # next_ffs.append(new_instance.name)
                    ffs = ffs_builder["next_ffs"] + ffs_builder["output_ffs"]

    return next_ff, last_ff, ffs_builder, ffs


def generate_ffs_list(instance, ffs, ffs_builder):
    """Generates a ffs list to be mapped from a shift-register through recursion"""

    # print(instance.name)
    new_instance = None
    next_ff = instance
    last_ff = False
    ffs_builder["next_ffs"].append(instance.name)
    # next_ffs.append(instance.name)
    # Loop through the pins of the FF
    for pin in instance.pins:
        # Find the pin with the Q port
        if "Q" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire is not None:
                # Loop through the pins connected to the wire
                for w_pin in pin.wire.pins:
                    # Find the pin with the D port
                    if "D" in w_pin.inner_pin.port.name:
                        new_instance = w_pin.instance
                        (next_ff, last_ff, ffs_builder, ffs) = analyze_new_instance(
                            new_instance, next_ff, last_ff, ffs_builder, ffs
                        )
    if not last_ff:
        # Get to next FF
        ffs = generate_ffs_list(next_ff, ffs, ffs_builder)

    return ffs


def go_to_initial_ff(instance, ffs):
    """Goes to the initial ff using recursion"""

    ffs_builder = {"output_ffs": [], "next_ffs": []}
    previous_instance = None
    initial_flipflop = True
    # Loop through the pins of the FF
    for pin in instance.pins:
        # Find the pin with the D port
        if "D" in pin.inner_pin.port.name:
            # Check that it has a wire
            if pin.wire is not None:
                # Loop through the pins connected to the wire
                for w_pin in pin.wire.pins:
                    # Find the pin with the Q port
                    #! It should only have one flipflop before it giving its output
                    if "Q" in w_pin.inner_pin.port.name:
                        # Prepare to go to previous flipflop
                        initial_flipflop = False
                        previous_instance = w_pin.instance

    if initial_flipflop is True:
        ffs = generate_ffs_list(instance, ffs, ffs_builder)
    else:
        ffs = go_to_initial_ff(previous_instance, ffs)

    return ffs


def check_pin_for_ffs(pin, done_with_mapping, ffs, instance):
    """Checks the FF's pin for other FFs"""

    # Loop through the pins connected to the wire
    ffs_connected = 0
    for w_pin in pin.wire.pins:
        # Check for outer pin
        # if type(w_pin) == sdn.OuterPin:
        if isinstance(w_pin, sdn.OuterPin):
            # Count FFs connected to wire
            if ("FDRE" in w_pin.instance.reference.name) or (
                "FDSE" in w_pin.instance.reference.name
            ):
                ffs_connected += 1
    # Check if it is connected to more than one FF (Part of a shift register)
    if (ffs_connected > 1) and (not done_with_mapping):
        # Go to initial FF to map FFs correctly
        ffs = go_to_initial_ff(instance, ffs)
        done_with_mapping = True

    return done_with_mapping, ffs


def get_ffs_to_map_through_shift_register(library, ffs):
    """Gets the ffs to be mapped through the shift-register"""

    done_with_mapping = False
    # Loop through each instance in the library to find a flipflop that has its output
    # connected to another flipflop
    for instance in library.get_instances():
        # Select FF
        if ("FDRE" in instance.reference.name) or ("FDSE" in instance.reference.name):
            # Loop through the pins of the FF
            for pin in instance.pins:
                # Find the pin with the Q port
                if "Q" in pin.inner_pin.port.name:
                    # Check that it has a wire
                    if pin.wire is not None:
                        done_with_mapping, ffs = check_pin_for_ffs(
                            pin, done_with_mapping, ffs, instance
                        )

    return ffs


def print_mapped_ffs_through_shift_register(mapped_ffs):
    """Prints the mapped ffs through the shift-register"""

    for ff_pair in mapped_ffs:
        print(ff_pair[0], " <-> ", ff_pair[1])


def map_shift_register_and_output_ffs(library1, library2):
    """Maps the ffs in a shift-register and its output"""

    impl_ffs = []
    reversed_ffs = []

    impl_ffs = get_ffs_to_map_through_shift_register(library1, impl_ffs)

    reversed_ffs = get_ffs_to_map_through_shift_register(library2, reversed_ffs)

    mapped_flipflops = []
    # Map flipflops gathered from the carries
    if len(impl_ffs) == len(reversed_ffs):
        length = len(impl_ffs)
        for i in range(length):
            mapped_pair = []
            mapped_pair.append(impl_ffs[i])
            mapped_pair.append(reversed_ffs[i])
            mapped_flipflops.append(mapped_pair)

    # print_mapped_flipflops_through_shift_register(mapped_flipflops)

    return mapped_flipflops
