"""Helper functions for interacting with RapidWright"""

from collections.abc import MutableMapping
from fnmatch import fnmatch
import logging
from os.path import commonprefix
import re

from bidict import bidict
import spydrnet as sdn

# pylint: disable=wrong-import-position,wrong-import-order
from bfasst import jpype_jvm
from bfasst.config import PART

jpype_jvm.start()
from com.xilinx.rapidwright.device import BELPin
from com.xilinx.rapidwright.design import Cell, Design, SiteInst, SitePinInst, Unisim
from com.xilinx.rapidwright.design.DesignTools import getConnectionPIPs
from com.xilinx.rapidwright.design.tools import LUTTools
from com.xilinx.rapidwright.edif import EDIFDirection as RwDirection
from com.xilinx.rapidwright.edif import EDIFCellInst, EDIFHierPortInst, EDIFPortInst, EDIFNet
from java.util import ArrayList as JArrayList
from java.lang import IllegalArgumentException

# pylint: enable=wrong-import-position,wrong-import-order


class RapidwrightException(Exception):
    pass


def is_static_net(net: EDIFNet) -> bool:
    return net.isGND() or net.isVCC()


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


def generate_lut62_name(lut6_edif_cell_inst, lut6_cell, lut5_cell):
    """Create name for luts combined onto single LUT6_2"""
    site_str = str(lut6_cell.getSite()).rsplit("_", maxsplit=1)[-1]
    new_cell_name = lut6_edif_cell_inst.getName() + f"_{site_str}_{lut6_cell.getBELName()}_phys"

    # Check routethru
    if lut6_cell.isRoutethru() and (lut5_cell is None or lut5_cell.isRoutethru()):
        new_cell_name = (
            lut6_edif_cell_inst.getName()
            + f"_routethru_{site_str}_"
            + str(lut6_cell.getBEL().getName())[0]
        )

    if lut5_cell:
        new_cell_name += "_shared"
    return new_cell_name


def generate_const_lut_name(site_inst, pins):
    suffix = ""
    for pin, is_gnd in pins:
        suffix += f"{pin}.{'GND' if is_gnd else 'VCC'}"
    return str(site_inst.getName()) + suffix


def generate_const_rt_lut_name(lut5_edif_cell_inst, lut5, const_type, const_pin):
    """Generate name for a signal rt lut combined with a const rt lut"""
    tmp = (
        f"_routethru_{str(lut5.getBEL().getName())[0:2]}"
        if lut5.isRoutethru()
        else str(lut5.getBEL().getName())
    )
    site_str = str(lut5.getSite()).rsplit("_", maxsplit=1)[-1]
    name = (
        f"{lut5_edif_cell_inst.getName()}_{site_str}_{tmp}_"
        + f"{const_type}_{const_pin}_phys_shared"
    )
    return name


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
    remove the old cell from the net.

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


def combine_const_nets(port, old_insts, new_inst, unisim_cell, log=logging.warning):
    """
    Moves the connections from multiple const nets to a single const net

    Parameters:
    port      (str)
    old_insts (list[EDIFCellInst])
    new_inst  (EDIFCellInst)
    unisim_cell (Unisim.GND or Unisim.VCC) type of constant net to combine
    """
    net_name = new_inst.getPortInst(port).getNet().getName()
    unisim = "GND" if unisim_cell == Unisim.GND else "VCC"
    log(
        "WARNING: Multiple constant %s nets found in netlist. Using first one: %s",
        unisim,
        net_name,
    )

    for old_inst in old_insts:
        old_net = old_inst.getPortInst(port).getNet()
        main_net = new_inst.getPortInst(port).getNet()
        port_insts = list(old_net.getPortInsts())
        ground_instances = []
        for port_inst in port_insts:
            if not port_inst.isPrimitiveStaticSource():
                old_net.removePortInst(port_inst)
                main_net.addPortInst(port_inst)
            else:
                ground_instances.append(port_inst)
        for ground_instance in ground_instances:
            old_net.removePortInst(ground_instance)


def remove_and_disconnect_cell(cell):
    if isinstance(cell, Cell):
        cell = cell.getEDIFHierCellInst()
    if cell.getInst().getParentCell() is not None:
        logging.info("  %s removed", cell.getFullHierarchicalInstName())
        # Remove the port instances
        cell = cell.getInst()
        cell.getParentCell().removeCellInst(cell)
    else:
        logging.warning(
            "Warning: %s not removed, no parent cell found", cell.getFullHierarchicalInstName()
        )


