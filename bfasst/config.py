""" Machine-specific configuration settings"""

import os
from pathlib import Path

# Tool path locations
IC2_INSTALL_DIR = Path("/tools/lscc/iCEcube2.2020.12")
IC2_FOUNDRY = IC2_INSTALL_DIR / "LSE"
IC2_LSE_LD_LIBRARY_PATH = IC2_FOUNDRY / "bin" / "lin64"
IC2_LSE_SYNTH_BIN = IC2_LSE_LD_LIBRARY_PATH / "synthesis"
IC2_SBT_DIR = IC2_INSTALL_DIR / "sbt_backend"
IC2_SYNPLIFY_LD_LIBRARY_PATH = IC2_SBT_DIR / "bin" / "linux" / "opt" / "synpwrap"
IC2_SYNPLIFY_PATH = IC2_INSTALL_DIR / "synpbase"
IC2_SYNPLIFY_BIN = IC2_SYNPLIFY_LD_LIBRARY_PATH / "synpwrap"

CONFORMAL_REMOTE_MACHINE = "ssh.et.byu.edu"
CONFORMAL_REMOTE_MACHINE_USER = "jgoeders"
CONFORMAL_REMOTE_SOURCE_SCRIPT = Path("/ee2/Cadence/local/designkits/ee451/cdssetup/bashrc_cadence")
CONFORMAL_REMOTE_WORK_DIR = Path("/fsj/jgoeders/bfasst_work")
CONFORMAL_REMOTE_LIBS_DIR = Path("/fsj/jgoeders/bfasst_libs")
CONFORMAL_REMOTE_PATH = Path("/ee2/Cadence/CONFRML152/bin/lec")

VIVADO_BIN_PATH = Path(os.environ["VIVADO_PATH"])
VIVADO_COMMAND = [str(VIVADO_BIN_PATH), "-nojournal", "-nolog", "-mode", "tcl"]

I2C_LSE_TIMEOUT = 600.0
YOSYS_TIMEOUT = 600.0
CONFORMAL_TIMEOUT = 600.0

BUILD = "build"

PART_FAMILY = "artix7"
PART = "xc7a200tsbg484-1"
