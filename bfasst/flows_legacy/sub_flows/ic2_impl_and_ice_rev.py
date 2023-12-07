"""Subflow for running IC2 Implementation and then Icestrom Reversal"""

from bfasst.flows_legacy.flow import Flow
from bfasst.tools_legacy.impl.ic2 import Ic2ImplementationTool
from bfasst.job import Job
from bfasst.tools_legacy.reverse_bit.icestorm import IcestormReverseBitTool
from bfasst.types import ToolType


class Ic2ImplAndIceRev(Flow):
    """Subflow for running IC2 Implementation and then Icestrom Reversal"""

    def create(self):
        """
        Run IC2 Implementation and then Icestorm Reversal.  Not intended
        to be stand alone. There are always two jobs returned.
        """
        # clear job list in case this is called multiple times
        self.job_list = []

        curr_job = Job(
            Ic2ImplementationTool(
                self.design.build_dir, self.design, self.flow_args[ToolType.IMPL]
            ).implement_bitstream,
            self.design.rel_path,
        )
        self.job_list.append(curr_job)

        curr_job = Job(
            IcestormReverseBitTool(
                self.design.build_dir, self.design, self.flow_args[ToolType.REVERSE]
            ).reverse_bitstream,
            self.design.rel_path,
            {self.job_list[-1].uuid},
        )
        self.job_list.append(curr_job)

        return self.job_list
