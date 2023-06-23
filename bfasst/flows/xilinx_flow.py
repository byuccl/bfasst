"""Xilinx flow"""

from bfasst.flows.flow import Flow
from bfasst.impl.vivado import VivadoImplementationTool
from bfasst.synth.vivado import VivadoSynthesisTool
from bfasst.types import ToolType
from bfasst.job import Job


class XilinxFlow(Flow):
    """Xilinx flow"""

    def create(self):
        """Run Xilinx synthesis and implementation"""

        # Create a job for Vivado synthesis
        vivado_synth_tool = VivadoSynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(vivado_synth_tool.create_netlist)
        self.job_list.append(curr_job)

        # Create a job for Vivado implementation
        vivado_impl_tool = VivadoImplementationTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.IMPL]
        )
        curr_job = Job(vivado_impl_tool.implement_bitstream, [self.job_list[-1]])
        self.job_list.append(curr_job)

        return self.job_list
