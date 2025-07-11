"""Inject an error into a xrev netlist and run a structural compare to detect it."""

import random

from bfasst.flows.flow import Flow
from bfasst.flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.paths import FLOWS_PATH
from bfasst.tools.compare.structural.structural import Structural
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.transform.error_injector import ErrorInjector
from bfasst.tools.transform.phys_netlist import PhysNetlist
from bfasst.utils.transform.error_injector import ErrorType


class VivadoStructuralErrorInjection(Flow):
    """Inject an error into a xrev netlist and run a structural compare to detect it."""

    def __init__(self, design, *, num_runs=100, seed=None, synth_options="", logging_level="INFO"):
        # pylint: disable=duplicate-code
        super().__init__(design)
        self.design = design
        self.num_runs = num_runs
        self.seed = seed
        self.logging_level = logging_level
        if self.seed is not None:
            random.seed(self.seed)

        self.synth_options = VivadoPhysNetlist.add_required_synth_options(synth_options)

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=self.synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.phys_netlist_tool = PhysNetlist(
            self,
            design,
            synth_checkpoint=self.vivado_synth_tool.outputs["synth_dcp"],
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            impl_checkpoint=self.vivado_impl_tool.outputs["impl_dcp"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
            logging_level=self.logging_level,
        )
        self.xrev_tool = Xray(
            self,
            design,
            xdc_input=self.vivado_synth_tool.outputs["synth_constraints"],
            bitstream=self.vivado_impl_tool.outputs["bitstream"],
        )
        self.default_comparison_tool = Structural(self, design)
        self.default_injection_tool = ErrorInjector(self, design, logging_level=logging_level)
        # pylint: enable=duplicate-code

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets()
        self.xrev_tool.create_build_snippets()

        random_seed_multiplier = 1
        for error in ErrorType:
            for i in range(1, self.num_runs + 1):

                error_injector_tool = ErrorInjector(
                    self,
                    self.design,
                    error_type=error,
                    num=i,
                    multiplier=random_seed_multiplier,
                    reversed_netlist=self.xrev_tool.outputs["rev_netlist"],
                    logging_level=self.logging_level,
                )
                error_injector_tool.create_build_snippets()

                Structural(
                    self,
                    self.design,
                    log_name=f"{error.name.lower()}_{i}_cmp.log",
                    golden_netlist=error_injector_tool.outputs["corrupt_netlist"],
                    rev_netlist=self.xrev_tool.outputs["rev_netlist"],
                    expect_fail=True,
                    logging_level=self.logging_level,
                ).create_build_snippets()

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "vivado_structural_error_injection.py"

    def post_execute(self):
        """Remove all error injection and comparison artifacts for errors successfully detected
        by the compare tool"""

        cmp_dir = self.default_comparison_tool.build_path
        error_dir = self.default_injection_tool.build_path

        for error in ErrorType:
            for i in range(1, self.num_runs + 1):
                # remove the error injection artifact, the corrupt netlist, and the compare log if
                # the compare tool says the two netlists are different
                basename = f"{error.name.lower()}_{i}"
                cmp_log = cmp_dir / f"{basename}_cmp.log"
                with open(cmp_log, "r") as f:
                    if "SUCCESS: Structural comparison found mismatch as expected" in f.read():
                        err_log = error_dir / f"{basename}.log"
                        err_netlist = err_log.with_suffix(".v")
                        cmp_log.unlink()
                        err_log.unlink()
                        err_netlist.unlink()
                    else:
                        raise CompareFalsePositiveError(f"Error injection failed on {basename}")


class CompareFalsePositiveError(RuntimeError):
    """Raised when a compare tool incorrectly compares two netlist as equivalent."""
