import json
import pathlib
from bfasst import config
from bfasst.paths import BFASST_UTILS_PATH, COMMON_TOOLS_PATH, ENCRYPTED_IP_PATH
from bfasst.tools.tool import Tool
from bfasst.utils.general import json_write_if_changed


class EncryptedIpLoader(Tool):
    def __init__(
        self, flow, design_path, user_synth_dcp_path, ip_names, ip_ciphertext_paths
    ) -> None:
        super().__init__(flow, design_path)
        self.build_path = self.design_build_path / "loader"
        self._my_dir_path = pathlib.Path(__file__).parent
        self.user_synth_dcp_path = user_synth_dcp_path
        self.ip_names = ip_names
        self.ip_ciphertext_paths = ip_ciphertext_paths
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
        vivado_tcl_dict = {
            "loader_impl_dcp": str(
                ENCRYPTED_IP_PATH / "Project" / "loader_imp_design" / "implemented_loader.dcp"
            ),
            "user_synth_dcp": str(self.user_synth_dcp_path),
            "user_partial_bitstream": str(self.build_path / "user_partial.bit"),
            "final": str(self.build_path / "final"),
            "key_files": str(ENCRYPTED_IP_PATH / "Project" / "key_files"),
        }
        vivado_tcl_json = json.dumps(vivado_tcl_dict, indent=4)
        json_write_if_changed(self.build_path / "vivado.json", vivado_tcl_json)

        self._append_build_snippets_default(
            __file__,
            {
                "cwd": self.build_path,
                "loader_tcl_template": self._my_dir_path / "loader_vivado.tcl.mustache",
                "top_dcp": str(self.user_synth_dcp_path),
                "final": str(self.build_path / "final"),
                "user_partial_bitstream": str(self.build_path / "user_partial.bit"),
                "ip_args": " ".join(
                    [
                        f"--ip {ip_name} {cipher_path}"
                        for ip_name, cipher_path in zip(self.ip_names, self.ip_ciphertext_paths)
                    ]
                ),
            },
        )

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)

    def _init_outputs(self):
        pass
