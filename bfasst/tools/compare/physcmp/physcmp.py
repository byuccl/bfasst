"""RapidWright-based physical comparison ninja snippets."""

from argparse import Namespace

from bfasst.paths import BFASST_UTILS, COMPARE_TOOLS
from bfasst.tools.tool import Tool
from bfasst.utils.compare.physcmp_data_types import ImplReports


class PhysCmp(Tool):
    """RapidWright-based physical comparison ninja snippets."""

    def __init__(
        self,
        flow,
        design,
        *,
        golden: ImplReports,
        test: ImplReports,
        log_name: str = "physcmp.log",
        logging_level: str = "INFO",
    ):
        super().__init__(flow, design)
        self.build_path = self.design_build_path / "physcmp"

        self.golden = golden
        self.test = test

        self.log_name = log_name
        self.logging_level = logging_level

        self._init_outputs()

        self.rule_snippet_path = COMPARE_TOOLS / "physcmp" / "physcmp_rules.ninja.mustache"

        self.rules_render_dict = {
            "compare_script_path": str(BFASST_UTILS / "compare" / "physcmp.py"),
            "golden_dcp": str(self.golden.dcp),
            "golden_edf": str(self.golden.edf),
            "golden_setup_timing": str(self.golden.setup_timing),
            "golden_hold_timing": str(self.golden.hold_timing),
            "golden_timing_summary_full": str(self.golden.timing_summary_full),
            "golden_utilization": str(self.golden.utilization),
            "golden_power": str(self.golden.power),
            "golden_bitstream": str(self.golden.bitstream),
            "test_dcp": str(self.test.dcp),
            "test_edf": str(self.test.edf),
            "test_setup_timing": str(self.test.setup_timing),
            "test_hold_timing": str(self.test.hold_timing),
            "test_timing_summary_full": str(self.test.timing_summary_full),
            "test_utilization": str(self.test.utilization),
            "test_power": str(self.test.power),
            "test_bitstream": str(self.test.bitstream),
            "log_path": str(self.outputs["physcmp_log"]),
            "logging_level": f"--logging_level {self.logging_level}",
        }

    def _init_outputs(self):
        self.outputs["physcmp_log"] = self.build_path / self.log_name

    def create_build_snippets(self):
        self._append_build_snippets_default(__file__, self.rules_render_dict)

    def add_ninja_deps(self, deps):
        self._add_ninja_deps_default(deps, __file__)
        deps.append(BFASST_UTILS / "compare" / "physcmp.py")

    @classmethod
    def from_args(cls, flow, design, args: Namespace):
        """
        Helper to construct this tool directly from argparse Namespace.
        """
        golden = ImplReports.from_args(args, "golden")
        test = ImplReports.from_args(args, "test")
        return cls(
            flow,
            design,
            golden=golden,
            test=test,
            log_name=args.log_name,
            logging_level=args.logging_level,
        )
