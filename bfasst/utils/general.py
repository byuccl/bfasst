"""Utility functions"""

from argparse import ArgumentParser
import atexit
import code
import json
import logging
import os
from pathlib import Path
import re
import readline
import rlcompleter
import sys
import shutil
import enum

from jpype.types import JString
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
    # For rapidwright compatibility
    if isinstance(prop, JString):
        prop = str(prop)
    # Not a string? just return the prop
    elif not isinstance(prop, str):
        return prop

    # Try to convert to int
    try:
        prop = int(prop)
        return prop
    except ValueError:
        pass

    regex_nums = (  # Regex patterns for different verilog number formats.
        (r"\d+'d(\d+)", 10),
        (r"\d+'b([01]+)", 2),
        (r"\d+'h([0-9a-fA-F]+)", 16),
    )
    for regex, base in regex_nums:
        matches = re.match(regex, prop)
        if matches:
            return int(matches.group(1), base)

    if prop.upper() == "TRUE":
        return True
    if prop.upper() == "FALSE":
        return False

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
    if file.suffix in (".v", ".vm"):
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
    return x if x is not None else y


def json_write_if_changed(path, json_str):
    """Write the json file for the tool, if the new string
    does not match the json already in existence."""
    json_equivalent = compare_json(path, json_str)

    if not json_equivalent:
        with open(path, "w") as f:
            f.write(json_str)


def get_family_from_part(part):
    """
    part (string): e.g., "xc7a200tsbg484-1"
    Returns the part family name based on the part name,
    will have to be changed if we start supporting more part families
    """
    return "kintex7" if part[3] == "k" else "artix7"


def get_size(obj, seen=None):
    """Recursively finds size of objects using generators."""
    size = sys.getsizeof(obj)
    if seen is None:
        seen = set()
    obj_id = id(obj)
    if obj_id in seen:
        return 0
    seen.add(obj_id)
    if isinstance(obj, dict):
        size += sum(get_size(v, seen) for v in obj.values())
        size += sum(get_size(k, seen) for k in obj.keys())
    elif hasattr(obj, "__dict__"):
        size += get_size(obj.__dict__, seen)
    elif hasattr(obj, "__iter__") and not isinstance(obj, (str, bytes, bytearray)):
        size += sum(get_size(i, seen) for i in obj)
    return size


def add_path_arg(p: ArgumentParser, arg: str, help_msg: str):
    p.add_argument(arg, type=Path, required=True, help=help_msg)


def interpreter(local=None):
    """Start an interactive Python interpreter with the given locals. UNIX ONLY"""
    if local is None:
        local = globals().copy()
    else:
        local.update(globals())

    completer = rlcompleter.Completer(local)

    # Enable tab completion
    # Define the history file path
    history_file = os.path.join(os.path.expanduser("~"), ".python_history")

    # Read existing history if available
    try:
        readline.read_history_file(history_file)
    except FileNotFoundError:
        pass

    # Set the maximum number of lines in the history file
    readline.set_history_length(50)

    # Register a function to write the history on exit
    atexit.register(readline.write_history_file, history_file)

    # Enable tab completion
    readline.set_completer(completer.complete)
    readline.parse_and_bind("tab: complete")
    code.interact(local=local)
