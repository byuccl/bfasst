"""This file contains the function used to put the mapped ffs in a list"""


def get_mapped_ffs(mapped_flipflops, impl_ffs, reversed_ffs):
    """Returns a list of mapped ffs"""

    if len(impl_ffs) == len(reversed_ffs):
        length = len(impl_ffs)
        for i in range(length):
            mapped_pair = []
            mapped_pair.append(impl_ffs[i])
            mapped_pair.append(reversed_ffs[i])
            mapped_flipflops.append(mapped_pair)

    return mapped_flipflops
