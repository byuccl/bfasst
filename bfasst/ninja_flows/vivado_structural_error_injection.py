# pylint: disable=duplicate-code
"""Inject an error into a xrev netlist and run a structural compare to detect it."""
import random

from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_tools.impl.vivado_impl import VivadoImpl
from bfasst.ninja_tools.compare.structural.structural import Structural
from bfasst.ninja_tools.rev_bit.xray import Xray
from bfasst.ninja_tools.transform.error_injector import ErrorInjector
from bfasst.ninja_tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import NINJA_FLOWS_PATH
from bfasst.ninja_tools.synth.vivado_synth import VivadoSynth

from bfasst.ninja_utils.error_injector import ErrorType


class VivadoStructuralErrorInjection(Flow):
    """Inject an error into a xrev netlist and run a structural compare to detect it."""

    def __init__(self, design, num_runs=100, seed=None):
        super().__init__(design)
        self.num_runs = num_runs
        self.seed = seed
        if self.seed is not None:
            random.seed(self.seed)

        self.vivado_synth_tool = VivadoSynth(self, design)
        self.vivado_impl_tool = VivadoImpl(self, design)
        self.phys_netlist_tool = PhysNetlist(self, design)
        self.xrev_tool = Xray(self, design)
        self.error_injector_tool = ErrorInjector(self, design)
        self.compare_tool = Structural(self, design)

        self.error_injector_build = self.design_build_path / "error_injection"

    def create_build_snippets(self):
        self.vivado_synth_tool.create_build_snippets()
        self.vivado_impl_tool.create_build_snippets()
        self.phys_netlist_tool.create_build_snippets(
            impl_dcp=self.vivado_impl_tool.outputs["impl_checkpoint"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
        )
        self.xrev_tool.create_build_snippets(self.vivado_impl_tool.outputs["bitstream"])

        random_seed_multiplier = 1
        error_type = [ErrorType.BIT_FLIP, ErrorType.WIRE_SWAP]
        for error in error_type:
            for i in range(1, self.num_runs + 1):
                self.error_injector_tool.create_build_snippets(
                    error_type=error,
                    num=i,
                    multiplier=random_seed_multiplier,
                    reversed_netlist=self.xrev_tool.outputs["xray_netlist"],
                )
                corrupt_netlist_path = self.error_injector_build / f"{error.name.lower()}_{i}.v"
                self.compare_tool.create_build_snippets(
                    self.phys_netlist_tool.phys_netlist_path,
                    corrupt_netlist_path,
                    f"{error.name.lower()}_{i}_cmp.log",
                )

    def get_top_level_flow_path(self) -> str:
        return f"{NINJA_FLOWS_PATH}/vivado_structural_error_injection.py"

    def post_execute(self):
        """Remove all error injection and comparison artifacts for errors successfully detected
        by the compare tool"""

        cmp_dir = self.compare_tool.build_path
        error_dir = self.error_injector_tool.build_path

        for file in cmp_dir.iterdir():
            if not file.name.startswith("bit_flip") and not file.name.startswith("wire_swap"):
                continue
            with open(file, "r") as f:
                # SUCCESS means the compare tool did not detect an actual error
                if "FAIL" not in f.read():
                    print(f"Error injection failed on {file.name.split('_cmp.log')[0]}")
                else:
                    err_log_name = file.name.split("_cmp.log")[0] + ".log"
                    err_log = error_dir / err_log_name
                    err_netlist = err_log.with_suffix(".v")
                    file.unlink()
                    err_log.unlink()
                    err_netlist.unlink()
