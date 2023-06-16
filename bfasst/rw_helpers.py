"""Helper functions for interacting with RapidWright"""

from fnmatch import fnmatch
from os.path import commonprefix
import re

from bidict import bidict
import spydrnet as sdn

# pylint: disable=wrong-import-position,wrong-import-order
from bfasst import jpype_jvm

jpype_jvm.start()
from com.xilinx.rapidwright.design import Design, Unisim
from com.xilinx.rapidwright.design.tools import LUTTools
from com.xilinx.rapidwright.edif import EDIFDirection as RwDirection
from java.util import ArrayList as JArrayList

# pylint: enable=wrong-import-position,wrong-import-order


class RapidwrightException(Exception):
    pass


class _PinMapping:
    """
    Check default pin mappings for unisim types.
    """

    # TODO see if this can be pulled out of rw.
    # Maybe place an UNISIM cell and then check the l2p port mapping?
    CELL_PIN_MAP = {
        "MUXF7": bidict(
            {
                "I0": "0",
                "I1": "1",
                "S": "S0",
                "O": "OUT",
            }
        ),
        "MUXF8": bidict(
            {
                "I0": "0",
                "I1": "1",
                "S": "S0",
                "O": "OUT",
            }
        ),
        "CARRY4": bidict(
            {
                "DI[3]": "DI3",
                "DI[2]": "DI2",
                "DI[1]": "DI1",
                "DI[0]": "DI0",
                "CI": "CIN",
                "CO[3]": "CO3",
                "CO[2]": "CO2",
                "CO[1]": "CO1",
                "CO[0]": "CO0",
                "O[3]": "O3",
                "O[2]": "O2",
                "O[1]": "O1",
                "O[0]": "O0",
                "S[3]": "S3",
                "S[2]": "S2",
                "S[1]": "S1",
                "S[0]": "S0",
                "CYINIT": "CYINIT",
            }
        ),
        "BUFG": bidict({"I": "I0", "O": "O"}),
        "LUT6_2": bidict(
            {
                "I0": "A1",
                "I1": "A2",
                "I2": "A3",
                "I3": "A4",
                "I4": "A5",
                "I5": "A6",
                "O5": "O5",
                "O6": "O6",
            }
        ),
        "LUT6": bidict(
            {
                "I0": "A1",
                "I1": "A2",
                "I2": "A3",
                "I3": "A4",
                "I4": "A5",
                "I5": "A6",
                "O5": "O5",
                "O6": "O6",
            }
        ),
    }

    def __getitem__(self, attr):
        return self.CELL_PIN_MAP[attr]

    def cell_is_default_mapping(self, cell):
        """
        This checks whether the cell is using the default logical to physical mappings.

        Parameters:
            cell (rapidwright.Cell)
        """
        type_name = cell.getEDIFCellInst().getCellType().getName()
        default_l2p_map = self.CELL_PIN_MAP[type_name]

        l2p = cell.getPinMappingsL2P()
        for logical, physical in default_l2p_map.items():
            if logical in l2p and list(l2p[logical]) != [physical]:
                print(list(l2p[logical]), "<>", [physical])
                return False

        return True


PinMapping = _PinMapping()


def cell_is_6lut(cell):
    """Return whether this cell is using the 6LUT BEL"""
    return fnmatch(str(cell.getBELName()), "?6LUT")


def cell_is_5lut(cell):
    """Return whether this cell is using the 5LUT BEL"""
    return fnmatch(str(cell.getBELName()), "?5LUT")


def generate_combinded_cell_name(edif_cells):
    root_name = commonprefix([str(c.getName()) for c in edif_cells])
    leaves = [str(c.getName())[len(root_name) :] for c in edif_cells]
    return f"{root_name}ram32m_{'_'.join(leaves)}_phys"


def get_net_from_edif_port(cell, port_name, edif_cell=None):
    if edif_cell is None:
        edif_port = cell.getEDIFCellInst().getPortInst(port_name)
    else:
        edif_port = edif_cell.getPortInst(port_name)
    site_pin = cell.getSitePinFromPortInst(edif_port, JArrayList())
    return site_pin.getNet()


def valid_bus_transfer(logical_pins, dest_bus, old_edif_cell_inst, new_edif_cell_inst):
    """
    Check valid pin format and wire up logical pins from old cell to bus on new cell.

    Parameters:
    logical_pin (list) -> Ordered list of logical pins to transfer (e.g. ['A0', 'A1', 'A2']])
    dest_bus (str) -> Name of bus on new edif cell to transfer pins to.
                        If >= len(logical_pins), then upper pins are left unconnected.
    old_edif_cell_inst (EDIFCellInst)
    new_edif_cell_inst (EDIFCellInst)
    """

    bus = new_edif_cell_inst.getPort(dest_bus)
    assert bus.getWidth() >= len(logical_pins)

    for i, logical_pin in enumerate(logical_pins):
        old_port = old_edif_cell_inst.getPortInst(logical_pin)
        assert old_port

        logical_net = old_port.getNet()
        assert logical_net

        new_port = bus.getPortInstNameFromPort(bus.getPortIndexFromNameIndex(i))
        assert new_port

        logical_net.createPortInst(new_port, new_edif_cell_inst)
        logical_net.removePortInst(old_port)


