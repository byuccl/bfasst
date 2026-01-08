"""Import environment-specified configuration settings on demand."""

import os
import sys


def __getattr__(name):
    """Pull module attribues from environment variables."""
    if name == "__all__":
        raise ImportError("Wildcard imports are not supported from bfasst.config")
    value = os.environ.get(name, None)
    setattr(sys.modules[__name__], name, value)
    return value
