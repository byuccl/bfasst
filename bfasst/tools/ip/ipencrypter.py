import json
from bfasst import config
from bfasst.paths import BFASST_UTILS_PATH, COMMON_TOOLS_PATH
from bfasst.tools.tool import Tool
from bfasst.utils.general import json_write_if_changed


class IpEncrypter(Tool):
    def __init__(self, flow, design_path, ip_dcp_path) -> None:
        super().__init__(flow, design_path)
        self.build_path = self.design_build_path / "ip_encrypter"
        self.ip_dcp_path = ip_dcp_path
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)
        self._append_rule_snippets_default(
            None,
            {
                "vivado_path": config.VIVADO_BIN_PATH,
                "utils_path": BFASST_UTILS_PATH,
            },
            COMMON_TOOLS_PATH / "vivado_rules.ninja.mustache",
        )

    def create_build_snippets(self):
        dcp_to_v = {
            "dcp": str(self.outputs["encrypted_ip_dcp"]),
            "verilog": str(self.outputs["encrypted_verilog"]),
        }
        dcp_to_v_json = json.dumps(dcp_to_v, indent=4)
        json_write_if_changed(self.build_path / "dcp_to_v.json", dcp_to_v_json)

        self._append_build_snippets_default(
            __file__,
            {
                "dcp_unencrypted": self.ip_dcp_path,
                "dcp_encrypted": self.outputs["encrypted_ip_dcp"],
                "verilog_encrypted": self.outputs["encrypted_verilog"],
                "lut_ciphertext": self.outputs["lut_ciphertext"],
                "log_file": self.outputs["log"],
                "cwd": self.build_path,
                "gen_encrypted_verilog_template": COMMON_TOOLS_PATH / "dcp_to_v.tcl.mustache",
            },
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)

    def _init_outputs(self):
        self.outputs["encrypted_ip_dcp"] = self.build_path / "encrypted_ip.dcp"
        self.outputs["encrypted_verilog"] = self.build_path / "encrypted_ip.v"
        self.outputs["lut_ciphertext"] = self.build_path / "lut_ciphertext.txt"
        self.outputs["log"] = self.build_path / "log.txt"
