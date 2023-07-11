"""XilinxConformal flow"""

# pylint: disable=duplicate-code

from bfasst.flows.sub_flows.conformal import Conformal
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_and_reversed import XilinxAndReversed


class XilinxConformal(Flow):
    """XilinxConformal flow"""

    def create(self):
        """
        Run Xilinx synthesis and implementation and compare with
        conformal.
        """

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        xilinx_rev_sub_flow = XilinxAndReversed(self.design, self.flow_args)
        self.job_list.extend(xilinx_rev_sub_flow.create())

        # Set paths for conformal
        self.design.netlist_path = self.design.path / (self.design.top + ".v")
        if self.design.cur_error_flow_name is None:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_reversed.v"
                )
        else:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_" + self.design.cur_error_flow_name + "_reversed.v"
            )

        conformal_sub_flow = Conformal(self.design, self.flow_args)
        conformal_sub_flow.create()
        conformal_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list
