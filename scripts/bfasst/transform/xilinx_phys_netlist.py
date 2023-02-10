""" Creates a xilinx netlist that has only physical primitives"""

from fnmatch import fnmatch
import pathlib
import re
import subprocess
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

# pylint: enable=wrong-import-position,wrong-import-order


class XilinxPhysNetlist(TransformTool):
    """Creates a xilinx netlist that has only physical primitives"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "xilinx_phys_netlist"

    def run(self, design):
        """Transform the logical netlist into a netlist with only physical primitives"""
        after_netlist_verilog_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_physical.v"
        )

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

        # Read the checkpoint into rapidwright, and get the netlist
        rw_design = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)
        netlist = rw_design.getNetlist()

        # Get the LUT6_2 EDIFCell (all LUTs will be replaced with equivalent LUT6_2 primitives)
        lut6_2_edif_cell = netlist.getHDIPrimitive(Unisim.LUT6_2)

        # Keep a list of old replaced cells to remove after processing
        cells_to_remove = []

        # Loop through all cells in the design
        for cell in rw_design.getCells():
            # edif_cell_inst = cell.getEDIFCellInst()

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
                cells_to_remove.append(cell)

            # TODO: Handle other primitives? BUFG->BUFGCTRL, etc.

        # Remove old unusued cells
        for cell in cells_to_remove:
            edif_cell_inst = cell.getEDIFCellInst()

            # Remove the port instances
            edif_cell_inst.getParentCell().removeCellInst(edif_cell_inst)

        # Create a new netlist
        self.export_new_netlist(rw_design, after_netlist_verilog_path)

        return self.success_status

    def export_new_netlist(self, rw_design, after_netlist_verilog_path):
        """Export the new netlist to a Verilog netlist file"""
        print_color(
            TermColor.BLUE, "\nUsing Vivado to create new netlist:", after_netlist_verilog_path
        )
        phys_netlist_checkpoint = self.work_dir / "phys_netlist.dcp"

        # Export checkpoint, then run vivado to generate a new netlist
        rw_design.writeCheckpoint(phys_netlist_checkpoint)

        vivado_tcl_path = self.work_dir / "vivado_checkpoint_to_netlist.tcl"
        with open(vivado_tcl_path, "w") as fp:
            fp.write(f"write_verilog -force {after_netlist_verilog_path}\n")
            fp.write("exit\n")
        subprocess.run(
            [VIVADO_BIN_PATH, phys_netlist_checkpoint, "-mode", "batch", "-source", vivado_tcl_path]
        )
        print("Exported new netlist to", after_netlist_verilog_path)
        # netlist = spydrnet.parse(str(edif_path))
        # netlist.compose(verilog_path)

    def process_lut(self, lut6_cell, lut5_cell, lut6_2_cell):
        """This function takes a LUT* from the netlist and replaces with with a LUT6_2
        with logical mapping equal to the physical mapping."""

        lut6_edif_cell_inst = lut6_cell.getEDIFCellInst()
        assert lut6_edif_cell_inst
        if lut5_cell:
            lut5_edif_cell_inst = lut5_cell.getEDIFCellInst()

        print_color(TermColor.BLUE, "\nProcessing and replacing LUT", lut6_cell)
        if lut5_cell:
            print_color(TermColor.BLUE, "...along with co-located LUT", lut5_cell)

        # Create a new LUT6_2 instance
        new_cell_name = lut6_edif_cell_inst.getName() + "_phys"
        if lut5_cell:
            new_cell_name += "_shared"
        new_cell_inst = lut6_edif_cell_inst.getParentCell().createChildCellInst(
            new_cell_name, lut6_2_cell
        )
        print("Created new cell", new_cell_name)

        # Copy all properties from existing LUT to new LUT (INIT will be fixed later)
        new_cell_inst.setPropertiesMap(lut6_edif_cell_inst.createDuplicatePropertiesMap())
        # TODO: If other_lut_cell is not None, then check that properties don't conflict?

        # Wire up inputs/outputs
        physical_pins_to_nets = {}

        print(f"Processing LUT {lut6_cell.getName()}")
        for logical_pin, physical_pin in lut6_cell.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut6_edif_cell_inst.getPortInst(logical_pin)
            physical_pins_to_nets[physical_pin] = port_inst.getNet()

            self.connect_new_cell_pin(lut6_edif_cell_inst, new_cell_inst, logical_pin, physical_pin)

        # Now do the same for the other LUT
        print(f"Processing LUT {lut5_cell.getName()}")

        for logical_pin, physical_pin in lut5_cell.getPinMappingsL2P().items():
            assert len(physical_pin) == 1
            physical_pin = list(physical_pin)[0]

            port_inst = lut5_edif_cell_inst.getPortInst(logical_pin)
            logical_net = port_inst.getNet()
            assert logical_net

            if physical_pin in physical_pins_to_nets:
                # Already done this physical pin from other LUT
                # Make sure it's the same net
                assert physical_pins_to_nets[physical_pin] == logical_net
                print(f"  Skipping already connected physical pin {physical_pin}")
                continue

            self.connect_new_cell_pin(lut5_edif_cell_inst, new_cell_inst, logical_pin, physical_pin)

        self.process_lut_init(lut6_cell, lut5_cell, new_cell_inst)

    def connect_new_cell_pin(
        self, old_edif_cell_inst, new_edif_cell_inst, old_logical_pin, physical_pin
    ):
        """This function connects the net from old_edif_cell_inst/old_logical_pin,
        to the appropriate logical pin on the new_edif_cell_inst, based on the physical pin"""
        print(f"  Processing logical pin {old_logical_pin}, physical pin {physical_pin}")

        port_inst = old_edif_cell_inst.getPortInst(old_logical_pin)
        logical_net = port_inst.getNet()
        if port_inst.getDirection() == EDIFDirection.INPUT:
            print("    Input driven by net", logical_net)

            # A5 becomes I4, A1 becomes I0, etc.
            new_logical_pin = str(old_logical_pin)[0] + str(int(str(physical_pin[1])) - 1)
            print("    Connecting net", logical_net, "to input pin", new_logical_pin)

        elif port_inst.getDirection() == EDIFDirection.OUTPUT:
            print("    Drives net", logical_net)

            new_logical_pin = physical_pin
            print("    Connecting net", logical_net, "to output pin", new_logical_pin)

        new_port = new_edif_cell_inst.getPort(new_logical_pin)
        logical_net.createPortInst(new_port, new_edif_cell_inst)
        logical_net.removePortInst(old_edif_cell_inst.getPortInst(old_logical_pin))

    def process_lut_init(self, lut6_cell, lut5_cell, new_cell_inst):
        """Fix the LUT INIT property for the new_cell_inst"""
        assert lut5_cell is None

        #### Fix INIT string
        # TODO: Handle fractured LUT.
        print("\tFixing INIT string")

        # First get an equation from the logical INIT string
        init_eqn = str(LUTTools.getLUTEquation(lut6_cell))
        print("\t\tOld LUT INIT:", lut6_cell.getProperty("INIT"))
        print("\t\tOld LUT equation:", init_eqn)

        # Now go through and rename
        for logical_pin, physical_pin in lut6_cell.getPinMappingsL2P().items():
            # Skip the output pin
            if str(physical_pin).startswith("[O"):
                continue

            matches = re.match(r"\[(A\d)\]", str(physical_pin))
            assert matches
            physical_pin = matches[1]

            init_eqn = init_eqn.replace(str(logical_pin), str(physical_pin))

        # Physical LUT inputs use A#, but LUTTools expect I#
        init_eqn = init_eqn.replace("A", "I")

        print("\t\tNew LUT eqn:", init_eqn)
        init_str = LUTTools.getLUTInitFromEquation(init_eqn, 6)
        print("\t\tNew LUT INIT:", init_str)
        new_cell_inst.addProperty("INIT", init_str)

    def cell_is_6lut(self, cell):
        """Return whether this cell is using the 6LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?6LUT")

    def cell_is_5lut(self, cell):
        """Return whether this cell is using the 5LUT BEL"""
        return fnmatch(str(cell.getBELName()), "?5LUT")
