"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation
    3. Redacts the synthesis netlist properties
    4. Runs Vivado implementation again on the redacted netlist
    5. Compares the two implementations for logical equivalence using Yosys
"""

from bfasst.flows.flow import Flow
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.yosys.yosys import YosysCompare
from bfasst.tools.transform.netlist_redact import NetlistRedact
from bfasst.tools.impl.impl_detailed_reports import ImplDetailedReports
from bfasst.tools.transform.netlist_unredact import NetlistUnredact
from bfasst.paths import FLOWS_PATH
from bfasst.yaml_parser import DesignParser


class ImplRedact(Flow):
    """Tool to synthesize, implement, redact, reimplement, and compare designs"""

    def __init__(self, design):
        super().__init__(design)

        self.synth_opts = {"synth_design": "-flatten_hierarchy full"}
        # self.synth_opts = {"synth_design": ""}
        self.vivado_synth = VivadoSynth(
            self, design, opt_design=True, synth_options=self.synth_opts
        )
        parser = DesignParser(self.design_path / "design.yaml")
        if parser.clocks is None:
            print("Warning: No clocks found in yaml file")

        self.netlist_redact = NetlistRedact(
            self,
            design,
            dcp_path=self.vivado_synth.outputs["synth_dcp"],
            edf_path=self.vivado_synth.outputs["synth_edf"],
            orig_dcp_path=self.vivado_synth.outputs["synth_dcp"],
            orig_edf_path=self.vivado_synth.outputs["synth_edf"],
            logging_level="DEBUG",
            log_file="netlist_redact.log",
        )

        self.impl_redacted = VivadoImpl(
            self,
            design,
            synth_edf=self.netlist_redact.outputs["redacted_synth_edf"],
            build_path="vivado_reimpl",
            opt_design=False,
            phys_opt_design=True,
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
            disable_drc=True,
        )

        self.impl_orig = VivadoImpl(
            self,
            design,
            synth_edf=self.netlist_redact.outputs["unredacted_synth_edf"],
            opt_design=False,
            phys_opt_design=True,
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
        )

        if self.impl_orig.impl_build["clocks"] not in ("", {}):
            self.impl_redacted.outputs["clock_crank_tcl"] = (
                self.impl_redacted.build_path / "clock_crank.tcl"
            )
            self.impl_redacted.outputs_str["clock_crank_tcl"] = str(
                self.impl_redacted.outputs["clock_crank_tcl"]
            )
            self.impl_redacted.impl_build["tcl_sources"] = [
                self.impl_redacted.outputs_str["setup_tcl"],
                self.impl_redacted.outputs_str["clock_crank_tcl"],
                self.impl_redacted.outputs_str["reports_tcl"],
            ]

            self.impl_orig.outputs["clock_crank_tcl"] = (
                self.impl_orig.build_path / "clock_crank.tcl"
            )
            self.impl_orig.outputs_str["clock_crank_tcl"] = str(
                self.impl_orig.outputs["clock_crank_tcl"]
            )
            self.impl_orig.impl_build["tcl_sources"] = [
                self.impl_orig.outputs_str["setup_tcl"],
                self.impl_orig.outputs_str["clock_crank_tcl"],
                self.impl_orig.outputs_str["reports_tcl"],
            ]

        self.netlist_unredact = NetlistUnredact(
            self,
            design,
            dcp_path=self.impl_redacted.outputs["impl_dcp"],
            edf_path=self.impl_redacted.outputs["impl_edf"],
            unmodified_dcp_path=self.impl_orig.outputs["impl_dcp"],
            unmodified_edf_path=self.impl_orig.outputs["impl_edf"],
            props_json=self.netlist_redact.outputs["original_cell_props"],
        )

        self.impl_detailed_reports_orig = ImplDetailedReports(
            self,
            design,
            impl_dcp=self.netlist_unredact.outputs["unmodified_unredact_dcp"],
            tag="orig",
        )

        self.impl_detailed_reports_redacted = ImplDetailedReports(
            self, design, impl_dcp=self.netlist_unredact.outputs["unredact_dcp"], tag="redacted"
        )

        self.yosys_compare = YosysCompare(
            self,
            design,
            golden_netlist=self.impl_detailed_reports_orig.outputs["verilog"],
            rev_netlist=self.impl_detailed_reports_redacted.outputs["verilog"],
        )

        self.tools = [
            self.vivado_synth,
            self.impl_orig,
            self.netlist_redact,
            self.impl_redacted,
            self.netlist_unredact,
            self.impl_detailed_reports_orig,
            self.impl_detailed_reports_redacted,
            self.yosys_compare,
        ]

    def create_build_snippets(self):
        self.vivado_synth.create_build_snippets()
        self.netlist_redact.create_build_snippets()
        self.impl_orig.create_build_snippets()
        self.impl_redacted.create_build_snippets()
        self.netlist_unredact.create_build_snippets()
        self.impl_detailed_reports_orig.create_build_snippets()
        self.impl_detailed_reports_redacted.create_build_snippets()
        self.yosys_compare.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "impl_redact.py"