def valid_net_transfer(logical_pin, physical_pin, old_edif_cell_inst, new_edif_cell_inst):
    """
    Run assertions to check pin format and pin to port mapping then add new cell to the net and
    remove the old cell.

    Assumes that the new logical pin equals the old physical pin.  (LUTs
    are treated differently. See lut_move_net_to_new_cell).

    Parameters:
    logical_pin (str) -> logical pin to transfer (e.g. 'A0')
    physical_pin (iterable) -> physical pin for new net. len() == 1
    old_edif_cell_inst (EDIFCellInst)
    new_edif_cell_inst (EDIFCellInst)
    """

    assert len(physical_pin) == 1
    physical_pin = list(physical_pin)[0]

    old_port = old_edif_cell_inst.getPortInst(logical_pin)
    assert old_port

    logical_net = old_port.getNet()
    assert logical_net

    new_port = new_edif_cell_inst.getPort(physical_pin)
    assert new_port

    logical_net.createPortInst(new_port, new_edif_cell_inst)
    logical_net.removePortInst(old_port)


def process_lut_eqn(cell, is_lut5, log=print):
    """Transform a logical lut equation into a physical lut equation"""

    s6_or_5 = "5" if is_lut5 else "6"

    # The process is different for LUT routethrus as they don't really exist
    # in the EDIF netlist, and as such don't have equations or INIT strings.
    # Instead, we just look at which physical input pin is used for the
    # routethrough and generate a simple O=I<X> equation
    if cell.isRoutethru():
        assert len(cell.getPinMappingsL2P()) == 1
        physical_pins = list(list(cell.getPinMappingsL2P().values())[0])

        # Make sure this maps to only one physical pion
        assert len(physical_pins) == 1
        physical_pin = str(physical_pins[0])
        eqn = "O=I" + str(int(physical_pin[1]) - 1)
        log(f"  LUT{s6_or_5} is routethru using physical pin {physical_pin}, creating eqn {eqn}")
        return eqn

    # First get an equation from the logical INIT string
    orig_init_eqn = str(LUTTools.getLUTEquation(cell))

    log(f"  LUT{s6_or_5} INIT:", cell.getProperty("INIT"))
    log(f"  LUT{s6_or_5} equation:", orig_init_eqn)

    eqn = orig_init_eqn
    for logical_pin, physical_pin in cell.getPinMappingsL2P().items():
        # Skip the output pin
        if str(physical_pin).startswith("[O"):
            continue

        matches = re.match(r"\[A(\d)\]", str(physical_pin))
        assert matches

        # A5 becomes I4, A1 becomes I0, etc, so subtract 1, but
        # don't replace A with I yet, until all replacements are done.
        physical_pin = int(matches[1]) - 1

        eqn = eqn.replace(str(logical_pin), "A" + str(physical_pin))

    # Physical LUT inputs use A#, but LUTTools expect I#
    eqn = eqn.replace("A", "I")

    log(f"  New LUT{s6_or_5} eqn:", eqn)
    return eqn


def process_lut_init(lut6_cell, lut5_cell, new_cell_inst, log=print):
    """Fix the LUT INIT property for the new_cell_inst"""

    log("Fixing INIT string")

    lut6_eqn_phys = process_lut_eqn(lut6_cell, False, log)

    if lut5_cell:
        lut5_eqn_phys = process_lut_eqn(lut5_cell, True, log)

    if not lut5_cell:
        init_str = "64'h" + LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 6)[4:].zfill(16)
    else:
        init_str = (
            "64'h"
            + LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 5)[4:].zfill(8)
            + LUTTools.getLUTInitFromEquation(lut5_eqn_phys, 5)[4:].zfill(8)
        )
    log("  New LUT INIT:", init_str)
    new_cell_inst.addProperty("INIT", init_str)


def get_unisim_inputs(unisim):
    unisim_cell = Design.getUnisimCell(Unisim.valueOf(unisim))
    return [p.getName() for p in unisim_cell.getPorts() if p.getDirection() == RwDirection.IN]


def get_unisim_outputs(unisim):
    unisim_cell = Design.getUnisimCell(Unisim.valueOf(unisim))
    return [p.getName() for p in unisim_cell.getPorts() if p.getDirection() == RwDirection.OUT]


def get_sdn_direction_for_unisim(unisim, port_name):
    """
    Get a pin direction for a UNISIM cell

    Parameters:
    unisim (str) -> UNISIM cell name
    port_name (str) -> port name

    Return:
    spydrnet.ir.Port.Direction
    """

    unisim_cell = Design.getUnisimCell(Unisim.valueOf(unisim))
    if unisim_cell.getPort(port_name).getDirection() == RwDirection.IN:
        return sdn.IN
    elif unisim_cell.getPort(port_name).getDirection() == RwDirection.OUT:
        return sdn.OUT
    elif unisim_cell.getPort(port_name).getDirection() == RwDirection.INOUT:
        return sdn.INOUT
