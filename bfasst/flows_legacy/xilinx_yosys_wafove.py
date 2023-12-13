"""Wafove flow"""

# pylint: disable=duplicate-code

from bfasst.tools_legacy.compare.waveform import WaveformCompareTool
from bfasst.flows_legacy.flow import Flow
from bfasst.flows_legacy.xilinx import Xilinx
from bfasst.tools_legacy.job import Job
from bfasst.tools_legacy.reverse_bit.xray import XRayReverseBitTool
from bfasst.types import ToolType


class XilinxYosysWafove(Flow):
    """Wafove flow"""

    def create(self):
        """
        Vivado synthesis and implementation, reverse with xray,
        compare with WaFoVe.
        """
        # Reset job list in case this flow is called multiple times
        self.job_list = []

        self.job_list.extend(Xilinx(self.design, self.flow_args).create())

        # Run X-ray and fasm2bel
        xray_rev_bit_tool = XRayReverseBitTool(
            self.design.build_dir, self.design, self.flow_args[ToolType.REVERSE]
        )
        curr_job = Job(
            xray_rev_bit_tool.reverse_bitstream, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        # Input number of tests to run, seed to base random on, whether or not to show all signals
        # Whether or not to open gtkwave and analyze graphs, and whether or not to open Vivado and
        # analyze graphs.

        # Set the paths for the comparison tool
        self.design.impl_netlist_path = self.design.build_dir / (self.design.top + "_impl.v")
        self.design.reversed_netlist_path = self.design.build_dir / (
            self.design.top + "_reversed.v"
        )

        waveform_cmp_tool = WaveformCompareTool(
            self.design.build_dir,
            self.design,
            self.design.impl_netlist_path,
            self.design.reversed_netlist_path,
            self.flow_args[ToolType.CMP],
        )
        curr_job = Job(
            waveform_cmp_tool.compare_netlists, self.design.rel_path, {self.job_list[-1].uuid}
        )
        self.job_list.append(curr_job)

        return self.job_list
