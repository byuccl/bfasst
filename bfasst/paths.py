""" Repository paths using pathlib """

import pathlib
import os

ROOT_PATH = pathlib.Path(__file__).resolve().parent.parent

BUILD_PATH = pathlib.Path().cwd() / "build"

DESIGNS_PATH = ROOT_PATH / "designs"
BFASST_PATH = ROOT_PATH / "bfasst"
TESTS_PATH = ROOT_PATH / "tests"
RESOURCES_PATH = ROOT_PATH / "resources"
SCRIPTS_PATH = ROOT_PATH / "scripts"
ERROR_FLOW_PATH = ROOT_PATH / "error_flows"
THIRD_PARTY_PATH = ROOT_PATH / "third_party"

NINJA_TOOLS_PATH = BFASST_PATH / "ninja_tools"
NINJA_UTILS_PATH = BFASST_PATH / "ninja_utils"
NINJA_FLOWS_PATH = BFASST_PATH / "ninja_flows"

COMMON_TOOLS_PATH = NINJA_TOOLS_PATH / "common"

REV_BIT_TOOLS_PATH = NINJA_TOOLS_PATH / "rev_bit"
NINJA_TRANSFORM_TOOLS_PATH = NINJA_TOOLS_PATH / "transform"
PHYS_NETLIST_RULES_PATH = NINJA_TRANSFORM_TOOLS_PATH / "phys_netlist_rules.ninja"

NINJA_COMPARE_TOOLS_PATH = NINJA_TOOLS_PATH / "compare"
NINJA_CONFORMAL_TOOLS_PATH = NINJA_COMPARE_TOOLS_PATH / "conformal"
NINJA_STRUCTURAL_TOOLS_PATH = NINJA_COMPARE_TOOLS_PATH / "structural"
NINJA_YOSYS_TOOLS_PATH = NINJA_COMPARE_TOOLS_PATH / "yosys"

NINJA_BUILD_PATH = ROOT_PATH / "build.ninja"

I2C_RESOURCES = RESOURCES_PATH / "iCEcube2"
YOSYS_RESOURCES = RESOURCES_PATH / "yosys"
ONESPIN_RESOURCES = RESOURCES_PATH / "onespin"
YOSYS_INSTALL_DIR = THIRD_PARTY_PATH / "yosys"
GMT_TOOLS_PATH = THIRD_PARTY_PATH / "gmt_tools"

BFASST_UTILS_PATH = BFASST_PATH / "utils"


def get_fasm2bels_path():
    if "BFASST_PATH_FASM2BELS" in os.environ:
        return pathlib.Path(os.environ["BFASST_PATH_FASM2BELS"])
    return THIRD_PARTY_PATH / "fasm2bels"


XRAY_PATH = get_fasm2bels_path() / "third_party" / "prjxray"
