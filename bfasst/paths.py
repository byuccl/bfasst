"""Import Environmant Variables as Pathlib.Path objects if they exist"""

import sys
from pathlib import Path

from . import config


def __getattr__(name):
    """Return environment variables as Path(value) or None."""
    if name == "__all__":
        raise ImportError("Wildcard imports are not supported from bfasst.paths")
    value = config.__getattr__(name)
    if value is not None:
        value = Path(value)
    setattr(sys.modules[__name__], name, value)
    return value
