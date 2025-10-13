"""Handles starting the JPype JVM used for Rapidwright"""

import jpype
import jpype.imports

from bfasst.paths import THIRD_PARTY_PATH

_STARTED = False


def start():
    """Start the JVM"""

    global _STARTED  # pylint: disable=global-statement
    if _STARTED:
        return

    jpype.startJVM(
        classpath=[
            str(THIRD_PARTY_PATH / "RapidWright" / "bin"),
            *(str(s) for s in (THIRD_PARTY_PATH / "RapidWright" / "jars").glob("*.jar")),
        ]
    )

    _STARTED = True
