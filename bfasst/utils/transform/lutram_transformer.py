"""
Class to assess potential to combine LUTRAM Primitives and combine them.
Uses RapidWright
"""

import logging
from typing import Optional

import rapidwright as _
from com.xilinx.rapidwright.design import Cell, Unisim
from com.xilinx.rapidwright.edif import (
    EDIFCell,
    EDIFCellInst,
    EDIFHierCellInst,
    EDIFNetlist,
)

import bfasst.utils.rw_helpers as rw
from bfasst.utils.phys_netlist import PhysNetlistTransformError


class LUTRAMTransformer:
    """
    Class to assess potential to combine LUTRAM Primitives and combine them.
    Uses RapidWright
    """

    def __init__(
        self, netlist: EDIFNetlist, visited_cells: set, phys_ecells: dict, old_cells: list[Cell]
    ):
        """Init constants for RW Netlist processing"""
        self.visited_cells = visited_cells  # Set of visited cells
        self.phys_ecells = phys_ecells  # Dictionary of new cells created
        self.old_cells = old_cells  # Cells replaced by phys_ecells

        self.ram32x1s_edif_cell = netlist.getHDIPrimitive(Unisim.RAM32X1S)
        self.ram32x1s1_edif_cell = netlist.getHDIPrimitive(Unisim.RAM32X1S_1)
        self.ram32x1d_edif_cell = netlist.getHDIPrimitive(Unisim.RAM32X1D)
        self.ram32m_edif_cell = netlist.getHDIPrimitive(Unisim.RAM32M)

    @staticmethod
    def lutram_assertions(lut_rams: list[Cell]) -> tuple[EDIFCell, list[EDIFCellInst]]:
        """
        Run sanity assertions on LUTRAMs.
        Returns -> (parent cell, [child insts])
        """
        hedif_cells = [c.getEDIFHierCellInst() for c in lut_rams]
        parents1 = [c.getParent() for c in hedif_cells]
        test_type = {t.getCellType().getName() for t in parents1}
        assert len(test_type) == 1
        if not test_type < {"RAM32X1S", "RAM32X1D"}:
            raise PhysNetlistTransformError(f"Unexpected parent cell type {test_type}")

        # Need to go up 2 levels: True parent -> RAM32X1S -> RAMS32 (current cell)
        parent = {c.getParent().getParent() for c in hedif_cells}
        assert len(parent) == 1

        return (parent.pop().getCellType(), [c.getParent().getInst() for c in hedif_cells])

    def process_lutrams(
        self, lut_rams: list[Cell]
    ) -> tuple[set[EDIFHierCellInst], list[tuple[EDIFCellInst, str]]]:
        """
        Look at LUTRAMs in a site and see if they should be combined into a
        single RAM primitive.  RAMS32 is wrapped in RAM32X1S (parent cell), so
        LUTRAMs only need processed if they can be combined.
        """
        parents = [c.getEDIFHierCellInst().getParent() for c in lut_rams]
        parents_insts = [(p.getInst(), c.getBELName()) for p, c in zip(parents, lut_rams)]
        logging.info(
            "Analyzing LUTRAMS %s at site %s",
            str([p.getFullHierarchicalInstName() for p in parents]),
            str(lut_rams[0].getSiteInst()),
        )
        if len(set(parents)) == 1:  # Sometimes LUTRAMs are already combined into bigger primitive
            return (set(parents), parents_insts)

        cell_type = {c.getType() for c in lut_rams}
        if not cell_type <= {"RAMS32", "RAMD32"}:
            raise PhysNetlistTransformError(f"Unexpected child cell type {cell_type}")

        if len(cell_type) > 1:
            if len(lut_rams) == 2:
                return (set(parents), parents_insts)
            assert len(lut_rams) != 4
            if lut_rams[0].getType() == lut_rams[1].getType():
                lut_rams = lut_rams[0:2]
            elif lut_rams[1].getType() == lut_rams[2].getType():
                lut_rams = lut_rams[1:]
                parents = parents[1:]
            else:  # Should not reach here
                type_str = ", ".join([c.getType() for c in lut_rams])
                raise PhysNetlistTransformError(
                    f"Unexpected lutram configuration in slice: {type_str}"
                )
            ret = self.__check_ram32x1d(lut_rams, parents) or parents_insts
            return set(parents), ret

        if cell_type.pop() == "RAMS32":
            if len(lut_rams) == 4:
                ret = self.__check_ram32m(lut_rams, parents) or parents_insts
                return set(parents), ret
            ret = self.__check_ram32x1d(lut_rams, parents) or parents_insts
            return set(parents), ret

        if len(lut_rams) == 2:
            parents_insts = self.__check_ram32m(lut_rams, parents) or parents_insts
        return set(parents), parents_insts

    def __check_ram32x1d(
        self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]
    ) -> Optional[EDIFCellInst]:
        """Check if RAM32X1S/RAMS32 cells can be combined to RAM32X1D"""
        logging.info("  Checking to combine to RAM32X1D")
        same_nets = ["WE", "WCLK", "D"]
        # check for ram32x1d (2 luts)
        lut6_cell = lut_rams[0]
        ram32x1s_cell = parents[0].getInst()
        nets_lh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x1s_cell)
        init = lut6_cell.getProperty("INIT")
        for lut6_cell_rh, hier_cell in zip(lut_rams[1:], parents[1:]):
            ram32x1s_cell = hier_cell.getInst()
            nets_rh = rw.get_net_names_from_edif_ports(lut6_cell_rh, same_nets, ram32x1s_cell)
            init2 = lut6_cell_rh.getProperty("INIT")
            if init != init2:
                nets_lh = nets_rh
                init = init2
                lut6_cell = lut6_cell_rh
                continue

            for lh, rh in zip(nets_lh, nets_rh):
                if lh != rh:
                    nets_lh = nets_rh
                    init = init2
                    lut6_cell = lut6_cell_rh
                    break
            else:
                return self.__process_ram32x1d((lut6_cell, lut6_cell_rh))

    def __check_ram32m(
        self, lut_rams: list[Cell], parents: list[EDIFHierCellInst]
    ) -> Optional[EDIFCellInst]:
        """
        Check if RAM32X1S/RAMS32 or RAM32X1D/RAMD32 cells can be
        combined to RAM32M.
        """
        logging.info("  Checking to combine to RAM32M")
        same_nets = ["WE", "WCLK"]
        lut6_cell = lut_rams[0]
        ram32x_cell = parents[0].getInst()
        nets_lh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x_cell)
        for lut6_cell, hier_cell in zip(lut_rams[1:], parents[1:]):
            ram32x_cell = hier_cell.getInst()
            nets_rh = rw.get_net_names_from_edif_ports(lut6_cell, same_nets, ram32x_cell)
            for lh, rh in zip(nets_lh, nets_rh):
                if lh != rh:
                    if lut6_cell.getType() == "RAMS32":
                        return self.__check_ram32x1d(lut_rams, parents)
                    return None
        return self.__process_ram32m(lut_rams)

    def __process_ram32x1d(self, cells: list[Cell]) -> list[EDIFCellInst, str]:
        """
        Replace two RAM32X1S cells with a single RAM32X1D cell.
        """
        parent, edif_cells = self.lutram_assertions(cells)
        new_cell_name = f"{rw.generate_combinded_cell_name(edif_cells)}_ram32x1d_phys"
        cell_str = f"2 LUT_RAMS ({' '.join([str(n.getName()) for n in cells])})"
        logging.info("Converting %s to RAM32X1D %s", cell_str, new_cell_name)

        ram32x1d = parent.createChildCellInst(new_cell_name, self.ram32x1d_edif_cell)

        ram32x1d.addProperty("INIT", edif_cells[0].getProperty("INIT"))

        global_pins = {"WE": ["WE"], "WCLK": ["WCLK"], "D": ["D"]}
        rw.transfer_global_pins(edif_cells, ram32x1d, global_pins)

        addrs = ["A0", "A1", "A2", "A3", "A4"]
        for addr in addrs:
            rw.valid_net_transfer(addr, [addr], edif_cells[0], ram32x1d)
        rw.valid_net_transfer("O", ["DPO"], edif_cells[0], ram32x1d)

        rd_addrs = ["DPRA0", "DPRA1", "DPRA2", "DPRA3", "DPRA4"]
        for addr, rd_addr in zip(addrs, rd_addrs):
            rw.valid_net_transfer(addr, [rd_addr], edif_cells[1], ram32x1d)
        rw.valid_net_transfer("O", ["SPO"], edif_cells[1], ram32x1d)
        self.old_cells.extend(cells)
        for cell in cells:
            parent = cell.getEDIFHierCellInst().getParent()
            self.old_cells.append(parent)
        self.phys_ecells[(cells[0].getSiteName(), cells[0].getBELName())] = ram32x1d
        return [(ram32x1d, cells[0].getBELName())]

    def __process_ram32m(self, cells: list[Cell]) -> EDIFCellInst:
        """
        Replace four RAM32X1S or two RAM32X1D cells with a single RAM32M
        cell.
        """
        if len(cells) == 2:
            raise PhysNetlistTransformError("RAM32D not handled yet")

        parent, edif_cells = self.lutram_assertions(cells)
        new_cell_name = f"{rw.generate_combinded_cell_name(edif_cells)}_ram32m_phys"
        cell_str = f"4 LUT_RAMS ({' '.join([str(n.getName()) for n in cells])})"
        logging.info("Converting %s to RAM32M %s", cell_str, new_cell_name)

        ram32m = parent.createChildCellInst(new_cell_name, self.ram32m_edif_cell)

        prefix = ["A", "B", "C", "D"]
        for i, cell in zip(prefix, edif_cells):
            val = str(cell.getProperty("INIT").getValue())[4:]
            ram32m.addProperty(f"INIT_{i}", f"64'h{int(val, base=16):0{16}X}")

        global_pins = {"WE": ["WE"], "WCLK": ["WCLK"]}
        rw.transfer_global_pins(edif_cells, ram32m, global_pins)

        addrs = ["A0", "A1", "A2", "A3", "A4"]
        for i, cell in zip(prefix, edif_cells):
            rw.valid_bus_transfer(addrs, f"ADDR{i}", cell, ram32m)
            rw.valid_bus_transfer(["D"], f"DI{i}", cell, ram32m)
            rw.valid_bus_transfer(["O"], f"DO{i}", cell, ram32m)

        self.old_cells.extend(cells)
        for parent in (cell.getEDIFHierCellInst().getParent() for cell in cells):
            self.old_cells.append(parent)
        return [(ram32m, cells[0].getBELName())]
