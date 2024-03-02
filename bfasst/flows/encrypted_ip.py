"""Flow to create Vivado synthesis and implementation ninja snippets."""
import pathlib
import re
import pandas as pd

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
        self.impl_regular = VivadoImpl(self, design)

        self.synth_tool_per_ip = {}
        self.ip_encrypter_tool_per_ip = {}

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
            self.synth_tool_per_ip[ip_definition] = synth_tool            
            synth_tool.override_build_path(
                synth_tool.build_path.parent / f"{synth_tool.build_path.name}_{ip_definition}"
            )
            synth_tool._init_outputs()

            ip_encrypter_tool = IpEncrypter(
                self, design, ip_definition, synth_tool.outputs["synth_dcp"]
            )
            self.ip_encrypter_tool_per_ip[ip_definition] = ip_encrypter_tool
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
        self.loader_tool = EncryptedIpLoader(
            self,
            design,
            user_synth_dcp_path=self.top_synth_tool.outputs["synth_dcp"],
            encrypted_ip_data=self.design_props.encrypted_ip["ip"],
        )

    def get_top_level_flow_path(self):
        return pathlib.Path(__file__)
    
    def parse_runtime(self, log_path, str_identifier):
        with open(log_path, 'r') as f:
            txt = f.read()

        match = re.search(f"^{str_identifier} start time: (.*)$", txt, re.MULTILINE)
        assert match

        # Parse the datetime. Example: Fri Mar  1 08:44:27 AM MST 2024
        start_time = pd.to_datetime(match.group(1), format="%a %b %d %I:%M:%S %p %Z %Y")

        match = re.search(f"^{str_identifier} end time: (.*)$", txt, re.MULTILINE)
        assert match

        end_time = pd.to_datetime(match.group(1), format="%a %b %d %I:%M:%S %p %Z %Y")

        return (end_time - start_time).total_seconds()

    def post_execute(self):
        print("Running post_execute for EncryptedIP flow")
        out_csv_path = self.design_build_path / "area_results.csv"
        out_csv_runtime_path = self.design_build_path / "runtime_results.csv"

        # Get regular synthesis results
        reg_utilization_file = self.synth_regular.outputs["utilization"]
        encrypted_utilization_file = self.top_synth_tool.outputs["utilization"]

        regular_data = parse_hierarchical_utilization(reg_utilization_file)
        encrypted_data = parse_hierarchical_utilization(encrypted_utilization_file)

        instances = ["top"] + [
            f"top/{definition}"
            for ip in self.design_props.encrypted_ip["ip"]
            for definition in ip["instances"]
        ]

        df = pd.DataFrame(
            columns=["Instance", "LUTs-Regular", "FFs-Regular", "LUTs-Encrypted", "FFs-Encrypted"]
        )
        for instance in instances:
            assert instance in regular_data, f"Instance {instance} not found in regular data"
            assert instance in encrypted_data, f"Instance {instance} not found in encrypted data"

            row = pd.Series(
                {
                    "Instance": instance,
                    "LUTs-Regular": regular_data[instance]["Total LUTs"],
                    "FFs-Regular": regular_data[instance]["FFs"],
                    "RAMB-Regular": regular_data[instance]["RAMB36"]
                    + regular_data[instance]["RAMB18"],
                    "DSP-Regular": regular_data[instance]["DSP Blocks"],
                    "LUTs-Encrypted": encrypted_data[instance]["Total LUTs"],
                    "FFs-Encrypted": encrypted_data[instance]["FFs"],
                    "RAMB-Encrypted": encrypted_data[instance]["RAMB36"]
                    + encrypted_data[instance]["RAMB18"],
                    "DSP-Encrypted": encrypted_data[instance]["DSP Blocks"],
                }
            )
            df = pd.concat(
                [df, row.to_frame().T],
            )

        df.to_csv(out_csv_path, index=False)


        # Get runtimes
        df = pd.DataFrame(
            columns=["Instance", "Synth-Regular", "Impl-Regular", "Synth-Encrypted", "Impl-Encrypted", "IP-Encryption"]
        )
        synth_regular_runtime = self.parse_runtime(self.synth_regular.build_path / "vivado.log", "Synth")
        impl_regular_runtime = self.parse_runtime(self.impl_regular.build_path / "vivado.log", "Impl")
        synth_encrypted_runtime = self.parse_runtime(self.top_synth_tool.build_path / "vivado.log", "Synth")
        impl_encrypted_runtime = self.parse_runtime(self.loader_tool.build_path / "vivado.log", "Loader impl")

        row = pd.Series({
            "Instance": instance,
            "Synth-Regular": synth_regular_runtime,
            "Impl-Regular": impl_regular_runtime,
            "Synth-Encrypted": synth_encrypted_runtime,
            "Impl-Encrypted": impl_encrypted_runtime,
            "IP-Encryption": "-",
            }
        )
        df = pd.concat(
            [df, row.to_frame().T],
        )

        for ip in self.design_props.encrypted_ip["ip"]:
            synth_encrypted_runtime = self.parse_runtime(self.synth_tool_per_ip[ip["definition"]].build_path / "vivado.log", "Synth")
            ip_encryption_runtime = self.parse_runtime(self.ip_encrypter_tool_per_ip[ip["definition"]].build_path / "log.txt", "Encryption") + self.parse_runtime(self.ip_encrypter_tool_per_ip[ip["definition"]].build_path / "vivado.log", "DCP to verilog")

            row = pd.Series({
                "Instance": instance,
                "Synth-Regular": "-",
                "Impl-Regular": "-",
                "Synth-Encrypted": synth_encrypted_runtime,
                "Impl-Encrypted": "-",
                "IP-Encryption": ip_encryption_runtime,
                }
            )
            df = pd.concat(
                [df, row.to_frame().T],
            )
        df.to_csv(out_csv_runtime_path, index=False)
            