def lut_move_net_to_new_cell(
    edif_cell_insts,
    old_logical_pin,
    physical_pin,
    log=logging.info,
    already_connected_net=None,
):
    """This function connects the net from old_edif_cell_inst/old_logical_pin,
    to the appropriate logical pin on the new_edif_cell_inst, based on the physical pin,
    and disconnects from the old cell.  It's possible the net is already_connected to the
    new cell, in which case only the disconnect from old cell needs to be performed."""

    log(f"  Processing logical pin {old_logical_pin}, physical pin {physical_pin}")

    old_edif_cell_inst, new_edif_cell_inst = edif_cell_insts

    port_inst = old_edif_cell_inst.getPortInst(old_logical_pin)
    assert port_inst
    logical_net = port_inst.getNet()
    assert logical_net

    if already_connected_net:
        if logical_net == already_connected_net or logical_net.isInternalToParent():
            log(f"    Skipping already connected physical pin {physical_pin}")
        else:
            raise RapidwrightException(
                f"Conflicting net found on lut {old_edif_cell_inst} for "
                + f"logical/physical pin {old_logical_pin}/{physical_pin}. Net {logical_net} "
                + f"!= {already_connected_net}"
            )

    else:
        if port_inst.getDirection() == RwDirection.INPUT:
            log(f"    Input driven by net {logical_net}")

            # A5 becomes I4, A1 becomes I0, etc.
            new_logical_pin = f"I{int(str(physical_pin[1])) - 1}"
            log(f"    Connecting net {logical_net} to input pin {new_logical_pin} on new cell")

        elif port_inst.getDirection() == RwDirection.OUTPUT:
            log(f"    Drives net {logical_net}")

            new_logical_pin = physical_pin
            log(f"    Connecting net {logical_net} to output pin {new_logical_pin}")

        new_port = new_edif_cell_inst.getPort(new_logical_pin)
        assert new_port
        logical_net.createPortInst(new_port, new_edif_cell_inst)

    # Disconnect connection to port on old cell
    log(f"    Disconnecting net {logical_net} from pin {old_logical_pin} on old cell")
    logical_net.removePortInst(port_inst)


def process_lut_eqn(cell, is_lut5, log=logging.info):
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

    log(f"  LUT{s6_or_5} INIT: {cell.getProperty('INIT')}")
    log(f"  LUT{s6_or_5} equation: {orig_init_eqn}")

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
    return eqn


def process_shared_gnd_lut_eqn(lut5, gnd_pin, new_cell_inst, is_gnd, log=logging.info):
    lut5_eqn = process_lut_eqn(lut5, True, log)
    const_str = "00000000" if is_gnd else "FFFFFFFF"
    if gnd_pin.endswith("O5"):
        init_str = "64'h" + LUTTools.getLUTInitFromEquation(lut5_eqn, 5)[4:].zfill(8) + const_str
    else:
        init_str = f"64'h{const_str}" + LUTTools.getLUTInitFromEquation(lut5_eqn, 5)[4:].zfill(8)
    log(f"  New LUT INIT: {init_str}")
    new_cell_inst.addProperty("INIT", init_str)


def process_lut_init(lut6_cell, lut5_cell, log=logging.info):
    """Fix the LUT INIT property for the new_cell_inst"""

    lut6_eqn_phys = None
    if lut6_cell:
        lut6_eqn_phys = process_lut_eqn(lut6_cell, False, log)

    lut5_eqn_phys = None
    if lut5_cell:
        lut5_eqn_phys = process_lut_eqn(lut5_cell, True, log)

    if not lut5_cell:
        assert lut6_eqn_phys is not None
        init_str = "64'h" + LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 6)[4:].zfill(16)
    elif not lut6_cell:
        assert lut5_eqn_phys is not None
        init_str = "64'h00000000" + LUTTools.getLUTInitFromEquation(lut5_eqn_phys, 5)[4:].zfill(8)
    else:
        assert lut6_eqn_phys is not None
        assert lut5_eqn_phys is not None
        init_str = (
            "64'h"
            + LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 5)[4:].zfill(8)
            + LUTTools.getLUTInitFromEquation(lut5_eqn_phys, 5)[4:].zfill(8)
        )
    return init_str


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


def flip_const_port_signal(
    design: Design, ecell: EDIFCellInst, port_name: str, idx=-1, log=logging.info
):
    """Flip the constant port signal for a given port in an EDIF cell instance."""
    port_inst = ecell.getPortInst(port_name)
    if port_inst is None:
        log("Port %s disconnected... Assuming gnd and flipping to vcc", port_name)
        EDIFPortInst(ecell.getPort(port_name), design.getVccNet().getLogicalNet(), idx, ecell)
        return
    old_net = port_inst.getNet()
    if old_net.isGND():
        log("\tSetting %s to VCC (was GND)", str(port_inst))
        old_net.removePortInst(port_inst)
        design.getVccNet().getLogicalNet().addPortInst(port_inst)
    elif old_net.isVCC():
        log("\tSetting %s to GND (was VCC)", str(port_inst))
        old_net.removePortInst(port_inst)
        design.getGndNet().getLogicalNet().addPortInst(port_inst)
    else:
        logging.info("F2B marked non static port %s inverted, no action taken", str(port_inst))


