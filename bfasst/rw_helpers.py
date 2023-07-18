"""Helper functions for interacting with RapidWright"""

from collections.abc import MutableMapping
from fnmatch import fnmatch
from os.path import commonprefix
import re

from bidict import bidict
import spydrnet as sdn

# pylint: disable=wrong-import-position,wrong-import-order
from bfasst import jpype_jvm
from bfasst.config import PART

jpype_jvm.start()
from com.xilinx.rapidwright.design import Cell, Design, Unisim
from com.xilinx.rapidwright.design.tools import LUTTools
from com.xilinx.rapidwright.edif import EDIFDirection as RwDirection
from java.util import ArrayList as JArrayList
from java.lang import IllegalArgumentException

# pylint: enable=wrong-import-position,wrong-import-order


class RapidwrightException(Exception):
    pass


def cell_is_6lut(cell):
    """Return whether this cell is using the 6LUT BEL"""
    return fnmatch(str(cell.getBELName()), "?6LUT")


def cell_is_5lut(cell):
    """Return whether this cell is using the 5LUT BEL"""
    return fnmatch(str(cell.getBELName()), "?5LUT")


def generate_combinded_cell_name(edif_cells):
    root_name = commonprefix([str(c.getName()) for c in edif_cells])
    leaves = [str(c.getName())[len(root_name) :] for c in edif_cells]
    return f"{root_name}{'_'.join(leaves)}"


def get_net_from_edif_port(cell, port_name, edif_cell=None):
    if edif_cell is None:
        edif_port = cell.getEDIFCellInst().getPortInst(port_name)
    else:
        edif_port = edif_cell.getPortInst(port_name)
    site_pin = cell.getSitePinFromPortInst(edif_port, JArrayList())
    return site_pin.getNet()


def get_net_names_from_edif_ports(cell, port_names, edif_cell=None):
    return [
        get_net_from_edif_port(cell, port_name, edif_cell).getName() for port_name in port_names
    ]


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


def transfer_global_pins(old_cells, new_cell, global_pins):
    """
    Transfer global pin nets from old_cells to new_cell and then disconenct the
    old nets.

    This is a many to one transfer, where all of the old cells share the same
    net across their pins that should be connected to one pin on the new cell.
    Ex: a clk signal.
    """
    for logical_pin, phys_pin in global_pins.items():
        valid_net_transfer(logical_pin, phys_pin, old_cells[0], new_cell)
        for edif_cell in old_cells[1:]:
            old_port = edif_cell.getPortInst(logical_pin)
            net = old_port.getNet()
            net.removePortInst(old_port)


def remove_and_disconnect_cell(cell, log=print):
    if isinstance(cell, Cell):
        cell = cell.getEDIFHierCellInst()
    log(f"  {cell.getFullHierarchicalInstName()} removed")
    # Remove the port instances
    cell = cell.getInst()
    cell.getParentCell().removeCellInst(cell)


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


def process_shared_gnd_lut_eqn(lut5, gnd_pin, new_cell_inst, log=print):
    lut5_eqn = process_lut_eqn(lut5, True, log)
    if gnd_pin.endswith("5"):
        init_str = "64'h" + LUTTools.getLUTInitFromEquation(lut5_eqn, 5)[4:].zfill(16)
    else:
        init_str = "64'h00000000" + LUTTools.getLUTInitFromEquation(lut5_eqn, 5)[4:].zfill(8)
    log("  New LUT INIT:", init_str)
    new_cell_inst.addProperty("INIT", init_str)


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
    return [p.getName() for p in unisim_cell.getPorts() if p.getDirection() == RwDirection.INPUT]


def get_unisim_outputs(unisim):
    unisim_cell = Design.getUnisimCell(Unisim.valueOf(unisim))
    return [p.getName() for p in unisim_cell.getPorts() if p.getDirection() == RwDirection.OUTPUT]


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
    if unisim_cell.getPort(port_name).getDirection() == RwDirection.INPUT:
        return sdn.IN
    if unisim_cell.getPort(port_name).getDirection() == RwDirection.OUTPUT:
        return sdn.OUT
    if unisim_cell.getPort(port_name).getDirection() == RwDirection.INOUT:
        return sdn.INOUT

    raise RapidwrightException(f"Unknown direction for {unisim} {port_name}")


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


class _PinMap(MutableMapping):
    """
    {str: bidict} -> {unisim cell name: logical to physical pin mapping}
    Currently only intended for UNISIM cells with a 1 to 1 logical to physical
    mapping.  If an unisim cell does not have eligble placement sites, it can
    be manually added in the __init__ method.

    getCompatiblePlacements doesnt seem to support LUT6_2, BUFG,
    """

    def __init__(self, *args, **kwargs):
        self.store = {}
        self.update(dict(*args, **kwargs))
        self.design = Design("empty", PART)
        self.device = self.design.getDevice()
        self.store["LUT6_2"] = self._get_mapping("LUT6")

    def _assert_len(self, pins):
        assert len(pins) == 1
        return True

    def _get_mapping(self, unisim):
        cell_name = f"{unisim}_tmp"
        try:
            unisim_cell = self.design.createCell(cell_name, Unisim.valueOf(unisim))
        except IllegalArgumentException as e:
            self.design.getTopEDIFCell().removeCellInst(cell_name)
            self.design.removeCell(cell_name)
            raise KeyError(f"Unisim cell {unisim} not found.") from e
        placements = unisim_cell.getCompatiblePlacements()
        assert placements
        sites = {k: self.device.getAllCompatibleSites(k) for k in placements}
        mappings = []
        for site_type, bels in placements.items():
            site = sites[site_type][0]
            for bel in bels:
                assert self.design.placeCell(unisim_cell, site, site.getBEL(bel))
                l2p = unisim_cell.getPinMappingsL2P()
                mappings.append({k: set(v).pop() for k, v in l2p.items() if self._assert_len(v)})
                unisim_cell.unplace()
        for mapping in mappings:
            assert mapping == mappings[0]
        self.design.getTopEDIFCell().removeCellInst(cell_name)
        self.design.removeCell(cell_name)
        return bidict(mappings[0])

    def __getitem__(self, key):
        key = self._keytransform(key)
        if key not in self.store:
            self.store[key] = self._get_mapping(key)
        return self.store[key]

    def __setitem__(self, key, value):
        self.store[self._keytransform(key)] = value

    def __delitem__(self, key):
        del self.store[self._keytransform(key)]

    def __iter__(self):
        return iter(self.store)

    def __len__(self):
        return len(self.store)

    def _keytransform(self, key):
        return key

    def cell_is_default_mapping(self, cell):
        """
        This checks whether the cell is using the default logical to physical mappings.

        Parameters:
            cell (rapidwright.Cell)
        """
        type_name = cell.getEDIFCellInst().getCellType().getName()
        l2p = {k: frozenset(v) for k, v in cell.getPinMappingsL2P().items()}

        for logical, physical in self[type_name].items():
            if logical in l2p and set(l2p[logical]) != set(physical):
                print(set(l2p[logical]), "<>", set(physical))
                return False

        return True


PinMap = _PinMapping()
