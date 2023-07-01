"""XilinxOoc flow"""


from bfasst.config import VIVADO_BIN_PATH
from bfasst.flows.flow import Flow
from bfasst.impl.vivado import VivadoImplementationTool
from bfasst.job import Job
from bfasst.synth.vivado import VivadoSynthesisTool
from bfasst.types import ToolType


class XilinxOoc(Flow):
    """XilinxOoc flow"""

    def create(self):
        """Run Xilinx synthesis and implementation for ooc self.designs"""

        # Reset job list in case of previous runs
        self.job_list = []

        synth_tool = VivadoSynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        impl_tool = VivadoImplementationTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.IMPL]
        )

        if synth_tool.up_to_date() and impl_tool.up_to_date(impl_tool.check_impl_status, __file__):
            synth_tool.print_skipping_synth()
            impl_tool.print_skipping_impl()
            return self.job_list

        curr_job = Job(self.run_ooc_job, self.design.rel_path)
        self.job_list.append(curr_job)

        return self.job_list

    def run_ooc_job(self):
        """Runs an ooc job for a single design"""
        synth_tool = VivadoSynthesisTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.SYNTH]
        )
        impl_tool = VivadoImplementationTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.IMPL]
        )

        # Setup tools for ooc
        synth_tool.launch()
        impl_tool.launch()

        synth_tool.args.out_of_context = True
        impl_tool.args.out_of_context = True

        synth_tool.print_running_synth()
        impl_tool.print_running_impl()
        tcl_path = synth_tool.cwd / "run.tcl"
        report_io_path = synth_tool.work_dir / "report_io.txt"
        with open(tcl_path, "w") as fp:
            synth_tool.write_header(fp)
            synth_tool.write_hdl(fp)
            synth_tool.write_synth(fp)
            synth_tool.write_products(report_io_path, fp)
            # need to add constraints logic, but this is determined post-synthesis
            impl_tool.write_impl(fp)
            impl_tool.write_outputs(fp)
            synth_tool.write_footer(fp)

        cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
        synth_tool.exec_and_log(cmd)

        synth_tool.cleanup()
        impl_tool.cleanup()
