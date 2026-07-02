"""
Init Constants for Physical Netlist object
"""

import logging

import rapidwright as _
from com.xilinx.rapidwright.design import Cell, Unisim
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.edif import EDIFNet
from java.io import File, PrintStream
from java.lang import System

from bfasst.config import DEFAULT_PART
from bfasst.utils import rw_helpers as rw


class PhysNetlistTransformError(Exception):
    """Exception for errors in phys netlist transformation"""


class PhysNetlist:
    """
    Physical Netlist object to hold the physical netlist data.
    """

    def __init__(self, rw_log: str, impl_checkpoint: rw.VivadoCheckpoint, **kwargs):
        """Init constants for RW Netlist processing"""
        System.setOut(PrintStream(File(rw_log)))
        System.setErr(PrintStream(File(rw_log)))
        self.device = Device.getDevice(DEFAULT_PART)
        # Rapidwright design / netlist
        self.vivado_design, self.vivado_netlist = rw.load_design(impl_checkpoint)

        # Const nets
        self.vcc, self.gnd = None, None
        self.const_net_nd_to_pip = {}
        self.__init_const_nets()

        self.empty_cell = Cell("RW_PHYS_NETLIST_EMPTY_CELL")

        # Keep a list of old replaced cells to remove after processing
        self.cells_to_remove = []
        self.visited_cells = set()
        # EDIFCellInsts part of the post-edited design
        self.phys_ecells: rw.DesignCells = {}

        super().__init__(**kwargs)

    def __init_const_nets(self) -> None:
        """Init VCC and GND nets. Sets self.vcc and self.gnd"""
        net_tuples = ((Unisim.GND, "G", "gnd"), (Unisim.VCC, "P", "vcc"))
        for unisim_cell, port, name in net_tuples:
            edif_cell = self.vivado_netlist.getHDIPrimitive(unisim_cell)

            cell_insts = [
                inst
                for inst in self.vivado_netlist.getTopCell().getCellInsts()
                if inst.getCellType() == edif_cell
            ]
            if len(cell_insts) > 1:
                rw.combine_const_nets(
                    port, cell_insts[1:], cell_insts[0], unisim_cell, logging.warning
                )

            if cell_insts:
                const_net = cell_insts[0].getPortInst(port).getNet()
                setattr(self, name, const_net)
                continue

            # Create new const instance as part of top-level
            const_edif_inst = self.vivado_netlist.getTopCell().createChildCellInst(
                f"{name}_phys_netlist", edif_cell
            )

            # Create const net as part of top-level
            const_net = EDIFNet(name + "_net_phys_netlist", self.vivado_netlist.getTopCell())
            assert const_net
            setattr(self, name, const_net)

            const_port = const_edif_inst.getPort(port)
            assert const_port
            const_net.createPortInst(const_port, const_edif_inst)
