"""
Read Capnp files for logical and physical netlist representations.
See scripts/ for bash functions to convert these binary formats to text.
"""

import enum
import gzip
import os
from pathlib import Path

import capnp

from bfasst.paths import INTERCHANGE_SCHEMA_PATH

# pylint: disable=no-member
capnp.remove_import_hook()
# pylint: enable=no-member


# CAPNPROTO Constants
# Define capnproto compression format
class CompressionFormat(enum.Enum):
    UNCOMPRESSED = 0
    GZIP = 1


# Set capnproto traversal limit
NO_TRAVERSAL_LIMIT = 2**63 - 1
NESTING_LIMIT = 1024

SEARCH_PATH = [os.path.dirname(os.path.dirname(capnp.__file__))]
if "CONDA_PREFIX" in os.environ:
    SEARCH_PATH.append(os.path.join(os.environ["CONDA_PREFIX"], "include"))

if "CAPNP_PATH" in os.environ:
    SEARCH_PATH.append(os.environ["CAPNP_PATH"])

for path in ["/usr/local/include", "/usr/include"]:
    if os.path.exists(path):
        SEARCH_PATH.append(path)


class CapnpException(Exception):
    """Custom exception for Capnp related errors."""


class CapnpCells:
    """Helper class for retrieving capnp cells"""

    def __init__(self, phys_capnp_f: Path, log_capnp_f: Path) -> None:
        self.phys_capnp = self.read_phys_capnp(phys_capnp_f)
        self.log_capnp = self.read_log_capnp(log_capnp_f)

        self.phys_strs = self.phys_capnp.strList
        self.log_strs = self.log_capnp.strList

        self.phys_cells = {self.phys_strs[c.cellName]: c for c in self.phys_capnp.placements}
        self.log_cells = {self.log_strs[c.name]: c for c in self.log_capnp.instList}

    @staticmethod
    def _read_capnp_file(
        capnp_schema, f_in, compression_format=CompressionFormat.GZIP, is_packed=False
    ):
        """
        Return capnp files as python objects.
        """
        with open(f_in, "rb") as f:
            if compression_format == CompressionFormat.GZIP:
                with gzip.GzipFile(fileobj=f, mode="rb") as f_comp:
                    data = f_comp.read()
                    fb = capnp_schema.from_bytes_packed if is_packed else capnp_schema.from_bytes
                    return fb(
                        data,
                        traversal_limit_in_words=NO_TRAVERSAL_LIMIT,
                        nesting_limit=NESTING_LIMIT,
                    )
            capnp_read = capnp_schema.read_packed if is_packed else capnp_schema.read
            return capnp_read(f, traversal_limit_in_words=NO_TRAVERSAL_LIMIT)

    @staticmethod
    def read_phys_capnp(f_in):
        """
        Read a physical netlist from a capnp file.
        """
        # pylint: disable=no-member
        schema = capnp.load(
            str(INTERCHANGE_SCHEMA_PATH / "PhysicalNetlist.capnp"),
            imports=SEARCH_PATH,
        )
        # pylint: enable=no-member

        # Read the physical netlist
        with CapnpCells._read_capnp_file(schema.PhysNetlist, str(f_in)) as netlist:
            return netlist

    @staticmethod
    def read_log_capnp(f_in):
        """
        Read a logical netlist from a capnp file.
        """
        # pylint: disable=no-member
        schema = capnp.load(
            str(INTERCHANGE_SCHEMA_PATH / "LogicalNetlist.capnp"),
            imports=SEARCH_PATH,
        )
        # pylint: enable=no-member

        # Read the logical netlist
        with CapnpCells._read_capnp_file(schema.Netlist, str(f_in)) as netlist:
            return netlist

    def get_capnp_cell(self, cell_name: str):
        return self.phys_cells[cell_name], self.log_cells[cell_name.split("/")[0]]
