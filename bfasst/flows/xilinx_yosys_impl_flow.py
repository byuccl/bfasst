"""XilinxYosysImpl flow"""

from bfasst.compare.yosys import YosysCompareTool
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_and_reversed_flow import XilinxAndReversedFlow
from bfasst.job import Job
from bfasst.types import ToolType


class XilinxYosysImplFlow(Flow):
    """XilinxYosysImpl flow"""

    def _run(self):
        """Vivado synthesis and implementation, reverse with xray, compare with yosys"""

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        self.job_list.extend(XilinxAndReversedFlow(self.design, self.flow_args).create())

        yosys_cmp_tool = YosysCompareTool(
            self.design.build_dir,
            self.design,
            self.design.impl_netlist_path,
            self.design.reversed_netlist_path,
            self.flow_args[ToolType.CMP],
        )
        curr_job = Job(yosys_cmp_tool.compare_netlists, [self.job_list[-1]])
        self.job_list.append(curr_job)

        return self.job_list
