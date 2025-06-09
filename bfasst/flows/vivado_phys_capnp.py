"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.flows.flow import Flow
from bfasst.flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.tools.impl.vivado_impl import VivadoImpl
from bfasst.tools.rev_bit.xray import Xray
from bfasst.tools.transform.phys_netlist import PhysNetlist
from bfasst.paths import FLOWS_PATH
from bfasst.tools.synth.vivado_synth import VivadoSynth


class VivadoPhysCapnp(Flow):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, synth_options="", debug=False, logging_level="INFO"):
        # pylint: disable=duplicate-code
        super().__init__(design)

        self.synth_options = VivadoPhysNetlist.add_required_synth_options(synth_options)
        self.debug = debug
        self.logging_level = logging_level
        self.vivado_synth_tool = VivadoSynth(self, design, synth_options=self.synth_options)
        self.vivado_impl_tool = VivadoImpl(
            self,
            design,
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            constraints_files=self.vivado_synth_tool.outputs["synth_constraints"],
        )
        self.xray_tool = Xray(
            self,
            design,
            xdc_input=self.vivado_synth_tool.outputs["synth_constraints"],
            bitstream=self.vivado_impl_tool.outputs["bitstream"],
        )
        self.phys_netlist_tool = PhysNetlist(
            self,
            design,
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
            impl_checkpoint=self.vivado_impl_tool.outputs["impl_dcp"],
            phys_capnp=self.xray_tool.outputs["phys_capnp"],
            edf_capnp=self.xray_tool.outputs["edf_capnp"],
            logging_level=self.logging_level,
        )
        # pylint: enable=duplicate-code

    def get_top_level_flow_path(self):
        return f"{FLOWS_PATH}/vivado_phys_capnp.py"
