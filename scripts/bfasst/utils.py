import sys, os, shutil

import bfasst


class TermColor:
    """ Terminal codes for printing in color """

    # pylint: disable=too-few-public-methods

    PURPLE = "\033[95m"
    BLUE = "\033[94m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    END = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


def print_color(color, *msg):
    print(color + " ".join(str(item) for item in msg), TermColor.END)


def error(*msg, returncode=-1):
    """ Print an error message and exit program """

    print_color(TermColor.RED, "ERROR:", " ".join(str(item) for item in msg))
    assert False
    sys.exit(returncode)


def create_build_dir(dir):
    new_dir = os.path.join(dir, bfasst.config.BUILD_DIR)
    if not os.path.isdir(new_dir):
        os.mkdir(new_dir)
    return new_dir


def create_build_design_dir(build_dir, design_dir):
    design_build_dir = os.path.join(build_dir, design_dir)
    if not os.path.isdir(design_build_dir):
        os.makedirs(design_build_dir)
    return design_build_dir


def get_design_dir(design_name):
    return os.path.join(bfasst.paths.EXAMPLES_PATH, design_name)


def clean_folder(folder_path):
    for file_object in os.listdir(folder_path):
        file_object_path = os.path.join(folder_path, file_object)
        if os.path.isfile(file_object_path):
            os.unlink(file_object_path)
        else:
            shutil.rmtree(file_object_path)


def print_tcl_cmd_catch(fp, cmd, return_code=1):
    fp.write("if { [catch { " + cmd + " } ] } { exit " + str(return_code) + " }\n")
