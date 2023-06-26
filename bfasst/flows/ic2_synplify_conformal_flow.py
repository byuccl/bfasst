"""Ic2SynplifyConformal flow"""

from bfasst.flows.flow import Flow
from bfasst.flows.sub_flows.conformal_only_flow import ConformalOnlyFlow
from bfasst.flows.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRevFlow
from bfasst.job import Job
from bfasst.synth.ic2_synplify import Ic2SynplifySynthesisTool
from bfasst.types import ToolType


class Ic2SynplifyConformalFlow(Flow):
    """Ic2SynplifyConformal flow"""

    def create(self):
        """
        Icecube2 Synplify synthesis and implementation, reverse with
        icestorm, compare with Conformal.
        """
        # Reset job list in case this flow is called multiple times
        self.job_list = []

        # Run Icecube2 Synplify synthesis
        synplify_synth_tool = Ic2SynplifySynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(synplify_synth_tool.create_netlist, self.design.rel_path)
        self.job_list.append(curr_job)

        # Run icecube implementation and icestorm bitstream reversal
        impl_and_rev_sub_flow = Ic2ImplAndIceRevFlow(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies([self.job_list[-1]])
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Run conformal
        curr_job = Job(self.adjust_design_object, self.design.rel_path, [self.job_list[-1]])
        self.job_list.append(curr_job)

        conformal_sub_flow = ConformalOnlyFlow(self.design, self.flow_args)
        conformal_sub_flow.create()
        conformal_sub_flow.modify_first_job_dependencies([self.job_list[-1]])
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list

    def adjust_design_object(self):
        self.design.compare_golden_files.append(self.design.top_file)
        self.design.compare_golden_files.extend(self.design.get_support_files())
        self.design.compare_golden_files_paths.append(self.design.path / self.design.top_file)
        self.design.compare_golden_files_paths.extend(
            [self.design.path / f for f in self.design.get_support_files()]
        )
        self.design.golden_is_verilog = self.design.top_is_verilog()