def create_lut_routethru_net(cell: Cell, is_lut5: bool, new_lut_cell: EDIFCellInst) -> None:
    """
    Extra processing for LUT route through.  Need to create a new net
    connecting from the new LUT6_2 instance to the FF
    """
    logging.info("Creating routethru for %s", cell.getName())

    site_str = str(cell.getSite()).rsplit("_", maxsplit=1)[-1]
    # Create the new net
    new_net_name = (
        cell.getName()
        + f"_routethru_{site_str}:"
        + str(cell.getBEL().getName())[0]
        + ("6" if not is_lut5 else "5")
    )
    logging.info("  Creating new net %s", new_net_name)
    new_net = EDIFNet(new_net_name, cell.getEDIFCellInst().getParentCell())

    # Connect net to LUT output
    lut_out_port = new_lut_cell.getPort("O5" if is_lut5 else "O6")
    assert lut_out_port
    logging.info("  Connecting new net to LUT %s port %s", new_lut_cell, lut_out_port)
    new_net.createPortInst(lut_out_port, new_lut_cell)

    # Connect net to the input of the other cell in this site (FF, CARRY4)
    matching_cells = [
        c
        for c in cell.getSiteInst().getCells()
        if c.getName() == cell.getName() and not c.isRoutethru()
    ]
    assert len(matching_cells) == 1
    routed_to_cell = matching_cells[0]
    routed_to_cell_inst = routed_to_cell.getEDIFCellInst()

    # First figure out which logical pin this routethru goes to.
    # Even though we are calling the gePinMappingsL2P on the LUT cell,
    # it doesn't actually return the logical pin on the LUT, but rather
    # the downstream cell (FF, CARRY4).
    logical_pins = list(cell.getPinMappingsL2P().keys())
    assert len(logical_pins) == 1
    dest_port = str(logical_pins[0])

    dest_port_inst = routed_to_cell_inst.getPortInst(dest_port)
    assert dest_port_inst

    logging.info("  Connecting new net to BEL %s, port %s", routed_to_cell.getBELName(), dest_port)
    new_net.addPortInst(dest_port_inst)


def get_cells_from_site_pin(
    sink_pin: SitePinInst, sink_site: SiteInst
) -> list[tuple[Cell, BELPin]]:
    """
    Get the cells that are driven by this site pin.
    Currently assumes at most one site pip in between the site pin and the cell.
    """
    cells = []
    for pin in sink_pin.getSiteWireBELPins():
        cell = sink_site.getCell(pin.getBEL())
        if cell is not None:
            cells.append((cell, pin))
        elif sink_site.getUsedSitePIP(pin) is not None:
            wire = sink_site.getUsedSitePIP(pin).getOutputPin().getSiteWireName()
            for bp in (t for t in sink_site.getSiteWirePins(wire) if t != pin and t.isInput()):
                cell = sink_site.getCell(bp.getBEL())
                if cell is not None:
                    cells.append((cell, bp))
    return cells


def get_site_pin_driver(sink_pin: SitePinInst, design: Design):
    """Look at the intersite connection to get the site pin that drives sink_pin."""
    drv_node = getConnectionPIPs(sink_pin)[-1].getStartNode()
    drv_pin = drv_node.getSitePin()
    src_site_inst = design.getSiteInstFromSite(drv_pin.getSite())
    spi = src_site_inst.getSitePinInst(drv_pin.getPinName())
    return spi


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
                logging.warning(list(l2p[logical]), "<>", [physical])
                return False

        return True

    def ensure_connected(self, edif_cell_inst, net, log=logging.info):
        """
        Ensure that all ports on the cell are connected to the net.

        Sometimes Vivado leaves ports undriven, which can cause the port to not be
        explicitly shown in the verilog netlist.  This can cause issues since
        spydrnet will not infer ground for these signals. Use this function to make
        sure all ports are shown by connecting them.
        """

        type_name = edif_cell_inst.getCellType().getName()
        port_names = self.CELL_PIN_MAP[type_name]

        for phys_name, log_name in port_names.items():
            port = edif_cell_inst.getPortInst(phys_name)
            if port is None:
                log(
                    f"  Port {phys_name} not found on {edif_cell_inst.getName()}, connecting to net"
                )
                new_port = edif_cell_inst.getPort(log_name)
                net.createPortInst(new_port, edif_cell_inst)


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


def is_connected(port_inst: EDIFHierPortInst) -> bool:
    """
    A net is considered connected if it's connected to more than 1 port
    """
    net = port_inst.getHierarchicalNet()
    if net is None:
        return False
    if not len(net.getPortInsts()) > 1:
        return False
    return len(net.getLeafHierPortInsts(False, True)) > 0


def check_connected_ports(num_ports: int, port_insts: list[EDIFHierPortInst]) -> bool:
    """
    Sometimes unconnected output ports are included in the number
    of ports in the reversed netlist. This compares the number of
    only connected ports.
    """
    return num_ports == sum(is_connected(port_inst) for port_inst in port_insts)
