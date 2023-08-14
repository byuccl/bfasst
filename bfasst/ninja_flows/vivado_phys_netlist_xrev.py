"""Flow that combines vivado phys netlist and xray/f2b reversal"""

import chevron
from bfasst import config
from bfasst.ninja_flows.flow import Flow
from bfasst.ninja_flows.vivado_phys_netlist import VivadoPhysNetlist
from bfasst.paths import (
    NINJA_BUILD_PATH,
    NINJA_FLOWS_PATH,
    REV_BIT_TOOLS_PATH,
    ROOT_PATH,
    XRAY_PATH,
    get_fasm2bels_path,
)
from bfasst.yaml_parser import YamlParser


class VivadoPhysNetlistXrev(Flow):
    """Flow that combines vivado phys netlist and xray/f2b reversal."""

    def __init__(self, design):
        """Initialize the flow."""
        super().__init__(design)

        self.build = ROOT_PATH / "build" / design / "xray"
        self.__create_build_dir()
        self.phys_netlist_flow = VivadoPhysNetlist(design)

        self.top = YamlParser(self.design / "design.yaml").parse_top_module()

        # get these moved to paths later
        self.fasm2bels_path = get_fasm2bels_path()
        self.fasm2bels_python_path = (
            self.fasm2bels_path
            / "env"
            / "conda"
            / "envs"
            / "f4pga_xc_fasm2bels"
            / "bin"
            / "python3"
        )
        self.xray_db_path = self.fasm2bels_path / "third_party" / "prjxray-db"
        self.db_root = self.xray_db_path / config.PART_FAMILY
        self.to_netlist_log = self.build / "to_netlist.log"
        self.fasm_path = self.build / (self.top + ".fasm")
        self.reversed_netlist_path = self.build / (self.top + "_reversed.v")
        self.xdc_path = self.build / (self.top + "_reversed.xdc")
        self.constraints_path = (
            str(self.phys_netlist_flow.vivado_flow.synth_output / self.top) + ".xdc"
        )

    def __create_build_dir(self):
        self.build.mkdir(parents=True, exist_ok=True)

    def create_rule_snippets(self):
        self.phys_netlist_flow.create_rule_snippets()

        with open(REV_BIT_TOOLS_PATH / "xray.ninja_rules", "r") as f:
            rules = f.read()

        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(rules)

    def create_build_snippets(self):
        self.phys_netlist_flow.create_build_snippets()
        with open(REV_BIT_TOOLS_PATH / "xray.ninja_build.mustache", "r") as f:
            build_rules = chevron.render(
                f,
                {
                    "xray_path": str(XRAY_PATH / "build" / "tools"),
                    "bitstream_path": str(self.phys_netlist_flow.vivado_flow.impl_output / self.top)
                    + ".bit",
                    "xray_output": self.build,
                    "fasm2bels_python_path": self.fasm2bels_python_path,
                    "bit_to_fasm_path": XRAY_PATH / "utils" / "bit2fasm.py",
                    "db_root": self.db_root,
                    "part": config.PART,
                    "top": self.top,
                    "verilog_file": self.reversed_netlist_path,
                    "xdc_file": self.xdc_path,
                    "input_xdc": self.constraints_path,
                },
            )
        with open(NINJA_BUILD_PATH, "a") as f:
            f.write(build_rules)

    def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.phys_netlist_flow.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado_phys_netlist_xrev.py ")
        deps.append(f"{REV_BIT_TOOLS_PATH}/xray.ninja_rules ")
        deps.append(f"{REV_BIT_TOOLS_PATH}/xray.ninja_build.mustache ")
        return deps

    def get_top_level_flow_path(self):
        path = str(NINJA_FLOWS_PATH / "vivado_phys_netlist_xrev.py")
        return path
