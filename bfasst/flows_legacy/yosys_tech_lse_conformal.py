"""YosysTechLseConformal flow"""

# pylint: disable=duplicate-code

from bfasst.flows_legacy.sub_flows.conformal import Conformal
from bfasst.flows_legacy.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRev
from bfasst.flows_legacy.flow import Flow
from bfasst.impl.ic2 import Ic2ImplementationTool
from bfasst.job import Job
from bfasst.opt.ic2_lse import Ic2LseOptTool
from bfasst.reverse_bit.icestorm import IcestormReverseBitTool
from bfasst.synth.yosys import YosysTechSynthTool
from bfasst.types import ToolType


class YosysTechLseConformal(Flow):
    """YosysTechLseConformal flow"""

    def create(self):
        """
        Synthesize with yosys, optimize and implement with icecube2
        LSE, reverse with icestorm, and compare with conformal
        """

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        # Run the Yosys synthesizer
        yosys_synth_tool = YosysTechSynthTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(yosys_synth_tool.create_netlist, self.design.rel_path)
        self.job_list.append(curr_job)

        # Now run the LSE synthesizer on the Yosys output
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        lse_opt_tool = Ic2LseOptTool(self.design.build_dir, self.design, self.flow_args)
        curr_job = Job(lse_opt_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # Try fixing the netlist LUT inits (there's some issue with how LSE
        # generates them)
        curr_job = Job(lse_opt_tool.fix_lut_inits, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        Ic2ImplementationTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.IMPL]
        ).implement_bitstream()
        IcestormReverseBitTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.REVERSE]
        ).reverse_bitstream()

        impl_and_rev_sub_flow = Ic2ImplAndIceRev(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies(self.job_list[-1])
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Set paths for conformal
        self.design.netlist_path = self.design.build_dir / (self.design.top + "_impl.v")
        if self.design.cur_error_flow_name is None:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_reversed.v"
            )
        else:
            self.design.reversed_netlist_path = self.design.build_dir / (
                self.design.top + "_" + self.design.cur_error_flow_name + "_reversed.v"
            )

        conformal_sub_flow = Conformal(self.design, self.flow_args)
        conformal_sub_flow.create()
        conformal_sub_flow.modify_first_job_dependencies(self.job_list[-1])
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list

    def adjust_design_object(self):
        yosys_netlist_path = self.design.netlist_path
        self.design.compare_golden_files.append(yosys_netlist_path.name)
        self.design.compare_golden_files_paths.append(yosys_netlist_path)
        self.design.golden_is_verilog = True
