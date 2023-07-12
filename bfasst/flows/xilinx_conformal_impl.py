"""XilinxConformalImpl flow"""

# pylint: disable=duplicate-code

from bfasst.flows.sub_flows.conformal import Conformal
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_and_reversed import XilinxAndReversed
from bfasst.job import Job


class XilinxConformalImpl(Flow):
    """XilinxConformalImpl flow"""

    def create(self):
        """Vivado synthesis and implementation, reverse with xray, compare with conformal"""

        # Reset job list in case this flow is called multiple times
        self.job_list = []

        self.job_list.extend(XilinxAndReversed(self.design, self.flow_args).create())

        # Use conformal to compare against IMPL netlist
        curr_job = Job(self.adjust_design_object, self.design.rel_path, {self.job_list[-1].uuid})
        self.job_list.append(curr_job)

        # TODO Conformal_CompareTool.compare_netlists does not take a mapping arg

        # compare_tool = bfasst.compare.conformal.Conformal_CompareTool(
        #    Vendor.XILINX
        # )
        # with bfasst.conformal_lock:
        #    compare_tool.compare_netlists(
        #        self.design, args[FlowArgs.MAP_STAGE.value]
        #    )

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
        conformal_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(conformal_sub_flow.job_list)

        return self.job_list

    def adjust_design_object(self):
        self.design.golden_sources = [
            self.design.impl_netlist_path,
        ]
