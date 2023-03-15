""" Base class for implementation tools """
import abc
import pathlib
import shlex
from bfasst import tool

from bfasst.status import ImplStatus, Status
from bfasst.utils import print_color
from bfasst.tool import Tool, ToolProduct


class ImplementationTool(Tool):
    """Base class for implementation tools"""

    success_status = Status(ImplStatus.SUCCESS)

    def __init__(self, cwd, flow_args="") -> None:
        super().__init__(cwd)

        # Implementation options
        parser = tool.ToolArgParser("impl")
        parser.add_argument("--out_of_context", action="store_true")
        self.args = parser.parse_args(shlex.split(flow_args))

    # This method should run implementation.  It should return
    # (bitstream, status), where:
    #   - bitstream is the path to the produced netlist file
    #   - status is a Status object from bfasst.status
    @abc.abstractmethod
    def implement_bitstream(self, netlist_path, build_dir):
        pass

    def print_running_impl(self):
        print_color(self.TERM_COLOR_STAGE, "Running Implementation")

    def print_skipping_impl(self):
        print_color(self.TERM_COLOR_STAGE, "Implementation already run")

    def common_startup(self, design, log_check_fcn):
        """Commmon startup code for Implementation tools that first checks if
        prevous run can be used, and if not starts a new run"""
        status = self.get_prev_run_status(
            tool_products=[ToolProduct(design.bitstream_path, self.log_path, log_check_fcn)],
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.netlist_path.stat().st_mtime
            ),
        )

        if status is not None:
            self.print_skipping_impl()
            return status

        self.print_running_impl()
        self.open_new_log()
        return None
