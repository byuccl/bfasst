"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.flows.vivado_bit_to_netlist import VivadoBitToNetlist
from bfasst.flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.paths import BFASST_FLOWS
from bfasst.tools.compare.structural.structural_capnp_cmp import StructuralCapnpCmp


class VivadoPhysCapnp(VivadoBitToNetlist):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, synth_options="", debug=False, logging_level="INFO"):
        synth_options = VivadoPhysNetlist.add_required_synth_options(synth_options)
        super().__init__(design, synth_options)
        self.debug = debug

        self.capnp_cmp_tool = StructuralCapnpCmp(
            self,
            design,
            synth_checkpoint=self.vivado_synth_tool.outputs["synth_dcp"],
            synth_edf=self.vivado_synth_tool.outputs["synth_edf"],
            impl_checkpoint=self.vivado_impl_tool.outputs["impl_dcp"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
            phys_capnp=self.xrev_tool.outputs["phys_capnp"],
            edf_capnp=self.xrev_tool.outputs["edf_capnp"],
            logging_level=logging_level,
        )

    def get_top_level_flow_path(self):
        return f"{BFASST_FLOWS}/vivado_phys_capnp.py"
