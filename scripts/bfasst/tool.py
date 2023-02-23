""" Base class for all tools used in BFASST """

import abc
import argparse
import datetime
import pathlib
import subprocess
import sys
import types
from dataclasses import dataclass

from bfasst.utils import TermColor, print_color


@dataclass
class ToolProduct:
    """A file product of any tool.  If the tool producesd a log file, then you can also provide
    the log_path, as well as a parser function (check_log_fcn), than can check if a prevoius run of
    the tool was successful or not."""

    file_path: pathlib.Path
    log_path: pathlib.Path = None
    check_log_fcn: types.FunctionType = None


class Tool(abc.ABC):
    """Base class for all tools used in BFASST"""

    TERM_COLOR_STAGE = TermColor.PURPLE

    DATE_FORMAT = "%Y-%m-%d"
    TIME_FORMAT = "%H:%M:%S"
    TIMESTAMP_FORMAT = DATE_FORMAT + " " + TIME_FORMAT + ".%f\t"

    def __init__(self, cwd):
        super().__init__()
        self.cwd = cwd
        self.work_dir = self.make_work_dir()
        self.log_path = self.work_dir / "log.txt"
        self.log_fp = None

    @property
    @classmethod
    @abc.abstractclassmethod
    def TOOL_WORK_DIR(self):  # pylint: disable=invalid-name
        """The subdirectory in the build folder to used for this tool."""
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

    def open_new_log(self):
        self.log_fp = open(self.log_path, "w")

    def log(self, *msg, add_timestamp=False):
        """Write text to the log file and stdout"""
        text = " ".join(str(s) for s in msg)
        if add_timestamp:
            time_now = datetime.datetime.now()
            text = time_now.strftime(Tool.TIMESTAMP_FORMAT) + text
        print(text)
        self.log_fp.write(text + "\n")
        self.log_fp.flush()

    def log_color(self, color, *msg, add_timestamp=False):
        text = " ".join(str(s) for s in msg)
        if add_timestamp:
            time_now = datetime.datetime.now()
            text = time_now.strftime(Tool.TIMESTAMP_FORMAT) + text
        print_color(color, text)
        self.log_fp.write(text + "\n")
        self.log_fp.flush()

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
                if status.error:
                    return status

                # If log file doesn't have an error, but output file is expected and missing, re-run
                if (tool_product.file_path is not None) and (not tool_product.file_path.is_file()):
                    return None
            else:
                # This ToolProduct doesn't produce a log file

                # Rerun if product file is missing, or if product file is out of date
                if not tool_product.file_path.is_file() or (
                    dependency_modified_time > tool_product.file_path.stat().st_mtime
                ):
                    return None

        return self.success_status

    def exec_and_log(self, cmd, env=None, timeout=None):
        """Run a command using Popen and log the output, return the process handle"""
        proc = subprocess.Popen(
            cmd,
            cwd=self.work_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=True,
            env=env,
        )
        for line in proc.stdout:
            self.log(line.strip())
        proc.communicate(timeout=timeout)
        return proc


class ToolArgParser(argparse.ArgumentParser):
    def __init__(self, name) -> None:
        super().__init__()
        self.name = name

    def error(self, message):
        sys.stderr.write(f"{self.name} args error: {message}\n")
        sys.exit(2)
