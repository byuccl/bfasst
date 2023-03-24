""" Creates a xilinx netlist that has only physical primitives"""

from fnmatch import fnmatch
import pathlib
import re
import subprocess
import sys
import jpype
import jpype.imports
from jpype.types import JInt

from bfasst.config import VIVADO_BIN_PATH
from bfasst.paths import THIRD_PARTY_PATH
from bfasst.status import Status, TransformStatus
from bfasst.tool import ToolProduct
from bfasst.transform.base import TransformTool
from bfasst.utils import TermColor, print_color

jpype.startJVM(
    classpath=[
        str(THIRD_PARTY_PATH / "RapidWright" / "bin"),
        *(str(s) for s in (THIRD_PARTY_PATH / "RapidWright" / "jars").glob("*.jar")),
    ]
)
# pylint: disable=wrong-import-position,wrong-import-order
from com.xilinx.rapidwright.design import Design, Unisim
from com.xilinx.rapidwright.edif import EDIFDirection, EDIFNet
from com.xilinx.rapidwright.design.tools import LUTTools
from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order


class RapidwrightException(Exception):
    pass


class XilinxPhysNetlist(TransformTool):
    """Creates a xilinx netlist that has only physical primitives"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "xilinx_phys_netlist"

    STD_PIN_MAP_BY_CELL = {
        "MUXF7": {
            "I0": "0",
            "I1": "1",
            "S": "S0",
            "O": "OUT",
        },
        "MUXF8": {
            "I0": "0",
            "I1": "1",
            "S": "S0",
            "O": "OUT",
        },
        "CARRY4": {
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
        },
        "BUFG": {"I": "I0", "O": "O"},
    }

    def run(self, design):
        """Transform the logical netlist into a netlist with only physical primitives"""
        phys_netlist_verilog_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_physical.v"
        )
        phys_netlist_edif_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_physical.edf"
        )
        design.impl_netlist_path = phys_netlist_verilog_path

        # Redirect rapidwright output to file
        System.setOut(PrintStream(File(str(self.work_dir / "rapidwright_stdout.log"))))

        # Check for up to date previous run
        status = self.get_prev_run_status(
            tool_products=[
                ToolProduct(phys_netlist_verilog_path),
            ],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime,
                design.xilinx_impl_checkpoint_path.stat().st_mtime,
                design.impl_edif_path.stat().st_mtime,
            ),
        )

        if status is not None:
            print_color(self.TERM_COLOR_STAGE, "Physical Netlist conversion already run")
            return status

        self.open_new_log()
        self.log_color(
            TermColor.GREEN,
            "Starting logical to physical netlist conversion for",
            design.xilinx_impl_checkpoint_path,
            design.impl_edif_path,
            add_timestamp=True,
        )

        phys_netlist_checkpoint = self.work_dir / "phys_netlist.dcp"

        # Catch all Java exceptions since they are not picklable,
        # and so cannot be handled properly by multiprocessing
        # Don't raise from as this is also problematic.
        try:
            self.run_rapidwright(design, phys_netlist_checkpoint, phys_netlist_edif_path)
        except jpype.JException as exc:
            raise RapidwrightException(str(exc))  # pylint: disable=raise-missing-from

        status = self.export_new_netlist(phys_netlist_checkpoint, phys_netlist_verilog_path)

        return status

    def run_rapidwright(self, design, phys_netlist_checkpoint, phys_netlist_edif_path):
        """Do all rapidwright related processing on the netlist"""

        # Read the checkpoint into rapidwright, and get the netlist
        rw_design = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)

        netlist = rw_design.getNetlist()

        # Get the LUT6_2 EDIFCell (all LUTs will be replaced with equivalent LUT6_2 primitives)
        lut6_2_edif_cell = netlist.getHDIPrimitive(Unisim.LUT6_2)

        # Init BUFGCTRL cell template
        self.bufgctrl_edif_cell = netlist.getHDIPrimitive(Unisim.BUFGCTRL)
        self.vcc_edif_net = rw_design.getVccNet().getLogicalNet()

        # Keep a list of old replaced cells to remove after processing
        cells_to_remove = []

        # Keep a list of cells already visited and skip them
        # This happens when we process LUTS mapped to the same BEL
        cells_already_visited = set()

        # Loop through all cells in the design
        # TODO: getCells(), doesn't return routethru cells.  However, getSiteInst().getCells() DOES,
        # so we are probably finding them fine..as long as we never have two routethurs on the same
        # LUT6_2.  Not sure if this is possible, but perhaps we shoudl check for this case.
        # https://github.com/Xilinx/RapidWright/issues/36
        # Seems possible to happen (https://github.com/Xilinx/RapidWright/issues/226)
        for cell in rw_design.getCells():
            edif_cell_inst = cell.getEDIFCellInst()

            print_color(
                TermColor.RED,
                cell.getName(),
                f"({edif_cell_inst.getCellType().getName() if edif_cell_inst else 'None'})",
            )

            if edif_cell_inst is None:
                self.log("  Skipping")
                continue

            if cell in cells_already_visited:
                continue

            # Handle LUT cells
            if fnmatch(str(cell.getBELName()), "??LUT"):
                # Replace the LUT(s) with a LUT2_6
                cells_to_remove.extend(
                    self.process_lut(cell, lut6_2_edif_cell, cells_already_visited)
                )
                continue

            cell_type = edif_cell_inst.getCellType().getName()
            if cell_type in ("MUXF7", "MUXF8"):
                cells_to_remove.extend(self.process_muxf7_muxf8(cell))
                continue

            if cell_type in ("CARRY4",):
                cells_to_remove.extend(self.process_carry4(cell))
                continue

            if cell_type in ("BUFG",):
                cells_to_remove.extend(self.process_bufg(cell))
                continue

            # These primitives don't need to get transformed
            if cell_type in ("IBUF", "OBUF", "OBUFT", "FDSE", "FDRE"):
                continue

            # TODO: Handle other primitives? RAM*, BUFG->BUFGCTRL, etc.
            print(cell)
            return Status(
                TransformStatus.ERROR,
                f"Unhandled primitive {cell_type}",
            )

        # Remove old unusued cells
        self.log("Removing old cells...")
        for cell in cells_to_remove:
            self.log("  ", cell.getName())
            edif_cell_inst = cell.getEDIFCellInst()

            # Remove the port instances
            edif_cell_inst.getParentCell().removeCellInst(edif_cell_inst)

        # Export checkpoint, then run vivado to generate a new netlist
        rw_design.unplaceDesign()
        rw_design.writeCheckpoint(phys_netlist_checkpoint)

        self.log_color(TermColor.BLUE, "\nWriting EDIF phsyical netlist:", phys_netlist_edif_path)
        netlist.exportEDIF(phys_netlist_edif_path)

    def export_new_netlist(self, phys_netlist_checkpoint, phys_netlist_verilog_path):
        """Export the new netlist to a Verilog netlist file"""

        self.log_color(
            TermColor.BLUE, "\nUsing Vivado to create new netlist:", phys_netlist_verilog_path
        )

        vivado_tcl_path = self.work_dir / "vivado_checkpoint_to_netlist.tcl"
        with open(vivado_tcl_path, "w") as fp:
            fp.write(f"write_verilog -force {phys_netlist_verilog_path}\n")
            fp.write("exit\n")

        vivado_log_path = self.work_dir / "vivado_edf_to_v.txt"
        with open(vivado_log_path, "w") as fp:
            proc = subprocess.Popen(
                [
                    VIVADO_BIN_PATH,
                    phys_netlist_checkpoint,
                    "-mode",
                    "batch",
                    "-source",
                    vivado_tcl_path,
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                universal_newlines=True,
            )
            for line in proc.stdout:
                sys.stdout.write(line)
                sys.stdout.flush()
                fp.write(line)
                fp.flush()
            proc.communicate()
            if proc.returncode:
                return Status(TransformStatus.ERROR)

        self.log("Exported new netlist to", phys_netlist_verilog_path)
        return self.success_status

    def cell_is_default_mapping(self, cell):
        """This checks whether the cell is using the default logical to physical mappings"""
        type_name = cell.getEDIFCellInst().getCellType().getName()
        default_l2p_map = XilinxPhysNetlist.STD_PIN_MAP_BY_CELL[type_name]

        l2p = cell.getPinMappingsL2P()
        permuted = False
        for logical, physical in default_l2p_map.items():
            if logical in l2p and list(l2p[logical]) != [physical]:
                print(list(l2p[logical]), "<>", [physical])
                permuted = True
                break

        return permuted

    def process_muxf7_muxf8(self, cell):
        """Process MUXF7/MUXF8 primitive
        Not sure whether inputs can be permuted or not, but for now let's
        assume they can't be and throw a NotImplementedError exception if
        they are permuted in some way."""

        type_name = cell.getEDIFCellInst().getCellType().getName()
        self.log_color(TermColor.BLUE, f"\nProcessing {type_name}", cell)

        permuted = self.cell_is_default_mapping(cell)
        if not permuted:
            self.log("  Inputs not permuted, skipping")
            return []

        raise NotImplementedError

    def process_carry4(self, cell):
        """Process CARRY4 primitive
        Not sure whether inputs can be permuted or not, but for now let's
        assume they can't be and throw a NotImplementedError exception if
        they are permuted in some way."""
        type_name = cell.getEDIFCellInst().getCellType().getName()
        self.log_color(TermColor.BLUE, f"\nProcessing {type_name}", cell)

        print(cell.getPinMappingsL2P())
        permuted = self.cell_is_default_mapping(cell)
        if not permuted:
            self.log("  Inputs not permuted, skipping")
            return []

        raise NotImplementedError

    def check_pin(self, physical_pin, logical_pin, edif_cell_inst):
        """Run assertions to check pin format"""
        assert len(physical_pin) == 1
        physical_pin = list(physical_pin)[0]

        port_inst = edif_cell_inst.getPortInst(logical_pin)
        assert port_inst

        logical_net = port_inst.getNet()
        assert logical_net

        return (physical_pin, logical_net, port_inst)

    def process_bufg(self, bufg_cell):
        """Convert BUFG to BUFGCTRL"""
        bufg_edif_inst = bufg_cell.getEDIFCellInst()
        assert bufg_edif_inst

        type_name = bufg_edif_inst.getCellType().getName()
        self.log_color(TermColor.BLUE, f"\nProcessing {type_name}", bufg_cell)

        assert not self.cell_is_default_mapping(bufg_cell)

        new_cell_name = bufg_edif_inst.getName() + "_phys"
        bufgctrl = bufg_edif_inst.getParentCell().createChildCellInst(
            new_cell_name, self.bufgctrl_edif_cell
        )

        self.log("Created new cell", new_cell_name)

        bufgctrl.setPropertiesMap(bufg_edif_inst.createDuplicatePropertiesMap())

        # set default properties
        for prop_name in ("INIT_OUT", "IS_CE0_INVERTED", "IS_IGNORE1_INVERTED", "IS_S0_INVERTED"):
            bufgctrl.addProperty(prop_name, JInt(0))

        for prop_name in ("IS_CE1_INVERTED", "IS_IGNORE0_INVERTED", "IS_S1_INVERTED"):
            bufgctrl.addProperty(prop_name, JInt(1))

        bufgctrl.addProperty("PRESELECT_I0", "TRUE")
        bufgctrl.addProperty("PRESELECT_I1", "FALSE")

        # Copy pins
        self.log(f"  Copying pins from {bufg_cell.getName()}")
        print(bufg_cell.getPinMappingsL2P())

        for logical_pin, physical_pin in bufg_cell.getPinMappingsL2P().items():
            physical_pin, logical_net, port_inst = self.check_pin(
                physical_pin, logical_pin, bufg_edif_inst
            )
            new_logical_pin = physical_pin
            new_port = bufgctrl.getPort(new_logical_pin)
            assert new_port
            logical_net.createPortInst(new_port, bufgctrl)
            logical_net.removePortInst(port_inst)

        # Set default connections
        for port_name in ("CE0", "CE1", "I1", "IGNORE0", "IGNORE1", "S0", "S1"):
            port = bufgctrl.getPort(port_name)
            assert port
            self.vcc_edif_net.createPortInst(port, bufgctrl)

        return [bufg_cell]

    def get_lut6_lut5_for_given_lut_cell(self, cell, cells_already_visited):
        """For a given LUT cell, determine the LUT6 and LUT5 at the
        location and return them"""

        # Check if there is another LUT at this site/bel
        other_lut_cell = None
        other_cells_at_this_bel = [
            other_cell
            for other_cell in cell.getSiteInst().getCells()
            if fnmatch(str(other_cell.getBELName()), f"{str(cell.getBELName())[0]}?LUT")
            and other_cell != cell
        ]
        # Shouldn't have more than one other LUT at this location
        assert len(other_cells_at_this_bel) <= 1

        if other_cells_at_this_bel:
            other_lut_cell = other_cells_at_this_bel[0]
            cells_already_visited.add(other_lut_cell)

        # Determine which is the LUT6 vs LUT5
        if not other_lut_cell:
            lut6_cell = cell
            lut5_cell = None
        elif self.cell_is_6lut(cell):
            lut6_cell = cell
            lut5_cell = other_lut_cell
        else:
            lut6_cell = other_lut_cell
            lut5_cell = cell

        assert self.cell_is_6lut(lut6_cell)
        assert lut5_cell is None or self.cell_is_5lut(lut5_cell)

        return (lut6_cell, lut5_cell)

    def process_lut(self, cell, lut6_2_cell, cells_already_visited):
        """This function takes a LUT* from the netlist and replaces with with a LUT6_2
        with logical mapping equal to the physical mapping."""

        lut6_cell, lut5_cell = self.get_lut6_lut5_for_given_lut_cell(cell, cells_already_visited)

        self.log_color(
            TermColor.BLUE,
            "\nProcessing and replacing LUT",
            lut6_cell,
            "(routethru)" if lut6_cell.isRoutethru() else "",
        )
        if lut5_cell:
            self.log_color(
                TermColor.BLUE,
                "...along with co-located LUT",
                lut5_cell,
                "(routethru)" if lut5_cell.isRoutethru() else "",
            )

        lut6_edif_cell_inst = lut6_cell.getEDIFCellInst()
        assert lut6_edif_cell_inst

        # Create a new LUT6_2 instance
        new_cell_name = lut6_edif_cell_inst.getName() + "_phys"
        if lut5_cell:
            new_cell_name += "_shared"
        new_cell_inst = lut6_edif_cell_inst.getParentCell().createChildCellInst(
            new_cell_name, lut6_2_cell
        )
        self.log("Created new cell", new_cell_name)

        # Copy all properties from existing LUT to new LUT (INIT will be fixed later)
        new_cell_inst.setPropertiesMap(lut6_edif_cell_inst.createDuplicatePropertiesMap())
        # TODO: If other_lut_cell is not None, then check that properties don't conflict?

        # Wire up inputs/outputs
        physical_pins_to_nets = {}

        self.log(f"Processing LUT {lut6_cell.getName()}")
        print(lut6_cell.getPinMappingsL2P())
        for logical_pin, physical_pin in lut6_cell.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut6_edif_cell_inst.getPortInst(logical_pin)
            assert port_inst
            physical_pins_to_nets[physical_pin] = port_inst.getNet()

            self.lut_move_net_to_new_cell(
                lut6_edif_cell_inst, new_cell_inst, logical_pin, physical_pin
            )

        # Now do the same for the other LUT
        if lut5_cell:
            print(lut5_cell.getPinMappingsL2P())

            self.log(f"Processing LUT {lut5_cell.getName()}")
            for logical_pin, physical_pin in lut5_cell.getPinMappingsL2P().items():
                assert len(physical_pin) == 1
                physical_pin = list(physical_pin)[0]

                lut5_edif_cell_inst = lut5_cell.getEDIFCellInst()
                port_inst = lut5_edif_cell_inst.getPortInst(logical_pin)
                assert port_inst

                # Disconnect net from logical pin on old cell,
                # and connect to new logical pin (based on physical pin) of new cell
                self.lut_move_net_to_new_cell(
                    lut5_edif_cell_inst,
                    new_cell_inst,
                    logical_pin,
                    physical_pin,
                    already_connected_net=physical_pins_to_nets.get(physical_pin),
                )

        # If old cell is a LUT route through some extra processing is required.
        # LUT route through cells don't exist in the original netlist (the original net
        # goes straight to the FF), so now that the net is going to stop at the LUT input,
        # a new net is needed to connect LUT output to FF
        if lut6_cell.isRoutethru():
            self.create_lut_routethru_net(lut6_cell, False, new_cell_inst)
        if lut5_cell and lut5_cell.isRoutethru():
            self.create_lut_routethru_net(lut5_cell, True, new_cell_inst)

        # Fix the new LUT INIT property based on the new pin mappings
        self.process_lut_init(lut6_cell, lut5_cell, new_cell_inst)

        # Return the cells to be removed
        cells_to_remove = []
        if not lut6_cell.isRoutethru():
            cells_to_remove.append(lut6_cell)
        if lut5_cell and not lut5_cell.isRoutethru():
            cells_to_remove.append(lut5_cell)
        return cells_to_remove

    def create_lut_routethru_net(self, cell, is_lut5, new_lut_cell):
        """Extra processing for LUT route through.  Need to create a new net
        connecting from the new LUT6_2 instance to the FF"""

        self.log("Creating routethru for", cell.getName())

        # Create the new net
        new_net_name = cell.getName() + "_routethru"
        self.log("  Creating new net", new_net_name)
        new_net = EDIFNet(new_net_name, cell.getEDIFCellInst().getParentCell())

        # Connect net to LUT output
        lut_out_port = new_lut_cell.getPort("O5" if is_lut5 else "O6")
        assert lut_out_port
        self.log(
            "  Connecting new net to LUT", new_lut_cell.getName(), "port", lut_out_port.getName()
        )
        new_net.createPortInst(lut_out_port, new_lut_cell)

        # Connect net to the input of the other cell in this site (FF, CARRY4)
        matching_cells = [
            other_cell
            for other_cell in cell.getSiteInst().getCells()
            if other_cell.getName() == cell.getName() and not other_cell.isRoutethru()
        ]
        assert len(matching_cells) == 1
        routed_to_cell = matching_cells[0]

        # First figure out which logical pin this routethru goes to.
        # Even though we are calling the gePinMappingsL2P on the LUT cell,
        # it doesn't actually return the logical pin on the LUT, but rather
        # the downstream cell (FF, CARRY4).
        logical_pins = list(cell.getPinMappingsL2P().keys())
        assert len(logical_pins) == 1
        routed_to_port_name = str(logical_pins[0])
        print(routed_to_port_name)

        # Handle bus based ports (eg CARRY4 )
        routed_to_port_idx = None
        if "[" in routed_to_port_name:
            match = re.match(r"(.*)\[(\d+)\]", routed_to_port_name)
            assert match
            routed_to_port_name = match.group(1)
            routed_to_port_idx = int(match.group(2))

        routed_to_cell_inst = routed_to_cell.getEDIFCellInst()
        routed_to_port = routed_to_cell_inst.getPort(routed_to_port_name)
        assert routed_to_port

        # The index in the signal name is not necessarily the index used in the netlist
        # Perform the conversion here
        if routed_to_port.isBus():
            routed_to_port_idx = routed_to_port.getPortIndexFromNameIndex(routed_to_port_idx)

        self.log(
            "  Connecting new net to BEL",
            routed_to_cell.getBEL().getName(),
            ", port",
            f"{routed_to_port_name}[{routed_to_port_idx}]"
            if routed_to_port_idx is not None
            else routed_to_port_name,
        )

        if routed_to_port_idx is not None:
            new_net.createPortInst(routed_to_port, routed_to_port_idx, routed_to_cell_inst)
        else:
            new_net.createPortInst(routed_to_port, routed_to_cell_inst)

    def lut_move_net_to_new_cell(
        self,
        old_edif_cell_inst,
        new_edif_cell_inst,
        old_logical_pin,
        physical_pin,
        already_connected_net=None,
    ):
        """This function connects the net from old_edif_cell_inst/old_logical_pin,
        to the appropriate logical pin on the new_edif_cell_inst, based on the physical pin,
        and disconnects from the old cell.  It's possible the net is already_connected to the
        new cell, in which case only the disconnect from old cell needs to be performed."""

        self.log(f"  Processing logical pin {old_logical_pin}, physical pin {physical_pin}")

        port_inst = old_edif_cell_inst.getPortInst(old_logical_pin)
        logical_net = port_inst.getNet()
        assert logical_net

        if already_connected_net:
            assert logical_net == already_connected_net
            self.log(f"    Skipping already connected physical pin {physical_pin}")

        else:
            if port_inst.getDirection() == EDIFDirection.INPUT:
                self.log("    Input driven by net", logical_net)

                print(physical_pin)
                # A5 becomes I4, A1 becomes I0, etc.
                new_logical_pin = "I" + str(int(str(physical_pin[1])) - 1)
                self.log(
                    "    Connecting net",
                    logical_net,
                    "to input pin",
                    new_logical_pin,
                    "on new cell",
                )

            elif port_inst.getDirection() == EDIFDirection.OUTPUT:
                self.log("    Drives net", logical_net)

                new_logical_pin = physical_pin
                self.log("    Connecting net", logical_net, "to output pin", new_logical_pin)

            new_port = new_edif_cell_inst.getPort(new_logical_pin)
            assert new_port
            logical_net.createPortInst(new_port, new_edif_cell_inst)

        # Disconnect connection to port on old cell
        self.log("    Disconnecting net", logical_net, "from pin", old_logical_pin, "on old cell")
        logical_net.removePortInst(port_inst)

    def process_lut_eqn(self, cell, is_lut5):
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
            self.log(
                f"  LUT{s6_or_5} is routethru using physical pin {physical_pin}, creating eqn {eqn}"
            )
            return eqn

        # First get an equation from the logical INIT string
        orig_init_eqn = str(LUTTools.getLUTEquation(cell))

        self.log(f"  LUT{s6_or_5} INIT:", cell.getProperty("INIT"))
        self.log(f"  LUT{s6_or_5} equation:", orig_init_eqn)

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

        self.log(f"  New LUT{s6_or_5} eqn:", eqn)
        return eqn

    def process_lut_init(self, lut6_cell, lut5_cell, new_cell_inst):
        """Fix the LUT INIT property for the new_cell_inst"""

        self.log("Fixing INIT string")

        lut6_eqn_phys = self.process_lut_eqn(lut6_cell, False)

        if lut5_cell:
            lut5_eqn_phys = self.process_lut_eqn(lut5_cell, True)

        if not lut5_cell:
            init_str = LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 6)
        else:
            init_str = (
                "64'h"
                + LUTTools.getLUTInitFromEquation(lut6_eqn_phys, 5)[4:].zfill(8)
                + LUTTools.getLUTInitFromEquation(lut5_eqn_phys, 5)[4:].zfill(8)
            )
        self.log("  New LUT INIT:", init_str)
        new_cell_inst.addProperty("INIT", init_str)

    def cell_is_6lut(self, cell):
        """Return whether this cell is using the 6LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?6LUT")

    def cell_is_5lut(self, cell):
        """Return whether this cell is using the 5LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?5LUT")
