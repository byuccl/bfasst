"""
Helpers and constants for netlist obfuscation/deobfuscation
"""

TAG_PROP = "OBF_TAG"

# Strings to obfuscate LUTs
# All are unique under rotation and inversion
SENTINEL_VALUES = {
    2: "4'hD",
    3: "8'hCA",
    4: "16'hC96A",
    5: "32'hD7314A6E",
    6: "64'hD7314A6E96B3C58A",
}


def get_masking_init(lut_size: int) -> str:
    """
    Return an INIT string from SENTINEL_VALUES
    """
    if lut_size not in SENTINEL_VALUES:
        raise ValueError(f"No parity mask for LUT{lut_size}")
    return SENTINEL_VALUES[lut_size]
