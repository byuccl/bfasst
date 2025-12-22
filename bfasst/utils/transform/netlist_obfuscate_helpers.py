"""
Helpers and constants for netlist obfuscation/deobfuscation
"""

import re

TAG_PROP = "OBF_TAG"

# SENTINEL_VALUES = {
#     2: "4'h9",
#     3: "8'h69",
#     4: "16'h6996",
#     5: "32'h69969669",
#     6: "64'h6996966969969669",
# }

SENTINEL_VALUES = {
    2: "4'hD",
    3: "8'hCA",
    4: "16'hC96A",
    5: "32'hD7314A6E",
    6: "64'hD7314A6E96B3C58A",
}


_INIT_RE = re.compile(r"^(\d+)'([hb])([0-9a-fA-F]+)$", re.IGNORECASE)


def parse_init(lit: str):
    """
    Parse "<W>'h<HEX>" or "<W>'b<BIN>" -> (width, value).
    Return None if not matched.
    """
    m = _INIT_RE.fullmatch(lit.strip())
    if not m:
        return None
    width = int(m.group(1))
    base = m.group(2).lower()
    digits = m.group(3)
    if base == "h":
        value = int(digits, 16)
    elif base == "b":
        value = int(digits, 2)
    else:
        return None
    return width, value


def format_init(width_bits: int, value_int: int, force_binary: bool = False) -> str:
    value_masked = value_int & ((1 << width_bits) - 1)

    if force_binary:
        bin_str = f"{value_masked:0{width_bits}b}"
        return f"{width_bits}'b{bin_str}"

    hex_digits = (width_bits + 3) // 4
    return f"{width_bits}'h{value_masked:0{hex_digits}X}"


# pylint: disable=unused-argument
def get_masking_init(orig_init: str, lut_size: int) -> str:
    """
    Return an INIT string from SENTINEL_VALUES
    """
    if lut_size not in SENTINEL_VALUES:
        raise ValueError(f"No parity mask for LUT{lut_size}")
    return SENTINEL_VALUES[lut_size]
