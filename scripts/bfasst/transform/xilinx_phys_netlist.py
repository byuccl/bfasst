""" Creates a xilinx netlist that has only physical primitives"""


import re
import subprocess
import jpype
import jpype.imports

from bfasst.config import VIVADO_BIN_PATH
from bfasst.paths import THIRD_PARTY_PATH
from bfasst.status import Status, TransformStatus
from bfasst.transform.base import TransformTool

jpype.startJVM(
    classpath=[
        str(THIRD_PARTY_PATH / "RapidWright" / "bin"),
        *(str(s) for s in (THIRD_PARTY_PATH / "RapidWright" / "jars").glob("*.jar")),
    ]
)
# pylint: disable=wrong-import-position,wrong-import-order
from com.xilinx.rapidwright.design import (
    Design,
    Unisim,
    PinType,
)
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

        # Read the checkpoint into rapidwright, and get the netlist
        rw_design = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)
        netlist = rw_design.getNetlist()

        # Get the LUT6_2 EDIFCell (all LUTs will be replaced with equivalent LUT6_2 primitives)
        lut6_2_edif_cell = netlist.getHDIPrimitive(Unisim.LUT6_2)

        # Keep a list of old replaced cells to remove after processing
        cells_to_remove = []

        # Loop through all cells in the design
        for cell in rw_design.getCells():
            edif_cell_inst = cell.getEDIFCellInst()

            # Handle LUT cells
            if edif_cell_inst and str(edif_cell_inst.getCellType()).startswith("LUT"):
                # TODO: Check if there is another LUT at this site/bel

                # Replace the LUT* with a LUT2_6
                self.process_lut(cell, lut6_2_edif_cell)
                cells_to_remove.append(cell)

            # TODO: Handle other primitives? BUFG->BUFGCTRL, etc.

        # Remove old unusued cells
        for cell in cells_to_remove:
            edif_cell_inst = cell.getEDIFCellInst()

            # Remove the port instances
            edif_cell_inst.getParentCell().removeCellInst(edif_cell_inst)

        # Create a new netlist
        self.export_new_netlist(rw_design, after_netlist_verilog_path)

    def export_new_netlist(self, rw_design, after_netlist_verilog_path):
        """Export the new netlist to a Verilog netlist file"""
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

    def process_lut(self, lut_cell, lut6_2_cell):
        """This function takes a LUT* from the netlist and replaces with with a LUT6_2
        with logical mapping equal to the physical mapping."""

        edif_cell_inst = lut_cell.getEDIFCellInst()
        assert edif_cell_inst

        print("Processing and replacing LUT", lut_cell)

        # Create a new LUT6_2 instance
        new_cell_inst = edif_cell_inst.getParentCell().createChildCellInst(
            edif_cell_inst.getName() + "_new", lut6_2_cell
        )

        # Copy all properties from existing LUT to new LUT (INIT will be fixed later)
        new_cell_inst.setPropertiesMap(edif_cell_inst.createDuplicatePropertiesMap())

        # Wire up inputs/outputs
        for logical_pin, physical_pin in lut_cell.getPinMappingsL2P().items():
            print("\tProcessing logical pin", logical_pin)

            site_pin_inst = lut_cell.getSitePinFromLogicalPin(logical_pin, None)

            if site_pin_inst.getPinType() == PinType.IN:
                # Get the net that drives to this logical pin
                logical_in_net = site_pin_inst.getNet().getLogicalNet()
                print("\t\tInput driven by net", logical_in_net)

                new_logical_pin = str(logical_pin)[0] + (list(physical_pin)[0])[1]
                print("\t\tConnecting net", logical_in_net, "to input pin", new_logical_pin)
                logical_in_net.createPortInst(new_cell_inst.getPort(new_logical_pin), new_cell_inst)
                logical_in_net.removePortInst(edif_cell_inst.getPortInst(logical_pin))

            elif site_pin_inst.getPinType() == PinType.OUT:
                logical_out_net = site_pin_inst.getNet().getLogicalNet()
                print("\t\tDrives net", logical_out_net)

                new_logical_pin = list(physical_pin)[0]
                print("\t\tConnecting net", logical_out_net, "to output pin", new_logical_pin)
                logical_out_net.createPortInst(
                    new_cell_inst.getPort(new_logical_pin), new_cell_inst
                )
                logical_out_net.removePortInst(edif_cell_inst.getPortInst(logical_pin))

        #### Fix INIT string
        # TODO: Handle fractured LUT.
        print("\tFixing INIT string")

        # First get an equation from the logical INIT string
        init_eqn = str(LUTTools.getLUTEquation(lut_cell))
        print("\t\tOld LUT INIT:", lut_cell.getProperty("INIT"))
        print("\t\tOld LUT equation:", init_eqn)

        # Now go through and rename
        for logical_pin, physical_pin in lut_cell.getPinMappingsL2P().items():
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
