""" Helper functions for structural.py """


def create_cell_props() -> dict:
    """Creates a dictionary of cell properties for each cell type."""
    init_only = (
        "LUT6_2",
        "RAM32X1S",
        "RAM32X1D",
        "RAM32X1S_1",
        "RAM32X1D_1",
        "RAM64X1D",
        "RAM256X1S",
        "SRL16E",
        "SRLC16E",
        "SRLC32E",
        "FDSE",
        "FDRE",
        "FDCE",
        "FDPE",
        "LDCE",
    )

    no_props = ("IBUF", "OBUF", "OBUFT", "MUXF7", "MUXF8", "CARRY4", "IOBUF", "GND", "VCC")

    cell_props = {x: ("INIT",) for x in init_only}
    cell_props.update({x: () for x in no_props})
    cell_props["RAM32M"] = ("INIT_A", "INIT_B", "INIT_C", "INIT_D")
    cell_props["RAM64M"] = ("INIT_A", "INIT_B", "INIT_C", "INIT_D")
    cell_props["RAMB36E1"] = tuple(
        [f"INIT_{i:02X}" for i in range(int("0x80", base=16))] + ["DOA_REG", "DOB_REG", "RAM_MODE"]
    )
    # TODO add INIT_A, INIT_B, INITP_00 - INITP_0F
    cell_props["RAMB18E1"] = tuple(
        f"INIT_{i:02X}" for i in range(int("0x40", base=16))
    )  # TODO add INIT_A, INIT_B, INITP_00 - INITP_07
    cell_props["BUFGCTRL"] = (
        "INIT_OUT",
        "IS_CE0_INVERTED",
        "IS_CE1_INVERTED",
        "IS_IGNORE0_INVERTED",
        "IS_IGNORE1_INVERTED",
        "IS_S0_INVERTED",
        "IS_S1_INVERTED",
        "PRESELECT_I0",
        "PRESELECT_I1",
    )
    cell_props["DSP48E1"] = (
        "ACASCREG",
        "ADREG",
        "A_INPUT",
        "ALUMODEREG",
        "AREG",
        "AUTORESET_PATDET",
        "BCASCREG",
        "B_INPUT",
        "BREG",
        "CARRYINREG",
        "CARRYINSELREG",
        "CREG",
        "DREG",
        "INMODEREG",
        "MASK",
        "MREG",
        "OPMODEREG",
        "PATTERN",
        "PREG",
        "SEL_MASK",
        "SEL_PATTERN",
        "USE_DPORT",
        "USE_MULT",
        "USE_PATTERN_DETECT",
        "USE_SIMD",
    )

    return cell_props


def count_num_const(pins) -> int:
    return sum(1 for pin in pins if pin.net and (pin.net.is_gnd or pin.net.is_vdd))
