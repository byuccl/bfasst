"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib
import re

import yaml
from bfasst.flows.flow import Flow
from bfasst.tools.impl.vivado_impl import VivadoImpl

from bfasst.tools.ip.ipencrypter import IpEncrypter
from bfasst.tools.ip.loader import EncryptedIpLoader
from bfasst.tools.synth.vivado_synth import VivadoSynth
from bfasst.utils.vivado import parse_hierarchical_utilization


class EncryptedIP(Flow):
    def __init__(self, design):
        super().__init__(design)

        encrypted_ip_paths = []
        encrypted_ip_ciphertext_paths = []

        assert self.design_props.encrypted_ip, "No encrypted IPs specified"

        # ip_definitions = [ip["definition"] for ip in self.design_props.encrypted_ip["ip"]]

        # Perform the regular vivado CAD flow
        self.synth_regular = VivadoSynth(self, design)
        VivadoImpl(self, design)

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
        self.top_synth_tool = VivadoSynth(
            self, design, ooc=True, synth_options="-flatten_hierarchy rebuilt"
        )
        self.top_synth_tool.verilog = [
            self.design_path / v for v in self.design_props.encrypted_ip["user_files"]
        ]
        self.top_synth_tool.verilog.extend(encrypted_ip_paths)

        # Encrypted IP Shell
        EncryptedIpLoader(
            self,
            design,
            user_synth_dcp_path=self.top_synth_tool.outputs["synth_dcp"],
            encrypted_ip_data=self.design_props.encrypted_ip["ip"],
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)

    def post_execute(self):
        out_csv_path = self.design_build_path / "area_results.txt"

        # Get regular synthesis results
        reg_utilization_file = self.synth_regular.outputs["utilization"]
        encrypted_utilization_file = self.top_synth_tool.outputs["utilization"]

        regular_data = parse_hierarchical_utilization(reg_utilization_file)
        encrypted_data = parse_hierarchical_utilization(encrypted_utilization_file)

        instances = ["top_0"] + [
            f"top_0/{definition}"
            for ip in self.design_props.encrypted_ip["ip"]
            for definition in ip["instances"]
        ]

        for instance in instances:
            if 
            assert instance in regular_data, f"Instance {instance} not found in regular data"
            assert instance in encrypted_data, f"Instance {instance} not found in encrypted data"
