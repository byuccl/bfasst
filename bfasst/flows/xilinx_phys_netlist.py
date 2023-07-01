"""XilinxPhysNetlist flow"""

from bfasst.flows.flow import Flow
from bfasst.flows.xilinx import Xilinx
from bfasst.job import Job
from bfasst.transform.xilinx_phys_netlist import XilinxPhysNetlist as XilinxPhysNetlistTool
from bfasst.types import ToolType


class XilinxPhysNetlist(Flow):
    """XilinxPhysNetlist flow"""

    def create(self):
        """Create a Xilinx physical netlist"""

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        if "--flatten" not in self.flow_args[ToolType.SYNTH]:
            self.flow_args[ToolType.SYNTH] += " --flatten"

        self.job_list.extend(Xilinx(self.design, self.flow_args).create())

        curr_job = Job(
            XilinxPhysNetlistTool(self.design.build_dir, self.design).run,
            self.design.rel_path,
            {self.job_list[-1].uuid},
        )
        self.job_list.append(curr_job)

        return self.job_list
