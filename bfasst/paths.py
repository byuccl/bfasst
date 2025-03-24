"""Repository paths using pathlib"""

import pathlib
import os

ROOT_PATH = pathlib.Path(__file__).resolve().parent.parent

BUILD_DEFAULT_PATH = pathlib.Path().cwd() / "build"

DESIGNS_PATH = ROOT_PATH / "designs"
BFASST_PATH = ROOT_PATH / "bfasst"
TESTS_PATH = ROOT_PATH / "tests"
RESOURCES_PATH = ROOT_PATH / "resources"
SCRIPTS_PATH = ROOT_PATH / "scripts"
ERROR_FLOW_PATH = ROOT_PATH / "error_flows"
THIRD_PARTY_PATH = ROOT_PATH / "third_party"

TOOLS_PATH = BFASST_PATH / "tools"
FLOWS_PATH = BFASST_PATH / "flows"

COMMON_TOOLS_PATH = TOOLS_PATH / "common"

DATASET_METRICS_TOOLS_PATH = TOOLS_PATH / "dataset_metrics"

REV_BIT_TOOLS_PATH = TOOLS_PATH / "rev_bit"
NINJA_TRANSFORM_TOOLS_PATH = TOOLS_PATH / "transform"

COMPARE_TOOLS_PATH = TOOLS_PATH / "compare"
CONFORMAL_TOOLS_PATH = COMPARE_TOOLS_PATH / "conformal"
STRUCTURAL_TOOLS_PATH = COMPARE_TOOLS_PATH / "structural"
YOSYS_TOOLS_PATH = COMPARE_TOOLS_PATH / "yosys"

NINJA_BUILD_PATH = pathlib.Path().cwd() / "build.ninja"

IC2_RESOURCES = RESOURCES_PATH / "iCEcube2"
LSE_PRJ_TEMPLATE = IC2_RESOURCES / "template_lse_prj.mustache"
IC2_IMPL_TCL_TEMPLATE = IC2_RESOURCES / "template.tcl"
SYNPLIFY_PRJ_TEMPLATE = IC2_RESOURCES / "template_sp_prj.mustache"

YOSYS_RESOURCES = RESOURCES_PATH / "yosys"
YOSYS_SYNTH_SCRIPT_TEMPLATE = YOSYS_RESOURCES / "yosys_synth_template.mustache"
GMT_TOOLS_PATH = THIRD_PARTY_PATH / "gmt_tools"
RAPIDWRIGHT_PATH = THIRD_PARTY_PATH / "RapidWright"
YOSYS_PATH = THIRD_PARTY_PATH / "yosys"
YOSYS_EXE_PATH = YOSYS_PATH / "yosys"
WAFOVE_PATH = THIRD_PARTY_PATH / "WaFoVe"

ICESTORM_PATH = THIRD_PARTY_PATH / "icestorm" / "bin"
ICEUNPACK_PATH = ICESTORM_PATH / "iceunpack"
ICEBOX_VLOG_PATH = ICESTORM_PATH / "icebox_vlog"

BFASST_UTILS_PATH = BFASST_PATH / "utils"

FLOW_DESCRIPTIONS_PATH = FLOWS_PATH / "flow_descriptions.yaml"


def get_fasm2bels_path():
    if "BFASST_PATH_FASM2BELS" in os.environ:
        return pathlib.Path(os.environ["BFASST_PATH_FASM2BELS"])
    return THIRD_PARTY_PATH / "fasm2bels"


FASM2BELS_PATH = get_fasm2bels_path()
FASM2BELS_PYTHON_PATH = (
    FASM2BELS_PATH / "env" / "conda" / "envs" / "f4pga_xc_fasm2bels" / "bin" / "python3"
)
XRAY_PATH = FASM2BELS_PATH / "third_party" / "prjxray"
XRAY_DB_PATH = FASM2BELS_PATH / "third_party" / "prjxray-db"
