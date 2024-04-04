"""Utility functions"""

import json
import logging
from pathlib import Path
import re
import sys
import shutil
import enum

from bfasst.paths import DESIGNS_PATH
from bfasst.config import BUILD


class TermColor:
    """Terminal codes for printing in color"""

    # pylint: disable=too-few-public-methods

    PURPLE = "\033[95m"
    BLUE = "\033[94m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    END = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


class HdlType(enum.Enum):
    """class enumerating the type of HDL"""

    VERILOG = 1
    VHDL = 2
    MIXED = 3
    SYSTEM_VERILOG = 4


def print_color_no_newl(color, *msg):
    """Print color without newline"""
    sys.stdout.write(color + " ".join(str(item) for item in msg), TermColor.END)


def print_color(color, *msg):
    """Print mesage in color"""
    print(color + " ".join(str(item) for item in msg), TermColor.END)


def error(*msg, returncode=-1):
    """Print an error message and exit program"""

    print_color(TermColor.RED, "ERROR:", " ".join(str(item) for item in msg))
    sys.exit(returncode)


def create_build_dir(path):
    """Create a build directory if it doesn't exist"""
    new_dir = path / BUILD
    new_dir.mkdir(exist_ok=True)
    return new_dir


def create_build_design_dir(build_dir, design_dir):
    """Create design/build directory"""
    design_build_dir = build_dir / design_dir
    design_build_dir.mkdir(exist_ok=True)
    return design_build_dir


def get_design_dir(design_name):
    """Return the design directory"""
    return DESIGNS_PATH / design_name


def clean_folder(folder_path):
    """Remove all items in a folder"""

    for path in folder_path.iterdir():
        if path.is_file():
            path.unlink()
        else:
            shutil.rmtree(path)


def print_tcl_cmd_catch(fp, cmd, return_code=1):
    """Create a Tcl catch statement"""

    fp.write("if { [catch { " + cmd + " } ] } { exit " + str(return_code) + " }\n")


def convert_verilog_literal_to_int(prop):
    """
    Convert a Verilog literal to an integer

    >>> convert_verilog_literal_to_int("4'b1001")
    9
    >>> convert_verilog_literal_to_int("32'hdeadbeef")
    3735928559
    """
    # Not a string? just return the prop
    if not isinstance(prop, str):
        return prop

    # Try to convert to int
    try:
        prop = int(prop)
        return prop
    except ValueError:
        pass

    # Decimal literal
    matches = re.match(r"\d+'d(\d+)", prop)
    if matches:
        return int(matches.group(1))

    # Binary literal
    matches = re.match(r"\d+'b([01]+)", prop)
    if matches:
        return int(matches.group(1), 2)

    # Hex literal
    matches = re.match(r"\d+'h([0-9a-fA-F]+)", prop)
    if matches:
        return int(matches.group(1), 16)

    return prop


def properties_are_equal(prop1, prop2):
    """Compare Verilog property strings for equivalence

    >>> properties_are_equal(9, "32'b1001")
    True
    >>> properties_are_equal("32'b11101001", "8'he9")
    True
    >>> properties_are_equal(99, "16'd0099")
    True
    >>> properties_are_equal(1, "1'b1")
    True
    """
    return convert_verilog_literal_to_int(prop1) == convert_verilog_literal_to_int(prop2)


def compare_json(old_file, new_json):
    """Takes an old json file a new json string and compares them to see if they are different"""
    if not (old_file).is_file():
        return False

    with open(old_file, "r") as f:
        old_json = json.load(f)
        return sort_json(old_json) == sort_json(json.loads(new_json))


def sort_json(item):
    """Sorts a json object recursively"""
    if isinstance(item, dict):
        return sorted((k, sort_json(v)) for k, v in item.items())
    if isinstance(item, list):
        return sorted(sort_json(x) for x in item)
    return item


def log_with_banner(*msg):
    message = " ".join(str(s) for s in msg)
    banner = "=" * 120
    logging.info(banner)
    logging.info(message)
    logging.info(banner)


def get_hdl_src_types(srcs):
    """get hdl type of project"""
    if isinstance(srcs, Path):
        return get_hdl_src_type(srcs)

    hdl_type = None
    for src in srcs:
        hdl_type = get_hdl_src_type(src, hdl_type)
    return hdl_type


def get_hdl_src_type(file, hdl_type=None):
    """get hdl type of file"""
    if file.suffix == ".v" or file.suffix == ".vm":
        if hdl_type is None:
            hdl_type = HdlType.VERILOG
        elif hdl_type == HdlType.VHDL:
            hdl_type = HdlType.MIXED
    elif file.suffix == ".sv":
        if hdl_type is None:
            hdl_type = HdlType.SYSTEM_VERILOG
        elif hdl_type == HdlType.VHDL:
            hdl_type = HdlType.MIXED
    elif file.suffix == ".vhd":
        if hdl_type is None:
            hdl_type = HdlType.VHDL
        elif hdl_type == HdlType.VERILOG:
            hdl_type = HdlType.MIXED

    assert hdl_type is not None
    return hdl_type


def ensure_tuple(x):
    """If x is not a tuple, convert to tuple"""
    if isinstance(x, tuple):
        return x
    if isinstance(x, list):
        return tuple(x)
    return (x,)


def ensure(x, y):
    """Compensates for how python deals with default reference objects"""
    if x is None:
        return y
    return x


def json_write_if_changed(path, json_str):
    """Write the json file for the tool, if the new string
    does not match the json already in existence."""
    json_equivalent = compare_json(path, json_str)

    if not json_equivalent:
        with open(path, "w") as f:
            f.write(json_str)
