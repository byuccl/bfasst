"""XilinxStructuralErrorInjection flow"""

import random

from bfasst.compare.base import CompareException
from bfasst.compare.structural import StructuralCompareTool
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_phys_netlist_xrev_flow import XilinxPhysNetlistXrevFlow
from bfasst.transform.error_injector import ErrorInjector as SdnErrorInjector
from bfasst.transform.error_injector import ErrorType
from bfasst.types import ToolType


class XilinxStructuralErrorInjectionFlow(Flow):
    """XilinxStructuralErrorInjection flow"""

    def get_corrupt_netlist_path(self):
        return self.design.corrupted_netlist_path

    def generate_path_to_save_corrupted_netlist(self, num_problems, err):
        return self.design.path / f"{err}_error_{num_problems}.v"

    def _run(self):
        """Inject errors into FASM2BELS netlist and compare with Conformal"""

        if "--max_dsp" not in self.flow_args[ToolType.SYNTH]:
            self.flow_args[ToolType.SYNTH] += " --max_dsp 0"

        self.job_list.extend(XilinxPhysNetlistXrevFlow(self.design, self.flow_args).create())

        random.seed(0)
        injection_types = [ErrorType.BIT_FLIP, ErrorType.WIRE_SWAP]

        error_injector = SdnErrorInjector(cwd=self.design.build_dir, design=self.design)

        phys_netlist_rev_job = self.job_list[-1]

        for err in injection_types:
            num_problems = 0
            num_runs = 100
            for i in range(1, num_runs + 1):
                # Give the injector a number for logging the run, and run the injection
                error_injector.run_num = i
                error_injector.inject(err)

                # Reset the mappings in the compare tool, give it a number for logging the run,
                # and run the comparison
                compare_tool.reset_mappings()

                # The compare tool should only reset its logs once per flow,
                # not per error type, but should be unaware of what type of error is being injected
                compare_tool.run_num = i if err == injection_types[0] else i + num_runs

                try:
                    compare_tool.compare_netlists()
                    # An error was injected, but not detected
                    num_problems += 1
                    new_path = self.generate_path_to_save_corrupted_netlist(num_problems, err)
                    self.get_corrupt_netlist_path().rename(new_path)
                except CompareException:
                    # An error was injected and detected
                    pass

                # Remove the corrupt netlist so that it can be regenerated
                self.get_corrupt_netlist_path().unlink()

        if num_problems != 0:
            return "ErrorInjectionException: Some errors were not caught"
        return None
