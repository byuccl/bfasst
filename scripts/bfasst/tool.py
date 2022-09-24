import abc
import pathlib
import types
from dataclasses import dataclass

from bfasst.utils import TermColor


@dataclass
class ToolProduct:
    file_path: pathlib.Path
    log_path: pathlib.Path = None
    check_log_fcn: types.FunctionType = None


class Tool(abc.ABC):
    TERM_COLOR_STAGE = TermColor.PURPLE

    def __init__(self, cwd, flow_args = ""):
        super().__init__()
        self.cwd = cwd
        self.flow_args = flow_args
        self.work_dir = self.make_work_dir()

    @property
    @classmethod
    @abc.abstractclassmethod
    def TOOL_WORK_DIR(self):
        raise NotImplementedError

    @property
    @classmethod
    @abc.abstractclassmethod
    def success_status(self):
        raise NotImplementedError

    def make_work_dir(self):
        work_dir = self.cwd / self.TOOL_WORK_DIR

        if not work_dir.is_dir():
            work_dir.mkdir()
        return work_dir

    def get_prev_run_status(self, tool_products, dependency_modified_time):
        """Determines whether previous run data can be reused, and if so,
        returns the Status, otherwise returns None if Tool needs to be re-run"""

        # Loop through tool prodcuts
        for tool_product in tool_products:
            # If ToolProduct produces a log file:
            if tool_product.log_path:
                # If log file is missing, re-run
                if not tool_product.log_path.is_file():
                    return None

                # If log file is out of date, need to re-run
                if dependency_modified_time > tool_product.log_path.stat().st_mtime:
                    return None

                # If log file has an error, return that status
                status = tool_product.check_log_fcn(tool_product.log_path)

                # If log file doesn't have an error, but output file is expected and missing, re-run
                if (tool_product.file_path is not None) and (not tool_product.file_path.is_file()):
                    return None
            else:
                # This ToolProduct doesn't produce a log file

                # Rerun if product file is missing
                if not tool_product.file_path.is_file():
                    return None

                # Rerun if product file is out of date
                if dependency_modified_time > tool_product.file_path.stat().st_mtime:
                    return None

        return self.success_status
