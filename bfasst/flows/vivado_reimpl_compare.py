"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation
    3. Changes the synthesis netlist in some way
    4. Runs Vivado implementation again on the new netlist
    5. Compares the two implementations for physical differences
"""

import logging
import json
from shutil import copy
from pathlib import Path

from bfasst.flows.flow import Flow
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.compare.physcmp.physcmp import PhysCmp
from bfasst.tools.transform.netlist_transform import NetlistTransform
from bfasst.paths import FLOWS_PATH
from bfasst.utils.general import json_write_if_changed

class VivadoReimplCompare(Flow):
    """Tool to synthesize, implement, reimplement, and compare designs"""

    def __init__(self, design):
        super().__init__(design)
        
        self.synth_opts = {"synth_design": "-flatten_hierarchy full"}
        self.vivado_synth = VivadoSynth(
                self, 
                design, 
                synth_options=self.synth_opts
        )

        self.netlist_transform = NetlistTransform(
                self,
                design,
                dcp_path=self.vivado_synth.outputs["synth_dcp"],
                edf_path=self.vivado_synth.outputs["synth_edf"],
                transform_type="purge_luts",
                logging_level="DEBUG",
                log_file="netlist_transform.log"
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
                synth_edf=self.netlist_transform.outputs["transformed_synth_edf"],
                constraints_files=self.vivado_synth.outputs["synth_constraints"],
        )

        self.impl_transform.build_path = self.impl_transform.build_path.parent / "vivado_reimpl"
        self.impl_transform._init_outputs()
        self.impl_transform.outputs_str = {k: str(v) for k, v in self.impl_transform.outputs.items()}
        self.impl_transform.impl_build = {
            "part": self.impl_transform.flow.part,
            "impl_output": str(self.impl_transform.build_path),
            "synth_output": str(
                self.impl_transform.build_path.parent / ("synth" if not self.impl_transform.ooc else "synth_ooc")
            ),
            "clocks": (
                self.impl_transform.design_props.clocks
                if self.impl_transform.design_props is not None and type(self.impl_transform.flow).__name__ == "ClockCrank"
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

        self.physcmp = PhysCmp(
            self,
            design,
        
            golden_dcp=self.impl_orig.outputs["impl_dcp"],
            golden_edf=self.impl_orig.outputs["impl_edf"],
            golden_setup_timing=self.impl_orig.outputs["setup_timing"],
            golden_hold_timing=self.impl_orig.outputs["hold_timing"],
            golden_timing_summary_full=self.impl_orig.outputs["timing_summary_full"],
            golden_utilization=self.impl_orig.outputs["utilization"],
            golden_power=self.impl_orig.outputs["power"],
        
            test_dcp=self.impl_transform.outputs["impl_dcp"],
            test_edf=self.impl_transform.outputs["impl_edf"],
            test_setup_timing=self.impl_transform.outputs["setup_timing"],
            test_hold_timing=self.impl_transform.outputs["hold_timing"],
            test_timing_summary_full=self.impl_transform.outputs["timing_summary_full"],
            test_utilization=self.impl_transform.outputs["utilization"],
            test_power=self.impl_transform.outputs["power"],
        
            log_name="phys_cmp.log",
            logging_level="DEBUG",
        )


        self.tools = [
            self.vivado_synth,
            self.netlist_transform,
            self.impl_orig,
            self.impl_transform,
            self.physcmp,
        ]

    def create_build_snippets(self):
        self.vivado_synth.create_build_snippets()
        self.netlist_transform.create_build_snippets()
        self.impl_orig.create_build_snippets()
        self.impl_transform.create_build_snippets()
        self.physcmp.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado_reimpl_compare.py"

