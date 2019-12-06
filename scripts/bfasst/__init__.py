import os, logging, pathlib

import bfasst.utils
import bfasst.config
import bfasst.flow
import bfasst.synth
import bfasst.design
import bfasst.status
import bfasst.impl
import bfasst.reverse_bit
import bfasst.compare
import bfasst.experiment

BFASST_REPO_PATH = pathlib.Path(__file__).resolve().parent.parent.parent

EXAMPLES_PATH = BFASST_REPO_PATH / "examples"
EXPERIMENTS_PATH = BFASST_REPO_PATH / "experiments"
RESOURCES_PATH = BFASST_REPO_PATH / "resources"
SCRIPTS_PATH = BFASST_REPO_PATH / "scripts"

I2C_RESOURCES = RESOURCES_PATH / "iCEcube2"
YOSYS_RESOURCES = RESOURCES_PATH / "yosys"
