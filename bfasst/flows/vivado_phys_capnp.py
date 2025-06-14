"""Structural Comparison of physical netlist and reversed netlist"""

from bfasst.flows.vivado_bit_to_netlist import VivadoBitToNetlist
from bfasst.paths import FLOWS_PATH
from bfasst.tools.compare.structural.structural_capnp_cmp import StructuralCapnpCmp


class VivadoPhysCapnp(VivadoBitToNetlist):
    """Structural Comparison of physical netlist and reversed netlist"""

    def __init__(self, design, synth_options="", debug=False, logging_level="INFO"):
        super().__init__(design, synth_options)
        self.debug = debug

        self.capnp_cmp_tool = StructuralCapnpCmp(
            self,
            design,
            impl_checkpoint=self.vivado_impl_tool.outputs["impl_dcp"],
            impl_edf=self.vivado_impl_tool.outputs["impl_edf"],
            phys_capnp=self.xrev_tool.outputs["phys_capnp"],
            edf_capnp=self.xrev_tool.outputs["edf_capnp"],
            logging_level=logging_level,
        )

    def get_top_level_flow_path(self):
        return f"{FLOWS_PATH}/vivado_phys_capnp.py"
