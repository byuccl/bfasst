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
from bfasst.tools.impl.impl_detailed_reports import ImplDetailedReports
from bfasst.tools.transform.netlist_deobfuscate import NetlistDeobfuscate
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
            build_path="vivado_reimpl",
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
        )

        self.netlist_deobfuscate = NetlistDeobfuscate(
            self,
            design,
            dcp_path=self.impl_transform.outputs["impl_dcp"],
            edf_path=self.impl_transform.outputs["impl_edf"],
            props_json=self.netlist_obfuscate.outputs["original_cell_props"],
        )

        self.impl_detailed_reports_orig = ImplDetailedReports(
            self, design, impl_dcp=self.impl_orig.outputs["impl_dcp"], tag="orig"
        )
        self.impl_detailed_reports_transform = ImplDetailedReports(
            self, design, impl_dcp=self.netlist_deobfuscate.outputs["deobf_dcp"], tag="transform"
        )

        golden = ImplReports(
            dcp=self.impl_orig.outputs["impl_dcp"],
            edf=self.impl_orig.outputs["impl_edf"],
            setup_timing=self.impl_detailed_reports_orig.outputs["setup_timing"],
            hold_timing=self.impl_detailed_reports_orig.outputs["hold_timing"],
            timing_summary_full=self.impl_detailed_reports_orig.outputs["full_timing_summary"],
            utilization=self.impl_detailed_reports_orig.outputs["utilization"],
            power=self.impl_detailed_reports_orig.outputs["power_summary"],
        )

        test = ImplReports(
            dcp=self.impl_transform.outputs["impl_dcp"],
            edf=self.impl_transform.outputs["impl_edf"],
            setup_timing=self.impl_detailed_reports_transform.outputs["setup_timing"],
            hold_timing=self.impl_detailed_reports_transform.outputs["hold_timing"],
            timing_summary_full=self.impl_detailed_reports_transform.outputs["full_timing_summary"],
            utilization=self.impl_detailed_reports_transform.outputs["utilization"],
            power=self.impl_detailed_reports_transform.outputs["power_summary"],
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
            self.netlist_deobfuscate,
            self.impl_detailed_reports_orig,
            self.impl_detailed_reports_transform,
            self.physcmp,
        ]

    def create_build_snippets(self):
        self.vivado_synth.create_build_snippets()
        self.netlist_obfuscate.create_build_snippets()
        self.impl_orig.create_build_snippets()
        self.impl_transform.create_build_snippets()
        self.netlist_deobfuscate.create_build_snippets()
        self.impl_detailed_reports_orig.create_build_snippets()
        self.impl_detailed_reports_transform.create_build_snippets()
        self.physcmp.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "impl_obfuscate.py"
