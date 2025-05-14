"""
Flow that does the following:
    1. Synthesizes a design
    2. Runs Vivado implementation
    3. Injects a placement constraint to force a physical change
    4. Runs Vivado implementation again
    5. Compares the two implementations for physical differences
"""

import pathlib
import json
import logging

from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.tools.compare.physcmp.physcmp import PhysCmp
from bfasst.paths import FLOWS_PATH
from bfasst.utils.general import json_write_if_changed

# configure verbose logging
logging.basicConfig(level=logging.DEBUG, format="[%(levelname)s] %(message)s")

# === ADJUST THESE TO YOUR DESIGN ===
CELL_TO_MOVE = "myRegfile/register_reg[30][18]"   # pick one from your Design.getCells() list
NEW_LOC      = "SLICE_X10Y10/BFF"                 # a valid BEL in the same site
# ==================================

class VivadoReimplImpl(VivadoImpl):
    """
    Second implementation of VivadoReimpl.
    Same as VivadoImpl but writes into vivado_reimpl/,
    with an extra XDC constraint to force a placement diff.
    """
    
    def __init__(
        self, flow, design, synth_edf, constraints_files="", ooc=False, impl_options=""
    ):
        super().__init__(flow, design, synth_edf, constraints_files, ooc, impl_options)

        # Redirect all outputs into vivado_reimpl/
        self.build_path = self.build_path.parent / "vivado_reimpl"
        self._init_outputs()

        # Capture outputs as strings for impl_build
        self.outputs_str = {k: str(v) for k, v in self.outputs.items()}
        self.impl_build.update({
            "impl_output": str(self.build_path),
            "outputs":     self.outputs_str,
            "tcl_sources": [
                self.outputs_str["setup_tcl"],
                self.outputs_str["impl_tcl"],
                self.outputs_str["reports_tcl"],
            ],
        })

        logging.debug(f"Initialized VivadoReimplImpl with synth_edf={synth_edf!r}")

        # --- Inject placement constraint XDC ---
        inject_xdc = self.build_path / "force_place.xdc"
        inject_xdc.parent.mkdir(parents=True, exist_ok=True)
        with open(inject_xdc, "w") as f:
            f.write("## Auto-generated placement constraint\n")
            f.write(f"set_property LOC {NEW_LOC} [get_cells {CELL_TO_MOVE}]\n")
        logging.info(f"Will inject placement XDC → {inject_xdc}")

        # Add that XDC into impl_build inputs for impl.json correctness
        inputs = self.impl_build.setdefault("inputs", {})
        xdc_list = inputs.setdefault("xdc", [])
        xdc_list.append(str(inject_xdc))
        logging.debug(f"impl_build['inputs']['xdc'] = {xdc_list!r}")

        # ── And *also* append it to the VivadoImpl constraints_file so run.tcl reads it ──
        # VivadoImpl stores a singular attribute `self.constraints_file`
        if isinstance(self.constraints_file, str):
            self.constraints_file = f"{self.constraints_file} {inject_xdc}"
        else:
            # in case it was a list/tuple
            cf = list(self.constraints_file) if isinstance(self.constraints_file, (list, tuple)) else [self.constraints_file]
            cf.append(str(inject_xdc))
            self.constraints_file = cf
        logging.debug(f"Reimpl constraints_file → {self.constraints_file!r}")

        # Reflect that in impl_build too
        self.impl_build["constraints_file"] = self.constraints_file
    
    def create_build_snippets(self):
        logging.info("=== VivadoReimplImpl.create_build_snippets ===")
        logging.debug(f"Using synth_edf = {self.synth_edf}")

        # regenerate impl.json so our XDC shows up
        self._init_outputs()
        impl_json = json.dumps(self.impl_build, indent=2)
        json_write_if_changed(self.build_path / "impl.json", impl_json)
        logging.debug(f"Wrote vivado_reimpl/impl.json:\n{impl_json}")

        # now do the normal VivadoImpl build snippet
        super().create_build_snippets()


class VivadoReimplCompare(Flow):
    """Synthesize, impl, reimpl with placement tweak, then PhysCmp."""

    def __init__(self, design):
        super().__init__(design)
        logging.info("=== VivadoReimplCompare.__init__ ===")

        synth_options = {"synth_design": "-flatten_hierarchy full"}

        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=synth_options)
        self.synth_edf_orig    = self.vivado_synth_tool.outputs["synth_edf"]
        logging.debug(f"Synthesized EDIF → {self.synth_edf_orig}")

        self.vivado_impl1 = VivadoImpl(
            self,
            design,
            synth_edf=self.synth_edf_orig,
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        logging.debug(f"First impl uses EDIF → {self.vivado_impl1.synth_edf}")

        self.vivado_impl2 = VivadoReimplImpl(
            self,
            design,
            synth_edf=self.synth_edf_orig,
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )

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
        logging.debug(f"PhysCmp golden_dcp = {self.vivado_impl1.outputs['impl_dcp']}")
        logging.debug(f"PhysCmp test_dcp   = {self.vivado_impl2.outputs['impl_dcp']}")

        self.tools = [
            self.vivado_synth_tool,
            self.vivado_impl1,
            self.vivado_impl2,
            self.physcmp,
        ]

    def create_build_snippets(self):
        logging.info("=== VivadoReimplCompare.create_build_snippets ===")
        logging.debug(f"  Synth EDIF: {self.synth_edf_orig}")
        self.vivado_synth_tool.create_build_snippets()

        logging.debug(f"  Impl1 outputs: {self.vivado_impl1.outputs}")
        self.vivado_impl1.create_build_snippets()

        logging.debug(f"  Impl2 inputs (EDIF + XDC): synth_edf={self.vivado_impl2.synth_edf}")
        self.vivado_impl2.create_build_snippets()

        logging.debug(f"  PhysCmp inputs: golden={self.vivado_impl1.outputs['impl_dcp']} "
                          f"test={self.vivado_impl2.outputs['impl_dcp']}")
        self.physcmp.create_build_snippets()

    def get_top_level_flow_path(self):
        return FLOWS_PATH / "vivado_reimpl_compare.py"

