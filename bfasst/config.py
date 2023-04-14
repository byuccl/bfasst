""" Machine-specific configuration settings"""

import os
from pathlib import Path

# Tool path locations
IC2_INSTALL_DIR = Path("/opt/lscc/iCEcube2.2017.08/")
ICESTORM_INSTALL_DIR = Path("/home/jgoeders/icestorm")

CONFORMAL_REMOTE_MACHINE = "ssh.et.byu.edu"
CONFORMAL_REMOTE_MACHINE_USER = "squallzz"
CONFORMAL_REMOTE_SOURCE_SCRIPT = Path("/ee2/Cadence/local/designkits/ee451/cdssetup/bashrc_cadence")
CONFORMAL_REMOTE_WORK_DIR = Path("/fsj/squallzz/bfasst_work")
CONFORMAL_REMOTE_LIBS_DIR = Path("/fsj/squallzz/bfasst_libs")
CONFORMAL_REMOTE_PATH = Path("/ee2/Cadence/CONFRML152/bin/lec")

VIVADO_BIN_PATH = os.environ["VIVADO_PATH"]

I2C_LSE_TIMEOUT = 600.0
YOSYS_TIMEOUT = 600.0
CONFORMAL_TIMEOUT = 600.0

BUILD_DIR = "build"

PART_FAMILY = "artix7"
PART = "xc7a200tsbg484-1"
