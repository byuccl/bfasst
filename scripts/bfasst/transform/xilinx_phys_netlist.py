""" Creates a xilinx netlist that has only physical primitives"""


import jpype
import jpype.imports
# from jpype.types import *

from bfasst.paths import THIRD_PARTY_PATH
from bfasst.status import Status, TransformStatus
from bfasst.transform.base import TransformTool

jpype.startJVM(classpath=[str(THIRD_PARTY_PATH /"rapidwright-2022.2.1-standalone-lin64.jar")])
from com.xilinx.rapidwright.design import Design, Unisim, PinType
# from com.xilinx.rapidwright.design import Unisim


class XilinxPhysNetlist(TransformTool):
    """ Creates a xilinx netlist that has only physical primitives"""
    
    success_status = Status(TransformStatus.SUCCESS)
    TOOL_WORK_DIR = "xilinx_phys_netlist"

    def run(self, design):
        print("Hi there")
        before_netlist_path = design.impl_edif_path.parent / (design.impl_edif_path.stem + "_before.edf")
        after_netlist_path = design.impl_edif_path.parent / (design.impl_edif_path.stem + "_after.edf")


        print(design.impl_netlist_path)
        print(design.xilinx_impl_checkpoint_path, design.xilinx_impl_checkpoint_path.is_file())
        print(design.impl_edif_path, design.impl_edif_path.is_file())
        d = Design.readCheckpoint(design.xilinx_impl_checkpoint_path, design.impl_edif_path)

        print("Device:", d.getDevice().getName())

        netlist = d.getNetlist()

        netlist.exportEDIF(before_netlist_path)

        # Create LUT6_2 cell
        # lut6_2_cell = d.createCell("LUT6_2", Unisim.LUT6_2)
        lut6_2_edif_cell = 	netlist.getHDIPrimitive(Unisim.LUT6_2)


        leaf_cells = netlist.getAllLeafCellInstances()

        for leaf_cell in leaf_cells:
            print(leaf_cell, leaf_cell.getCellType())

        print("=" * 10, "cells", "="*10)
        cells = d.getCells()
        cells_to_remove = []
        print("# cells:", len(cells))
        for cell in cells:
            edif_cell_inst = cell.getEDIFCellInst()
            # if edif_cell_inst:
            #     print("\tEDIFCellInst Type:",edif_cell_inst.getCellType())
            if edif_cell_inst and str(edif_cell_inst.getCellType()).startswith("LUT"):
                # continue
                self.process_lut(d, cell, lut6_2_edif_cell)
                cells_to_remove.append(cell)

        for cell in cells_to_remove:
            edif_cell_inst = cell.getEDIFCellInst()

            # Remove the port instances
            edif_cell_inst.getParentCell().removeCellInst(edif_cell_inst)

        cells = d.getCells()
        print("# cells:", len(cells))


        try:
            netlist.removeUnusedCellsFromAllWorkLibraries()
            netlist.exportEDIF(after_netlist_path)
        except jpype.JException as exception:
            print(exception)
            print (exception.message())
            print (exception.stacktrace())

            
        print("Exported new netlist to", after_netlist_path)



            
    def process_lut(self,rapidwright_design, lut_cell, lut6_2_cell):
        edif_cell_inst = lut_cell.getEDIFCellInst()
        edif_netlist = rapidwright_design.getNetlist()
        assert(edif_cell_inst)

        print("Processing and replacing LUT", lut_cell)

        # Create a new LUT6_2 with the same parent in the netlist
        parent_module = edif_cell_inst.getParentCell()       
        # print("\tParent:", parent_module)

        # print(len(parent_module.getCellInsts()))

        # Create a new LUT6_2
        new_cell_inst = parent_module.createChildCellInst(edif_cell_inst.getName() + "_new", lut6_2_cell)

        # Copy properties
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
                logical_out_net.createPortInst(new_cell_inst.getPort(new_logical_pin), new_cell_inst)
                logical_out_net.removePortInst(edif_cell_inst.getPortInst(logical_pin))



                # TODO
                
        
        # TODO: Fix INIT string

