"""YosysTechSynplifyOnespin flow"""

# pylint: disable=duplicate-code

from bfasst.flows_legacy.flow import Flow
from bfasst.flows_legacy.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRev
from bfasst.flows_legacy.sub_flows.onespin_cmp import OnespinCmp
from bfasst.job import Job
from bfasst.opt.ic2_synplify import Ic2SynplifyOptTool
from bfasst.synth.yosys import YosysTechSynthTool
from bfasst.types import ToolType


class YosysTechSynplifyOnespin(Flow):
    """YosysTechSynplifyOnespin flow"""

    def create(self):
        """
        Synthesize with yosys, optimize and implement with icecube2
        Synplify, reverse with icestorm, and compare with Onespin
        """

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        # Run the Yosys synthesizer
        yosys_synth_tool = YosysTechSynthTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(yosys_synth_tool.create_netlist, self.design.rel_path)
        self.job_list.append(curr_job)

        # Now run the Synplify synthesizer on the Yosys output
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        synplify_opt_tool = Ic2SynplifyOptTool(self.design.build_dir, self.design, self.flow_args)
        curr_job = Job(
            synplify_opt_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        impl_and_rev_sub_flow = Ic2ImplAndIceRev(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        curr_job = Job(
            self.change_compare_revised_file_path, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        onespin_cmp_sub_flow = OnespinCmp(self.design, self.flow_args)
        onespin_cmp_sub_flow.create()
        onespin_cmp_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(onespin_cmp_sub_flow.job_list)

        return self.job_list

    def adjust_design_object(self):
        yosys_netlist_path = self.design.netlist_path
        self.design.compare_golden_files.append(yosys_netlist_path.name)
        self.design.compare_golden_files_paths.append(yosys_netlist_path)
        self.design.golden_is_verilog = True

    def change_compare_revised_file_path(self):
        self.design.compare_revised_file = self.design.reversed_netlist_filename()
