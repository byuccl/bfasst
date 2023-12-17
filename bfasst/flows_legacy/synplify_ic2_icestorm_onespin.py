"""SynplifyIc2IcestormOnespin flow"""

# pylint: disable=duplicate-code

from bfasst.tools_legacy.compare.onespin import OneSpinCompareTool
from bfasst.flows_legacy.flow import Flow
from bfasst.flows_legacy.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRev
from bfasst.tools_legacy.job import Job
from bfasst.tools_legacy.synth.ic2_synplify import Ic2SynplifySynthesisTool
from bfasst.types import ToolType


class SynplifyIc2IcestormOnespin(Flow):
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

        impl_and_rev_sub_flow = Ic2ImplAndIceRev(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Set paths for onespin
        self.design.netlist_path = self.design.build_dir / (self.design.top + "_impl.v")
        if self.design.cur_error_flow_name is None:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_reversed.v"
            )
        else:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_" + self.design.cur_error_flow_name + "_reversed.v"
            )

        # Run onespin
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        cmp_tool = OneSpinCompareTool(
            self.design.build_dir,
            self.design,
            self.design.netlist_path,
            self.design.reversed_netlist_path,
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
