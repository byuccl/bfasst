"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib
from bfasst.flows.flow import Flow

from bfasst.tools.ip.ipencrypter import IpEncrypter
from bfasst.tools.ip.loader import EncryptedIpLoader
from bfasst.tools.synth.vivado_synth import VivadoSynth


class EncryptedIP(Flow):
    def __init__(self, design):
        super().__init__(design)

        # Synthesize and encrypt each encrypte IP
        for ip in self.design_props.encrypted_ip:
            synth_tool = VivadoSynth(
                self,
                design,
                ooc=True,
                top=ip,
                synth_options="-mode out_of_context -flatten_hierarchy full",
            )
            synth_tool.override_build_path(
                synth_tool.build_path.parent / f"{synth_tool.build_path.name}_{ip}"
            )
            synth_tool._init_outputs()

            ip_encrypter_tool = IpEncrypter(self, design, synth_tool.outputs["synth_dcp"])
            ip_encrypter_tool.override_build_path(
                ip_encrypter_tool.build_path.parent / f"{ip_encrypter_tool.build_path.name}_{ip}"
            )

        # Synthesize the top module
        synth_tool = VivadoSynth(self, design, ooc=True, synth_options="-flatten_hierarchy rebuilt")

        # Encrypted IP Shell
        EncryptedIpLoader(self, design, user_synth_dcp_path=synth_tool.outputs["synth_dcp"])

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
