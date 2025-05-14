"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation
    3. Runs a script to change the netlist
    4. Runs Vivado implementation again
    5. Runs a comparison between the two implementation
"""

import pathlib

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.compare.physcmp.physcmp import PhysCmp
from bfasst.paths import FLOWS_PATH
from bfasst.paths import BUILD_PATH
from bfasst.design import Design
from bfasst.utils.general import json_write_if_changed
import json

class VivadoReimplImpl(VivadoImpl):
    """
    Second implementation of VivadoReimpl.
    Same as VivadoImpl but writes into vivado_reimpl/.
    """

    def __init__(
        self, flow, design, synth_edf, constraints_files="", ooc=False, impl_options=""
    ):
        super().__init__(flow, design, synth_edf, constraints_files, ooc, impl_options)
        self.build_path = self.build_path.parent / "vivado_reimpl"
        self._init_outputs()
        self.outputs_str = {k: str(v) for k, v in self.outputs.items()}

        self.impl_build.update({
            "impl_output": str(self.build_path),
            "outputs": self.outputs_str,
            "tcl_sources": [
                self.outputs_str["setup_tcl"],
                self.outputs_str["impl_tcl"],
                self.outputs_str["reports_tcl"],
            ]
        })

    def create_build_snippets(self):
        # regenerate impl.json in the vivado_reimpl folder
        impl_json = json.dumps(self.impl_build, indent=4)
        json_write_if_changed(self.build_path / "impl.json", impl_json)

        super().create_build_snippets()

class VivadoReimplCompare(Flow):
    """Synthesize and implement a design, modify it, reimplement, and compare results."""

    def __init__(self, design):
        super().__init__(design)
        
        synth_options = {
                "synth_design": "-flatten_hierarchy full"
                }

        self.vivado_synth_tool = VivadoSynth(
                self, 
                design, 
                synth_options=synth_options, 
        )
        
        self.synth_edf_orig = self.vivado_synth_tool.outputs["synth_edf"]
        self.vivado_impl1 = VivadoImpl(
                self,
                design,
                synth_edf=self.synth_edf_orig,
                constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )

        # self.modified_edf = self.vivado_synth_tool.outputs["synth_edf"] # no change for now

        self.vivado_impl2 = VivadoReimplImpl(
                self,
                design,
                synth_edf=self.synth_edf_orig,
                constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )

#        self.compare = Structural(
#                self,
#                design,
#                golden_netlist=self.vivado_impl1.outputs["impl_verilog"],
#                rev_netlist=self.vivado_impl2.outputs["impl_verilog"],
#                log_name="impl_cmp.log",
#                logging_level="DEBUG"
#        )

        self.physcmp = PhysCmp(
                self,
                design,
                golden_dcp=self.vivado_impl1.outputs["impl_dcp"],
                golden_edf=self.vivado_impl1.outputs["impl_edf"],
                test_dcp=self.vivado_impl2.outputs["impl_dcp"],
                test_edf=self.vivado_impl2.outputs["impl_edf"],
                log_name="phys_cmp.log",
                logging_level="DEBUG",
        )

        self.tools = [
                self.vivado_synth_tool,
                self.vivado_impl1,
                self.vivado_impl2,
                self.physcmp
        ]
        
    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado_reimpl_compare.py"
