"""Any multiprocessing locks used by tools can be located here"""

import multiprocessing

__conformal_lock = None


def conformal_lock():
    global __conformal_lock  # pylint: disable=global-statement
    if __conformal_lock is None:
        __conformal_lock = multiprocessing.Manager().Lock()
    return __conformal_lock
