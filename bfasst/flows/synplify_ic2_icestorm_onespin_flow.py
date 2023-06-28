"""SynplifyIc2IcestormOnespin flow"""

from bfasst.compare.onespin import OneSpinCompareTool
from bfasst.flows.flow import Flow
from bfasst.flows.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRevFlow
from bfasst.job import Job
from bfasst.synth.ic2_synplify import Ic2SynplifySynthesisTool
from bfasst.types import ToolType


class SynplifyIc2IcestormOnespinFlow(Flow):
    """SynplifyIc2IcestormOnespin flow"""

    def create(self):
        """
        Icecube2 Synplify synthesis and implementation, reverse with
        icestorm, compare with onespin.
        """
        # Reset job list in case this flow is called multiple times
        self.job_list = []

        synplify_synth_tool = Ic2SynplifySynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(synplify_synth_tool.create_netlist, self.design.rel_path)
        self.job_list.append(curr_job)

        impl_and_rev_sub_flow = Ic2ImplAndIceRevFlow(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Run onespin
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        cmp_tool = OneSpinCompareTool(
            self.design.build_dir,
            self.design,
            self.design.compare_golden_files,
            self.design.reversed_netlist_filename(),
            self.flow_args[ToolType.CMP],
        )
        curr_job = Job(cmp_tool.compare_netlists, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        return self.job_list

    def adjust_design_object(self):
        self.design.compare_golden_files.append(self.design.top_file)
        self.design.compare_golden_files.extend(self.design.get_support_files())
        self.design.compare_golden_files_paths.append(self.design.path / self.design.top_file)
        self.design.compare_golden_files_paths.extend(
            [self.design.path / f for f in self.design.get_support_files()]
        )
        self.design.golden_is_verilog = self.design.top_is_verilog()
