"""ConformalOnly flow"""

from bfasst.compare.conformal import ConformalCompareTool
from bfasst.flows_legacy.flow import Flow
from bfasst.job import Job
from bfasst.types import ToolType, Vendor


class Conformal(Flow):
    """ConformalOnly flow"""

    def create(self):
        """Run Conformal in isolation"""
        # clear job list in case this is called multiple times
        self.job_list = []

        design = self.design
        assert design.netlist_path is not None
        assert design.reversed_netlist_path is not None

        design.golden_sources = [design.netlist_path]
        vendor = Vendor.XILINX  # TODO vendor should be flow arg
        compare_tool = ConformalCompareTool(
            design.build_dir,
            design,
            design.golden_sources,
            design.reversed_netlist_path,
            self.flow_args[ToolType.CMP],
            vendor,
        )

        curr_job = Job(compare_tool.compare_netlists, self.design.rel_path)
        self.job_list.append(curr_job)
        return self.job_list
