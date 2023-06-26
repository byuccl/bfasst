"""Job class for a job function and dependency list"""


from bfasst.tool import BfasstException


class Job:
    """Class for a job function and dependency list"""

    def __init__(self, function, design_name, dependencies=None):
        self.function = function
        self.design_name = design_name
        self.dependencies = dependencies

    def invert(self):
        """This can be called in the case where we want to invert the job's exception handling"""
        return Job(self.inverter, self.design_name, self.dependencies)

    def inverter(self):
        try:
            self.function()
        except BfasstException:
            return

        raise BfasstException("Job succeeded but was expected to fail")
