""" Utility functions"""
import sys
import shutil

import bfasst


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


def print_color_no_newl(color, *msg):
    """Print color without newline"""
    sys.stdout.write(color + " ".join(str(item) for item in msg), TermColor.END)


def print_color(color, *msg):
    """Print mesage in color"""
    print(color + " ".join(str(item) for item in msg), TermColor.END)


def error(*msg, returncode=-1):
    """Print an error message and exit program"""

    print_color(TermColor.RED, "ERROR:", " ".join(str(item) for item in msg))
    assert False
    sys.exit(returncode)


def create_build_dir(path):
    """Create a build directory if it doesn't exist"""
    new_dir = path / bfasst.config.BUILD_DIR
    new_dir.mkdir(exist_ok=True)
    return new_dir


def create_build_design_dir(build_dir, design_dir):
    """Create design/build directory"""
    design_build_dir = build_dir / design_dir
    design_build_dir.mkdir(exist_ok=True)
    return design_build_dir


def get_design_dir(design_name):
    """Return the design directory"""
    return bfasst.paths.EXAMPLES_PATH / design_name


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
