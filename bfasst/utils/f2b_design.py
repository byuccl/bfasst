"""
Class to load a Fasm2bels capnproto design/netlist and fix the signals based on the
fasm2bels IS_..._INVERTED properties.
"""

import logging
from pathlib import Path
import time

from bfasst import jpype_jvm
from bfasst import utils
from bfasst.config import PART
import bfasst.utils.rw_helpers as rw
from bfasst.utils.capnp_cells import CapnpCells

# pylint: disable=wrong-import-position,wrong-import-order,import-error
jpype_jvm.start()
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.design import Cell
from com.xilinx.rapidwright.edif import EDIFCellInst, EDIFHierCellInst, EDIFHierPortInst
from com.xilinx.rapidwright.interchange import LogNetlistReader, PhysNetlistReader
from java.lang import System
from java.io import PrintStream, File

# pylint: enable=wrong-import-position,wrong-import-order,import-error


class F2BDesign:
    """
    Load Fasm2bels capnproto design into RapidWright and fix inverted signals.

    Currently, the fix_rev_... functions need to be manually called so the user
    can avoid iterating a cycle of iterating through all the design cells.
    """

    def __init__(self, edf_capnp, impl_capnp, f2b_rw_log, **kwargs):
        # Redirect rapidwright output to file
        System.setOut(PrintStream(File(f2b_rw_log)))
        System.setErr(PrintStream(File(f2b_rw_log)))
        logging.info("Loading reversed capnp objects: %s, %s", str(impl_capnp), str(edf_capnp))
        start_time = time.time()
        self.rev_netlist = LogNetlistReader.readLogNetlist(str(edf_capnp))
        self.rev_design = PhysNetlistReader.readPhysNetlist(str(impl_capnp), self.rev_netlist)
        self.rev_design.flattenDesign()
        self.rev_netlist.expandMacroUnisims(Device.getDevice(PART).getSeries())
        logging.info("Loading reversed capnp objects took %s seconds.", time.time() - start_time)

        self.capnp_cells = CapnpCells(impl_capnp, edf_capnp)
        # Static variables for fixing rev Primitives
        self.dsp_inv_props = (
            ("IS_INMODE_INVERTED", "INMODE"),
            ("IS_ALUMODE_INVERTED", "ALUMODE"),
            ("IS_OPMODE_INVERTED", "OPMODE"),
        )

        # These signals are fixed routing paths in the FPGA (nonprogrammable). They are always
        # connected to the cooresponding neighbor DSP site in the tile. Internal to the site,
        # there is a mux that selects them. Dispite this, when they are unused, Vivado shows
        # them as connected to GND or simply disconnected. F2B shows the persistant connection
        # to the neighboring DSP site.
        # Other inputs control the mux, so as long as this matches, the cascade values
        # are irrelevant. See Xilinx UG479 Figure 2-1 for more information.
        self.dsp_constant_ports = ["CARRYCASCIN", "CARRYCASCOUT"] + [
            f"{port_name}[{idx}]"
            for port_name, bus_size in (("PCIN", 48), ("PCOUT", 48))
            for idx in range(bus_size)
        ]

        self.bram_inv_props = (
            ("IS_CLKARDCLK_INVERTED", "CLKARDCLK"),
            ("IS_CLKBWRCLK_INVERTED", "CLKBWRCLK"),
            ("IS_ENARDEN_INVERTED", "ENARDEN"),
            ("IS_ENBWREN_INVERTED", "ENBWREN"),
            ("IS_RSTRAMARSTRAM_INVERTED", "RSTRAMARSTRAM"),
            ("IS_RSTRAMB_INVERTED", "RSTRAMB"),
            ("IS_RSTREGARSTREG_INVERTED", "RSTREGARSTREG"),
            ("IS_RSTREGB_INVERTED", "RSTREGB"),
        )
        self.bufgctrl_inv_props = (
            ("IS_S0_INVERTED", "S0"),
            ("IS_S1_INVERTED", "S1"),
            ("IS_CE0_INVERTED", "CE0"),
            ("IS_CE1_INVERTED", "CE1"),
            ("IS_IGNORE0_INVERTED", "IGNORE0"),
            ("IS_IGNORE1_INVERTED", "IGNORE1"),
        )

        self.rw_value_mismatch = 0
        self.rw_value_mismatches = []
        self.rw_problem_cells = set()

        super().__init__(**kwargs)

    def handle_missing_prop(self, rev_cell: Cell, prop_name: str) -> int:
        """
        Sometimes properties from capnp are missing in the RapidWright data structure.
        So far this has only been LUT Init strings.
        """
        _, lcapnp_cell = self.capnp_cells.get_capnp_cell(rev_cell.getName())
        assert lcapnp_cell is not None
        rev_value = None

        for props in lcapnp_cell.propMap.entries:
            if self.capnp_cells.log_capnp.strList[props.key] == prop_name:
                rev_value = self.capnp_cells.log_capnp.strList[props.textValue]
                break
        assert rev_value is not None
        rev_value = utils.convert_verilog_literal_to_int(rev_value)
        self.rw_value_mismatch += 1
        self.rw_problem_cells.add(rev_cell.getName())
        logging.warning("Adding cell %s to rw problem cells", rev_cell.getName())
        return rev_value

    def update_lut_ports(self, rev_cell: Cell, rev_port_insts: dict[str, EDIFHierPortInst]) -> None:
        """Update port_insts on the reversed LUT to reflect the combined LUT6_2 cell."""
        assert "O6" not in rev_port_insts
        assert "O5" not in rev_port_insts

        if rev_cell.getType() == "LUT6":
            rev_port_insts["O6"] = rev_port_insts.pop("O")
            rev_lut5 = rev_cell.getSiteInst().getCell(f"{rev_cell.getBELName()[0]}5LUT")
            if rev_lut5 is not None:
                rev_hecell_lut5 = rev_lut5.getEDIFHierCellInst()
                o5 = rev_hecell_lut5.getPortInst("O")
                if o5 is not None:
                    rev_port_insts["O5"] = o5
                if __debug__:  # Sanity check input nets are the same on shared pins
                    self._compare_shared_lut_pins(rev_port_insts, rev_hecell_lut5)

        elif rev_cell.getType() == "LUT5":
            rev_port_insts["O5"] = rev_port_insts.pop("O")
            rev_lut6 = rev_cell.getSiteInst().getCell(f"{rev_cell.getBELName()[0]}6LUT")
            if rev_lut6 is not None:
                rev_hecell_lut6 = rev_lut6.getEDIFHierCellInst()
                rev_port_insts["O6"] = rev_hecell_lut6.getPortInst("O")
                rev_port_insts["I5"] = rev_hecell_lut6.getPortInst("I5")
                if __debug__:  # Sanity check input nets are the same on shared pins
                    self._compare_shared_lut_pins(rev_port_insts, rev_hecell_lut6)

    def _compare_shared_lut_pins(
        self, rev_port_insts: dict[str, EDIFHierPortInst], other_lut: EDIFHierCellInst
    ) -> None:
        """
        Compare the shared pins of LUT6 and LUT5 cells to ensure they match.
        This is used when a LUT6_2 cell is split into a LUT6 and LUT5.
        """
        for port_name in ("I0", "I1", "I2", "I3", "I4"):
            if port_name not in rev_port_insts:
                assert other_lut.getPortInst(port_name) is None
                continue
            l6_net = rev_port_insts[port_name].getHierarchicalNet()
            l5_net = other_lut.getPortInst(port_name).getHierarchicalNet()
            assert l6_net == l5_net

    def _check_bram(self, name: str, ecell: EDIFCellInst, rev_cell: Cell) -> set[str]:
        """Special checks for BRAM"""
        ignore_pins = {"RSTRAMARSTRAM", "RSTRAMB"}
        mode = ecell.getProperty("RAM_MODE").getValue()
        if ecell.getProperty("DOA_REG").getValue() == "0":
            if ecell.getProperty("DOB_REG").getValue() == "0":
                ignore_pins.update(("RSTREGARSTREG", "RSTREGB", "REGCEAREGCE", "REGCEB"))
            elif mode == "TDP":
                ignore_pins.update(("RSTREGARSTREG",))
        bram_a_only = False
        if mode == "TDP":
            ignore_pins.update(("SBITERR", "ECCPARITY", "RDADDRECC"))
            # Continue check for bram_a_only
            port_gen = (ecell.getPortInst(f"DOBDO[{i}]") for i in range(32))
            ports = [p for p in port_gen if p is not None and not p.getNet().isGND()]
            bram_a_only = not ports
        if bram_a_only:
            ignore_pins.update(
                ("CASCADEINA", "CASCADEINB", "CASCADEOUTA", "CASCADEOUTB", "CLKBWRCLK", "ENBWREN")
            )

        # According to the BRAM docs, if SDP, then these ports are not used.
        if mode == "SDP":
            ignore_pins.update(
                (
                    "CASCADEINA",
                    "CASCADEINB",
                    "CASCADEOUTA",
                    "CASCADEOUTB",
                    "REGCEB",
                    "RSTREGB",
                    "WEA",
                )
            )

        if rev_cell.getType() == "RAMB36E1":
            # A15 is only connected to a non-const net when cascade is enabled
            # Right now, it seems vivado will connect to vcc, although unconnected is valid
            expected_props = (
                ecell.getProperty("RAM_EXTENSION_A").getValue() == '"NONE"'
                and ecell.getProperty("RAM_EXTENSION_B").getValue() == '"NONE"'
                and rw.is_static_net(ecell.getPortInst("ADDRARDADDR[15]").getNet())
                and rw.is_static_net(ecell.getPortInst("ADDRBWRADDR[15]").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEINA").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEINB").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEOUTA").getNet())
                and rw.is_static_net(ecell.getPortInst("CASCADEOUTB").getNet())
            )
            if not expected_props:
                logging.warning("Unexpected BRAM properties for %s", name)

        self.fix_rev_bram(rev_cell, ignore_pins)

        return ignore_pins

    def fix_rev_bufg(self, cell: Cell) -> None:
        """
        Sometimes F2B puts the same clock signal to both bufgctrl input ports, instead of just I0.
        """
        ecell = cell.getEDIFCellInst()
        assert ecell
        i1_port = ecell.getPortInst("I1")
        i1_net = i1_port.getNet()
        if not i1_net.isVCC():
            i0 = ecell.getPortInst("I0").getNet()
            assert i0.getName() == i1_net.getName()
            logging.info("F2B BUFGCTRL %s has same clock on both inputs, switching I1 to VCC", cell)
            i1_net.removePortInst(ecell.getPortInst("I1"))
            self.rev_design.getVccNet().getLogicalNet().addPortInst(i1_port)

        for prop, port_name in self.bufgctrl_inv_props:
            val = ecell.getProperty(prop).getValue()
            if val == "1'b1":
                logging.info("Flipping %s port on BUFGCTRL %s", port_name, cell.getName())
                rw.flip_const_port_signal(self.rev_design, ecell, port_name)

    def fix_rev_dsp(self, cell: Cell) -> None:
        """
        Fasm2bels does not accurately set the OPMODE, ALUMODE, INMODE pins.
        The fasm file specifies some incoming nets to these ports should be
        inverted, but the f2b code does not do anything with this information.
        I have added some code to add a custom property to the DSP48E2 for these
        values. Check the dsp properties and adjust the input signals accordingly.
        """
        logging.info("Processing reversed DSP %s for inverted signals", cell.getName())
        ecell = cell.getEDIFCellInst()
        assert ecell

        # XRAY erroneously does not output feature to invert carryin signal.
        rw.flip_const_port_signal(self.rev_design, ecell, "CARRYIN")

        name = cell.getSite().getName()
        viv_cell = self.vivado_design.getSiteInstFromSiteName(name).getCell(cell.getBELName())
        viv_cell = viv_cell.getEDIFCellInst()
        for port_name in self.dsp_constant_ports:
            viv_port_inst = viv_cell.getPortInst(port_name)
            if viv_port_inst is None or viv_port_inst.getNet().isGND():
                logging.info("Disconnecting %s port", port_name)
                port_inst = ecell.getPortInst(port_name)
                assert port_inst
                port_inst.getNet().removePortInst(port_inst)

        # Flip dsp signals according to f2b properties
        for prop, port_name in self.dsp_inv_props:
            val = ecell.getProperty(prop).getValue()
            for idx, inv in enumerate(reversed(val[3:])):
                if not int(inv):
                    continue
                rw.flip_const_port_signal(self.rev_design, ecell, f"{port_name}[{idx}]", idx)
        if ecell.getProperty("IS_CLK_INVERTED").getValue() == "1'b1":
            rw.flip_const_port_signal(self.rev_design, ecell, "CLK")

        # FASM2BELS just sets USE_MULT to "MULTIPLY" -> infer new value based on OPMODE
        # If opmode is not constant, then the value is DYNAMIC
        # The multiply unit (output) is only used if opmode[3:0] = 4'b0101
        opmode = [
            ecell.getPortInst(port_name).getNet()
            for port_name in ("OPMODE[3]", "OPMODE[2]", "OPMODE[1]", "OPMODE[0]")
        ]
        if [net for net in opmode if not rw.is_static_net(net)]:
            logging.info("Nonconstant OPMODE: Setting USE_MULT to DYNAMIC for %s", cell.getName())
            ecell.addProperty("USE_MULT", "DYNAMIC")
        elif [net.isVCC() for net in opmode] != [False, True, False, True]:
            logging.info(
                "Constant OPMODE bypasses mult output. Setting USE_MULT to NONE for %s",
                cell.getName(),
            )
            ecell.addProperty("USE_MULT", "NONE")

    def fix_rev_bram(self, cell: Cell, ignore_pins: set[str]) -> None:
        """
        Invert BRAM ports based on f2b properties.
        Ignore pins takes non zero timme, so skip if possible.
        """
        logging.info("Processing reversed BRAM %s for inverted signals", cell.getName())
        ecell = cell.getEDIFCellInst()
        assert ecell

        # Flip bram signals according to f2b properties
        for prop, port_name in (p for p in self.bram_inv_props if p[1] not in ignore_pins):
            val = int(str(ecell.getProperty(prop).getValue()))
            if val:
                rw.flip_const_port_signal(self.rev_design, ecell, port_name)
