"""Data types for metrics comparison between implementations."""

from __future__ import annotations
from dataclasses import dataclass


@dataclass
class TimingMetrics:
    """Timing metrics from Vivado timing_summary report."""

    wns: float  # Worst Negative Slack (ns)
    tns: float  # Total Negative Slack (ns)
    whs: float  # Worst Hold Slack (ns)
    ths: float  # Total Hold Slack (ns)
    failing_endpoints: int  # TNS Failing Endpoints


@dataclass
class ResourceMetrics:
    """Resource utilization metrics from Vivado utilization report."""

    lut_used: int
    ff_used: int
    bram36_used: int
    bram18_used: int
    dsp_used: int


@dataclass
class CompilationMetrics:
    """Compilation time metrics parsed from Vivado log."""

    place_time_sec: float
    route_time_sec: float
    total_time_sec: float


@dataclass
class ImplMetrics:
    """Combined metrics for an implementation."""

    timing: TimingMetrics
    resources: ResourceMetrics
    compilation: CompilationMetrics


@dataclass
class MetricsComparison:
    """Comparison between golden and test implementations."""

    golden: ImplMetrics
    test: ImplMetrics

    def to_dict(self) -> dict:
        """Convert comparison to dictionary for JSON output."""
        return {
            "timing": {
                "wns": {
                    "golden": self.golden.timing.wns,
                    "test": self.test.timing.wns,
                    "delta": self.test.timing.wns - self.golden.timing.wns,
                },
                "tns": {
                    "golden": self.golden.timing.tns,
                    "test": self.test.timing.tns,
                    "delta": self.test.timing.tns - self.golden.timing.tns,
                },
                "whs": {
                    "golden": self.golden.timing.whs,
                    "test": self.test.timing.whs,
                    "delta": self.test.timing.whs - self.golden.timing.whs,
                },
                "ths": {
                    "golden": self.golden.timing.ths,
                    "test": self.test.timing.ths,
                    "delta": self.test.timing.ths - self.golden.timing.ths,
                },
                "failing_endpoints": {
                    "golden": self.golden.timing.failing_endpoints,
                    "test": self.test.timing.failing_endpoints,
                    "delta": self.test.timing.failing_endpoints
                    - self.golden.timing.failing_endpoints,
                },
            },
            "resources": {
                "lut": {
                    "golden": self.golden.resources.lut_used,
                    "test": self.test.resources.lut_used,
                    "delta": self.test.resources.lut_used - self.golden.resources.lut_used,
                },
                "ff": {
                    "golden": self.golden.resources.ff_used,
                    "test": self.test.resources.ff_used,
                    "delta": self.test.resources.ff_used - self.golden.resources.ff_used,
                },
                "bram36": {
                    "golden": self.golden.resources.bram36_used,
                    "test": self.test.resources.bram36_used,
                    "delta": self.test.resources.bram36_used - self.golden.resources.bram36_used,
                },
                "bram18": {
                    "golden": self.golden.resources.bram18_used,
                    "test": self.test.resources.bram18_used,
                    "delta": self.test.resources.bram18_used - self.golden.resources.bram18_used,
                },
                "dsp": {
                    "golden": self.golden.resources.dsp_used,
                    "test": self.test.resources.dsp_used,
                    "delta": self.test.resources.dsp_used - self.golden.resources.dsp_used,
                },
            },
            "compilation": {
                "place_time_sec": {
                    "golden": self.golden.compilation.place_time_sec,
                    "test": self.test.compilation.place_time_sec,
                    "delta": self.test.compilation.place_time_sec
                    - self.golden.compilation.place_time_sec,
                },
                "route_time_sec": {
                    "golden": self.golden.compilation.route_time_sec,
                    "test": self.test.compilation.route_time_sec,
                    "delta": self.test.compilation.route_time_sec
                    - self.golden.compilation.route_time_sec,
                },
                "total_time_sec": {
                    "golden": self.golden.compilation.total_time_sec,
                    "test": self.test.compilation.total_time_sec,
                    "delta": self.test.compilation.total_time_sec
                    - self.golden.compilation.total_time_sec,
                },
            },
        }
