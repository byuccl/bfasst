"""XilinxPhysNetlistCmp flow"""

from bfasst.compare.structural import StructuralCompareTool
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_phys_netlist_xrev_flow import XilinxPhysNetlistXrevFlow
from bfasst.job import Job
from bfasst.types import ToolType


class XilinxPhysNetlistCmpFlow(Flow):
    """XilinxPhysNetlistCmp flow"""

    def create(self):
        """Compare Xilinx physical netlist to FASM2BELs netlist"""

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        if "--max_dsp" not in self.flow_args[ToolType.SYNTH]:
            self.flow_args[ToolType.SYNTH] += " --max_dsp 0"

        self.job_list.extend(XilinxPhysNetlistXrevFlow(self.design, self.flow_args).create())

        structural_compare_tool = StructuralCompareTool(
            self.design.build_dir,
            self.design,
            self.design.phys_netlist_path,
            self.design.reversed_netlist_path,
            self.flow_args[ToolType.CMP],
        )
        curr_job = Job(
            structural_compare_tool.compare_netlists, self.design.rel_path, [self.job_list[-1]]
        )
        self.job_list.append(curr_job)

        return self.job_list
