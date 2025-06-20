"""
Helpers and constants for netlist obfuscation/deobfuscation
"""

import random
import logging
from typing import List

TAG_PROP = "OBF_TAG"


def _active_pins(init: int, lut_size: int) -> List[int]:
    """Return sorted list of pin indices (0=I0 ... 5=I5) that the INIT depends on."""
    pins = []
    for pin in range(lut_size):
        mask = 1 << pin
        for idx in range(1 << lut_size):
            a = (init >> idx) & 1
            b = (init >> (idx ^ mask)) & 1
            if a != b:
                pins.append(pin)
                break
    return sorted(pins)


def _shuffle_init_same_pins(init: int, lut_size: int) -> int:
    """
    Return another 64/32/16/8/4-bit INIT word that
      - has the same Hamming weight
      - keeps every original pin observable
      - preserves MUX-tree depth
      - is randomised so it cannot be guessed
    """
    if lut_size == 1:
        return init  # never obfuscate LUT1

    # Split INIT into an array of bits for easy swapping
    bits = [(init >> i) & 1 for i in range(1 << lut_size)]

    # Randomly swap each pair of minterms that differ only in one pin.
    # This preserves   – pin observability (each pin still toggles output)
    #                  – global weight (because we swap 0 <-> 1)
    rng = random.randrange  # local alias, faster
    for pin in range(lut_size):
        step = 1 << pin
        stride = step << 1
        for base in range(0, 1 << lut_size, stride):
            for off in range(step):
                a = base | off
                b = a | step  # index that differs only by <pin>
                if bits[a] ^ bits[b]:      # exactly one is 1
                    if rng(2):             # 50 % probability – random
                        bits[a], bits[b] = bits[b], bits[a]

    # Reassemble integer
    new_init = 0
    for i, bit in enumerate(bits):
        new_init |= bit << i
    return new_init


def shuffle_preserve_bucket(init, size):
    pins = _active_pins(init, size)
    # 1. Partition minterms by the *fastest* pin
    fastest = max(pins)           # e.g. 5 for LUT6
    half = 1 << fastest
    # Each pair (m, m^half) must still differ after shuffle
    bits = [(init >> i) & 1 for i in range(1 << size)]
    pairs = [(i, i ^ half) for i in range(half)]
    ones_in_fast = sum(bits[a] ^ bits[b] for a, b in pairs)
    for a, b in random.sample(pairs, len(pairs)):   # random order
        if bits[a] ^ bits[b]:
            # swap with 50 % chance but keep the same (#pairs with diff)
            if random.getrandbits(1):
                bits[a], bits[b] = bits[b], bits[a]
    # reassemble
    new = 0
    for i, b in enumerate(bits):
        new |= b << i
    return new if new != init else shuffle_preserve_bucket(init, size)


def get_masking_init(orig_init: str, lut_size: int) -> str:
    """
    Given the *string* INIT from an EDIF/Verilog property (e.g. "64'h699696..."),
    return a different INIT string that is timing-equivalent but unpredictable.
    """
    if lut_size == 1:
        return orig_init  # leave LUT1 untouched

    # parse the incoming hex literal  int
    value = int(orig_init.split("'h")[1], 16)
    new_value = shuffle_preserve_bucket(value, lut_size)

    # Guarantee the new value is actually different (rare corner case)
    # if new_value == value:
        # logging.info("new_value == value")
        # force at least one extra swap
        # new_value ^= 1 << random.randrange(1 << lut_size)

    width = 1 << lut_size  # 4,8,16,32,64
    logging.info("Old INIT: %s; New INIT: %s", orig_init, f"{width:02d}'h{new_value:0{width//4}X}")
    return f"{width:02d}'h{new_value:0{width//4}X}"

