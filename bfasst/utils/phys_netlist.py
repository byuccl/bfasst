"""
Init Constants for Physical Netlist object
"""

import logging
from pathlib import Path
import time

from bfasst import jpype_jvm
from bfasst.config import PART
from bfasst.utils import rw_helpers as rw

# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.design import Cell, Design, Unisim
from com.xilinx.rapidwright.edif import EDIFNet, EDIFNetlist
from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class PhysNetlist:
    """
    Physical Netlist object to hold the physical netlist data.
    """

    def __init__(self, rw_log: str, impl_checkpoint: tuple[Path, Path]):
        """Init constants for RW Netlist processing"""
        System.setOut(PrintStream(File(rw_log)))
        System.setErr(PrintStream(File(rw_log)))
        self.device = Device.getDevice(PART)
        # Rapidwright design / netlist
        self.vivado_design, self.vivado_netlist = self._load_designs(impl_checkpoint)

        # Const nets
        self.vcc, self.gnd = None, None
        self.const_net_nd_to_pip = {}
        self.__init_const_nets()

        # Cells to use for new Primitives
        # Init BUFGCTRL cell template
        self.bufgctrl_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.BUFGCTRL)

        # Init LUT cell templates
        self.lut6_2_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.LUT6_2)
        self.ram32x1s_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1S)
        self.ram32x1s1_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1S_1)
        self.ram32x1d_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32X1D)
        self.ram32m_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.RAM32M)
        self.ldce_edif_cell = self.vivado_netlist.getHDIPrimitive(Unisim.LDCE)
        self.lut_pair_bel_names = [
            ("A6LUT", "A6LUT_O6", "A5LUT", "A5LUT_O5"),
            ("B6LUT", "B6LUT_O6", "B5LUT", "B5LUT_O5"),
            ("C6LUT", "C6LUT_O6", "C5LUT", "C5LUT_O5"),
            ("D6LUT", "D6LUT_O6", "D5LUT", "D5LUT_O5"),
        ]

        self.ff_rt_pins = {
            "CK": ("G", self.vcc),
            "CE": ("GE", self.vcc),
            "SR": ("CLR", self.gnd),
            "D": ("D", None),
        }

        self.empty_cell = Cell("RW_PHYS_NETLIST_EMPTY_CELL")
        self.hanging_pins = {}  # Cell name: list(tuple(driving SitePinInst, cell, sink BELPin))
        self.site_pin_to_net = {}  # SitePinInst: EDIFNet

        # Keep a list of old replaced cells to remove after processing
        self.cells_to_remove = []
        self.visited_cells = set()
        self.phys_ecells = []  # tuple(EDIFCellInst, SiteInst, str(bel_name))

    def __init_const_nets(self) -> None:
        """Init VCC and GND nets"""
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

    def _load_designs(self, impl_checkpoint: tuple[Path, Path]) -> tuple[Design, EDIFNetlist]:
        """Load the designs from the given paths"""
        impl_dcp, impl_edf = impl_checkpoint
        logging.info("Loading vivado dcp and edf files: %s, %s", str(impl_dcp), str(impl_edf))
        start_time = time.time()
        vivado_design = Design.readCheckpoint(impl_dcp, impl_edf)
        vivado_netlist = vivado_design.getNetlist()
        vivado_design.flattenDesign()
        vivado_netlist.expandMacroUnisims(self.device.getSeries())
        logging.info("Loading vivado netlist took %s seconds.", time.time() - start_time)
        return vivado_design, vivado_netlist
