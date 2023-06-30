"""Run various synth and implementation tools so that utilization reports are available"""

# pylint: disable=duplicate-code

import shutil

from bfasst.flows.flow import Flow
from bfasst.impl.ic2 import Ic2ImplementationTool
from bfasst.opt.ic2_lse import Ic2LseOptTool
from bfasst.opt.ic2_synplify import Ic2SynplifyOptTool
from bfasst.reverse_bit.icestorm import IcestormReverseBitTool
from bfasst.synth.ic2_lse import Ic2LseSynthesisTool
from bfasst.synth.ic2_synplify import Ic2SynplifySynthesisTool
from bfasst.synth.yosys import YosysTechSynthTool
from bfasst.types import ToolType
from bfasst.job import Job
from bfasst.flows.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRevFlow


class GatherImplDataFlow(Flow):
    """GatherImplData flow"""

    def create(self):
        """
        This flow is mainly to try running the tools with different
        synthesis/ implementation (e.g. synplify vs yosys, etc.) options to
        compare their physical results (e.g. LUT counts, FF counts, etc)
        """

        # Set the results file path so it can be used in the different tools
        self.design.results_summary_path = self.design.build_dir / "results_summary.txt"

        # Start with an RTL->Synplify->IC2->Icestorm flow
        synplify_synth_tool = Ic2SynplifySynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(synplify_synth_tool.create_netlist, self.design.rel_path)
        self.job_list.append(curr_job)

        # Create a job for icecube2 implementation and bitstream reversal
        impl_and_rev_sub_flow = Ic2ImplAndIceRevFlow(self.design, self.flow_args)
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Create a job to clean up project directories so we get fresh results later
        curr_job = Job(self.clean_up_synplify, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # Now create a new RTL->LSE->IC2->Icestorm job
        lse_synth_tool = Ic2LseSynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(
            lse_synth_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        # Run Icecube2 implementations and icestorm bitstream reversal
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Clean up project directories so we get fresh results later
        lse_clean_job = Job(self.clean_up_lse, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(lse_clean_job)

        # Now do Yosys->Synplify->IC2->Icestorm
        # Run the Yosys synthesizer
        yosys_synth_tool = YosysTechSynthTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        curr_job = Job(
            yosys_synth_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        # Now run the Synplify synthesizer on the Yosys output
        synplify_opt_tool = Ic2SynplifyOptTool(self.design.build_dir, self.design, self.flow_args)
        curr_job = Job(
            synplify_opt_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        # Run IC2 Implementation and Icestorm bitstream reversal
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        # Clean up project directories so we get fresh results later
        curr_job = Job(self.clean_up_yosys, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # Now do Yosys->LSE->IC2->Icestorm
        # Run the Yosys synthesizer
        curr_job = Job(
            yosys_synth_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        # Now run the LSE synthesizer on the Yosys output
        lse_opt_tool = Ic2LseOptTool(self.design.build_dir, self.design, self.flow_args)
        curr_job = Job(lse_opt_tool.create_netlist, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # Run IC2 Implementation and Icestorm bitstream reversal
        impl_and_rev_sub_flow.create()
        impl_and_rev_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(impl_and_rev_sub_flow.job_list)

        return self.job_list

    def clean_up_synplify(self):
        if (self.design.build_dir / Ic2SynplifyOptTool.TOOL_WORK_DIR).exists():
            shutil.rmtree(self.design.build_dir / Ic2SynplifyOptTool.TOOL_WORK_DIR)
        shutil.rmtree(self.design.build_dir / Ic2SynplifySynthesisTool.TOOL_WORK_DIR)
        self.clean_up_build_and_rev()

    def clean_up_lse(self):
        if (self.design.build_dir / Ic2LseOptTool.TOOL_WORK_DIR).exists():
            shutil.rmtree(self.design.build_dir / Ic2LseOptTool.TOOL_WORK_DIR)
        shutil.rmtree(self.design.build_dir / Ic2LseSynthesisTool.TOOL_WORK_DIR)
        self.clean_up_build_and_rev()

    def clean_up_yosys(self):
        shutil.rmtree(self.design.build_dir / YosysTechSynthTool.TOOL_WORK_DIR)

        # TODO check that this line should be added.
        shutil.rmtree(self.design.build_dir / Ic2SynplifyOptTool.TOOL_WORK_DIR)

        self.clean_up_build_and_rev()

    def clean_up_build_and_rev(self):
        shutil.rmtree(self.design.build_dir / Ic2ImplementationTool.TOOL_WORK_DIR)
        shutil.rmtree(self.design.build_dir / IcestormReverseBitTool.TOOL_WORK_DIR)
