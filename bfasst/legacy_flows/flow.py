"""
Base class for all flows.
"""

import abc
from importlib import import_module
from pathlib import Path

from bfasst.tool import BfasstException


class FlowException(BfasstException):
    pass


def get_flows():
    """Get all flows in the flows directory"""
    flows = [flow.stem for flow in Path(__file__).parent.glob("*.py") if flow.stem != "__init__"]
    return flows


def get_flow(flow_name):
    """Get a flow by name"""
    if flow_name not in get_flows():
        raise FlowException(f"Flow {flow_name} not found")
    flow_module = import_module(f"bfasst.legacy_flows.{flow_name}")
    flow_class = "".join([word.capitalize() for word in flow_name.split("_")])
    return getattr(flow_module, flow_class)


class Flow(abc.ABC):
    """Base class for all flows"""

    def __init__(self, design, flow_args):
        super().__init__()
        self.design = design
        self.flow_args = flow_args
        self.job_list = []

    @classmethod
    @abc.abstractclassmethod
    def create(self):
        """Create all the jobs necessary for the flow"""
        raise NotImplementedError

    def _get_first_job(self):
        if len(self.job_list) > 0:
            return self.job_list[0]
        return None

    def modify_first_job_dependencies(self, new_dependencies: list):
        """
        Allows the dependency list of the first job returned from a flow to be modified
        after the job has been created
        This is useful for adding dependencies to the first job returned from a subflow
        when the subflow jobs occur in the middle of the master flow
        """
        first_job = self._get_first_job()
        if first_job is None:
            raise BfasstException("There were no jobs in the subflow")

        if first_job.dependencies is not None:
            for dependency in new_dependencies:
                first_job.dependencies.append(dependency)
        else:
            first_job.dependencies = new_dependencies
