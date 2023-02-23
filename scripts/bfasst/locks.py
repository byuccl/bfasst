""" Any multiprocessing locks used by tools can be located here"""

import multiprocessing


conformal_lock = multiprocessing.Manager().Lock()
onespin_lock = multiprocessing.Manager().Lock()
