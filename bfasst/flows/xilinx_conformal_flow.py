"""XilinxConformal flow"""

from bfasst.flows.sub_flows.conformal_only_flow import ConformalOnlyFlow
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_and_reversed_flow import XilinxAndReversedFlow


class XilinxConformalFlow(Flow):
    """XilinxConformal flow"""

    def create(self):
        """
        Run Xilinx synthesis and implementation and compare with
        conformal.
        """

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        xilinx_rev_sub_flow = XilinxAndReversedFlow(self.design, self.flow_args)
        self.job_list.extend(xilinx_rev_sub_flow.create())

        conformal_sub_flow = ConformalOnlyFlow(self.design, self.flow_args)
        conformal_sub_flow.create()
        conformal_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list
