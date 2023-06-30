"""XilinxConformalImpl flow"""

# pylint: disable=duplicate-code

from bfasst.flows.sub_flows.conformal_only_flow import ConformalOnlyFlow
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_and_reversed_flow import XilinxAndReversedFlow
from bfasst.job import Job


class XilinxConformalImplFlow(Flow):
    """XilinxConformalImpl flow"""

    def _run(self):
        """Vivado synthesis and implementation, reverse with xray, compare with conformal"""

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        self.job_list.extend(XilinxAndReversedFlow(self.design, self.flow_args).create())

        # Use conformal to compare against IMPL netlist
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # TODO Conformal_CompareTool.compare_netlists does not take a mapping arg

        # compare_tool = bfasst.compare.conformal.Conformal_CompareTool(
        #    Vendor.XILINX
        # )
        # with bfasst.conformal_lock:
        #    compare_tool.compare_netlists(
        #        self.design, args[FlowArgs.MAP_STAGE.value]
        #    )
        conformal_sub_flow = ConformalOnlyFlow(self.design, self.flow_args)
        conformal_sub_flow.create()
        conformal_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list

    def adjust_design_object(self):
        self.design.golden_sources = [
            self.design.impl_netlist_path,
        ]
