"""
Helpers and constants for netlist obfuscation/deobfuscation
"""

import random
import re
import logging
from typing import List

TAG_PROP = "OBF_TAG"


_INIT_RE = re.compile(r"^(\d+)'([hb])([0-9a-fA-F]+)$", re.IGNORECASE)
def parse_init(lit: str) -> tuple[int, int] | None:
    """
    Parse "<W>'h<HEX>" or "<W>'b<BIN>" → (width, value).
    Return None if not matched.
    """
    m = _INIT_RE.fullmatch(lit.strip())
    if not m:
        return None
    width = int(m.group(1))
    base = m.group(2).lower()
    digits = m.group(3)
    if base == 'h':
        value = int(digits, 16)
    elif base == 'b':
        value = int(digits, 2)
    else:
        return None  # unsupported base
    return width, value


def format_init(width_bits: int, value_int: int) -> str:
    value_masked = value_int & ((1 << width_bits) - 1)

    if width_bits == 1:
        return f"1'b{value_masked}"
    
    hex_digits = (width_bits + 3) // 4
    return f"{width_bits}'h{value_masked:0{hex_digits}X}"


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
                if bits[a] ^ bits[b]:  # exactly one is 1
                    if rng(2):  # 50 % probability – random
                        bits[a], bits[b] = bits[b], bits[a]

    # Reassemble integer
    new_init = 0
    for i, bit in enumerate(bits):
        new_init |= bit << i
    return new_init


def shuffle_preserve_bucket(init, size):
    pins = _active_pins(init, size)
    # 1. Partition minterms by the *fastest* pin
    fastest = max(pins)  # e.g. 5 for LUT6
    half = 1 << fastest
    # Each pair (m, m^half) must still differ after shuffle
    bits = [(init >> i) & 1 for i in range(1 << size)]
    pairs = [(i, i ^ half) for i in range(half)]
    ones_in_fast = sum(bits[a] ^ bits[b] for a, b in pairs)
    for a, b in random.sample(pairs, len(pairs)):  # random order
        if bits[a] ^ bits[b]:
            # swap with 50 % chance but keep the same (#pairs with diff)
            if random.getrandbits(1):
                bits[a], bits[b] = bits[b], bits[a]
    # reassemble
    new = 0
    for i, b in enumerate(bits):
        new |= b << i
    return new if new != init else shuffle_preserve_bucket(init, size)


SENTINEL_VALUES = {
    2: "4'h9",
    3: "8'h69",
    4: "16'h6996",
    5: "32'h69969669",
    6: "64'h6996966969969669",
}


def get_masking_init(orig_init: str, lut_size: int) -> str:
    """
    Return an INIT string from SENTINEL_VALUES
    """
    if lut_size not in SENTINEL_VALUES:
        raise ValueError(f"No parity mask for LUT{lut_size}")
    return SENTINEL_VALUES[lut_size]

