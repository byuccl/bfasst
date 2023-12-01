"""Subflow for running IC2 Implementation, Icestrom bit reversal, and Onespin compare"""

from bfasst.flows_legacy.flow import Flow
from bfasst.flows_legacy.sub_flows.ic2_impl_and_ice_rev import Ic2ImplAndIceRev
from bfasst.flows_legacy.sub_flows.onespin_cmp import OnespinCmp


class Ic2ImplIceRevOneCmp(Flow):
    """Subflow for running IC2 Implementation, Icestrom bit reversal, and Onespin compare"""

    def create(self):
        """Run IC2 Implementation, Icestrom bit reversal, and Onespin compare"""
        # clear job list in case this is called multiple times
        self.job_list = []

        self.job_list = Ic2ImplAndIceRev(self.design, self.flow_args).create()

        onespin_sub_flow = OnespinCmp(self.design, self.flow_args)
        onespin_sub_flow.create()
        onespin_sub_flow.modify_first_job_dependencies({self.job_list[-1].uuid})
        self.job_list.extend(onespin_sub_flow.job_list)

        return self.job_list
