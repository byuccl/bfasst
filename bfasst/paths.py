"""Import Environmant Variables as Pathlib.Path objects if they exist"""

import sys
from pathlib import Path
from typing import TYPE_CHECKING

from bfasst import config

# This is needed for pylint/pylance type checking to work. Ignored during real runtimes.
if TYPE_CHECKING:
    from .paths_stubs import *  # pylint: disable=wildcard-import,unused-wildcard-import


def __getattr__(name):
    """Return environment variables as Path(value) or None."""
    if name == "__all__":
        raise ImportError("Wildcard imports are not supported from bfasst.paths")
    if name[0:2] == "__" and name[-2:] == "__":
        # Do not pretend to have values for dunder members. (e.g., __test__ for doctest)
        raise AttributeError
    value = config.__getattr__(name)
    if value is not None:
        value = Path(value)
    setattr(sys.modules[__name__], name, value)
    return value
