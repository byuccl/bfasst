"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib
from bfasst.flows.flow import Flow

from bfasst.tools.ip.ipencrypter import IpEncrypter
from bfasst.tools.synth.vivado_synth import VivadoSynth


class EncryptedIP(Flow):
    def __init__(self, design):
        super().__init__(design)

        for ip in self.design_props.encrypted_ip:
            print(f"Encrypted IP: {ip}")
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

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
