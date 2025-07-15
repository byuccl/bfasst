"""Manage installation of external tools"""

import argparse
import os
import socket
import subprocess
import sys
import traceback
import paramiko

import yaml

from bfasst.config import IC2_INSTALL_DIR, PART, VIVADO_BIN_PATH
from bfasst.paths import (
    ICEBOX_VLOG_PATH,
    ICEUNPACK_PATH,
    RAPIDWRIGHT_PATH,
    ROOT_PATH,
    THIRD_PARTY_PATH,
    WAFOVE_PATH,
    YOSYS_PATH,
    FASM2BELS_PATH,
    DESIGNS_PATH,
)
from bfasst.utils.conformal import ConformalCompare
from bfasst.utils.general import error
from bfasst.yaml_parser import FlowDescriptionParser

################################################################################
# Per Tool Check Functions
################################################################################


def check_rand_soc():
    return (THIRD_PARTY_PATH / "rand_soc" / "requirements.txt").is_file()


def check_vivado():
    return VIVADO_BIN_PATH.is_file()


def check_ic2():
    return IC2_INSTALL_DIR.is_dir()


def check_icestorm():
    return ICEBOX_VLOG_PATH.is_file() and ICEUNPACK_PATH.is_file()


def check_fasm2bels():
    return (FASM2BELS_PATH / "env").is_dir() and (FASM2BELS_PATH / f"{PART}_db").is_file()


def check_conformal():
    try:
        client = ConformalCompare.connect_to_remote_machine()
    except (socket.gaierror, paramiko.ssh_exception.AuthenticationException):
        print(traceback.format_exc())
        return False
    if not client:
        return False
    client.close()
    return True


def check_rapidwright():
    return (
        (RAPIDWRIGHT_PATH / "build" / "libs" / "rapidwright.jar").is_file()
        and (RAPIDWRIGHT_PATH / "interchange" / "schema" / "capnp" / "java.capnp").is_file()
        and os.environ.get("INTERCHANGE_SCHEMA_PATH") is not None
    )


def check_yosys():
    return (YOSYS_PATH / "yosys").is_file()


def check_wafove():
    return (WAFOVE_PATH / "wafove" / "compare_waveforms.py").is_file()


def check_opentitan():
    return (DESIGNS_PATH / "opentitan").is_dir()


################################################################################
# Command Line Interface
################################################################################


def install_tool(tool):
    print("=" * 80)
    print("Installing", tool)
    print("=" * 80, flush=True)

    proc = subprocess.run(["make", f"install_{tool}"], cwd=ROOT_PATH)
    if proc.returncode:
        return False
    return True


def install_tools(tools):
    if not tools:
        return True
    for tool in tools:
        success = install_tool(tool)
        if not success:
            return False
    return check_tools(tools)


def install_tools_cli(tools):
    if not install_tools(tools):
        sys.exit(1)


def install_flow_tools(flow):
    tools = FlowDescriptionParser().get_flow_tools(flow)
    return install_tools(tools)


def install_test_yaml_cli(args):
    yaml_path = args.yaml_path

    with open(yaml_path) as f:
        data = yaml.safe_load(f)
    success = install_flow_tools(data["flow"])
    if not success:
        sys.exit(1)


def check_flow(flow):
    tools = FlowDescriptionParser().get_flow_tools(flow)
    return check_tools(tools)


def check_flow_cli(flow):
    if not check_flow(flow):
        sys.exit(1)


def check_tools(tools):
    """Check that the given list of tools are installed"""
    missing_tools = []
    if not tools:
        return True
    for tool in tools:
        fcn_name = f"check_{tool}"
        if fcn_name not in globals():
            error("external_tools.py requires a function named", fcn_name)
        if not globals()[fcn_name]():
            missing_tools.append(tool)
            print(
                (
                    f"External tool {tool} is not installed. "
                    f"Please try installing with `make install_{tool}`"
                )
            )
    if missing_tools:
        return False
    return True


def check_tools_cli(tools):
    if not check_tools(tools):
        sys.exit(1)


def main():
    """CLI interface"""
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()
    subparsers.required = True

    parser_install = subparsers.add_parser("install")
    parser_install.add_argument("tool", nargs="+")
    parser_install.set_defaults(func=lambda args: install_tools_cli(args.tool))

    parser_install = subparsers.add_parser("install_flow_tools")
    parser_install.add_argument("flow")
    parser_install.set_defaults(func=lambda args: install_flow_tools(args.flow))

    parser_install = subparsers.add_parser("install_test_yaml")
    parser_install.add_argument("yaml_path")
    parser_install.set_defaults(func=install_test_yaml_cli)

    parser_check = subparsers.add_parser("check")
    parser_check.add_argument("tool", nargs="+")
    parser_check.set_defaults(func=lambda args: check_tools_cli(args.tool))

    parser_check = subparsers.add_parser("check_flow")
    parser_check.add_argument("flow")
    parser_check.set_defaults(func=lambda args: check_flow_cli(args.flow))

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
