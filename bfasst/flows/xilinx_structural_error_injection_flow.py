"""XilinxStructuralErrorInjection flow"""

from functools import partial
from os import unlink
import random

from bfasst.compare.structural import StructuralCompareTool
from bfasst.flows.flow import Flow
from bfasst.flows.xilinx_phys_netlist_xrev_flow import XilinxPhysNetlistXrevFlow
from bfasst.job import Job
from bfasst.transform.error_injector import ErrorInjector
from bfasst.transform.error_injector import ErrorType
from bfasst.types import ToolType


class XilinxStructuralErrorInjectionFlow(Flow):
    """XilinxStructuralErrorInjection flow"""

    def get_corrupt_netlist_path(self):
        return self.design.corrupted_netlist_path

    def generate_path_to_save_corrupted_netlist(self, num_problems, err):
        return self.design.path / f"{err}_error_{num_problems}.v"

    def create(self):
        """Inject errors into FASM2BELS netlist and compare with Conformal"""

        if "--max_dsp" not in self.flow_args[ToolType.SYNTH]:
            self.flow_args[ToolType.SYNTH] += " --max_dsp 0"

        # All other jobs depend on the last one returned from this sub flow
        self.job_list.extend(XilinxPhysNetlistXrevFlow(self.design, self.flow_args).create())

        # Get a reference to the dependency job that generates the netlist
        phys_netlist_rev_job = self.job_list[-1]

        # Seed the main flow's random number generator so that the same errors are injected
        random.seed(0)
        error_type = [ErrorType.BIT_FLIP, ErrorType.WIRE_SWAP]

        # For each error type
        random_seed_multiplier = 1
        for error in error_type:
            num_runs = 100

            for i in range(1, num_runs + 1):
                error_injector = ErrorInjector(
                    self.design.build_dir,
                    self.design,
                    log_num=i,
                    random_generator=random.Random(random_seed_multiplier * i),
                )

                # Create a job to inject the correct type of error
                error_function = error_injector.get_injection_function(error)
                curr_job = Job(error_function, self.design.rel_path, [phys_netlist_rev_job])
                self.job_list.append(curr_job)

                compare_tool = StructuralCompareTool(
                    cwd=self.design.build_dir,
                    design=self.design,
                    gold_netlist=self.design.phys_netlist_path,
                    rev_netlist=error_injector.corrupted_netlist_path,
                    flow_args=self.flow_args[ToolType.CMP],
                )

                comparison_job = Job(
                    compare_tool.compare_netlists, self.design.rel_path, set(self.job_list[-1].uuid)
                )

                # Rather than append to the job list,
                # we create a new job that inverts its exception handling.
                # If the comparison fails with an exception, we've caught the injected error.
                self.job_list.append(comparison_job.invert())

                # Clean up the corrupted netlist if the comparison passes
                curr_job = Job(
                    partial(unlink, error_injector.corrupted_netlist_path),
                    self.design.rel_path,
                    set(self.job_list[-1].uuid),
                )
                self.job_list.append(curr_job)

            random_seed_multiplier += 1

        return self.job_list
