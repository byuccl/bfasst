"""
Functions to run vivado synthesis and implementation
"""

from pathlib import Path

from .config import VIVADO_BIN_PATH
from .impl.vivado import VivadoImplementationTool
from .status import BfasstException
from .synth.vivado import VivadoSynthesisTool
from .tool import ToolProduct


class VivadoSynthImpTool:
    """Run Vivado Synthesis and Implementation"""

    def __init__(self, cwd, flow_args=""):
        self.synth_tool = VivadoSynthesisTool(cwd, flow_args)
        self.impl_tool = VivadoImplementationTool(cwd, flow_args)

    def run(self, design):
        """Run synthesis and implementation"""

        synth_status = self.synth_tool.check_runs(design)

        if synth_status is not None:
            self.synth_tool.print_skipping_synth()
            impl_status = self.impl_tool.get_prev_run_status(
                tool_products=[
                    ToolProduct(
                        design.bitstream_path,
                        self.impl_tool.log_path,
                        self.impl_tool.check_impl_status,
                    )
                ],
                dependency_modified_time=max(
                    Path(__file__).stat().st_mtime, design.netlist_path.stat().st_mtime
                ),
            )
            if impl_status is not None:
                self.impl_tool.print_skipping_impl()
                return impl_status

            self.impl_tool.print_running_impl()
            self.impl_tool.open_new_log()
            self.impl_tool.run_implementation(design)
            return self.impl_tool.check_impl_status(self.impl_tool.log_path)

        self.synth_tool.print_running_synth()

        tcl_path = self.synth_tool.cwd / "run.tcl"
        report_io_path = self.synth_tool.work_dir / "report_io.txt"
        with open(tcl_path, "w") as fp:
            self.synth_tool.write_header(fp)
            self.synth_tool.write_hdl(design, fp)
            self.synth_tool.write_synth(design, fp)
            self.synth_tool.write_products(design, report_io_path, fp)
            self.impl_tool.write_impl(fp)
            self.synth_tool.write_footer(fp)

        cmd = [str(VIVADO_BIN_PATH), "-mode", "tcl", "-source", str(tcl_path)]
        proc = self.synth_tool.exec_and_log(cmd)
        if proc.returncode:
            raise BfasstException(0, "Vivado synth/impl flow failed")

        return self.impl_tool.success_status
