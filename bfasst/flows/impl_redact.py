"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation (golden)
    3. Redacts the synthesis netlist properties
    4. Runs Vivado implementation again on the redacted netlist (test)
    5. Optionally runs a third implementation without phys_opt (super_golden) for metrics baseline
    6. Compares bitstreams (golden vs test) and metrics (baseline vs test)
"""

from bfasst.flows.flow import Flow
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl

# from bfasst.tools.compare.yosys.yosys import YosysCompare
from bfasst.tools.compare.metricscmp.metricscmp import MetricsCmp
from bfasst.tools.transform.netlist_redact import NetlistRedact
from bfasst.tools.impl.impl_detailed_reports import ImplDetailedReports
from bfasst.tools.transform.netlist_unredact import NetlistUnredact
from bfasst.paths import FLOWS_PATH
from bfasst.yaml_parser import DesignParser


class ImplRedact(Flow):
    """Tool to synthesize, implement, redact, reimplement, and compare designs"""

    def __init__(self, design, use_super_golden=True, super_golden_impl_options=None):
        super().__init__(design)

        self.use_super_golden = use_super_golden
        if super_golden_impl_options is None:
            # Default: empty phys_opt flags for super_golden
            # (still runs phys_opt in clock crank loop)
            super_golden_impl_options = {
                "phys_opt_flags_postplace": "",
                "phys_opt_flags_postroute": "",
            }

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

        impl_options = {
            "phys_opt_flags_postplace": (
                "-fanout_opt -placement_opt -casc_opt -cell_group_opt -critical_cell_opt "
                "-dsp_register_opt -bram_register_opt -bram_enable_opt -shift_register_opt "
                "-critical_pin_opt -memory_rewire_opt -hold_fix"
            ),
            "phys_opt_flags_postroute": (
                "-routing_opt -casc_opt -cell_group_opt -critical_cell_opt "
                "-critical_pin_opt -clock_opt -memory_rewire_opt -hold_fix"
            ),
        }
        self.impl_redacted = VivadoImpl(
            self,
            design,
            synth_edf=self.netlist_redact.outputs["redacted_synth_edf"],
            build_path="vivado_reimpl",
            opt_design=False,
            phys_opt_design=True,
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
            disable_drc=True,
            impl_options=impl_options,
        )

        self.impl_orig = VivadoImpl(
            self,
            design,
            synth_edf=self.netlist_redact.outputs["unredacted_synth_edf"],
            opt_design=False,
            phys_opt_design=True,
            constraints_files=self.vivado_synth.outputs["synth_constraints"],
            impl_options=impl_options,
        )

        # Super golden: original design with different (or no) phys_opt flags
        # Runs clock crank loop with empty phys_opt flags as baseline for metrics comparison
        self.impl_super_golden = None
        self.impl_detailed_reports_super_golden = None
        if self.use_super_golden:
            self.impl_super_golden = VivadoImpl(
                self,
                design,
                synth_edf=self.netlist_redact.outputs["unredacted_synth_edf"],
                build_path="vivado_impl_super_golden",
                opt_design=False,
                phys_opt_design=True,
                constraints_files=self.vivado_synth.outputs["synth_constraints"],
                impl_options=super_golden_impl_options,
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

            if self.impl_super_golden:
                self.impl_super_golden.outputs["clock_crank_tcl"] = (
                    self.impl_super_golden.build_path / "clock_crank.tcl"
                )
                self.impl_super_golden.outputs_str["clock_crank_tcl"] = str(
                    self.impl_super_golden.outputs["clock_crank_tcl"]
                )
                self.impl_super_golden.impl_build["tcl_sources"] = [
                    self.impl_super_golden.outputs_str["setup_tcl"],
                    self.impl_super_golden.outputs_str["clock_crank_tcl"],
                    self.impl_super_golden.outputs_str["reports_tcl"],
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

        if self.impl_super_golden:
            self.impl_detailed_reports_super_golden = ImplDetailedReports(
                self,
                design,
                impl_dcp=self.impl_super_golden.outputs["impl_dcp"],
                tag="super_golden",
            )

        # self.yosys_compare = YosysCompare(
        #     self,
        #     design,
        #     golden_netlist=self.impl_detailed_reports_orig.outputs["verilog"],
        #     rev_netlist=self.impl_detailed_reports_redacted.outputs["verilog"],
        #     use_redact_script=True,
        # )

        # Build MetricsCmp arguments
        # Bitstream comparison: golden vs test (always) - use post-unredaction bitstreams
        # Metrics comparison: baseline (super_golden if enabled, else golden) vs test
        metrics_cmp_kwargs = {
            "golden_bitstream": self.impl_detailed_reports_orig.outputs["bitstream"],
            "test_bitstream": self.impl_detailed_reports_redacted.outputs["bitstream"],
            "golden_timing": self.impl_detailed_reports_orig.outputs["timing_summary"],
            "golden_utilization": self.impl_detailed_reports_orig.outputs["utilization"],
            "golden_log": self.impl_orig.outputs["log"],
            "test_timing": self.impl_detailed_reports_redacted.outputs["timing_summary"],
            "test_utilization": self.impl_detailed_reports_redacted.outputs["utilization"],
            "test_log": self.impl_redacted.outputs["log"],
        }
        if self.impl_detailed_reports_super_golden:
            metrics_cmp_kwargs["baseline_timing"] = self.impl_detailed_reports_super_golden.outputs[
                "timing_summary"
            ]
            metrics_cmp_kwargs["baseline_utilization"] = (
                self.impl_detailed_reports_super_golden.outputs["utilization"]
            )
            metrics_cmp_kwargs["baseline_log"] = self.impl_super_golden.outputs["log"]

        self.metrics_cmp = MetricsCmp(self, design, **metrics_cmp_kwargs)

        self.tools = [
            self.vivado_synth,
            self.impl_orig,
            self.netlist_redact,
            self.impl_redacted,
            self.netlist_unredact,
            self.impl_detailed_reports_orig,
            self.impl_detailed_reports_redacted,
            # self.yosys_compare,
            self.metrics_cmp,
        ]
        if self.impl_super_golden:
            self.tools.insert(2, self.impl_super_golden)
            self.tools.insert(-1, self.impl_detailed_reports_super_golden)

    def create_build_snippets(self):
        self.vivado_synth.create_build_snippets()
        self.netlist_redact.create_build_snippets()
        self.impl_orig.create_build_snippets()
        if self.impl_super_golden:
            self.impl_super_golden.create_build_snippets()
        self.impl_redacted.create_build_snippets()
        self.netlist_unredact.create_build_snippets()
        self.impl_detailed_reports_orig.create_build_snippets()
        self.impl_detailed_reports_redacted.create_build_snippets()
        if self.impl_detailed_reports_super_golden:
            self.impl_detailed_reports_super_golden.create_build_snippets()
        # self.yosys_compare.create_build_snippets()
        self.metrics_cmp.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "impl_redact.py"
