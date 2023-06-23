"""Job class for a job function and dependency list"""


class Job:
    """Class for a job function and dependency list"""

    def __init__(self, function, dependencies=None):
        self.function = function
        self.dependencies = dependencies
