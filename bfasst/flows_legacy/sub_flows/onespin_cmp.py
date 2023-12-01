"""Subflow for running onespin comparison"""

# pylint: disable=duplicate-code

from bfasst.compare.onespin import OneSpinCompareTool
from bfasst.flows_legacy.flow import Flow
from bfasst.job import Job
from bfasst.types import ToolType


class OnespinCmp(Flow):
    """Subflow for running onespin comparison"""

    def create(self):
        """Run Onespin compare"""
        # clear job list in case this is called multiple times
        self.job_list = []

        compare_tool = OneSpinCompareTool(
            self.design.build_dir,
            self.design,
            self.design.netlist_path,
            self.design.reversed_netlist_path,
            self.flow_args[ToolType.CMP],
        )
        curr_job = Job(
            compare_tool.compare_netlists,
            self.design.rel_path,
        )

        self.job_list.append(curr_job)

        return self.job_list
