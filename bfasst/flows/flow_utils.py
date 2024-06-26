"""Utility methods for getting flows"""

from bfasst.paths import NINJA_BUILD_PATH


def create_build_file():
    """Overwrite the build.ninja file when running generation and build steps separately"""
    with open(NINJA_BUILD_PATH, "w") as f:
        f.write("# This file is autogenerated by bfasst\n\n")
