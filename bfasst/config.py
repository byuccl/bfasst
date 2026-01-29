"""Import environment-specified configuration settings on demand."""

import os
import sys
from typing import TYPE_CHECKING

# This is needed for pylint/pylance type checking to work. Ignored during real runtimes.
if TYPE_CHECKING:
    from .config_stubs import *  # pylint: disable=wildcard-import,unused-wildcard-import


def __getattr__(name):
    """Pull module attributes from environment variables."""
    if name == "__all__":
        raise ImportError("Wildcard imports are not supported from bfasst.config")
    value = os.environ.get(name, None)
    setattr(sys.modules[__name__], name, value)
    return value
