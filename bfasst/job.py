"""Job class for a job function and dependency list"""


from bfasst.tool import BfasstException


class Job:
    """Class for a job function and dependency list"""

    def __init__(self, function, dependencies=None):
        self.function = function
        self.dependencies = dependencies

    def invert_job(self):
        """This can be called in the case where we want to invert the job's exception handling"""
        self.invert_job_helper()

    def invert_job_helper(self):
        """Helper function for invert_job"""
        try:
            self.function()
        except BfasstException:
            return

        raise BfasstException("Job succeeded but was expected to fail")
