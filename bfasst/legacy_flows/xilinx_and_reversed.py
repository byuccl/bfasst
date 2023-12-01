"""XilinxAndReversed flow"""

# pylint: disable=duplicate-code

from bfasst.legacy_flows.flow import Flow
from bfasst.legacy_flows.xilinx import Xilinx
from bfasst.job import Job
from bfasst.reverse_bit.xray import XRayReverseBitTool
from bfasst.types import ToolType


class XilinxAndReversed(Flow):
    """XilinxAndReversed flow"""

    def create(self):
        """Run Xilinx bitstream, then fasm2bels reverse"""
        # Reset job list in case this flow is called multiple times
        self.job_list = []

        if "--max_dsp" not in self.flow_args[ToolType.SYNTH]:
            self.flow_args[ToolType.SYNTH] += " --max_dsp 0"

        self.job_list.extend(Xilinx(self.design, self.flow_args).create())

        xray_rev_tool = XRayReverseBitTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.REVERSE]
        )
        curr_job = Job(
            xray_rev_tool.reverse_bitstream, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        return self.job_list
