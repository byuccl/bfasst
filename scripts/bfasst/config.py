from pathlib import Path

# Tool path locations
IC2_INSTALL_DIR = Path("/home/elicahill/lscc/iCEcube2.2017.08/")
ICESTORM_INSTALL_DIR = Path("/home/elicahill/icestorm/icestorm")
YOSYS_INSTALL_DIR = Path("/home/elicahill/icestorm/yosys")

CONFORMAL_REMOTE_MACHINE = "ssh.et.byu.edu"
CONFORMAL_REMOTE_MACHINE_USER = "ecahill"
CONFORMAL_REMOTE_SOURCE_SCRIPT = Path("/ee2/Cadence/local/designkits/ee451/cdssetup/bashrc_cadence")
CONFORMAL_REMOTE_WORK_DIR = Path("/fsj/ecahill/ice")
CONFORMAL_REMOTE_LIBS_DIR = Path("/fsj/ecahill/ice_libs")
CONFORMAL_REMOTE_PATH = Path("/ee2/Cadence/CONFRML152/bin/lec")

I2C_LSE_TIMEOUT = 600.0
CONFORMAL_TIMEOUT = 600.0

BUILD_DIR = "build"


SYNTH_LOG_NAME = "synth.log"
IMPL_LOG_NAME = "impl.log"
