import os, logging

import bfasst.experiments
import bfasst.utils
import bfasst.config
import bfasst.flow
import bfasst.synth
import bfasst.design
import bfasst.status
import bfasst.impl
import bfasst.reverse_bit
import bfasst.compare

BFASST_REPO_PATH = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), os.pardir, os.pardir))

EXAMPLES_PATH = os.path.join(BFASST_REPO_PATH, "examples")
RESOURCES_PATH = os.path.join(BFASST_REPO_PATH, "resources")

I2C_RESOURCES = os.path.join(RESOURCES_PATH, "iCEcube2")