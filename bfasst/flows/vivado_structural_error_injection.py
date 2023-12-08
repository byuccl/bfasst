"""Inject an error into a xrev netlist and run a structural compare to detect it."""
import random

from bfasst.flows.flow import Flow
from bfasst.flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.structural.structural import Structural
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.transform.error_injector import ErrorInjector
from bfasst.tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth

from bfasst.utils.error_injector import ErrorType


class VivadoStructuralErrorInjection(Flow):
    """Inject an error into a xrev netlist and run a structural compare to detect it."""

    def __init__(self, design, num_runs=100, seed=None, synth_options=""):
        super().__init__(design)
        self.num_runs = num_runs
        self.seed = seed
        if self.seed is not None:
            random.seed(self.seed)

        self.synth_options = VivadoPhysNetlist.add_required_synth_options(synth_options)

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=self.synth_options)
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.phys_netlist_tool = PhysNetlist(self, design)
        self.xrev_tool = Xray(self, design)
        self.error_injector_tool = ErrorInjector(self, design)
        self.compare_tool = Structural(self, design, expect_fail=True)

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        self.xrev_tool.create_build_snippets(self.vivado_impl_tool.outputs["bitstream"])

        random_seed_multiplier = 1
        for error in ErrorType:
            for i in range(1, self.num_runs + 1):
                self.error_injector_tool.create_build_snippets(
                    error_type=error,
                    num=i,
                    multiplier=random_seed_multiplier,
                    reversed_netlist=self.xrev_tool.outputs["xray_netlist"],
                )
                corrupt_netlist_path = (
                    self.error_injector_tool.build_path / f"{error.name.lower()}_{i}.v"
                )
                self.compare_tool.create_build_snippets(
                    self.phys_netlist_tool.phys_netlist_path,
                    corrupt_netlist_path,
                    f"{error.name.lower()}_{i}_cmp.log",
                )

    def get_top_level_flow_path(self) -> str:
        return FLOWS_PATH / "vivado_structural_error_injection.py"

    def post_execute(self):
        """Remove all error injection and comparison artifacts for errors successfully detected
        by the compare tool"""

        cmp_dir = self.compare_tool.build_path
        error_dir = self.error_injector_tool.build_path

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
