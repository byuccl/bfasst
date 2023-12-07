from bfasst.tools.tool import Tool


class IpEncrypter(Tool):
    def __init__(self, flow, design_path, ip_dcp_path) -> None:
        super().__init__(flow, design_path)
        self.build_path = self.design_build_path / "ip_encrypter"
        self.ip_dcp_path = ip_dcp_path
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self):
        self._append_build_snippets_default(
            __file__,
            {
                "dcp_unencrypted": self.ip_dcp_path,
                "dcp_encrypted": self.outputs["encrypted_ip_dcp"],
                "lut_ciphertext": self.outputs["lut_ciphertext"],
                "log_file": self.outputs["log"],
            },
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)

    def _init_outputs(self):
        self.outputs["encrypted_ip_dcp"] = self.build_path / "encrypted_ip.dcp"
        self.outputs["lut_ciphertext"] = self.build_path / "lut_ciphertext.txt"
        self.outputs["log"] = self.build_path / "log.txt"
