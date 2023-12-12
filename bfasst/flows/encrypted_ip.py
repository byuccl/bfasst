"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib

import yaml
from bfasst.flows.flow import Flow

from bfasst.tools.ip.ipencrypter import IpEncrypter
from bfasst.tools.ip.loader import EncryptedIpLoader
from bfasst.tools.synth.vivado_synth import VivadoSynth


class EncryptedIP(Flow):
    def __init__(self, design):
        super().__init__(design)

        encrypted_ip_paths = []
        encrypted_ip_ciphertext_paths = []

        assert self.design_props.encrypted_ip, "No encrypted IPs specified"

        # ip_definitions = [ip["definition"] for ip in self.design_props.encrypted_ip["ip"]]

        # Synthesize and encrypt each encrypte IP
        for ip in self.design_props.encrypted_ip["ip"]:
            ip_definition = ip["definition"]
            synth_tool = VivadoSynth(
                self,
                design,
                ooc=True,
                top=ip_definition,
                synth_options="-flatten_hierarchy full",
            )
            synth_tool.override_build_path(
                synth_tool.build_path.parent / f"{synth_tool.build_path.name}_{ip_definition}"
            )
            synth_tool._init_outputs()

            ip_encrypter_tool = IpEncrypter(
                self, design, ip_definition, synth_tool.outputs["synth_dcp"]
            )
            # ip_encrypter_tool.override_build_path(
            #     ip_encrypter_tool.build_path.parent
            #     / f"{ip_encrypter_tool.build_path.name}_{ip_definition}"
            # )
            encrypted_ip_paths.append(ip_encrypter_tool.outputs["encrypted_verilog"])
            ip["ciphertext_path"] = str(ip_encrypter_tool.outputs["lut_ciphertext"])

        # Synthesize the top module
        synth_tool = VivadoSynth(self, design, ooc=True, synth_options="-flatten_hierarchy rebuilt")
        synth_tool.verilog = [
            self.design_path / v for v in self.design_props.encrypted_ip["user_files"]
        ]
        synth_tool.verilog.extend(encrypted_ip_paths)

        encrypted_ip_yaml_path = self.design_build_path / "encrypted_ip.yaml"
        encrypted_ip_yaml_path.parent.mkdir(exist_ok=True, parents=True)
        with open(encrypted_ip_yaml_path, "w") as f:
            yaml.dump(self.design_props.encrypted_ip["ip"], f)

        # Encrypted IP Shell
        EncryptedIpLoader(
            self,
            design,
            user_synth_dcp_path=synth_tool.outputs["synth_dcp"],
            encrypted_ip_yaml_path=encrypted_ip_yaml_path,
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
