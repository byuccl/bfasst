""" Creates a xilinx netlist that has only physical primitives"""

from fnmatch import fnmatch
import pathlib
import re
import subprocess
import sys
import jpype
import jpype.imports

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
from com.xilinx.rapidwright.edif import EDIFDirection
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

    def run(self, design):
        """Transform the logical netlist into a netlist with only physical primitives"""
        after_netlist_verilog_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_physical.v"
        )

        # Redirect rapidwright output to file
        System.setOut(PrintStream(File(str(self.work_dir / "rapidwright_stdout.log"))))

        # Check for up to date previous run
        status = self.get_prev_run_status(
            tool_products=[
                ToolProduct(after_netlist_verilog_path),
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
            TermColor.PURPLE,
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
            self.run_rapidwright(design, phys_netlist_checkpoint)
        except jpype.JException as exc:
            raise RapidwrightException(str(exc))  # pylint: disable=raise-missing-from

        status = self.export_new_netlist(phys_netlist_checkpoint, after_netlist_verilog_path)

        return status

    def run_rapidwright(self, design, phys_netlist_checkpoint):
        """Do all rapidwright related processing on the netlist"""

        # Read the checkpoint into rapidwright, and get the netlist
        rw_design = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)

        netlist = rw_design.getNetlist()

        # Get the LUT6_2 EDIFCell (all LUTs will be replaced with equivalent LUT6_2 primitives)
        lut6_2_edif_cell = netlist.getHDIPrimitive(Unisim.LUT6_2)

        # Keep a list of old replaced cells to remove after processing
        cells_to_remove = []

        # Keep a list of cells already visited and skip them
        # This happens when we process LUTS mapped to the same BEL
        cells_already_visited = set()

        # Loop through all cells in the design
        for cell in rw_design.getCells():
            if cell in cells_already_visited:
                continue

            # Handle LUT cells
            if fnmatch(str(cell.getBELName()), "A?LUT"):
                # TODO: Check if there is another LUT at this site/bel
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

                assert self.cell_is_6lut(lut6_cell)
                assert lut5_cell is None or self.cell_is_5lut(lut5_cell)

                # Replace the LUT(s) with a LUT2_6
                self.process_lut(lut6_cell, lut5_cell, lut6_2_edif_cell)

                cells_to_remove.append(lut6_cell)
                if lut5_cell:
                    cells_to_remove.append(lut5_cell)

            # TODO: Handle other primitives? BUFG->BUFGCTRL, etc.

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

    def export_new_netlist(self, phys_netlist_checkpoint, after_netlist_verilog_path):
        """Export the new netlist to a Verilog netlist file"""
        self.log_color(
            TermColor.BLUE, "\nUsing Vivado to create new netlist:", after_netlist_verilog_path
        )

        vivado_tcl_path = self.work_dir / "vivado_checkpoint_to_netlist.tcl"
        with open(vivado_tcl_path, "w") as fp:
            fp.write(f"write_verilog -force {after_netlist_verilog_path}\n")
            fp.write("exit\n")

        vivado_log_path = self.TOOL_WORK_DIR / "vivado_edf_to_v.txt"
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

        self.log("Exported new netlist to", after_netlist_verilog_path)
        return self.success_status

    def process_lut(self, lut6_cell, lut5_cell, lut6_2_cell):
        """This function takes a LUT* from the netlist and replaces with with a LUT6_2
        with logical mapping equal to the physical mapping."""

        lut6_edif_cell_inst = lut6_cell.getEDIFCellInst()
        assert lut6_edif_cell_inst

        self.log_color(TermColor.BLUE, "\nProcessing and replacing LUT", lut6_cell)
        if lut5_cell:
            self.log_color(TermColor.BLUE, "...along with co-located LUT", lut5_cell)

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
        for logical_pin, physical_pin in lut6_cell.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut6_edif_cell_inst.getPortInst(logical_pin)
            physical_pins_to_nets[physical_pin] = port_inst.getNet()

            self.connect_new_cell_pin(lut6_edif_cell_inst, new_cell_inst, logical_pin, physical_pin)

        # Now do the same for the other LUT
        if lut5_cell:
            self.log(f"Processing LUT {lut5_cell.getName()}")
            for logical_pin, physical_pin in lut5_cell.getPinMappingsL2P().items():
                assert len(physical_pin) == 1
                physical_pin = list(physical_pin)[0]

                lut5_edif_cell_inst = lut5_cell.getEDIFCellInst()
                port_inst = lut5_edif_cell_inst.getPortInst(logical_pin)

                self.connect_new_cell_pin(
                    lut5_edif_cell_inst,
                    new_cell_inst,
                    logical_pin,
                    physical_pin,
                    already_connected=physical_pin in physical_pins_to_nets,
                )

        self.process_lut_init(lut6_cell, lut5_cell, new_cell_inst)

    def connect_new_cell_pin(
        self,
        old_edif_cell_inst,
        new_edif_cell_inst,
        old_logical_pin,
        physical_pin,
        already_connected=False,
    ):
        """This function connects the net from old_edif_cell_inst/old_logical_pin,
        to the appropriate logical pin on the new_edif_cell_inst, based on the physical pin,
        and disconnects from the old cell.  It's possible the net is already_connected to the
        new cell, in which case only the disconnect from old cell needs to be performed."""
        self.log(f"  Processing logical pin {old_logical_pin}, physical pin {physical_pin}")

        port_inst = old_edif_cell_inst.getPortInst(old_logical_pin)
        logical_net = port_inst.getNet()

        if already_connected:
            self.log(f"    Skipping already connected physical pin {physical_pin}")

        else:
            if port_inst.getDirection() == EDIFDirection.INPUT:
                self.log("    Input driven by net", logical_net)

                # A5 becomes I4, A1 becomes I0, etc.
                new_logical_pin = str(old_logical_pin)[0] + str(int(str(physical_pin[1])) - 1)
                self.log("    Connecting net", logical_net, "to input pin", new_logical_pin)

            elif port_inst.getDirection() == EDIFDirection.OUTPUT:
                self.log("    Drives net", logical_net)

                new_logical_pin = physical_pin
                self.log("    Connecting net", logical_net, "to output pin", new_logical_pin)

            new_port = new_edif_cell_inst.getPort(new_logical_pin)
            logical_net.createPortInst(new_port, new_edif_cell_inst)

        # Disconnect connection to port on old cell
        logical_net.removePortInst(port_inst)

    def process_lut_eqn_logical_to_physical(self, eqn, cell):
        """Transform a LUT equation using the logical to physical mappings"""
        for logical_pin, physical_pin in cell.getPinMappingsL2P().items():
            # Skip the output pin
            if str(physical_pin).startswith("[O"):
                continue

            matches = re.match(r"\[(A\d)\]", str(physical_pin))
            assert matches
            physical_pin = matches[1]

            eqn = eqn.replace(str(logical_pin), str(physical_pin))

        # Physical LUT inputs use A#, but LUTTools expect I#
        eqn = eqn.replace("A", "I")
        return eqn

    def process_lut_init(self, lut6_cell, lut5_cell, new_cell_inst):
        """Fix the LUT INIT property for the new_cell_inst"""

        #### Fix INIT string
        # TODO: Handle fractured LUT.
        self.log("  Fixing INIT string")

        # First get an equation from the logical INIT string
        lut6_init_eqn = str(LUTTools.getLUTEquation(lut6_cell))
        self.log("    LUT6 INIT:", lut6_cell.getProperty("INIT"))
        self.log("    LUT6 equation:", lut6_init_eqn)

        if lut5_cell:
            lut5_init_eqn = str(LUTTools.getLUTEquation(lut5_cell))
            self.log("    LUT5 INIT:", lut5_cell.getProperty("INIT"))
            self.log("    LUT5 equation:", lut5_init_eqn)

        # If both LUT outputs are used, then neither equation should use I5
        if lut5_cell:
            assert "I5" not in lut6_init_eqn
            assert "I5" not in lut5_init_eqn

        lut6_init_eqn = self.process_lut_eqn_logical_to_physical(lut6_init_eqn, lut6_cell)
        self.log("    New LUT6 eqn:", lut6_init_eqn)
        if lut5_cell:
            lut5_init_eqn = self.process_lut_eqn_logical_to_physical(lut5_init_eqn, lut5_cell)
            self.log("    New LUT5 eqn:", lut6_init_eqn)

        if not lut5_cell:
            init_str = LUTTools.getLUTInitFromEquation(lut6_init_eqn, 6)
        else:
            init_str = (
                "64'h"
                + LUTTools.getLUTInitFromEquation(lut6_init_eqn, 5)[4:]
                + LUTTools.getLUTInitFromEquation(lut5_init_eqn, 5)[4:]
            )
        self.log("    New LUT INIT:", init_str)
        new_cell_inst.addProperty("INIT", init_str)

    def cell_is_6lut(self, cell):
        """Return whether this cell is using the 6LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?6LUT")

    def cell_is_5lut(self, cell):
        """Return whether this cell is using the 5LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?5LUT")
