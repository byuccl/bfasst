""" Trigger download of rapidwright data files"""

from bfasst import jpype_jvm

jpype_jvm.start()

# pylint: disable=wrong-import-position,wrong-import-order
from com.xilinx.rapidwright.util import FileTools

# pylint: enable=wrong-import-position,wrong-import-order

print("-" * 80)
print("Running rapidwright `Design.readCheckpoint` to trigger download of the")
print("7-series data files.")
print("-" * 80)

# Load a rapidwright design
FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")
