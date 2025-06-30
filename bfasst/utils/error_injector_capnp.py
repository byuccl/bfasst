"""Inject errors into reversed capnp netlist"""

from enum import Enum
import logging
import random
from pathlib import Path
import time

from bfasst import jpype_jvm
from bfasst.config import PART
from bfasst import utils
from bfasst.utils.capnp_cells import CapnpCells
from bfasst.utils.general import convert_verilog_literal_to_int

jpype_jvm.start()
from com.xilinx.rapidwright.device import Device
from com.xilinx.rapidwright.interchange import LogNetlistReader, LogNetlistWriter, PhysNetlistReader, PhysNetlistWriter

from java.lang import System
from java.io import PrintStream, File

class ErrorType(Enum):
    """Types of errors that can be injected"""

    BIT_FLIP = "BIT_FLIP"
    WIRE_SWAP = "WIRE_SWAP"

class ErrorInjectorException(Exception):
    """Exception for ErrorInjector"""

class ErrorInjectorCapnp:
    """Inject errors into reversed capnp netlist"""
    def __init__(self, build_dir, log_path, rw_log, seed, error_type, phys_netlist, log_netlist, logging_level=logging.DEBUG) -> None:
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / "error_injection_capnp"
        self.log_path = self.stage_dir / log_path
        self.rw_log = str(self.stage_dir / rw_log)
        self.logging_level = logging_level
        logging.basicConfig(
            filename=self.log_path,
            level=self.logging_level,
            format="%(asctime)s %(message)s",
            datefmt="%Y%m%d%H%M%S",
        )
        self.random_generator = random.Random(seed)


        self.rev_netlist = None
        self.rev_design = None
        self.capnp_cells = None
        self.device = Device.getDevice(PART)

        System.setOut(PrintStream(File(self.rw_log)))
        System.setErr(PrintStream(File(self.rw_log)))

        self.load_capnp_design(phys_netlist, log_netlist)

        self.injector = self.get_injection_function(ErrorType[error_type.upper()])
        self.luts = None


    def get_injection_function(self, error_type):
        """
        Injects an error into the netlist of the given type
        """
        if error_type == ErrorType.BIT_FLIP:
            return self.inject_bit_flip
        # TODO: add wire flip
        # if error_type == ErrorType.WIRE_SWAP:
        #     return self.inject_wire_swap
        raise ErrorInjectorException("Invalid error type")

    
    def get_luts(self) -> None:
        """
        Gets a list of all luts in the netlist, including routethrus
        """
        # luts = [instance for instance in self.rev_design.getAllLeafHierCellInstances() if "LUT" in instance.toString()]
        sites = self.rev_design.getSiteInsts()
        cells = []
        for site in sites:
            cells.extend(site.getCells())
        edif_cells = []
        for cell in cells:
            edif_cells.append(cell.getEDIFHierCellInst())
        luts = [edif_cell for edif_cell in edif_cells if "LUT" in edif_cell.toString()]
        luts.sort(key=lambda x: x.toString())
        self.luts = [instance.getInst() for instance in luts]
        

    def pick_lut(self):
       """
       Picks a random lut out of the list
       """
       lut_num = self.random_generator.randrange(len(self.luts))
       return self.luts[lut_num]

    def get_init_size(self, lut) -> int:
        init_string = str(lut.getProperty("INIT").getValue())
        init_size = int(init_string.split("'")[0])
        return init_size


    def pick_bit(self, lut) -> int:
        """
        Picks a random bit out of the luts init string
        """
        init_size = self.get_init_size(lut)
        return self.random_generator.randrange(init_size)


    def flip_bit(self, lut, bit_num) -> None:
        """
        Flips the bit, creates a new INIT property, and replaces the old one
        """
        init_size = self.get_init_size(lut)
        old_init = lut.getProperty("INIT").getValue()
        new_init_int = convert_verilog_literal_to_int(old_init) ^ (1 << bit_num)
        hex_digits = (init_size + 3) // 4
        new_hex = format(new_init_int & ((1 << init_size) - 1), f"0{hex_digits}x")
        new_init = f"{init_size}'h" + new_hex
        prop = lut.getProperty("INIT")
        prop.setValue(new_init)


    def inject_bit_flip(self) -> None:
        """Injects a bit flip error into a LUT's init string"""
        self.get_luts()
        lut = self.pick_lut()
        bit_num = self.pick_bit(lut)
        self.flip_bit(lut, bit_num)
        logging.info("Finished flipping bit")

    def write_new_netlist(self) -> None:
        """
        Writes the new logical netlist
        """
        PhysNetlistWriter.writePhysNetlist(self.rev_design, str(self.stage_dir / "corrupt_phys_netlist.capnp"))
        LogNetlistWriter.writeLogNetlist(self.rev_netlist, str(self.stage_dir / "corrupt_log_netlist.capnp"))
        logging.info("Finished writing netlist")


    def load_capnp_design(self, phys_capnp: Path, edf_capnp: Path) -> None:
        """Load the capnp design and netlist."""
        logging.info("Loading reversed capnp objects: %s, %s", str(phys_capnp), str(edf_capnp))
        start_time = time.time()
        
        self.rev_netlist = LogNetlistReader.readLogNetlist(str(edf_capnp))
        self.rev_design = PhysNetlistReader.readPhysNetlist(str(phys_capnp), self.rev_netlist)
        self.rev_design.flattenDesign()
        self.rev_netlist.expandMacroUnisims(self.device.getSeries())
        logging.info("Loading reversed capnp objects took %s seconds.", time.time() - start_time)

        self.capnp_cells = CapnpCells(phys_capnp, edf_capnp)




