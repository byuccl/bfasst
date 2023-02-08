""" Creates a xilinx netlist that has only physical primitives"""


import subprocess
import jpype
import jpype.imports

from bfasst.config import VIVADO_BIN_PATH
from bfasst.paths import THIRD_PARTY_PATH
from bfasst.status import Status, TransformStatus
from bfasst.transform.base import TransformTool

jpype.startJVM(classpath=[str(THIRD_PARTY_PATH / "rapidwright-2022.2.1-standalone-lin64.jar")])
from com.xilinx.rapidwright.design import (  # pylint: disable=wrong-import-position,wrong-import-order
    Design,
    Unisim,
    PinType,
)


class XilinxPhysNetlist(TransformTool):
    """Creates a xilinx netlist that has only physical primitives"""

    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "xilinx_phys_netlist"

    def run(self, design):
        """Transform the logical netlist into a netlist with only physical primitives"""
        before_netlist_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_before.edf"
        )
        after_netlist_verilog_path = design.impl_edif_path.parent / (
            design.impl_edif_path.stem + "_after.v"
        )

        print(design.impl_netlist_path)
        print(design.xilinx_impl_checkpoint_path, design.xilinx_impl_checkpoint_path.is_file())
        print(design.impl_edif_path, design.impl_edif_path.is_file())
        rw_design = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)

        print("Device:", rw_design.getDevice().getName())

        netlist = rw_design.getNetlist()

        netlist.exportEDIF(before_netlist_path)

        # Get LUT6_2 EDIFCell
        lut6_2_edif_cell = netlist.getHDIPrimitive(Unisim.LUT6_2)

        leaf_cells = netlist.getAllLeafCellInstances()

        for leaf_cell in leaf_cells:
            print(leaf_cell, leaf_cell.getCellType())

        print("=" * 10, "cells", "=" * 10)
        cells = rw_design.getCells()
        cells_to_remove = []
        print("# cells:", len(cells))

        for cell in cells:
            edif_cell_inst = cell.getEDIFCellInst()
            # if edif_cell_inst:
            #     print("\tEDIFCellInst Type:",edif_cell_inst.getCellType())
            if edif_cell_inst and str(edif_cell_inst.getCellType()).startswith("LUT"):
                # TODO: Check if there is another LUT at this site/bel

                # Replace the LUT* with a LUT2_6
                self.process_lut(cell, lut6_2_edif_cell)
                cells_to_remove.append(cell)

            # TODO: Handle other primitives? BUFG->BUFGCTRL, etc.

        for cell in cells_to_remove:
            edif_cell_inst = cell.getEDIFCellInst()

            # Remove the port instances
            edif_cell_inst.getParentCell().removeCellInst(edif_cell_inst)

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

        # Create a new LUT6_2
        new_cell_inst = edif_cell_inst.getParentCell().createChildCellInst(
            edif_cell_inst.getName() + "_new", lut6_2_cell
        )

        # Copy properties
        # TODO: Properties on fractured LUT?
        new_cell_inst.setPropertiesMap(edif_cell_inst.createDuplicatePropertiesMap())

        # Fix INIT to match physical LUT
        print(lut_cell.getProperties())

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

                # TODO

        # TODO: Fix INIT string
