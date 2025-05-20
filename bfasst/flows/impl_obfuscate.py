"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation
    3. Changes the synthesis netlist in some way
    4. Runs Vivado implementation again on the new netlist
    5. Compares the two implementations for physical differences
"""

from bfasst.flows.flow import Flow
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.physcmp.physcmp import PhysCmp
from bfasst.tools.transform.netlist_obfuscate import NetlistObfuscate
from bfasst.utils.physcmp_data_types import ImplReports
from bfasst.paths import FLOWS_PATH


class ImplObfuscate(Flow):
    """Tool to synthesize, implement, reimplement, and compare designs"""

    def __init__(self, design):
        super().__init__(design)

        self.synth_opts = {"synth_design": "-flatten_hierarchy full"}
        self.vivado_synth = VivadoSynth(self, design, synth_options=self.synth_opts)

        self.netlist_obfuscate = NetlistObfuscate(
            self,
            design,
            dcp_path=self.vivado_synth.outputs["synth_dcp"],
            edf_path=self.vivado_synth.outputs["synth_edf"],
            transform_type="purge_luts",
            logging_level="DEBUG",
            log_file="netlist_obfuscate.log",
        )

        self.impl_orig = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth.outputs["synth_edf"],
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
        )

        self.impl_transform = VivadoImpl(
            self,
            design,
            synth_edf=self.netlist_obfuscate.outputs["transformed_synth_edf"],
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
        )

        # We have to do some hacky stuff to get two instances of VivadoImpl running
        self.impl_transform.build_path = self.impl_transform.build_path.parent / "vivado_reimpl"
        self.impl_transform._init_outputs()
        self.impl_transform.outputs_str = {
            k: str(v) for k, v in self.impl_transform.outputs.items()
        }
        self.impl_transform.impl_build = {
            "part": self.impl_transform.flow.part,
            "impl_output": str(self.impl_transform.build_path),
            "synth_output": str(
                self.impl_transform.build_path.parent
                / ("synth" if not self.impl_transform.ooc else "synth_ooc")
            ),
            "clocks": (
                self.impl_transform.design_props.clocks
                if self.impl_transform.design_props is not None
                and type(self.impl_transform.flow).__name__ == "ClockCrank"
                else ""
            ),
            "outputs": self.impl_transform.outputs_str,
            "tcl_sources": [
                self.impl_transform.outputs_str["setup_tcl"],
                self.impl_transform.outputs_str["impl_tcl"],
                self.impl_transform.outputs_str["reports_tcl"],
            ],
            "inputs": self.impl_transform.inputs_str,
        }

        golden = ImplReports(
            dcp=self.impl_orig.outputs["impl_dcp"],
            edf=self.impl_orig.outputs["impl_edf"],
            setup_timing=self.impl_orig.outputs["setup_timing"],
            hold_timing=self.impl_orig.outputs["hold_timing"],
            timing_summary_full=self.impl_orig.outputs["timing_summary_full"],
            utilization=self.impl_orig.outputs["utilization"],
            power=self.impl_orig.outputs["power"],
        )
        test = ImplReports(
            dcp=self.impl_transform.outputs["impl_dcp"],
            edf=self.impl_transform.outputs["impl_edf"],
            setup_timing=self.impl_transform.outputs["setup_timing"],
            hold_timing=self.impl_transform.outputs["hold_timing"],
            timing_summary_full=self.impl_transform.outputs["timing_summary_full"],
            utilization=self.impl_transform.outputs["utilization"],
            power=self.impl_transform.outputs["power"],
        )

        self.physcmp = PhysCmp(
            self,
            design,
            golden=golden,
            test=test,
            log_name="physcmp.log",
            logging_level="DEBUG",
        )

        self.tools = [
            self.vivado_synth,
            self.impl_orig,
            self.netlist_obfuscate,
            self.impl_transform,
            self.physcmp,
        ]

    def create_build_snippets(self):
        self.vivado_synth.create_build_snippets()
        self.netlist_obfuscate.create_build_snippets()
        self.impl_orig.create_build_snippets()
        self.impl_transform.create_build_snippets()
        self.physcmp.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "impl_obfuscate.py"
