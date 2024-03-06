"""Ic2 Implementation Tool (ninja snippet generation for ic2 implementation)"""

import pathlib
from bfasst.config import IC2_SBT_DIR
from bfasst.paths import IC2_IMPL_TCL_TEMPLATE
from bfasst.tools.impl.impl_tool import ImplTool


class Ic2Impl(ImplTool):
    """Ic2 Implementation Tool (ninja snippet generation for ic2 implementation)"""

    def __init__(self, flow, design_path):
        super().__init__(flow, design_path)
        self._my_dir_path = pathlib.Path(__file__).parent

        # outputs must be initialized AFTER output paths are set
        self._init_outputs()

    def create_rule_snippets(self):
        self._append_rule_snippets_default(__file__)

    def create_build_snippets(self, netlist_full_path):
        # NOTE: the netlist_full_path is used by ninja to ensure the build snippet
        # only runs after the synthesis tool has completed
        # However, the relative path is used in the TCL script, since it must be run
        # from the build directory for this tool
        self._append_build_snippets_default(
            __file__,
            {
                "outputs": [v for _, v in self.outputs.items()],
                "build_path": self.build_path,
                "sbt_dir": IC2_SBT_DIR,
                "ic2_impl_tcl": IC2_IMPL_TCL_TEMPLATE,
                "top": self.design_props.top,
                "netlist_rel_path": ".."
                / pathlib.Path(netlist_full_path).relative_to(self.build_path.parent),
                "netlist_full_path": netlist_full_path,
                "design": self.design_path,
            },
        )

    def _init_outputs(self):
        # enumerate the base path for the outputs of the ic2 impl tool
        self.outputs_path = self.build_path / "sbt" / "outputs"

        # set the outputs for each child dir of the base path
        self._init_bitmap_outputs()
        self._init_placer_outputs()
        self._init_packer_outputs()
        self._init_router_outputs()

        # set each of the outputs directly on the base path
        self.outputs["impl_v_file"] = self.build_path / (self.design_props.top + "_sbt.v")
        self.outputs["impl_vhd_file"] = self.build_path / (self.design_props.top + "_sbt.vhd")
        self.outputs["impl_rpt"] = self.outputs_path / (self.design_props.top + "_sbt.rpt")
        self.outputs["device_info"] = self.outputs_path / "device_info.txt"

    def _init_bitmap_outputs(self):
        bitmap = self.outputs_path / "bitmap"
        self.outputs["bitstream"] = bitmap / (self.design_props.top + "_bitmap.bin")
        self.outputs["bit_hex_map"] = bitmap / (self.design_props.top + "_bitmap.hex")
        self.outputs["bit_nvcm_map"] = bitmap / (self.design_props.top + "_bitmap.nvcm")
        self.outputs["bitmap_glb_txt"] = bitmap / (self.design_props.top + "_bitmap_glb.txt")
        self.outputs["bitmap_int_hex"] = bitmap / (self.design_props.top + "_bitmap_int.hex")

    def _init_placer_outputs(self):
        placer = self.outputs_path / "placer"
        self.outputs["constraints"] = placer / (self.design_props.top + "_sbt.pcf")
        self.outputs["placer_log"] = placer / "placer.log"
        self.outputs["clustering_result"] = placer / "packing_clustering.result"

    def _init_packer_outputs(self):
        packer = self.outputs_path / "packer"
        self.outputs["packer_cell_pcf"] = packer / (self.design_props.top + "_cell_sbt.pcf")
        self.outputs["packer_log"] = packer / (self.design_props.top + "_info.log")
        self.outputs["packer_lgc_pcf"] = packer / (self.design_props.top + "_lgc_sbt.pcf")
        self.outputs["packer_rpt"] = packer / (self.design_props.top + "_pack.rpt")
        self.outputs["packer_pin_table"] = packer / (self.design_props.top + "_pin_table.CSV")

    def _init_router_outputs(self):
        router = self.outputs_path / "router"
        self.outputs["router_rpt"] = router / (self.design_props.top + "_router.rpt")
        self.outputs["route_file"] = router / (self.design_props.top + ".route")
        self.outputs["router_log"] = router / (self.design_props.top + ".rt_log")
        self.outputs["cascade_info"] = router / "cascad_info.txt"

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
