"""Handles starting the JPype JVM used for Rapidwright"""

import jpype

if not jpype.isJVMStarted():
    jpype.startJVM()
